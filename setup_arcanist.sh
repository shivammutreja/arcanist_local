#!/bin/bash


WORKING_DIR=`pwd`

confirm() {
        echo "Press RETURN to continue, or ^C to cancel.";
        read  ignored
}

echo "Please run this file in the home directory"
echo 

echo "Run this file by executing 'bash setup_arcanist'"

echo

confirm

sudo apt-get install php7.0 php7.0-mbstring php7.0-curl

if [ ! -e phabricator ]

then

  git clone https://github.com/phacility/phabricator.git

else

  (cd phabricator && git pull --rebase)

fi

if [ ! -e libphutil ]

then

  git clone https://github.com/phacility/libphutil.git

else

  (cd libphutil && git pull --rebase)

fi

if [ ! -e arcanist ]

then

  git clone https://github.com/phacility/arcanist.git

else

  (cd arcanist && git pull --rebase)

fi

echo '{"phabricator.uri": "http://hosted_phabricator.com/"}' >> .arcconfig

echo

export PATH="$PATH:/$WORKING_DIR/arcanist/bin/"

echo -e "\nexport PATH='$PATH:"$WORKING_DIR"/arcanist/bin/'" >> ~/.bashrc

arc set-config default http://hosted_phabricator.com/

arc set-config phabricator.uri http://hosted_phabricator.com/

echo 'source "'$WORKING_DIR'/arcanist/resources/shell/bash-completion"' >> ~/.bashrc

echo 
echo -e "\e[1;31mAdded arc autocomplete to your bash file\e[0m"
echo

arc install-certificate

echo
echo -e "\e[0;32mYou can take a look at the following article to get a gist of how the workflow would be : \n \e[0;34mhttps://thomas-barthelemy.github.io/2015/08/20/phabricator-arcanist-flow/\e[0m"
echo 

echo "Please don't use arc start (it's not used in our setup, thus isn't properly configured.)"
echo


