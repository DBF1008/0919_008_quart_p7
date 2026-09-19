#!/usr/bin/env bash
# Run all unit tests for the Quart blueprint lifecycle refactoring.
# Usage: ./test.sh [extra pytest args...]
set -euo pipefail
cd "$(dirname "$0")"

# Prefer the project virtualenv, fall back to the system python.
if [ -x ".venv/bin/python" ]; then
    PYTHON=".venv/bin/python"
else
    PYTHON="python3"
fi

# Pre-existing environment-only failures (unrelated to this change):
# - tests/test_blueprints.py::test_cli_blueprints[cli_group2-args2] (click version behavior)
# - tests/test_cli.py::test_version_command (requires installed quart dist metadata)
exec "$PYTHON" -m pytest tests/ -v \
    -p no:cacheprovider \
    -o addopts="" \
    --deselect "tests/test_blueprints.py::test_cli_blueprints[cli_group2-args2]" \
    --deselect "tests/test_cli.py::test_version_command" \
    "$@"
