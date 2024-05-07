(( ${+commands[zoxide]} || ${+commands[asdf]} && ${+functions[_direnv_hook]} )) && () {

  local command=${commands[zoxide]:-"$(${commands[asdf]} which zoxide 2> /dev/null)"}
  [[ -z $command ]] && return 1

   # generating init file
  local initfile=$1/zoxide-init.zsh
  if [[ ! -e $initfile || $initfile -ot $command ]]; then
    $command init zsh >| $initfile
    zcompile -UR $initfile
  fi

  source $initfile
} ${0:h}