"*****************************************************************************
"" Vim-Plug core
"*****************************************************************************
"
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
if has('win32')&&!has('win64')
  let curl_exists=expand('C:\Windows\Sysnative\curl.exe')
else
  let curl_exists=expand('curl')
endif

" let g:vim_bootstrap_langs = "html,javascript,php,python,typescript"
let g:vim_bootstrap_editor = "nvim"				" nvim or vim
let g:vim_bootstrap_frams = "vuejs"

if !filereadable(vimplug_exists)
  if !executable(curl_exists)
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!"curl_exists" -fLo " . shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.config/nvim/plugged'))

"*****************************************************************************
"" Plug install packages
"*****************************************************************************
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/CSApprox'
Plug 'Raimondi/delimitMate'
Plug 'majutsushi/tagbar'
Plug 'Yggdroot/indentLine'
Plug 'editor-bootstrap/vim-bootstrap-updater'
Plug 'tpope/vim-rhubarb' " required by fugitive to :Gbrowse


if isdirectory('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
endif
let g:make = 'gmake'
if exists('make')
        let g:make = 'make'
endif
Plug 'Shougo/vimproc.vim', {'do': g:make}

"" Snippets
Plug 'honza/vim-snippets'

"*****************************************************************************
"" Custom bundles
"*****************************************************************************

" html
"" HTML Bundle
Plug 'hail2u/vim-css3-syntax'
Plug 'gko/vim-coloresque'
Plug 'tpope/vim-haml'
Plug 'mattn/emmet-vim'


" javascript
"" Javascript Bundle
Plug 'jelera/vim-javascript-syntax'


" php
"" PHP Bundle
Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install --no-dev -o'}
Plug 'stephpy/vim-php-cs-fixer'


" python
"" Python Bundle
Plug 'davidhalter/jedi-vim'
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}


" typescript
Plug 'leafgarland/typescript-vim'
Plug 'HerringtonDarkholme/yats.vim'


" vuejs
Plug 'posva/vim-vue'
Plug 'leafOfTree/vim-vue-plugin'

" blade
Plug 'yaegassy/coc-blade-formatter', {'do': 'npm install --frozen-lockfile'}
" custom package
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'editorconfig/editorconfig-vim'
Plug 'ekalinin/dockerfile.vim'
Plug 'tpope/vim-dotenv'
Plug 'ryanoasis/vim-devicons'
Plug 'sainnhe/gruvbox-material'
Plug 'terryma/vim-multiple-cursors'
Plug 'thaerkh/vim-workspace'
Plug '907th/vim-auto-save'
Plug 'burntsushi/ripgrep'
Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }
Plug 'sheerun/vim-polyglot'
Plug 'schickling/vim-bufonly'
Plug 'apzelos/blamer.nvim'
Plug 'junegunn/vim-easy-align'
Plug 'vim-test/vim-test'
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
Plug 'voldikss/vim-floaterm'
Plug 'tpope/vim-surround'

"*****************************************************************************
"*****************************************************************************

"" Include user's extra bundle
if filereadable(expand("~/.config/nvim/local_bundles.vim"))
  source ~/.config/nvim/local_bundles.vim
endif

call plug#end()

" Required:
filetype plugin indent on


"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8


"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overridden by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent

"" Map leader to ,
let mapleader=','

"" Enable hidden buffers
set hidden
set nowrap
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
set noswapfile

set pumheight=10                        " Makes popup menu smaller
set conceallevel=0                      " So that I can see `` in markdown files

" Give more space for displaying messages.
set cmdheight=2
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=1000

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
"" Searching
set hlsearch
set incsearch
"set ignorecase
"set smartcase
set autowriteall

set fileformats=unix,dos,mac

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

" session
function OpenCurrentSession()
    if (argc() == 1 && isdirectory(argv()[0]))
        execute 'CocCommand session.load ' . substitute(getcwd(), '/', '_', 'g')
        sleep 1000m
        execute 'CocCommand explorer --preset pwd'
    endif
