syntax on
set undodir=~/.vim/undodir
set backspace=indent,eol,start
set cmdheight=2
set updatetime=100
set noswapfile
set nowrap
set nu
set undofile
set softtabstop=4 shiftwidth=4 expandtab
set ignorecase
filetype plugin indent on

" Remaps
imap jj <Esc>

" Netrw settings
let g:netrw_liststyle=3
let g_netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_winsize=25

" Disable ALE LSP for CoC
let g:ale_disable_lsp = 1

" Vim Plug plugin manager
" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'arcticicestudio/nord-vim'

call plug#end()

" dank colors
colorscheme nord
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
