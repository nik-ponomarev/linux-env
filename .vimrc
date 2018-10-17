" GENERAL
set nocompatible

" Autoread options
set autoread
autocmd CursorHold,CursorHoldI,FocusGained,BufEnter * checktime
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" COLORS

" enable syntax processin
syntax enable
colorscheme monokai

" SPACES AND TABS

" number of visual spaces per TAB
set tabstop=4

" number of spaces to be shifted
set shiftwidth=4

" number of spaces in tab when editing
set softtabstop=4

" tabs are spaces
set expandtab

" UI CONFIG

" show line numbers
set number

" show whitespaces and tabs
set list
set listchars=tab:>-,trail:~,extends:>,precedes:<

" Can move one more character after line end
set virtualedit=onemore

" show command in bottom bar
set showcmd
set showmode

" highlight current line
set cursorline

" load filetype-specific indent files
filetype indent on

" visual autocomplete for command menu
set wildmenu

" redraw only when we need to
set lazyredraw

" highlight matching [{()}]
set showmatch

" SEARCHING

" ignore case when searching
set ignorecase

" search as characters are entered
set incsearch

" highlight matches
set hlsearch

" KEY MAPPINGS

:let mapleader = ","

" Delete current Buffer
nmap <leader>w :bp<bar>bd #<CR>

" Ctags

set tags=./tags;,tags;./.tags;,.tags;

" Generate/add ctags for TBB project
function! GenerateTBBTags()
    let tbb_tags_command = "uctags -f .tags -R include src/tbb src/tbbmalloc src/tbbproxy"
    silent exec "!" . tbb_tags_command
    redraw!
endfunction

:command TBBTags :call GenerateTBBTags()

" PLUGIN MANAGER VIM-PLUG

" Specify a directory for plugins
call plug#begin('~/.vim/plugins')

" On-demand loading of NerdTREE
Plug 'scrooloose/nerdtree', { 'on' : 'NERDTreeToggle' }

" Air-line
Plug 'vim-airline/vim-airline'

" NERD Commenter
Plug 'scrooloose/nerdcommenter'

" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Tagbae. List of tags in current file, bird's eye view.
" Plug 'majutsushi/tagbar'

" Vim dispatch
Plug 'tpope/vim-dispatch'

" Markdown
Plug 'plasticboy/vim-markdown'

" Snippets engine
Plug 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

" Initialize plugin system
call plug#end()

"" PLUGIN CONFIGS

"" NerdTREE config

" defaults
let NERDTreeShowHidden=1

" hotkeys
map <C-n> :NERDTreeToggle<CR>

" close vim if only NerdTREE opened
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"" Air-line config

let g:airline#extensions#tabline#enabled = 1

"" NERD Commenter config

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Vim-dispatch build
nnoremap <F5> :Dispatch<CR>

" Markdown config
let g:vim_markdown_folding_disabled = 1 

" UltiSnips snippets configuration
" Trigger configuration.
let g:UltiSnipsExpandTrigger="<tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" FZF config

" Default fzf layout
" " - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" Augmenting Ag command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], preview window, [toggle keys...]])
" :Ag  - Start fzf with hidden preview window that can be enabled with \"?\" key
" :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
    \               <bang>0 ? fzf#vim#with_preview('up:60%')
      \                 : fzf#vim#with_preview('right:50%:hidden','?'),
        \           <bang>0)

" Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" Ctags command
let g:fzf_tags_command = 'uctags -f .tags -R .'

" Mappings
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>t :Tags<CR>
nnoremap <leader>a :Ag<SPACE>