endfunction


function SaveCurrentSession()
execute 'CocCommand session.save ' . substitute(getcwd(), '/', '_', 'g')
endfunction

nnoremap <leader>ss :call SaveCurrentSession()<CR>
nnoremap <leader>so :CocList sessions<CR>
autocmd VimEnter * nested call OpenCurrentSession()
"autocmd VimEnter * nested call OpenCurrentSession()

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax on
set ruler
set number

let no_buffers_menu=1
" Important!!
if has('termguicolors')
set termguicolors
endif
" For dark version.
set background=dark
colorscheme gruvbox-material
let g:gruvbox_material_background = 'soft'
let g:gruvbox_material_better_performance = 1

set mousemodel=popup
set t_Co=256
set guioptions=egmrti
set gfn=FiraCode\ Nerd\ Font\ 10

if has("gui_running")
    set cursorline                          " Enable highlighting of the current line
    set guifont=FiraCode\ Nerd\ Font:h12
    if has("gui_mac") || has("gui_macvim")
        set transparency=7
    endi 
else
if exists('g:vv')
    set guifont=FiraCodeNerdFontComplete-Regular:h12
    VVset fontfamily=FiraCodeNerdFontComplete-Regular
    VVset fontsize=10
    VVset windowheight=100%
    VVset windowwidth=100%
    VVset windowleft=0
    VVset windowtop=0
endif

if exists('g:neovide') 
    set cursorline                          " Enable highlighting of the current line
    set guifont=FiraCode\ Nerd\ Font:h10
    let g:neovide_refresh_rate=140
    let g:neovide_cursor_antialiasing=v:true
    let g:neovide_transparency=0.9
    let g:neovide_cursor_vfx_mode = "railgun"

    " copy paste
    vmap <D-c> y<Esc>i
    vmap <D-x> d<Esc>i
    imap <D-v> <Esc>pi
    imap <D-y> <Esc>ddi
    map <D-z> <Esc>
    imap <D-z> <Esc>ui

    " undo redo
    nnoremap <D-z> u
    nnoremap <D-y> <C-R>
    inoremap <D-z> <C-O>u
    inoremap <D-y> <C-O><C-R>

    " save
    nnoremap <silent><D-s> :<c-u>update<cr>
    vnoremap <silent><D-s> <c-c>:update<cr>gv
    inoremap <silent><D-s> <c-o>:update<cr>
else
    " undo redo
    nnoremap <C-z> u
    nnoremap <C-y> <C-R>
    inoremap <C-z> <C-O>u
    inoremap <C-y> <C-O><C-R>
endif

let g:CSApprox_loaded = 1

set nocursorline        " Don't paint cursor line
set nocursorcolumn      " Don't paint cursor column
set lazyredraw          " Wait to redraw
set ttyfast
set scrolljump=8        " Scroll 8 lines at a time at bottom/top
let html_no_rendering=1 " Don't render italic, bold, links in HTML


" IndentLine
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = 0
let g:indentLine_char = '???'
let g:indentLine_faster = 1
endif

"" Disable the blinking cursor.
set gcr=a:blinkon0

au TermEnter * setlocal scrolloff=0
au TermLeave * setlocal scrolloff=3


"" Status bar
set laststatus=2

"" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

