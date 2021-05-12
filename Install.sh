#!/bin/bash
######################################################
# Title:  SudoBox                                    #
# started from Adamgot                               #
# URL: https://sudobox.io                            #
######################################################

#variable recalls
cat "/opt/appdata/plex/database/Library/Application Support/Plex Media Server/Preferences.xml" | sed -e 's;^.* PlexOnlineToken=";;' | sed -e 's;".*$;;' | tail -1 >> /opt/sudobox/var/plex.token
plexlibrary=(/opt/sudobox/python-plexlibrary)
plex.token=(cat opt/sudobox/var/plex.token)

#Checks Plex has been installed and is running

plexcheck() {
  pcheck=$(docker ps --format '{{.Names}}' | grep "plex")
  if [ "$pcheck" == "" ]; then

    tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  WARNING! - Plex is not Installed/Running! Cannot Proceed!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
    read -p 'Confirm Info | PRESS [ENTER] ' typed </dev/tty
    question1
  fi
}

#check Trakt api client file exist if it does then copy to
if [[ -f /var/plexguide/traktarr/trakt.client ]]
then
    traktid$(cat /var/plexguide/traktarr/trakt.client)
    echo "<file> exists on your filesystem"
fi

#check Trakt api secret file exist if it does then copy to
if [[ -f /var/plexguide/traktarr/trakt.secret ]]
then
    traktid$(cat /var/plexguide/traktarr/trakt.secret)
    echo "<file> exists on your filesystem"
fi


#### create folders & set permissions
USER=$(getent passwd 1000 | awk -F: '{ print $1}')

mkdir -p /opt/sudobox/var
mkdir -p /opt/sudobox/python-plexlibrary

#Download and put required files into the correct directory
git clone -b plex-movie-agent --single-branch https://github.com/Xpl0yt91/python-plexlibrary.git $plexlibrary

#install requirements
pip install -rv $plexlibrary/requirements.txt

