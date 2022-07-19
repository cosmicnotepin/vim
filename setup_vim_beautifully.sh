#!/usr/bin/env bash
echo This will install vim-gkt3, silversearcher-ag and several plugins for vim.
echo It will move the .vimrc to ~
echo Then it will remove itself and the containting folder
sudo apt install vim-gtk3
sudo apt install silversearcher-ag
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
mv $SCRIPT_DIR/.vimrc ~
rm $SCRIPT_DIR/setup_vim_beautifully.sh
rm $SCRIPT_DIR/README.md
rm -rf $SCRIPT_DIR/.git
if [ -z "$(ls -A $SCRIPT_DIR)" ]; then
    rm -r $SCRIPT_DIR
else
    echo Do not put trash in my folder and expect me to clean it up.
fi
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/undo
mkdir -p ~/.vim/swap
mkdir -p ~/.vim/pack/dmad/start
cd ~/.vim/pack/dmad/start
git clone https://tpope.io/vim/surround.git
git clone https://github.com/simnalamburt/vim-mundo
git clone https://github.com/ap/vim-buftabline.git
git clone https://github.com/preservim/nerdtree.git
git clone https://github.com/junegunn/fzf.git
git clone https://github.com/junegunn/fzf.vim.git
git clone https://github.com/dmerejkowsky/vim-ale.git
git clone https://github.com/mileszs/ack.vim.git
