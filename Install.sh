#!/bin/bash
######################################################
# All rights reserved.                               #
# started from Adamgot                               #
# Install script from SudoBox.io                     #
######################################################

Plex.Token=$(sudo cat "/opt/appdata/plex/database/Library/Application Support/Plex Media Server/Preferences.xml" | sed -e 's;^.* PlexOnlineToken=";;' | sed -e 's;".*$;;' | tail -1)

#### create folders & set permissions
USER=$(getent passwd 1000 | awk -F: '{ print $1}')

mkdir -p opt/appdata/python-plexlibrary

#gitpull to directory

#install requirements

#get plex token and more



#copy apis and details

#give options to install things automagically - if this then that function
