#!/bin/bash

set -e
if [[ ! -z "$SKIP_DEBUGGER" ]]; then
  echo "Skipping debugger because SKIP_DEBUGGER enviroment variable is set"
  exit
fi

# Install tmate on macOS or Ubuntu
echo Setting up tmate...
if [ -x "$(command -v brew)" ]; then
  brew install tmate > /tmp/brew.log
fi
if [ -x "$(command -v apt-get)" ]; then
  sudo apt-get install -y tmate openssh-client > /tmp/apt-get.log
fi


echo start
mkdir ~/.ssh
echo "$SSH_KEY" > ~/.ssh/id_rsa
echo sshok
sudo chmod 600 ~/.ssh/id_rsa
echo key ok

git clone "$AC_DIRS"
echo clone ok
cd wolfScanCline
pip install -r requirements.txt
cp -r Config Urlscan/
cp -r utils Urlscan/
cp  db_config.py Urlscan/
echo cp ok
cd Urlscan
echo ook start now
python Run.py
