#!/usr/bin/env bash
set -e
COURSE="$1"; TOPIC="$2"
if [ -z "$COURSE" ] || [ -z "$TOPIC" ]; then
  echo "Usage: ./scripts/new-topic.sh <CourseFolder> <TopicFolder>"
  exit 1
fi
mkdir -p "$COURSE/$TOPIC/assets"
cat > "$COURSE/$TOPIC/PLAYBOOK_ENTRY.md" <<EOF
---
layout: default
title: ${TOPIC//-/ }
---
# ${TOPIC//-/ }

## Overview
What/why.

## Steps / Commands
- steps

## Evidence
Screenshots in \`./assets/\`:
- yyyy-mm-${TOPIC}-01.png

## Reflection
2–4 sentences.
EOF
# HTML alias so buttons work immediately
cp "$COURSE/$TOPIC/PLAYBOOK_ENTRY.md" "$COURSE/$TOPIC/PLAYBOOK_ENTRY.html" 2>/dev/null || true

# Link from course index if present
if [ -f "$COURSE/index.md" ]; then
  echo "- [${TOPIC//-/ }](./$TOPIC/PLAYBOOK_ENTRY.html)" >> "$COURSE/index.md"
fi
echo "Created $COURSE/$TOPIC and linked it in $COURSE/index.md (if present)."
