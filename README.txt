NAME
	portscanner.sh

USAGE
	./portscanner.sh [-t timeout] [host startport stopport]

DESCRIPTION
	The function of portscanner.sh is to scan a host in attempt to gather details including whether the hostname is reachable, and whether a certain range of ports is available. The hostname is deemed reachable if the pingcheck function follows through. After this, the program will test a range of ports specified by the user through the use of a function testing through /dev/tcp. The program can either be run just through the CLI, or it can be run in an interactive mode.

COMMAND-LINE OPTIONS

	./portscanner.sh : Launches interactive batch mode. Default timeout is 2 seconds.
	
	./portscanner.sh -t [seconds] :  Launches interactive batch mode, sets timeout to [seconds]

	./portscanner.sh [hostname startport stopport]	: Run from command line, timeout is 2 seconds.

	./portscanner.sh -t [seconds] [hostname startport stopport]: Run from command line, timeout to [seconds].


INPUT FILE FORMAT
	In order to create a file to pipe into this document, please specify host, startport, and stopport within one file, repeating this order. Each element of that list should be put onto a new line. See the example below:
	
	yahoo.com
	100
	110
	google.com
	20
	26


