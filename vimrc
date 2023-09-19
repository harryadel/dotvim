call plug#begin('~/.vim/plugged')
" Plug 'tpope/vim-sensible'
Plug 'tpope/vim-abolish'
Plug 'Yggdroot/indentLine'
Plug '907th/vim-auto-save'
Plug 'justinmk/vim-sneak'
Plug 'yegappan/mru'
Plug 'dyng/ctrlsf.vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'tpope/vim-speeddating'
" Plug 'wfxr/minimap.vim'
Plug 'sheerun/vim-polyglot'
Plug 'mattn/emmet-vim'
Plug 'neoclide/npm.nvim', {'do' : 'npm install'}
Plug 'leafgarland/typescript-vim'
Plug 'leshill/vim-json'
Plug 'pangloss/vim-javascript'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
Plug 'jiangmiao/auto-pairs'
" Plug 'altercation/vim-colors-solarized'
Plug 'ayu-theme/ayu-vim'
Plug 'hashivim/vim-terraform'
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdcommenter'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'nlknguyen/copy-cut-paste.vim'
Plug 'ledesmablt/vim-run'
call plug#end()

" make vim behave in more useful way (the default) than vi-compatible manner
set nocompatible
set encoding=utf8
" enables syntax highlighting
" syntax off

" Disables annoying higlighing 
set nospell

" ayu mirage Theme config
set termguicolors     " enable true colors support
" let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
let ayucolor="dark"   " for dark version of theme
colorscheme ayu

" Ignore uppercase test === Test
set ignorecase
" Take note of camelCases fooBar !== foobar 
set smartcase
" Highlight search as you type
set incsearch
" Clear highlight when done
nnoremap <CR> :noh<CR><CR>:<backspace>
" Highlight search findings
set hlsearch
" Automatically save the changes without asking
" set autowriteall

set hidden  " Manage multiple buffers effectively: the current buffer can be “sent” to the
            " background without writing to disk. When a background buffer becomes current again,
            " marks and undo-history are remembered
" Shows history of commands
set showcmd
set showmode
" To allow backspacing over everything in insert mode 
" (including automatically inserted indentation, line breaks and start of insert)
set backspace=indent,eol,start
set history=1000
set autoread
set completeopt=longest,menuone
" disables sounds, bells, beeps and screen flashing
set noerrorbells visualbell t_vb= 
set title
" Allow mouse
set mouse=a 
set background=dark
set t_Co=16
set number
" set relativenumber
" set cursorline
" Dont cut lines at the end of the screen
set nowrap
set linebreak
set scrolloff=8
set signcolumn=yes
set sidescrolloff=5
"set undodir=~/.vim/undodir
" set directory=$HOME/.vim/swp/
" See invisible characters
set list
" Show hidden characters like end of line, trails and tabs
" set listchars=eol:.,tab:>-,trail:~,extends:>,precedes:<
" set listchars=tab:▸\ ,eol:¬
" Allow normal copy-pasting
" https://stackoverflow.com/a/44944386/6688795
" set clipboard=unnamedplus
" lightline config 
set laststatus=2 
set showtabline=2  " always show tabline
if !has('gui_running')
  set t_Co=256
endif
set noshowmode

iabbrev waht what
iabbrev tehn then


let mapleader = ","
let maplocalleader = "\\"
" Shortcut to rapidly toggle `set list`
nnoremap <leader>l :set list!<CR>
" Invisible character colors 
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59


" Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction

function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction

" Only do this part when compiled with support for autocommands
" if has("autocmd")
  " Enable file type detection
  " filetype on
  " augroup filetype_html
  "autocmd!
  "" Syntax of these languages is fussy over tabs Vs spaces
  "autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  "autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

  "" Customisations based on house-style (arbitrary)
  "autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
  "autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
  "autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab

  "" Treat .rss files as XML
  "autocmd BufNewFile,BufRead *.rss setfiletype xml
  " augroup EBD
" endif

" Disable syntax higlighing for markdown files as it disallows me to edit
" hyperlinks
autocmd! FileType markdown setlocal syntax=off

" This line was leading NERDTree and CtrlSF to save empty files in project
" directory
" autocmd BufNewFile * :write
autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
autocmd FileType python nnoremap <buffer> <localleader>c I#<esc>

" label-mode for a minimalist alternative to EasyMotion
let g:sneak#label = 1

" Set the default mode for ctrlsf 
let g:ctrlsf_default_view_mode= 'compact'
" Async search mode so as not to block 
let g:ctrlsf_search_mode= 'async'

