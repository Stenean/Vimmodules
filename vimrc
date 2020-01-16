" vim: set ts=2 sw=2 sts=2 et fdm=marker:
" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.

let &rtp = "/opt/vim," . &rtp
let &packpath = "/opt/vim," . &packpath
" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

" If you prefer the old-style vim functionalty, add 'runtime! vimrc_example.vim'
" Or better yet, read /usr/share/vim/vim80/vimrc_example.vim or the vim manual
" and configure vim to your own liking!

" do not load defaults if ~/.vimrc is missing
"let skip_defaults_vim=1

" => Powerline setup {{{
python3 << ENDPYTHON
import sys
sys.path.insert(3, '/usr/lib/python3.8/site-packages')

from powerline.vim import setup as powerline_setup
powerline_setup()
del powerline_setup
ENDPYTHON
" }}}

" Syntax and file type setup {{{
syntax on
syntax enable
" Enable filetype plugins
filetype plugin indent on
" }}}
" Set utf8 as standard encoding and en_US as the standard language {{{
let $LANG='en'
set langmenu=en
set encoding=utf8
" }}}
" Use Unix as the standard file type
set ffs=unix,dos,mac
" UI {{{
set number
set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set t_Co=256
colorscheme solarized
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7
" Use spaces instead of tabs
set expandtab
" Be smart when using tabs ;)
set smarttab
" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=8
set softtabstop=4
" Linebreak on 500 characters
set lbr
set tw=99
" Color column for 100 characters
set colorcolumn=100
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines
" }}}
" Set to auto read when a file is changed from the outside {{{
set autoread
set nowrap
" }}}
" More natural split opening {{{
set splitbelow
set splitright
" }}}
" Fold optimisations {{{
syntax sync minlines=256
set synmaxcol=300
set re=1
" }}}
" Mouse support {{{
set mouse=a
set ttymouse=sgr
if has('ballooneval')
  set ballooneval
endif
if has('balloonevalterm')
  set balloonevalterm
endif
" }}}
" With a map leader it's possible to do extra key combinations {{{
" like <leader>w saves the current file
let mapleader = "\\"
let g:mapleader = "\\"
" Fast saving
nmap <leader>w :w!<cr>
" }}}
" Yanks to global system clipboard {{{
set clipboard^=unnamed
set clipboard^=unnamedplus
" }}}
set completeopt=menu,menuone,preview,noselect,noinsert
" Turn on the WiLd menu
set wildmenu
" Ignore compiled files
set wildignore=*.o,*~,*.pyc
" A buffer becomes hidden when it is abandoned
set hid
" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
" Ignore case when searching
set ignorecase
" When searching try to be smart about cases
set smartcase
" Highlight search results
set hlsearch
" Makes search act like search in modern browsers
set incsearch
" Don't redraw while executing macros (good performance config)
set lazyredraw
" Highlight current cursor line
set cursorline
" For regular expressions turn magic on
set magic
" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2
" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
set switchbuf=useopen
set viewoptions=cursor,slash,unix
set bsdir=current
" Turn backup off, since most stuff is in SVN, git et.c anyway... {{{
set nobackup
set nowb
set noswapfile
set undofile "so is persistent undo ...
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload
let s:vim_path = $HOME . '/.vim/'
if strlen(finddir('undo', s:vim_path)) == 0
  call system('mkdir -p ' . s:vim_path . 'undo')
endif
if strlen(finddir('view', s:vim_path)) == 0
  call system('mkdir -p ' . s:vim_path . 'view')
endif
set undodir=/$HOME/.vim/undo/
set viewdir=/$HOME/.vim/view/
" }}}

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

nnoremap <space> za
vnoremap <space> zf

nnoremap <C-g> :ALEGoToDefinition<CR>

let g:powerline_pycmd="py3"

" Config {{{


" ALE {{{

let g:ale_set_balloons = 1
let g:ale_echo_msg_format='[%linter%] %code: %%s'
let g:ale_linters = {
\   'javascript': ['eslint', 'tsserver'],
"\   'python': ['pyls', 'flake8', 'mypy', 'pylint'],
\   'python': ['pyls'],
\   'cpp': ['clangd'],
\}
let g:ale_completion_enabled = 1
let g:ale_history_log_output = 1
" let g:ale_lint_on_text_changed = 'normal'

" }}}

" }}}
