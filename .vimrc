" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2006 Nov 16
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
let $TMPDIR = $HOME."/tmp" 
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" In many terminal emulators the mouse works just fine, thus enable it.
set mouse=a

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
"  set hlsearch
endif

if has("gui_running")
  set guioptions -=m
  set guioptions -=T
  set guifont=Consolas:h11:cANSI:qDRAFT
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    autocmd!
    au!

    autocmd BufNewFile,BufRead *.c set formatprg=astyle
    autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()
    autocmd FileType php setlocal shiftwidth=4 tabstop=4
    autocmd BufWinEnter * let &foldlevel = max(map(range(1, line('$')), 'foldlevel(v:val)'))
    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
	 	\ | wincmd p | diffthis
"Ale config
let g:ale_cpp_cc_options = '-std=c++20 -Wall'

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'jsx': ['eslint'],
\   'python': ['flake8'],
\ }
"let g:ale_python_pylint_options = '-E'

let g:ale_fixers = {
\   'javascript': ['prettier', 'eslint'],
\   'json': ['prettier']
\ }
"\   'python': ['autopep8', 'reorder-python-imports'],

" let g:ale_javascript_prettier_options = '--print-width=120'
" let g:ale_javascript_prettier_options = '--no-semi --single-quote --trailing-comma es5'

" Don't highlight the whole line
let g:ale_set_highlights = 0

" Only lint when saving file
" let g:ale_lint_on_text_changed = 'never'

" Directly fix when saving
let g:ale_fix_on_save = 1

" Modify icons and colors
let g:ale_sign_error = '✖'
hi ALEErrorSign ctermfg=160 ctermbg=236
let g:ale_sign_warning = '⚠'
hi ALEWarningSign ctermfg=222 ctermbg=236
let g:bufferline_fname_mod = ':~:.'

let g:buftabline_numbers = 1

""

let g:php_cs_fixer_cache = "~/tmp/.php_cs.cache" " options: --cache-file
let g:ale_php_phpcs_standard = 'psr2'


set hid
set wmh=0
"set foldmethod=syntax
syntax on

""

map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
noremap ; : 
noremap : ;

nnoremap å i<cr><esc>k$
set backupdir=/home/dmad/.vim/backup
set directory=/home/dmad/.vim/swap
set undodir=/home/dmad/.vim/undo
set undofile
set ignorecase
set smartcase
"set verbosefile=log.txt
"set verbose=15
"next line is write with sudo trick, % is current file
cmap w!! %!sudo tee > /dev/null %
"close all but current buffer
command! BufOnly silent! execute "%bd|e#|bd#"
let mapleader =","
nnoremap <leader>o :BufOnly<CR>
nnoremap <leader>f :FZF<CR>
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>m :MundoToggle<CR>
nnoremap <leader>l oconsole.log('<ESC>pa')<ESC>oconsole.log(<ESC>pa)<ESC>
nnoremap <leader>p oprint(f'<ESC>pa: {<ESC>pa}')<ESC>
nnoremap <leader>c ostd::cout << "<ESC>pa: " << <ESC>pa << '\n';<ESC>
nnoremap <leader>q :cclose<CR>
cnoremap fpwd let @+ = expand("%:p")<CR>
cnoremap svnd VCSDiff
cnoremap svnb VCSBlame!
runtime macros/matchit.vim
set tabstop=4
set shiftwidth=4
set expandtab
set statusline=%-2.3n\ %<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
let g:ackprg = 'ag --nocolor --column'
cabbrev ag Ack!
cabbrev agu Ack! -u
cabbrev ntf NERDTreeFind
cabbrev vb vsp \| b 
set encoding=utf8
set termguicolors
set background=dark
if &term == 'win32'
    let &t_ti.=" \e[1 q"
    let &t_SI.=" \e[5 q-- INSERT --"
    let &t_EI.=" \e[1 q"
    let &t_te.=" \e[0 q"
else
    let &t_ti.="\e[1 q"
    let &t_SI.="\e[5 q"
    let &t_EI.="\e[1 q"
    let &t_te.="\e[0 q"
endif
"tex
let g:vimtex_view_general_viewer= 'sumatraPDF'
let g:vimtex_view_general_options = '-reuse-instance @pdf'
let g:vimtex_view_general_options_latexmk = '-reuse-instance'
