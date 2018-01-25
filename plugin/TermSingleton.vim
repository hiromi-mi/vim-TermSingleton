" TermSingleton.vim : Avoid to open Vim inside Vim's Terminal
" Author: hiromi-mi (https://github.com/hiromi-mi)
" License: The Unlicense (See LICENSE)
" Last Modified: 2018.01.25
"
" How To Use: just to source TermSingleton.vim in vimrc
" Options:
"  - g:termsingleton_opencmd
"     Prefer a command to open new buffers. Default Value is "tab drop"
"     Note: This option should be defined before `source TermSingleton.vim`
" NOTE: $EDITOR variable should set 'rvim', not 'vim'
"
" TODO: "vim -" is not supported

if exists("g:loaded_termsingleton")
   finish
endif

let g:termsingleton_opencmd = get(g:, "termsingleton_opencmd", "tab drop")

if $VIM_SERVERNAME != ''
   try
      if argc() > 0
	 silent call remote_send($VIM_SERVERNAME,
                  \ "<C-W>:" . g:termsingleton_opencmd . " " .
                  \ join(map(argv(), 'fnamemodify(v:val, ":p")')) . "<CR>")
      endif
      quitall
   catch /E145/
      " Because of Restricted-Mode: Disabled
   catch /.*/
      echo "TermSingleton: Can't use outside Vim (maybe because of sandbox?)"
   endtry
endif

if has('clientserver') && empty(v:servername)
   call remote_startserver("VIM")
endif

let g:loaded_termsingleton = 1
" vim: filetype=vim: expandtab: softtabstop=3: shiftwidth=3:
