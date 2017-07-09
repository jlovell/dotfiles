# setup copied from https://github.com/mathiasbynens/dotfiles
# usage: cd here and `source bootstrap.sh`

git pull origin master;

function doIt() {
  rsync --exclude ".git/" \
    --exclude ".DS_Store" \
    --exclude ".osx" \
    --exclude "bootstrap.sh" \
    --exclude "README.md" \
    --exclude "LICENSE-MIT.txt" \
    --exclude "apps/" \
    -avh --no-perms . ~;
  source ~/.bash_profile;
  rm -r ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/User;
  ln -s apps/Sublime/User ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/User;

  defaults write -g InitialKeyRepeat -int 15 # normal minimum is 15 (225 ms)
  defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
  defaults write -g com.apple.trackpad.scaling 3
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
  doIt;
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt;
  fi;
fi;
unset doIt;


