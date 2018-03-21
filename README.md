# wifiwhitelist
A script to ensure a Mac only connects to a preset list of wifi networks.

This script is intended to be run from a LaunchDaemon and will perform checks at a pre set time to see if the device is connected to any networks that are not allowed.

If a non approved network is being used then the connection is dropped and the user is notified by the jamf helper.

This script has been tested on 10.11, 10.12 and 10.13

