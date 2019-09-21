# $FreeBSD: releng/12.0/share/skel/dot.cshrc 337497 2018-08-08 19:24:20Z asomers $
# more examples available at /usr/share/examples/csh/
#

umask 22

alias h         history 25
alias j         jobs -l
alias ll        ls -Alrt
alias grep      grep --color=auto

# These are normally set through /etc/login.conf.  You may override them here
# if wanted.
# set path = (/sbin /bin /usr/sbin /usr/bin /usr/local/sbin /usr/local/bin $HOME/bin)

setenv  BLOCKSIZE       K
setenv  EDITOR  vim
setenv  PAGER   less

set nobeep
set autolist
set color
set uname=`uname`
if ($uname == "Linux") then
  alias ls 'ls --color=auto -F \!*'
  set first_ip=`ip addr | sed -e '/127\.0\.0\.1/d' | awk '/inet .*/{print $2}' | sed 1q | awk -F/ '{print $1}'`
else
  alias ls 'ls -F \!*'
  set first_ip=`ifconfig | sed -e '/127\.0\.0\.1/d' | awk '/inet .* netmask/{print $2}' | sed 1q | sed -n '1,1p'`
endif

if ($?prompt) then
  set ip_str=''
  if ($?first_ip) then
    set ip_str="$first_ip"
  endif
  if(! $?WINDOW ) then
    set prompt = "%{^[[1;33m%}%N%{^[[m%}@%{^[[1;37m%}%m%{^[[1;32m%}($ip_str) %{^[[1;36m%}%~%{^[[1;37m%} %# "
  else
    set prompt = "%{^[[1;35m%}[W$WINDOW]%{^[[1;33m%}%N%{^[[m%}@%{^[[1;37m%}%m%{^[[1;32m%}($ip_str) %{^[[1;36m%}%~%{^[[1;37m%} %# "
  endif
  set promptchars = "%#"

  set filec
  set history = 1000
  set savehist = (1000 merge)
  # Use history to aid expansion
  set autoexpand
  set autorehash
  set mail = (/var/mail/$USER)
  if ( $?tcsh ) then
          bindkey "^W" backward-delete-word
          bindkey -k up history-search-backward
          bindkey -k down history-search-forward
  endif

endif
