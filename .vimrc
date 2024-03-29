" Vim Configuration

" General Settings

set nocompatible        " not compatible with the old-fashion vi mode
set bs=2                " allow backspacing over everything in insert mode
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set autoread            " auto read when file is changed from outside
set nu                  " line number
set term=xterm
" set completefunc=syntaxcomplete#Complete " disabled

set hlsearch          " search highlighting
syntax on             " syntax highlight
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins


" auto reload vimrc when editing it
autocmd! bufwritepost .vimrc source ~/.vimrc


" set clipboard=unnamed " yank to the system register (*) by default
set showmatch           " Cursor shows matching ) and }
set showmode            " Show current mode
set wildchar=<TAB>      " start wild expansion in the command line using <TAB>
set wildmenu            " wild char completion menu

" ignore these files while expanding wild chars
set wildignore=*.o,*.class,*.pyc

set autoindent          " auto indentation
set copyindent          " copy the previous indentation on autoindenting
set incsearch           " incremental search
set nobackup            " no *~ backup files
set ignorecase          " ignore case when searching
set smartcase           " ignore case if search pattern is all lowercase, case-sensitive otherwise
set smarttab            " insert tabs on the start of a line according to context

" disable sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500              " timeoutlen

" TAB setting{
   set expandtab        " replace <TAB> with spaces
   set softtabstop=2
   set shiftwidth=2

   au FileType Makefile set noexpandtab
"}                                                             

" status line {
set laststatus=2        " always show status line
set statusline=%m%r%h\ %w\ %{HasPaste()}%<%-15.25(%t%)\ \
set statusline+=\ \ [%{&ff}/%Y]
" current dir path
set statusline+=\ \ \ %<%20.30(%{CurDir()}%)\
" separation between left and right aligned items
set statusline+=%=%-10.(%l,%c%V%)\ %p%%/%L

function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "/~", "")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return '[PASTE]'
    else
        return ''
    endif
endfunction

"}


" C/C++ specific settings
autocmd FileType c,cpp,cc  set cindent comments=sr:/*,mb:*,el:*/,:// cino=>s,e0,n0,f0,{0,}0,^-1s,:0,=s,g0,h1s,p2,t0,+2,(2,)20,*30

"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"---------------------------------------------------------------------------
" Tip #382: Search for <cword> and replace with input() in all open buffers
"---------------------------------------------------------------------------
fun! Replace()
    let s:word = input("Replace " . expand('<cword>') . " with:")
    :exe 'bufdo! %s/\<' . expand('<cword>') . '\>/' . s:word . '/ge'
    :unlet! s:word
endfun


"---------------------------------------------------------------------------
" USEFUL SHORTCUTS
"---------------------------------------------------------------------------
" set leader to ,
let mapleader=","
let g:mapleader=","

"replace the current word in all opened buffers
map <leader>r :call Replace()<CR>

