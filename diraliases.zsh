function _importAliases() {
  while read line
  do
      ALIASNAME=`echo "$line" | sed "s/\(\w*\)|\(.*\)|\(.*\)/\1/"`
      ALIASDESC=`echo "$line" | sed "s/\(\w*\)|\(.*\)|\(.*\)/\2/"`
      ALIASVALUE=`echo "$line" | sed "s/\(\w*\)|\(.*\)|\(.*\)/\3/"`
      alias $ALIASNAME=$ALIASVALUE
      
  done < $1
}

function _importUnaliases() {
  while read line
  do
      ALIASNAME=`echo "$line" | sed "s/\(\w*\)|\(.*\)|\(.*\)/\1/"`
      unalias $ALIASNAME
      
  done < $1
}


function _initDirAliases() {
  DIRALIASES_WD="/home/agallou/.diraliases"

  DIRALIASES_WD_FILE="${DIRALIASES_WD}${PWD}/aliases"
  DIRALIASES_PWD_FILE="${PWD}/aliases"

  if [ -f $DIRALIASES_WD_FILE ]; then
     _importAliases $DIRALIASES_WD_FILE
  fi
  if [ -f $DIRALIASES_PWD_FILE ]; then
     _importAliases $DIRALIASES_PWD_FILE
  fi

  #au lancement $OLDPWD et $PWD sont identiques
  if [[ $PWD == $OLDPWD ]]; then
    return;
  fi

  DIRALIASES_OLDWD_FILE="${DIRALIASES_WD}${OLDPWD}/aliases"
  DIRALIASES_OLDPWD_FILE="${OLDPWD}/aliases"

  if [ -f $DIRALIASES_OLDWD_FILE ]; then
     _importUnaliases $DIRALIASES_OLDWD_FILE
  fi
  if [ -f $DIRALIASES_OLDPWD_FILE ]; then
     _importUnaliases $DIRALIASES_OLDPWD_FILE
  fi


}

chpwd_functions=(${chpwd_functions[@]} "_initDirAliases")
_initDirAliases
