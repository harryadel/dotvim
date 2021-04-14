set nocompatible

call plug#begin('~/.vim/plugged')
Plug 'yegappan/mru'
Plug 'wfxr/minimap.vim'
Plug 'neoclide/npm.nvim', {'do' : 'npm install'}
Plug 'leafgarland/typescript-vim'
Plug 'leshill/vim-json'
Plug 'tpope/vim-markdown'
Plug 'pangloss/vim-javascript'
Plug 'marijnh/tern_for_vim'
Plug 'slava/tern-meteor'
Plug 'slava/vim-spacebars'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dense-analysis/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'altercation/vim-colors-solarized'
Plug 'hashivim/vim-terraform'
Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'mengelbrecht/lightline-bufferline'
call plug#end()

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬
" Invisible character colors 
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" Allow normal copy-pasting
" https://stackoverflow.com/a/44944386/6688795
set clipboard=unnamedplus
set paste

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
if has("autocmd")
  " Enable file type detection
  filetype on

  " Syntax of these languages is fussy over tabs Vs spaces
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

  " Customisations based on house-style (arbitrary)
  autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab

  " Treat .rss files as XML
  autocmd BufNewFile,BufRead *.rss setfiletype xml
endif

" Move between windows
" map <C-h> <C-w>h
" map <C-j> <C-w>j
" map <C-k> <C-w>k
" map <C-l> <C-w>l

vnoremap > >gv
vnoremap < <gv



set encoding=utf8
syntax enable
set spell
set hidden  " Manage multiple buffers effectively: the current buffer can be “sent” to the
            " background without writing to disk. When a background buffer becomes current again,
            " marks and undo-history are remembered
set showcmd
set showmode
set backspace=indent,eol,start
set history=1000
set autoread
set noerrorbells 
set visualbell
set title
set mouse=a 
set background=dark
set number
set cursorline
set nowrap
set linebreak
set scrolloff=3
set sidescrolloff=5
set undodir=~/.vim/undodir
colorscheme solarized
set directory=$HOME/.vim/swp//
if has('gui_running')
  set guifont=JetBrains\ Mono
endif
" for linux and windows users (using the control key)
" map <C-S-]> gt
" map <C-S-[> gT
" map <C-1> 1gt
" map <C-2> 2gt
" map <C-3> 3gt
" map <C-4> 4gt
" map <C-5> 5gt
" map <C-6> 6gt
" map <C-7> 7gt
" map <C-8> 8gt
" map <C-9> 9gt
" map <C-0> :tablast<CR>

" Nerdtree config
" in NERDTree, to open-silently file in newtab with Enter, instead of default
" pressing "T" (same for not silently with Tab instead of t) 
let NERDTreeMapOpenInTab='<TAB>'
let NERDTreeMapOpenInTabSilent='<ENTER>'
" tab movement
" nnoremap <C-b> :NERDTreeToggle<CR>


nnoremap <C-t>     :tabnew<CR>
" Ctrl + w interfers with window movement
" nnoremap <C-w>     :tabclose<CR>
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>

" Bubble single lines
nmap <C-k> [e
nmap <C-j> ]e
" Bubble multiple lines
vmap <C-k> [egv
vmap <C-j> ]egv


" minimap config
let g:minimap_width = 10
let g:minimap_auto_start = 1
let g:minimap_auto_start_win_enter = 1

" lightline config 
set laststatus=2 
set showtabline=2  " always show tabline
autocmd BufWritePost,TextChanged,TextChangedI * call lightline#update()

let g:lightline = {
      \ 'colorscheme': 'solarized',
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

" vim airline config
" let g:airline_theme='solarized'
" let g:airline_solarized_bg='dark'

" Terraform config
let g:terraform_fmt_on_save=1
let g:terraform_align=1

" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

" Pressing ,v opens the vimrc file in a new tab
let mapleader = ","
nmap <leader>v :tabedit $MYVIMRC<CR>
