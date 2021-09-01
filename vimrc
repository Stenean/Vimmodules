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
set relativenumber
set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set t_Co=256
colorscheme solarized
set background=dark
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
" No annoying sound on errors {{{
set noerrorbells
set novisualbell
set t_vb=
set tm=500
set switchbuf=useopen
set viewoptions=cursor,slash,unix
set bsdir=current
" }}}
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

" Center screen after search
nnoremap n nzzzv
nnoremap N Nzzzv

" Fix indenting visual block
vmap < <gv
vmap > >gv

inoremap jk <ESC>

nmap <C-P> :FZF<CR>

nnoremap <silent> <leader>DD :exe ":profile start profile.log"<cr>:exe ":profile func *"<cr>:exe ":profile file *"<cr>
nnoremap <silent> <leader>DP :exe ":profile pause"<cr>
nnoremap <silent> <leader>DC :exe ":profile continue"<cr>
nnoremap <silent> <leader>DQ :exe ":profile pause"<cr>:noautocmd qall!<cr>

let g:powerline_pycmd="py3"

" Functions {{{ 

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    inoremap <buffer> <expr><c-f> lsp#scroll(+4)
    inoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    
    " refer to doc to add more commands
endfunction

" }}}

" Autocommands {{{

autocmd BufWritePre *.py :%s/\s\+$//e

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" }}}

" Config {{{

" Solarized {{{

let g:solarized_termcolors = 16

" }}}

" vim-indent-guides {{{

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=0

" }}}

" vim-lsp {{{

let g:lsp_signs_enabled = 1         " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
let g:lsp_highlight_references_enabled = 0

" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')

" }}}

" asyncomplete.vim {{{

let g:asyncomplete_auto_popup = 0

inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
imap <c-space> <Plug>(asyncomplete_force_refresh)
imap <C-@> <C-Space>

" for asyncomplete.vim log
" let g:asyncomplete_log_file = expand('~/asyncomplete.log')

" }}}

" UltiSnips {{{

let g:UltiSnipsExpandTrigger="<meta>"
let g:UltiSnipsRemoveSelectModeMappings = 1

" }}}

" ropevim {{{

let g:ropevim_enable_shortcuts=0

" }}}

" vim-isort {{{

let g:vim_isort_python_version = 'python3'

" }}}

" FZF {{{

let g:fzf_layout = { 'down': '30%' }
let $FZF_DEFAULT_COMMAND = 'find . -type f 
            \ -not -path "**/.git/**" 
            \ -not -path "**/.tox/**" 
            \ -not -path "**/node_modules/**"
            \ -not -path "**/site-packages/**"
            \ -not -name "*.pyc"'

" }}}

" }}}
