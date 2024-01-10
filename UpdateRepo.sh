#!/bin/bash
#1 - git branch to setup
#Sequence of these git commands is mandatory to cover various states of git repos.
#If CI/CD build is broken, check this script is not in subject of change.
#This script is used for Linux Environment
#This script takes Branch_Name as parameter and then below git commands will execute
#Purpose of this script is to update workspace to the specified Branch_Name
#Usage sh AppFx/Scripts/Setup_Repo.sh Branch_Name

if [ -z "$1" ]; then
    echo "Usage sh UpdateRepo.sh Branch_Name"
    exit 1
fi

git fetch -p
VAR=$?
if [ $VAR != "0" ]; then
    echo "ERRORLEVEL:" $VAR
    exit $VAR
fi

git clean -dfx
VAR=$?
if [ $VAR != "0" ]; then
    echo "ERRORLEVEL:" $VAR
    exit $VAR
fi

git submodule foreach --recursive git clean -xfd
VAR=$?
if [ $VAR != "0" ]; then
    echo "ERRORLEVEL:" $VAR
    exit $VAR
fi

git reset --hard
VAR=$?
if [ $VAR != "0" ]; then
    echo "ERRORLEVEL:" $VAR
    exit $VAR
fi

git submodule foreach --recursive git reset --hard
VAR=$?
if [ $VAR != "0" ]; then
    echo "ERRORLEVEL:" $VAR
    exit $VAR
fi

git checkout $1
VAR=$?
if [ $VAR != "0" ]; then
    echo "ERRORLEVEL:" $VAR
    exit $VAR
fi

git pull
VAR=$?
if [ $VAR != "0" ]; then
    echo "ERRORLEVEL:" $VAR
    exit $VAR
fi

git submodule update --init --recursive
VAR=$?
if [ $VAR != "0" ]; then
    echo "ERRORLEVEL:" $VAR
    exit $VAR
fi