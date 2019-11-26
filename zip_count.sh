#!/bin/bash

# zip count
# decirella@gmail.com
# 20191126

# call with argument of directory of zip files
# count of files within each zip read to stdout and log file

for file in $(ls -tr $1)
    do
        if /usr/bin/file --mime-type $1/$file | grep -q "zip"; then
            unzip -l $1/$file  | awk '{count = $2} END{print count}' | tee -a zip_count.log 
            
        else
            echo "$file is not zipped"  | tee -a zip_count.log
        fi        
        
        timestamp=$( date +%Y%m%d-%H%M%S )
    done
