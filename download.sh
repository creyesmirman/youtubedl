echo "Checking if Prequisites are installed..."
if [ -e /usr/bin/xcode-select ]; then
echo "Xcode already installed!"
else
echo "Xcode needs to be installed. run 'sudo xcode-select --install' to start the process and follow instructions to accept usage."
echo "Run this script again when xcode has been installed."
exit 0
fi

echo "Checking for Homebrew...."
if [ -e /usr/local/bin/brew ]; then
echo "Homebrew already installed!"
echo "Checking for Homebrew Updates"
else
echo "Installing Homebrew!"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

sudo chown -R $(whoami) $(brew --prefix)/*

echo "Checking for Youtube-DL"
if [ -e /usr/local/bin/youtube-dl ]; then
echo "Youtube-DL already installed!"
else 
brew install youtube-dl
fi
echo "Fixing Links"
brew link youtube-dl
brew link --overwrite youtube-dl

echo "Installing Youtube-DL dependencies"
echo "Checking for ffmpeg"
if [ -e /usr/local/bin/ffmpeg ]; then
echo "FFMPEG Installed"
else
brew install ffmpeg
fi

echo "Updating and Upgrading any Brew formulas."
brew update && brew upgrade

echo "Cleaning up"
brew cleanup
clear
echo "Clean up Done!"

echo -n "Paste the Youtube URL: "
read link
if [ "$link" = "" ]; then
echo "Nothing entered. Exiting..."
:
else
echo "Pulling from " $link
youtube-dl -o '~/Desktop/%(title)s.%(ext)s' --extract-audio --audio-format mp3 $link
echo "Check your Desktop!"
fi

if [ -e /usr/local/bin/download ]; then
exit 0
else
echo "Copying to /usr/local/bin for ease of use"
me=`basename "$0"`
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
sudo cp $DIR/$me /usr/local/bin/download
echo "Next time just run 'download' to start the script!"
fi
