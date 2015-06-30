# !/bin/bash

cd
git clone https://github.com/ohowells/My-.vimrc.git
cd

if [-e oldvim]
then
	rm -rf oldvim
fi

if [-e .vim]
then
	# if .vim exists, check if .vimrc exists
	if [-e .vimrc]
	# if both exist, create a dir and move both
	then
		mkdir -p oldvim
		mv .vim oldvim/.vim
		mv .vimrc oldvim/.vimrc
	# if only .vim exists
	else
		mkdir -p oldvim
		mv .vim oldvim/.vim
	fi
else
	# if only .vimrc exists
	if [-e .vimrc]
	then
		mkdir -p oldvim
		mv .vimrc oldvim/.vimrc
	fi
fi

cd
cd My-.vimrc
mv -f .vimrc ..
cd
git clone https://github.com/Mizuchi/STL-Syntax.git
mkdir -p ~/.vim/after/syntax/cpp
mv -f STL-Syntax/after/syntax/cpp/stl.vim ~/.vim/after/syntax/cpp/
rm -rf STL-Syntax My-.vimrc
mkdir -p .vim/bundle
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo '\n' | vim +PluginInstall +qall