" Search mappings: These will make it so that going to the next one in a
vnoremap <silent> <leader>f :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>
" global search with CocSearch
nnoremap <silent> <leader>FA ""y:CocSearch -F <C-R>=expand('<cword>')<CR><CR>
nnoremap <silent> <leader>FD ""y:CocSearch -F <C-R>=expand('<cword>')<CR> -g <C-R>=GetAbsoluteForderPath()<CR>/**<CR>

vnoremap <silent> <leader>FA ""y:CocSearch -F <C-R>=escape(@", '/\')<CR><CR>
vnoremap <silent> <leader>FD ""y:CocSearch -F <C-R>=escape(@", '/\')<CR> -g <C-R>=GetAbsoluteForderPath()<CR>/**<CR>

" global search with ripgrep
nnoremap <silent> <leader>GA :Grepper -cword -noprompt<CR><CR>
nnoremap <silent> <leader>GD :Grepper -cword -noprompt -cd .<C-R>=GetAbsoluteForderPath()<CR><CR><CR>

" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Replace mappings
vnoremap <leader>R ""y:%s/<C-R>=escape(@", '/\')<CR>//g<Left><Left>
vnoremap <leader>r ""y:%s/<C-R>=expand('<cword>')<CR>//g<Left><Left>

" After searching for text, press this mapping to do a project wide find and
" replace. It's similar to <leader>r except this one applies to all matches
" across all files instead of just the current file.
nnoremap <Leader>RA
  \ :let @s='\<'.expand('<cword>').'\>'<CR>
  \ :Grepper -cword -noprompt<CR>
  \ :cfdo %s/<C-r>s//g \| update
  \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

nnoremap <Leader>RD
  \ :let @s='\<'.expand('<cword>').'\>'<CR>
  \ :Grepper -cword -noprompt -cd .<C-R>=GetAbsoluteForderPath()<CR><CR>
  \ :cfdo %s/<C-r>s//g \| update
  \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

" The same as above except it works with a visual selection.
xmap <Leader>RA
    \ "sy
    \ gvgr
    \ :cfdo %s/<C-r>s//g \| update
     \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

if exists("*fugitive#statusline")
set statusline+=%{fugitive#statusline()}
endif

" vim-airline
let g:airline_theme = 'gruvbox_material'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1

"*****************************************************************************
"" Abbreviations
"*****************************************************************************
"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite

" terminal emulation
nnoremap <silent> <leader>sh :terminal<CR>


"*****************************************************************************
"" Commands
"*****************************************************************************
" remove trailing whitespaces
command! FixWhitespace :%s/\s\+$//e

"*****************************************************************************
"" Functions
"*****************************************************************************
if !exists('*s:setupWrapping')
function s:setupWrapping()
set wrap
set wm=2
set textwidth=79
endfunction
endif

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************
"" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
augroup vimrc-sync-fromstart
autocmd!
autocmd BufEnter * :syntax sync maxlines=200
augroup END

"" Remember cursor position
augroup vimrc-remember-cursor-position
autocmd!
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

"" txt
augroup vimrc-wrapping
autocmd!
autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

"" make/cmake
augroup vimrc-make-cmake
autocmd!
autocmd FileType make setlocal noexpandtab
autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

set autoread
au CursorHold * checktime

"*****************************************************************************
"" Mappings
"*****************************************************************************

"" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

" git blamer
let g:blamer_enabled = 1
let g:blamer_show_in_visual_modes = 0
let g:blamer_show_in_insert_modes = 0
let g:blamer_delay = 500

"" Tabs
" nnoremap <Tab> gt
" nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

"" Opens an edit command with the path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"" Opens a tab edit command with the path of the currently edited file filled
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

"" fzf.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6  }  }
" The Silver Searcher
if executable('ag')
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
set grepprg=ag\ --nogroup\ --nocolor
endif

" ripgrep
if executable('rg')
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
set grepprg=rg\ --vimgrep
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>p :Files<CR>
"Recovery commands from history through FZF
nmap <leader>y :History:<CR>

" Tagbar
nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
autocmd GUIEnter * set visualbell t_vb=
endif

"" Copy/Paste/Cut
if has('unnamedplus')
set clipboard=unnamed,unnamedplus
endif

noremap YY "+y<CR>
" noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

if has('macunix')
" pbcopy for OSX copy/paste
vmap <C-x> :!pbcopy<CR>
vmap <C-c> :w !pbcopy<CR><CR>
endif

"" Close buffer
noremap <leader>c :bd<CR>
noremap <leader>ca :BOnly<CR>

"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
vnoremap <C-S-UP> :m '<-2<CR>gv=gv
vnoremap <C-S-DOWN> :m '>+1<CR>gv=gv

"" Open current line on GitHub
nnoremap <Leader>o :.Gbrowse<CR>

"*****************************************************************************
"" Custom configs
"*****************************************************************************

" html
" for html files, 2 spaces
autocmd Filetype html setlocal ts=2 sw=2 expandtab

" javascript
let g:javascript_enable_domhtmlcss = 1

" vim-javascript
augroup vimrc-javascript
autocmd!
autocmd FileType javascript setl tabstop=4|setl shiftwidth=4|setl expandtab softtabstop=4
augroup END

autocmd FileType scss setl iskeyword+=@-@
autocmd BufNewFile,BufRead *.php set iskeyword+=$

" php
" Phpactor plugin
" Include use statement
nmap <Leader>pi :call phpactor#UseAdd()<CR>
nmap <Leader>pcn :call phpactor#ClassNew()<CR>
nmap <Leader>pcm :PhpactorContextMenu<CR>
" Extract expression (normal mode)
nmap <silent><Leader>pee :call phpactor#ExtractExpression(v:false)<CR>
" Extract expression from selection
vmap <silent><Leader>pee :<C-U>call phpactor#ExtractExpression(v:true)<CR>
" Extract method from selection
vmap <silent><Leader>pem :<C-U>call phpactor#ExtractMethod()<CR>


" python
" vim-python
augroup vimrc-python
autocmd!
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
  \ formatoptions+=croq softtabstop=4
  \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END

" jedi-vim
let g:jedi#popup_on_dot = 0
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#rename_command = "<leader>r"
let g:jedi#show_call_signatures = "0"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#smart_auto_mappings = 0

" vim-airline
let g:airline#extensions#virtualenv#enabled = 1

" Syntax highlight
let python_highlight_all = 1


" typescript
let g:yats_host_keyword = 1



" vuejs
" vim vue
let g:vue_disable_pre_processors=1
" vim vue plugin
let g:vim_vue_plugin_load_full_syntax = 1


"*****************************************************************************
"*****************************************************************************

"" Include user's local vim config
if filereadable(expand("~/.config/nvim/local_init.vim"))
source ~/.config/nvim/local_init.vim
endif

"*****************************************************************************
"" Convenience variables
"*****************************************************************************

" vim-airline
if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_left_sep          = '???'
let g:airline_left_alt_sep      = '??'
let g:airline_right_sep         = '???'
let g:airline_right_alt_sep     = '??'
let g:airline#extensions#branch#prefix     = '???' "???, ???, ???
let g:airline#extensions#readonly#symbol   = '???'
let g:airline#extensions#linecolumn#prefix = '??'
let g:airline#extensions#paste#symbol      = '??'
let g:airline_symbols.linenr    = '???'
let g:airline_symbols.branch    = '???'
let g:airline_symbols.paste     = '??'
let g:airline_symbols.paste     = '??'
let g:airline_symbols.paste     = '???'
let g:airline_symbols.whitespace = '??'
let g:airline_symbols.linenr = ' ??? '
let g:airline_symbols.linenr = '???'
let g:airline_symbols.linenr = '???'
let g:airline_symbols.maxlinenr = ' '
let g:airline_symbols.maxlinenr = ' ???'
else
let g:airline#extensions#tabline#left_sep = '???'
let g:airline#extensions#tabline#left_alt_sep = '???'

" powerline symbols
let g:airline_left_sep = '???'
let g:airline_left_alt_sep = '???'
let g:airline_right_sep = '???'
let g:airline_right_alt_sep = '???'
let g:airline_symbols.branch = '???'
let g:airline_symbols.readonly = '???'
let g:airline_symbols.linenr = '???'
let g:airline_symbols.linenr = '???'
let g:airline_symbols.linenr = '???'
let g:airline_symbols.linenr = '??'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '???'
endif

" loading the plugin
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1

" map comment
nmap <leader>/ <Plug>CommentaryLine
xmap <leader>/ <Plug>Commentary
omap <leader>/ <Plug>Commentary

let g:context#commentstring#table = {}

let g:context#commentstring#table.php = {
        \ 'javaScript'  : '// %s',
        \ 'phpRegion'   : '// %s',
        \ 'cssStyle'    : '/*%s*/',
        \}

