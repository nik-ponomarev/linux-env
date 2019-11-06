# Install gdbinit
wget -P ~ git.io/.gdbinit

# Vim undo folder
mkdir .vim/undo

# Install/Update  Vim-Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install silversearcher
sudo apt-get install tmux silversearcher-ag sudo build-essential pkg-config autoconf

# Portable soft build
mkdir portable-soft

# Install universal ctags
git clone https://github.com/universal-ctags/ctags.git
cd ctags
./autogen.sh
./configure --prefix=$HOME/portable-soft --program-prefix=u
make
make install
cd ..
rm -rf ctags

# Install tmux plugin
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# SSH generate
cd ./ssh
ssh-keygen -o -t rsa -C "nikita.ponomarev@intel.com" -b 4096
