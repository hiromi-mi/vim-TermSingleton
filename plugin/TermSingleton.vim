" TermSingleton.vim
" Author: hiromi-mi (https://github.com/hiromi-mi)
" License: CC0 1.0 (https://creativecommons.org/publicdomain/zero/1.0/) or The Unlicenes
" Last Modified: 2018.01.15
"
" How To Use: just to source TermSingleton.vim in vimrc
" NOTE: $EDITOR variable should set 'rvim', not 'vim'
"
" TODO: "vim -" is not supported

if exists("g:loaded_termsingleton")
   finish
endif

if $VIM_SERVERNAME != ''
   try
      if argc() > 0
	 silent call remote_send($VIM_SERVERNAME, "\<C-\><C-N>:tab drop " . join(map(argv(), 'fnamemodify(v:val, ":p")')) . "<CR><C-o>i\<C-\><C-N><C-i>")
      endif
      quitall
   catch
      echo "TermSingleton: Can't use outside Vim (maybe because of sandbox or restricted-mode)"
   endtry
endif

if has('clientserver') && empty(v:servername)
   call remote_startserver("VIM")
endif

let g:loaded_termsingleton = 1
