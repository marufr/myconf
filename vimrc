"---------------------------begin Vundle--------------------------------
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" YouCompleteMe
Plugin 'Valloric/YouCompleteMe'

" nerdtree
Plugin 'scrooloose/nerdtree'

" nerd tree tabs
Plugin 'jistr/vim-nerdtree-tabs'

" syntastic
Plugin 'scrooloose/syntastic'

" Nvim-R
Plugin 'jalvesaq/Nvim-R'

" tsuquyomi (for typescript)
" Plugin 'Quramy/tsuquyomi'

" for typescript syntax highlighting
Plugin 'leafgarland/typescript-vim'

" required for tsuquyomi
" Plugin 'Shougo/vimproc'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'

" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'

" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'

" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

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
" Put your non-Plugin stuff after this line
"---------------------------end Vundle----------------------------------

filetype on
set number
set numberwidth=5

" tabs as four spaces
set expandtab
set shiftwidth=4
set softtabstop=4

"-------------------------------------------------------------------------------
" navigation
"-------------------------------------------------------------------------------
" Disable Arrow keys in Escape mode
" map <up> <nop>
" map <down> <nop>
" map <left> <nop>
" map <right> <nop>

" Disable Arrow keys in Insert mode
" imap <up> <nop>
" imap <down> <nop>
" imap <left> <nop>
" imap <right> <nop>
"-------------------------------------------------------------------------------
" stuff for syntastic
"-------------------------------------------------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_cpp_checkers=['clang_check']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" syntastic pylint
let g:syntastic_python_checkers=['pylint']
let g:syntastic_python_pylint_args='--disable=C0103,C0111,C0113'

" syntastic for typescript
let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi'] " You shouldn't use 'tsc' checker.
let g:syntastic_typescript_tsc_fname = ''
"-------------------------------------------------------------------------------
" stuff for YCM
"-------------------------------------------------------------------------------
" see:
" https://github.com/Valloric/YouCompleteMe#user-content-the-gycm_show_diagnostics_ui-option
" for why the following line is here
let g:ycm_show_diagnostics_ui = 1

" hilighting for YCM
hi YcmErrorSection ctermbg=Red

" close the preview window automatically
" let g:ycm_autoclose_preview_window_after_completion=1
"-------------------------------------------------------------------------------
" misc stuff
"-------------------------------------------------------------------------------
" start nerd tree and put the curser in the main window
" autocmd VimEnter * NERDTree
" autocmd VimEnter * wincmd p

" stuff for nerdtree tabs
let g:nerdtree_tabs_autoclose = 1
" let g:nerdtree_tabs_open_on_console_startup = 1
map <Leader>n <plug>NERDTreeTabsToggle<CR>

" Nvim-R
if has("gui_running")
    inoremap <C-Space> <C-x><C-o>
else
   inoremap <Nul> <C-x><C-o>
endif
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine

" handling eol whitespace
function! <SID>StripTrailingWhitespaces()
    let l:save_cursor = getpos('.')
    "let l = line('.')
    "let c = col('.')
    %s/\s\+$//e
    "call cursor(l, c)
    call setpos('.', l:save_cursor)
endfun
autocmd BufWritePre *.tex,*.bib,*.ts,*.js,*.json,*.py,*.c,*.cpp,*.h,*.hpp,.gitignore,.vimrc,*.R,*.md :call <SID>StripTrailingWhitespaces()

" columns at 81 chracters
highlight ColorColumn ctermbg=Gray guibg=Gray
set colorcolumn=81

" hilight matching words in search
set hlsearch
" can be temporarilly stopped with
" :nohlsearch
hi Search ctermbg=DarkYellow ctermfg=White

" map <CR> to turn of search text highlighting
nnoremap <silent> <CR> :nohlsearch<CR><CR>

color industry
syntax on

" highlight current line
set cursorline
hi CursorLine cterm=NONE ctermbg=darkblue ctermfg=white guibg=darkblue guifg=white

" Change Color when entering Insert Mode
autocmd InsertEnter * highlight  CursorLine ctermbg=DarkGreen ctermfg=White guibg=DarkGreen guifg=white

" Revert Color to default when leaving Insert Mode
autocmd InsertLeave * highlight  CursorLine ctermbg=darkblue ctermfg=white guibg=darkblue guifg=white

" Enable backspace opertions
set backspace=indent,eol,start

" Autosave sessions on leaving vim
autocmd VimLeave * :mksession! ~/.vim/sessions/last.vim

"-------------------------------------------------------------------------------
" function keys
"-------------------------------------------------------------------------------
" goto definition
map <F2> :YcmCompleter GoTo<CR>

function! ToggleErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$')
    " Nothing was closed, open syntastic error location panel
        Errors
    endif
endfunction

" Get documentation with YCM
map<F3> :YcmCompleter GetDoc<CR>

" Press F4 to toggle highlighting on/off, and show current value.
map <F4> :set hlsearch! hlsearch?<CR>

" Toggle syntastic errors with F5
map <silent> <F5> :call ToggleErrors()<CR>

" ycm fixit as F9
map <F9> :YcmCompleter FixIt<CR>

" determine syntax highlighting.
" from http://vim.wikia.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