let g:context#commentstring#table.vim = {
        \ 'vimLuaRegion'     : '--%s',
        \ 'vimPerlRegion'    : '#%s',
        \ 'vimPythonRegion'  : '#%s',
        \}

let g:context#commentstring#table.html = {
        \ 'javaScript'  : '//%s',
        \ 'cssStyle'    : '/*%s*/',
        \}

let g:context#commentstring#table.xhtml = g:context#commentstring#table.html

let g:context#commentstring#table['javascript.jsx'] = {
        \ 'jsComment' : '// %s',
        \ 'jsImport' : '// %s',
        \ 'jsxStatment' : '// %s',
        \ 'jsxRegion' : '{/*%s*/}',
        \ 'jsxTag' : '{/*%s*/}',
        \}

let g:context#commentstring#table['typescript.tsx'] = {
        \ 'tsComment' : '// %s',
        \ 'tsImport' : '// %s',
        \ 'tsxStatment' : '// %s',
        \ 'tsxRegion' : '{/*%s*/}',
        \ 'tsxTag' : '{/*%s*/}',
        \}


let g:context#commentstring#table.vue = {
        \ 'javaScript'  : '//%s',
        \ 'cssStyle'    : '/*%s*/',
        \}

let g:context#commentstring#table['javascript.vue'] = {
        \ 'javaScript'  : '//%s',
        \ 'cssStyle'    : '/*%s*/',
        \}

