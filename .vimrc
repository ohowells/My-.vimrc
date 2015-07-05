set shell=/bin/bash

set nocompatible              " be iMproved, required
filetype on                   " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Plugins to be managed by Vundle
" ----------------------------------------------------------
"Plugin 'edkolev/promptline.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jiangmiao/auto-pairs'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-markdown'
Plugin 'suan/vim-instant-markdown'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'airblade/vim-gitgutter'
Plugin 'chriskempson/base16-vim'
Plugin 'tpope/vim-fugitive'
" ------------------------------------------------------------
"
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ

" faster update time
set updatetime=700

syntax on
let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme base16-monokai
set background=dark

"tabs and spaces
set paste           
set shiftwidth=4	"1 tab == 4 spaces
set tabstop=4		"<TAB> == 4 spaces
set smarttab		"smart tab
set autoindent		"set auto indent
set expandtab
set cindent			"stricter indent rules for c type languages
set preserveindent	"save as much indent structure as possible

"UI Config
set number			"line number
set showmatch		"highlight matching [({})]
set magic			"magic for regular expression
set confirm			"ask to save file
set showcmd			"display incomplete command in the lower right corner of the console
set undolevels=1000	"let vim allow 1000 undos
set colorcolumn=100
highlight ColorColumn ctermbg=236

" git-gutter
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
let g:gitgutter_diff_args = '-w'
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = ':'
let g:gitgutter_max_signs = 1500
highlight clear SignColumn
highlight GitGutterAdd ctermfg=green ctermbg=235
highlight GitGutterChange ctermfg=yellow ctermbg=235
highlight GitGutterDelete ctermfg=red ctermbg=235
highlight GitGutterChangeDelete ctermfg=red ctermbg=235

"Searching
set incsearch			   "search as char are entered
set hlsearch			   "highlight matches
set smartcase			   "smart with case search

"Movement
set mouse=a				     "mouse support in console (option + mouseclick for mac users)
set mousehide				 "hide cursor when typing
set scrolloff=5		         "minimum lines to keep above and below

"instant markdown
filetype plugin on          "required

" statusline
set laststatus=2
set cmdheight=2

noremap ; :

" airline UI
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='base16'

function! AirlineInit()
	let g:airline_section_a = airline#section#create(['mode',' ','branch'])
	let g:airline_section_b = airline#section#create_left(['%F'])
	let g:airline_section_c = airline#section#create(['ffenc',' ','[%Y]'])
	let g:airline_section_x = airline#section#create(['%P'])   "P
	let g:airline_section_y = airline#section#create(['row:%l/%L'])
	let g:airline_section_z = airline#section#create_right(['col:%03c'])
endfunction
autocmd VimEnter * call AirlineInit()

" Syntastic settings recommended
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" enable all checkers on same file
let g:syntastic_aggregate_errors = 1

" enable syntax checkers
let g:syntastic_c_checkers = ['gcc']
let g:syntastic_cpp_checkers = ['cppcheck' , 'gcc' , 'make']
let g:syntastic_matlab_checkers = ['mlint']
let g:syntastic_markdown_checkers = ['mdl']
let g:syntastic_text_checkers = ['language_check' , 'atdtool']

let g:syntastic_cpp_compiler = 'clang++' " C++ compiler
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++' " C++11 support
let g:syntastic_cpp_compiler_options = ' -std=c++1y' " C++14 support

" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary")
map <C-n> :NERDTreeToggle<CR>

" vim-markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown    " *.md support

" spelling
:nnoremap <C-a> :set spell!<CR>

" YouCompleteMe file
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

" automatic Whitespace removal
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd FileType cpp,h, autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
