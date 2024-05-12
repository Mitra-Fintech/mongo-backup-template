#!/bin/bash

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to display messages with timestamp and color
print_message() {
    local color="$1"
    local message="$2"
    echo -e "$(TZ=":Asia/Kolkata" date +'%Y-%m-%d %H:%M:%S IST') ${color}${message}${NC}"
}

# Step 1: Create a folder structure with the specified format
current_date=$(TZ=":Asia/Kolkata" date +'%-d %b %Y')
current_time=$(TZ=":Asia/Kolkata" date +'%-l_%M %p')
folder_name="$current_date/$current_time"
print_message "$CYAN" "📁 Creating folder structure: $folder_name"
mkdir -p "$folder_name"

# Step 2: Change directory to the created folder
print_message "$CYAN" "📂 Changing directory to: $folder_name"
cd "$folder_name" || exit

# Step 3: Run mongodump command
print_message "$YELLOW" "💾 Running mongodump command"
mongodump --uri="Mogo DB String"

# Step 4: Move back to the parent folder
cd ..

# Step 5: Write git commit message
commit_message="🚀 Database backup successful at $(TZ=":Asia/Kolkata" date +'%Y-%m-%d %H:%M:%S IST')"
print_message "$GREEN" "🔍 Committing changes with message: $commit_message"

# Step 6: Commit and push
git add .
git commit -m "$commit_message"
git push origin main

print_message "$GREEN" "🎉 Backup process completed successfully"
