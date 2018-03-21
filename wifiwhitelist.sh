#!/bin/bash
# A Script to drop wifi connection if a machine is not connected to the approved wifi networks.
# Writted by Daniel Mintz @ Jamf. 21/03/18
####################################################################################################################################
# Variables set here################################################################################################################ 
CONNECTEDWIFI=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk -F': ' '/ SSID/ {print $2}')
WIFI1="SSID_GOES_HERE"
WIFI2="SSID_GOES_HERE"
logfile="/Library/companyname/wifilog.log"
maxsize=30
actualsize=$(du -k "$logfile" | cut -f 1)
idate=`date "+%H:%M:%S  %d/%m/%y"`
JAMFHELPER="/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper"
###################################################################################################################################
#Attributes set below
TOUCH='/usr/bin/touch'
###################################################################################################################################
#DO NOT EDIT BELOW THIS LINE
###################################################################################################################################
#Checks if log file directory exists and if not creates it. 

if
[ -d "/Library/poalim/" ]
then 
	echo "directory exists"
	
else 
	mkdir /Library/companyname
	
fi	

#makes a log file to write progress to
${TOUCH} "$logfile"

#Checks if log file is bigger than 30KB, if so deletes it
if [ $actualsize -ge $maxsize ]; then
	rm -f /Library/poalim/wifilog.log
	${TOUCH} "$logfile"

fi

if [ "$CONNECTEDWIFI" = "$WIFI1" ] || [ "$CONNECTEDWIFI" = "$WIFI2" ]
then
  echo "joined to correct wifi network on $idate" >>  "$logfile"
else 
	echo "joined to non approved SSID $idate" >>  "$logfile"
	echo "dropping wifi connection $idate" >>  "$logfile"
	/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -z
	echo "dropped wifi connection and notified user on $idate" >>  "$logfile"
	RESULT=`"$JAMFHELPER" -windowType utility -title "Notification" -description "Your mac is not on an approved wifi please connect to pcamp or HAPOLAIM" -button1 "OK"`
fi


