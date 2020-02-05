#!/bin/bash

# A basic bash port scanner
# Jocelyn Murray, CSPC 42700, 2/4/2020


# Establish process mode the program will run: Interactive v. Not Interactive and Default Timeout v. New Timeout
if [ $# -eq 0 ]
    then
	# Interactive mode consanly requests hostnames and port numbers with the default timeout of 2.
	processmode="interactive"
	timeout=2

elif [ $# -eq 2 ]
    then
	# Itimechange mode is interactive mode with a timeout set dynamically by the user.
	processmode="itimechange"
	if [ $1="-t" ]
    	    then
		 timeout=$2
		 echo "Timeout set to $timeout"
	    else
		 echo "Error: improper command usage, specify -t flag with only two arguments. Try ./portscanner.sh [-t timeout] [host startport stopport]"
		 exit
	fi

elif [ $# -eq 3 ]
    then
	# Default mode runs command as is with the default timeout as 2.
	processmode="default"
	host=$1
	startport=$2
	stopport=$3
	timeout=2

elif [ $# -eq 5 ]
    then 
	# Dtimechange mode is a non-interactive mode with a timeout set dynamically by the user.
	processmode="dtimechange"
	if [ $1="-t" ]
    	    then
		timeout=$2
		host=$3
		startport=$4
		stopport=$5
	    else
		 echo "Error: improper command usage, specify -t flag first with 5 arguments. Try ./portscanner.sh [-t timeout] [host startport stopport]"
	fi	
	
    else
	echo "Error: improper command usage. Incorrect number of arguments specified. Arguments specified: $#. Try ./portscanner.sh [-t timeout] [host startport stopport]"
	exit
fi


# Functions ping check an port check to call upon in the later processes.
function pingcheck
{
    echo "Commencing ping check against: $host"
    bytecount=$(ping -c 1 $host | grep bytes | wc -l)
    if [ $bytecount -gt 1 ]; then
	echo "$host is up"
    else
	echo "$host is down, quitting"
	exit
    fi
}

function portcheck
{
    # loop through the range of ports.
    echo "Commencing port check against ports: $startport to $stopport"
    for ((counter=$startport; counter<=$stopport; counter++))
    	do
	    if timeout $timeout bash -c "echo > /dev/tcp/$host/$counter"
		then
	   	   echo "port $counter is open"
		else
	   	   echo "port $counter is closed"
	    fi
        done   
}

echo "Process mode has been set to: $processmode"

# If the mode is interactive, the command launches into a while loop asking for host and port information.
if [[ $processmode == "interactive" ]] || [[ $processmode == "itimechange" ]]
    then
	termprocess=1
	while [ $termprocess -eq 1 ]
	    do
		echo
		echo "Please input a hostname, or leave blank to exit"
		read
		echo $host
		host=${REPLY}
		echo
		if [ -z $host ]
		    then
			termprocess=0
			echo "No hostname specified... exiting"
			exit
		    else
			echo "Please input a starting port"
			read startport
			echo
			echo "Please input an ending port"
			read stopport
			echo
		fi
		pingcheck
		portcheck
		host=""
	    done


# If the mode is not interactive, the program will run the command regularly
elif [[ $processmode == "default" ]] || [[ $processmode == "dtimechange" ]]
    then
	pingcheck
	portcheck

else
    echo "No Running Phase Properly Set."
fi



