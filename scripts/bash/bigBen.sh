#!/bin/bash
set -x
NRC=0

quit_handler() {
echo "Quit?"
read -r -p "[Y/N]: " local quit_In

while [[ $NRC -gt 3 ]]; do
	if [[ quit_In = ~[Yy] ]]; then
		echo ""
		echo "Goodbye" 
		sleep 3
		clear
		NRC=-1
		
		
	elif [[ quit_In = ~[Nn] ]]; then
		echo ""
		echo "Continuing" 
		NRC=0
		break
	else
		echo "" 
		echo "Invalid, try again." 
	fi 
done 


}




main() {
	
	clear

	echo "welcome to Big Ben - The Clock Watcher"


	while true; do
		
		bool24="false"
		

		read -r -p "Enter time of clock-in:  " clock_IN


		# Use regex_12h and regex_24h

		regex_12h="^[0-9]{1,2}:[0-9]{2} [aApPmM]{2}$"
		regex_24h="^[0-9]{2}:[0-9]{2}$"

		
		if [[ $clock_IN =~ $regex_12h ]]; then
			echo "You have entered ${clock_IN}" 
			bool24="false"
			break
		elif [[ $clock_IN =~ $regex_24h ]]; then
			echo "You have entered ${clock_IN}"
			bool24="true"
			break
		
		else
			
			NRC=$(( NRC + 1 ))
			if [[ $NRC -gt 3 ]]; then
				quit_handler 
				break
			else
			echo "Format not recognized."
			fi
		fi
	done 

	#Get clock out time

	while true; do
		read -r -p "Enter expected time of clock-out:  " clock_OUT

		if [[ $clock_OUT =~ $regex_12h ]]; then
		    echo "You have entered ${clock_OUT}"
		    break 
		elif [[ $clock_OUT =~ $regex_24h ]]; then
		    echo "You have entered ${clock_OUT}"
		    break
		else
		    echo "Format not recognized."
		fi
	done

	# Get current time 

		while true; do

			if [[ $bool24 == "true" ]]; then
				clock_NOW=$(date "+%H:%M:%S")
				now=$(date -d "${clock_NOW}" +%s)
			else
				clock_NOW=$(date "+%I:%M:%S %p")
				now=$(date -d "${clock_NOW}" +%s) 
			fi
			clear
			echo "Current time is:  ${clock_NOW}"
			# Convert to epoch time

			start=$(date -d "${clock_IN}" +%s)
			end=$(date -d "${clock_OUT}" +%s)
			#now=$(date -d "${clock_NOW}" +%s) 

			diff=$(( end - now ))

#			echo "DEBUG: end=$end, now=$now, diff=$diff, h=$(( diff/3600 )) m=$(( (diff % 3600) / 60 )) s=$(( diff % 60 ))"
			echo "You have $((diff / 3600)) hours and $(( (diff % 3600) / 60 )) minutes left. $(( diff % 60 )) seconds remaining."
			echo "Type anything to quit"

			stty -icanon #turn off canon for a moment 
			if read -rs -t 1 -n 1 < /dev/tty; then
				stty icanon #turn on before breaking
				break
			fi
			stty icanon #turns it back even if no key was pressed
			tput cup 0 0 # <-- Cursor to line 0, char 0


		done

	#Restart?

	#Sanatize user input 

	while true; do

		echo ""
		read -r -p "Restart? [Y/N]: " reset_IN

		if [[  $reset_IN =~ [Yy] ]]; then
			echo "" 
			echo "Restarting..."
			sleep 3
			main
		elif [[ $reset_IN =~ [Nn] ]]; then 
			echo ""
			echo "Goodbye." 
			sleep 1 
			clear 
			exit 0

		else
			echo "" 
			echo "Invalid, please try again."
		fi
	done

 
} 

main

if [[ $NRC=-1 ]]; then 
	exit 0
fi