" open the error console
map <leader>cc :botright cope<CR>
" move to next error
map <leader>] :cn<CR>
" move to the prev error
map <leader>[ :cp<CR>

" move around splits {
  " move to and maximize the below split
  map <C-J> <C-W>j<C-W>_
  " move to and maximize the above split
  map <C-K> <C-W>k<C-W>_
  " move to and maximize the left split
  nmap <c-h> <c-w>h<c-w><bar>
  " move to and maximize the right split 
  nmap <c-l> <c-w>l<c-w><bar>
  set wmw=0                     " set the min width of a window to 0 so we can maximize others
  set wmh=0                     " set the min height of a window to 0 so we can maximize others
" }

" move around tabs. conflict with the original screen top/bottom
" comment them out if you want the original H/L
" go to prev tab
map <F11> gT
imap <F11> <C-o>gT
" go to next tab
map <F12> gt
imap <F12> <C-o>gt

" save and sudo save
map <C-t><C-s> :w !sudo tee > /dev/null %<CR>
imap <C-t><C-s> <C-o>:w !sudo tee > /dev/null %<CR>
map <C-s> :w<CR>
imap <C-s> <C-o>:w<CR>

" move windows in insert mode
imap <C-w> <C-o><C-w>

" Delete (not cut)
nnoremap <leader>d "_d
vnoremap <leader>d "_d
nnoremap <leader>D "_D
nnoremap <leader>x "_x

" new tab
map <C-t><C-t> :tabnew<CR>
" close tab
map <C-t><C-w> :tabclose<CR>

" ,/ turn off search highlighting
nmap <leader>/ :nohl<CR>

" Bash like keys for the command line
cnoremap <C-A>      <Home>
cnoremap <C-E>      <End>
cnoremap <C-K>      <C-U>

" Home-end mapping in insert mode
map <ESC>[H g^
imap <ESC>[H <C-o>g^
map <ESC>[F g$
imap <ESC>[F <C-o>g$

map <ESC>OH g^
imap <ESC>OH <C-o>g^
map <ESC>OF g$
imap <ESC>OF <C-o>g$

" ,p toggles paste mode
nmap <leader>p :set paste!<BAR>set paste?<CR>

" allow multiple indentation/deindentation in visual mode
vnoremap < <gv
vnoremap > >gv

" :cd. change working directory to that of the current file
cmap cd. lcd %:p:h

" Writing Restructured Text (Sphinx Documentation) {
   " Ctrl-u 1:    underline Parts w/ #'s
   noremap  <C-u>1 yyPVr#yyjp
   inoremap <C-u>1 <esc>yyPVr#yyjpA
   " Ctrl-u 2:    underline Chapters w/ *'s
   noremap  <C-u>2 yyPVr*yyjp
   inoremap <C-u>2 <esc>yyPVr*yyjpA
   " Ctrl-u 3:    underline Section Level 1 w/ ='s
   noremap  <C-u>3 yypVr=
   inoremap <C-u>3 <esc>yypVr=A
   " Ctrl-u 4:    underline Section Level 2 w/ -'s
   noremap  <C-u>4 yypVr-
   inoremap <C-u>4 <esc>yypVr-A
   " Ctrl-u 5:    underline Section Level 3 w/ ^'s
   noremap  <C-u>5 yypVr^
   inoremap <C-u>5 <esc>yypVr^A
"}

"---------------------------------------------------------------------------
" PROGRAMMING SHORTCUTS
"---------------------------------------------------------------------------

" Ctrl-[ jump out of the tag stack (undo Ctrl-])
map <C-[> <ESC>:po<CR>

" ,g generates the header guard
map <leader>g :call IncludeGuard()<CR>
fun! IncludeGuard()
   let basename = substitute(bufname(""), '.*/', '', '')
   let guard = '_' . substitute(toupper(basename), '\.', '_', "H")
   call append(0, "#ifndef " . guard)
   call append(1, "#define " . guard)
   call append( line("$"), "#endif // for #ifndef " . guard)
endfun



" Enable omni completion. (Ctrl-X Ctrl-O)
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType java set omnifunc=javacomplete#Complete

" use syntax complete if nothing else available
if has("autocmd") && exists("+omnifunc")
  autocmd Filetype *
              \ if &omnifunc == "" |
              \         setlocal omnifunc=syntaxcomplete#Complete |
              \ endif
endif

set cot-=preview "disable doc preview in omnicomplete

" make CSS omnicompletion work for SASS and SCSS
autocmd BufNewFile,BufRead *.scss             set ft=scss.css
autocmd BufNewFile,BufRead *.sass             set ft=sass.css

"---------------------------------------------------------------------------
" ENCODING SETTINGS
"---------------------------------------------------------------------------
set encoding=utf-8                                 
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1

fun! ViewUTF8()
        set encoding=utf-8                                 
        set termencoding=big5
endfun

fun! UTF8()
        set encoding=utf-8                                 
        set termencoding=big5
        set fileencoding=utf-8
        set fileencodings=ucs-bom,big5,utf-8,latin1
endfun

fun! Big5()
        set encoding=big5
        set fileencoding=big5
endfun


"---------------------------------------------------------------------------
" PLUGIN SETTINGS
"---------------------------------------------------------------------------


" ------- vim-latex - many latex shortcuts and snippets {

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash
set grepprg=grep\ -nH\ $*
" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

"}


" --- AutoClose - Inserts matching bracket, paren, brace or quote
" fixed the arrow key problems caused by AutoClose
if !has("gui_running") 
   imap  OA <ESC>ki
   imap  OB <ESC>ji
   imap  OC <ESC>li
   imap  OD <ESC>hi

   nmap  OA k
   nmap  OB j
   nmap  OC l
   nmap  OD h
endif



" --- Command-T
let g:CommandTMaxHeight = 15


" --- SuperTab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabContextDiscoverDiscovery = ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-p>", "&omnifunc:<c-x><c-o>"]

" include file search is disable here
" --- &omnifunc:<c-x><c-i>


" --- EasyMotion
"let g:EasyMotion_leader_key = '<Leader>m' " default is <Leader>w
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment


" --- TagBar
" toggle TagBar with F7
nnoremap <silent> <F7> :TagbarToggle<CR>
" set focus to TagBar when opening it
let g:tagbar_autofocus = 1

" --- PowerLine
" let g:Powerline_symbols = 'fancy' " require fontpatcher
"

" --- SnipMate
let g:snipMateAllowMatchingDot = 0

" --- coffee-script
" au BufWritePost *.coffee silent CoffeeMake! -b | cwindow | redraw! " recompile coffee scripts on write

" --- vim-gitgutter
let g:gitgutter_enabled = 1

" --- NerdTree Binding
nnoremap <silent> <F6> :NERDTree<CR>
inoremap <silent> <F6> <C-o>:NERDTree<CR>

" --- Ag: Search current word
map <silent> <C-f> :Ag <cword><cr>
let g:ag_working_path_mode="r"
ca Ag Ag!
ca ag Ag!

" --- Easy Align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
" example: gaip*= or (selected) ga**=
nmap ga <Plug>(EasyAlign)

" Window moving
nmap <silent> <leader><Up> :wincmd k<CR>
nmap <silent> <leader><Down> :wincmd j<CR>
nmap <silent> <leader><Left> :wincmd h<CR>
nmap <silent> <leader><Right> :wincmd l<CR>

au BufNewFile,BufRead *.rabl set filetype=ruby
au BufNewFile,BufRead *.coffee set filetype=coffee
autocmd BufNewFile,BufRead *.slim setlocal filetype=slim

" Rspec
" Test helpers from Gary Bernhardt's screen cast:
" https://www.destroyallsoftware.com/screencasts/catalog/file-navigation-in-vim
" https://www.destroyallsoftware.com/file-navigation-in-vim.html
function! RunTests(filename)
    " Write the file and run tests for the given filename
    :w
    :silent !echo;echo;echo;echo;echo
    exec ":!time rspec " . a:filename
endfunction

function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_spec_file = match(expand("%"), '_spec.rb$') != -1
    if in_spec_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number)
endfunction

" Run this file
map <leader>m :call RunTestFile()<cr>
" Run only the example under the cursor
map <leader>. :call RunNearestTest()<cr>
" Run all test files
map <leader>a :call RunTests('spec')<cr>
" Commenting blocks of code.
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType javascript,php   let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab,zsh   let b:comment_leader = '# '
autocmd FileType conf,nginx       let b:comment_leader = '# '
autocmd FileType yaml             let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '


noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>


let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
" let g:rubycomplete_rails = 1

" Handleing Mac option+right to next word
map <ESC>f e
imap <ESC>b <C-o>b
imap <ESC>f <C-o>e
cmap <ESC>f e
set t_Co=256          " 256 color mode

" Colors {
hi SignColumn ctermfg=white
hi IncSearch term=reverse cterm=reverse
hi ModeMsg term=bold cterm=bold
hi StatusLine term=bold,reverse cterm=bold,reverse
hi StatusLineNC term=reverse cterm=reverse
hi Visual term=reverse cterm=reverse
hi VisualNOS term=bold,underline cterm=bold,underline
" gray
hi Ignore ctermfg=0
hi LineNr term=underline cterm=bold ctermfg=0
" light red
hi ErrorMsg term=standout cterm=bold ctermbg=1
hi Error term=reverse cterm=bold ctermfg=7 ctermbg=1
hi WarningMsg term=standout cterm=bold ctermfg=1
hi Special term=bold cterm=bold ctermfg=1
" light green
hi MoreMsg term=bold cterm=bold ctermfg=2
hi Question term=standout cterm=bold ctermfg=2
hi Type term=underline cterm=bold ctermfg=2
" yellow
hi Search term=reverse ctermfg=0 ctermbg=3
hi WildMenu term=standout ctermfg=0 ctermbg=3
hi Statement term=bold cterm=bold ctermfg=3
hi Todo term=standout ctermfg=0 ctermbg=3
" dark blue
hi Folded ctermfg=7 ctermbg=4
hi SpecialKey term=bold cterm=bold ctermfg=4
hi NonText term=bold cterm=bold ctermfg=4
hi PreProc term=underline cterm=bold ctermfg=4
" pink
hi Title term=bold cterm=bold ctermfg=5
hi Constant term=underline cterm=bold ctermfg=5
" lightblue
hi Comment term=bold cterm=bold ctermfg=6
hi Directory term=bold cterm=bold ctermfg=6
hi Identifier term=underline cterm=bold ctermfg=6
" white
" }
