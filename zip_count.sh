#!/bin/bash

# zip count
# decirella@gmail.com
# 20191126

# call with argument of directory of zip files
# count of files within each zip read to stdout and log file

total_files=0
current_zip_count=0

timestamp=$( date +%Y%m%d-%H%M%S )
echo "$1" | tee -a zip_count.log
echo "$timestamp" | tee -a zip_count.log

for file in $(ls -tr $1)
    do
        if /usr/bin/file --mime-type $1/$file | grep -q "zip"; then
            current_zip_count=$(unzip -l $1/$file  | awk '{count = $2} END{print count}' | tee -a zip_count.log) 
            total_files=$((total_files + current_zip_count))
        else
            echo "$file is not zipped"  | tee -a zip_count.log
        fi              

    done

echo "Total files: $total_files" | tee -a zip_count.log
