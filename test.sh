#! /bin/bash
######################################
#
# James Stallings
# CMSC-257-001 Spring 2019
#
# vcutar.sh is a script to automate
# creation, viewing, and extraction
# of unix tarball's.
#
#######################################


# *******************
# archive_it 
# 
# a function to create a tar archive
# 
# *******************
archive_it (){
filenames='';
doneflag=0;

# ----------------------------------------------
# prompt user for input
# and accept string in variable called options
# ----------------------------------------------
echo "Select your options:";
echo -e "\tv - show tyhe progress of archiving";
echo -e "\tj - use bzip2";
echo -e "\tg - use gzip";
read options

# ----------------------------------------------
# if the options selected indicate two different forms
# of compression, ask user to try again. (not possible)
# ----------------------------------------------
if echo "$options" | grep -Eq '.*\jg|.*\gj'; then archive_it;
fi

myvar="-c"
options="$myvar""$options"
echo  -e "Input the direstory containing the source files. \"*\" for the current directory.";
read directory;

if $directory == "*"
then
directory= "./";
fi

echo  -e "Input the files/directories to archive. \":q\" to quit, \":a\" to proceed to archiving.";

while [ "$doneflag" != 1 ] 
do
	read temp;
	case $temp in 
	":q")
	    exit;;
	":a")
	    doneflag=1;;
	*)
	filenames="$filenames $temp";;
	esac
done

echo -e "Input the name of the archive."
read archiveName;

if echo "$options" | grep -Eq '.*\j.*'; 
then extension=".tz2";
archiveName="$archiveName""$extension";
fi

if echo "$options" | grep -Eq '.*\g.*'; 
then extension=".tgz";
archiveName="$archiveName""$extension";
fi

command=" $options $archiveName"

echo "tar $command"
}

extract_it (){
echo "extract";
}

view_it (){
echo "view";
}



case $1 in archive)
archive_it;;
extract)
extract_it;;
view)
view_it;;
:q)
exit;;
esac

