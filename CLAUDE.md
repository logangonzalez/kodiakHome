# Scripts

Personal scripts collection. GitHub repo: `kodiakHome`. Local path: `~/Repos/kodiakHome/`. Each file under `scripts/<language>/` is standalone — no shared library, no build step.

## Repository layout

```
kodiakHome/
├── README.md
├── CLAUDE.md
├── ANTHROPIC_TOS.md    ← acknowledgment of Anthropic's terms
└── scripts/
    ├── bash/
    └── python/
```

## Scripts inventory

| Script | Purpose |
|---|---|
| `scripts/bash/bigBen.sh` | Interactive clock-watcher. Prompts for clock-in / clock-out times (12h or 24h), then live-counts down remaining time until clock-out. |

When adding a new script, place it under `scripts/bash/` or `scripts/python/` and append a row here in the same commit.

## Conventions

- Bash scripts: shebang `#!/bin/bash`, executable bit set (`chmod +x`), kept at repo root unless a subdirectory is justified.
- Time input accepts both `HH:MM` (24h) and `H:MM am/pm` (12h) — match this in any new time-handling script.
- `set -x` is used in `bigBen.sh` for trace output; remove or gate behind a `DEBUG` flag if it gets noisy.

## Working with Claude in this repo

- Keep changes scoped to one script per commit when possible.
- After any code change, **add an entry to the Dev Journal below** in the same commit. The journal is the source of truth for "what changed and why" — commit messages stay short, the journal carries the context.
- Don't introduce new dependencies (package managers, language runtimes beyond bash/coreutils) without asking first.

## Dev Journal

Newest entries on top. Format:

```
### YYYY-MM-DD — <short title>
- **What:** one or two lines on the change
- **Why:** motivation / what prompted it
- **Files:** `path/to/file.sh`
- **Follow-ups:** anything deferred (optional)
```

---

### 2026-05-11 — Add `ANTHROPIC_TOS.md`
- **What:** Added a repo-root acknowledgment of Anthropic's Consumer/Commercial Terms, Usage Policy, and Privacy Policy (hyperlinked, with a non-authoritative summary). Updated `README.md` and `CLAUDE.md` layout trees to include the file.
- **Why:** Code in this repo is Claude-assisted; keeping an explicit acknowledgment on record makes the relationship to Anthropic's terms unambiguous for anyone reading the repo.
- **Files:** `ANTHROPIC_TOS.md`, `README.md`, `CLAUDE.md`

### 2026-05-11 — Reorganize into `scripts/{bash,python}/`; rename local dir to `kodiakHome`
- **What:** Moved `bigBen.sh` into `scripts/bash/`, added empty `scripts/python/` (with `.gitkeep`). Expanded `README.md` with a repo-layout tree. Updated inventory paths in `CLAUDE.md`. Locally renamed `~/Scripts` → `~/Repos/kodiakHome` so the on-disk name matches the GitHub repo.
- **Why:** Cleaner browsing in the Fresh TUI editor; grouping by language scales as more scripts are added; the `~/Repos/` parent leaves room for other repos alongside this one.
- **Files:** `README.md`, `CLAUDE.md`, `scripts/bash/bigBen.sh`, `scripts/python/.gitkeep`

### 2026-05-11 — Add CLAUDE.md
- **What:** Initial CLAUDE.md with scripts inventory, conventions, and dev-journal template.
- **Why:** Establish a single place to track changes and keep Claude oriented across sessions.
- **Files:** `CLAUDE.md`

### 2025-05-04 — Add `bigBen.sh`
- **What:** Interactive clock-watcher script with 12h/24h input parsing and live countdown.
- **Why:** Track time remaining in workday from the terminal.
- **Files:** `bigBen.sh`
- **Follow-ups:** Fix typo'd regex in `quit_handler` (`= ~[Yy]` should be `=~ [Yy]`); guard the final `if [[ $NRC=-1 ]]` (currently an assignment, always true).
