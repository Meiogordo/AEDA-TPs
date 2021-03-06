#!/bin/bash
#The script should be ran as ./generateTestProject <Testnumber> <Testyear>, for example ./generateTPProject 2 1516

#Check if an argument was given
#Basically checking if the number of arguments is 0 ($# returns the number of arguments)
if [[ $# -eq 0 ]]
then
	echo
	echo "No arguments were supplied!"
	echo "Exiting!"
	exit 3 #exit on error=no arguments provided
fi

#Checking if the given argument is a number
if [[ -n ${1//[0-9]/} ]]
then #(Checking if the variable, evaluated in arithmetic context, is equal to itself)
	echo
	echo "Given argument is not a number!"
	echo "Exiting!"
	exit 4 #exit on error=argument not a number
fi

#Checking if the second argument is also a number
if [[ -n ${2//[0-9]/} ]]
then
	echo
	echo "Second argument is not a number!"
	echo "Exiting!"
	exit 5 #exit on error=second argument not a number
fi

#Copying the folder structure from the template project to the new project
cp -r "AEDA-Test2-1516" "AEDA-Test$1-$2"
#Entering the new project folder
cd "AEDA-Test$1-$2"
#Deleting the unnecessary cmake-build-debug folder
rm -rf cmake-build-debug
#Renaming the project in the CMakeLists file
sed -i "s|AEDA_Test2-1516|AEDA_Test$1-$2|g" CMakeLists.txt
#Entering the .idea folder
cd .idea
#Renaming stuff inside the .idea folder
#misc.xml contains no references to the initial project name so we need not tinker with it
#We need to change the name of the .iml file that the other files point to
mv "AEDA-Test2-1516.iml" "AEDA-Test$1-$2.iml"
#Changing modules.xml (Note: here a  '-' was being used instead of '_')
sed -i "s|AEDA-Test2-1516|AEDA-Test$1-$2|g" modules.xml
#Changing workspace.xml (Note: here both characters are used, hence the two sed commands. Probably could use regex to avoid two separate commands but too lazy to think)
sed -i "s|AEDA-Test2-1516|AEDA-Test$1-$2|g" workspace.xml
sed -i "s|AEDA_Test2-1516|AEDA_Test$1-$2|g" workspace.xml
#Changing .name (weird that it is a file lol)
sed -i "s|AEDA_TPTemplate|AEDA_TP$1|g" .name


#Done
echo "Done. Have a nice Test$1 of $2!"