if exists('g:loaded_context_commentstring')
finish
endif


augroup ContextCommentstringBootstrap
autocmd!
autocmd FileType * call <SID>Setup()
augroup END


function! s:Setup()
augroup ContextCommentstringEnabled
    " Clear previous autocommands first in all cases, in case the filetype
    " changed from something in the table, to something NOT in the table.
    autocmd! CursorMoved <buffer>
    if !empty(&filetype) && has_key(g:context#commentstring#table, &filetype)
        let b:original_commentstring=&l:commentstring
        autocmd CursorMoved <buffer> call <SID>UpdateCommentString()
    endif
augroup END
endfunction


function! s:UpdateCommentString()
let l:stack = synstack(line('.'), col('.'))
if !empty(l:stack)
    for l:name in map(l:stack, "synIDattr(v:val, 'name')")
        if has_key(g:context#commentstring#table[&filetype], l:name)
            let &l:commentstring = g:context#commentstring#table[&filetype][l:name]
            return
        endif
    endfor
endif
let &l:commentstring = b:original_commentstring
endfunction


let g:loaded_context_commentstring = 1
" map replace
:nnoremap <Leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>
" vue config
let g:vue_pre_processors = 'detect_on_enter'
let g:vim_vue_plugin_config = { 
  \'syntax': {
  \   'template': ['html'], 
  \   'script': ['javascript'],
  \   'style': ['css'],
  \   'i18n': ['json'],
  \   'docs': 'markdown',
  \},
  \'full_syntax': ['css', 'html'],
  \'attribute': 1,
  \'keyword': 1,
  \}

" coc config
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
let col = col('.') - 1
return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
inoremap <silent><expr> <c-space> coc#refresh()
else
inoremap <silent><expr> <c-@> coc#refresh()
endif

let g:coc_global_extensions = [
\ 'coc-snippets',
\ 'coc-prettier', 
\ 'coc-json', 
\ 'coc-explorer',
\ 'coc-lists',
\ ]

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nnoremap <silent> <F10> :CocDiagnostics<CR> 
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> <F12> <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
else
    execute '!' . &keywordprg . " " . expand('<cword>')
endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>fm  <Plug>(coc-format-selected)
nmap <leader>fm  <Plug>(coc-format-selected)

augroup mygroup
autocmd!
" Setup formatexpr specified filetype(s).
autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
" Update signature help on jump placeholder.
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>aa  <Plug>(coc-codeaction-selected)
nmap <leader>aa  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <leader>ae  :<C-u>CocList diagnostics<cr>
" Show commands.
nnoremap <silent><nowait> <leader>cmd  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <leader>r  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <leader>S  :<C-u>CocList -I symbols<cr>
set sessionoptions+=globals

" buffers
noremap <Tab> :bn<CR>
noremap <S-Tab> :Buffers<CR>
map gn :bn<cr>
map gp :bp<cr>

"explorer
" let g:loaded_netrw  = 1
" let g:loaded_netrwPlugin = 1
" let g:loaded_netrwSettings = 1
" let g:loaded_netrwFileHandlers = 1
" let g:loaded_matchit = 1
:nnoremap <F3> :CocCommand explorer --preset pwd<CR>
let g:coc_explorer_global_presets = {
\   'pwd': {
\     'root-uri': getcwd(),
\   },
\ }
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif

augroup end
if exists('#User#CocGitStatusChange')
    doautocmd <nomodeline> User CocGitStatusChange
endif

function GetAbsoluteForderPath()
    return substitute(expand('%:p:h'), getcwd(), '', '')
endfunction


function GetAbsolutePath()
    return substitute(expand('%"d'), getcwd(), '', '')
endfunction

" yank current directory path into the clipboard
nnoremap fp :!echo -n % \| pbcopy %i<cr>:echo expand('%"d') "is yanked to clipboard"<cr>
" mutiple cursors
nnoremap <silent> <C-j> :MultipleCursorsFind <C-R>/<CR>
vnoremap <silent> <C-j> :MultipleCursorsFind <C-R>/<CR>
" autosave
let g:auto_save = 1
let g:auto_save_events = ["InsertLeave"] 
" let g:auto_save_events = ["InsertLeave", "TextChanged"] 
let g:auto_save_write_all_buffers = 1
" grepper
let g:grepper               = {}
let g:grepper.tools         = ['rg', 'ag', 'git']
let g:grepper.jump          = 1
let g:grepper.next_tool     = '<leader>nt'
let g:grepper.simple_prompt = 1
let g:grepper.quickfix      = 0
" alignment
" Start interactive EasyAlign in visual mode 
xmap <leader>a <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object
nmap <leader>a <Plug>(EasyAlign)

" test
if has('nvim')
let test#strategy='neovim'
else
let test#strategy='vimterminal'
endif

" for neovim
let test#neovim#term_position = "topleft"
let test#neovim#term_position = "vert"
let test#neovim#term_position = "vert botright 100"
" or for Vim8
let test#vim#term_position = "belowright"

function! DockerTransform(cmd) abort
let docker_container_name = '3t-product'
let phpunit_xml = '/var/www/html/phpunit.xml'
return 'docker exec ' . docker_container_name . ' phpdbg -qrr ' . a:cmd . ' -c ' . phpunit_xml . ' --debug --colors=always'
endfunction

let g:test#custom_transformations = {'docker': function('DockerTransform')}
let g:test#transformation = 'docker'

nmap <silent> <leader>tm :TestNearest<cr>
nmap <silent> <leader>tf :TestFile<cr>
nmap <silent> <leader>ta :TestSuite<cr>
nmap <silent> <leader>tp :TestLast<cr>

"floaterm
let g:floaterm_width = 0.8
let g:floaterm_height = 0.8
let g:floaterm_autoclose = 1
nnoremap <silent> <C-t> :FloatermToggle<CR>
tnoremap <silent> <C-t> <C-\><C-n>:FloatermToggle<CR>
tnoremap <silent> <C-n> <C-\><C-n>

" Default highlighting (see help :highlight and help :highlight-link)
highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
highlight link multiple_cursors_visual Visual