" Move between windows
" vnoremap <C-h> <C-w>h
" vnoremap <C-j> <C-w>j
" vnoremap <C-k> <C-w>k
" vnoremap <C-l> <C-w>l

vnoremap > >gv
vnoremap < <gv

" make . to work with visually selected lines
vnoremap . :normal.<CR>

if has('gui_running')
  set guifont=JetBrains\ Mono
endif

let g:auto_save = 1  " enable AutoSave on Vim startup

" Nerdtree config
" in NERDTree, to open-silently file in newtab with Enter, instead of default
" pressing "T" (same for not silently with Tab instead of t) 
let NERDTreeMapOpenInTab='<TAB>'
let NERDTreeMapOpenInTabSilent='<ENTER>'
" Show hidden files
let NERDTreeShowHidden=1
" Toggle NerdTree using Ctrl + B just like vscode 
nnoremap <C-b> :NERDTreeToggle<CR>
" tab movement
" nnoremap <C-b> :NERDTreeToggle<CR>

" How NERDTree would know in which window to to open up? 
" http://vimcasts.org/blog/2013/01/oil-and-vinegar-split-windows-and-project-drawer/
let NERDTreeHijackNetrw=1


" open up tab with Ctrl + T 
nnoremap <C-t> :tabnew<CR>
" Ctrl + w interfers with window movement
" nnoremap <C-w>     :tabclose<CR>

" Move between tabs using Ctrl + h or Ctrl + l
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>

" Bubble single lines
nmap <C-k> [e
nmap <C-j> ]e
" Bubble multiple lines
vmap <C-k> [egv
vmap <C-j> ]egv

" minimap config
" let g:minimap_width = 10
" let g:minimap_auto_start = 1
" let g:minimap_auto_start_win_enter = 1

" Switching between Vim and a terminal 
" Type fg in terminal to get back to vim
" nnoremap <leader>t :stop<CR>
" Just found out this can be achieved with Ctrl+z without a need for remap

"augroup buffer_write
"autocmd TextChanged,TextChangedI <buffer> silent write
"augroup END

let g:lightline = {
      \ 'colorscheme': 'ayu_dark',
      \ }

 let g:lightline.tabline = {
      \   'left': [ ['buffers'] ],
      \   'right': [ ['close'] ],
      \ }

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \   'buffers': 'lightline#bufferline#buffers',
      \ }

let g:lightline.component_type = {
      \     'linter_checking': 'right',
      \     'linter_infos': 'right',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'right',
      \     'buffers': 'tabsel',
      \ }

let g:lightline.active = { 
     \    'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ]],
     \    'left': [ [ 'mode', 'paste', ], [ 'readonly', 'filename', 'modified', ], ],
\ }


"coc config
" I work with Meteor 2.x which forces me to use Node 14 so I've to set custom
" path explicity
let g:coc_node_path = '/home/harry/n/n/versions/node/18.17.1/bin/node'
" inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" pangloss/vim-javascript config
let g:javascript_plugin_jsdoc = 1

" Ale Config
let g:ale_fixers = {
 \ 'javascript': ['eslint']
 \ }
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_lint_on_enter = 0
let g:ale_fix_on_save = 1
" Leave the language server protocol to CoC
let g:ale_disable_lsp = 1
" let g:airline#extensions#ale#enabled = 1
" let g:airline#extensions#bufferline#enabled = 1
" let g:ale_completion_enabled = 1

nnoremap <leader>af :ALEFix<cr>
"Move between linting errors
nnoremap ]r :ALENextWrap<CR>
nnoremap [r :ALEPreviousWrap<CR>

" Ctrl+P config
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
    \ 'AcceptSelection("t")': ['<cr>'],
    \ }
" Turns off caching so it can automatically detect new files 
let g:ctrlp_use_caching = 0


" vim airline config
" let g:airline_theme='solarized'
" let g:airline_solarized_bg='dark'

" Terraform config
let g:terraform_fmt_on_save=1
let g:terraform_align=1

" Edit my vim file
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

" Pressing ,v opens the vimrc file in a new tab
nmap <leader>v :tabedit $MYVIMRC<CR>

" clear the highlights
nmap <silent> ,/ :nohlsearch<CR>

" Nerd tree toggle shortcut
nmap t :NERDTreeToggle<CR>

" Exist insert mode using jk instead of <esc>
inoremap jk <esc>
" Disable old escape
inoremap <esc> <nop>

nnoremap <C-c> "+y
vnoremap <C-c> "+y
nnoremap <C-v> "+p
vnoremap <C-v> "+p
