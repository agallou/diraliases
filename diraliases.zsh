function chpwd {

#voir 
#https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/per-directory-history/per-directory-history.zsh#L142
#pour l'ajout au changement de dossier : 
#chpwd_functions=(${chpwd_functions[@]} "_per-directory-history-change-directory")

#toto mettre cela dans une fonction d'init appellée au démarrage
  DIRALIASES_WD="/home/agallou/.diraliases"
  DIRALIASES_WD_FILE="${DIRALIASES_WD}${PWD}/aliases"

  if [ -f $DIRALIASES_WD_FILE ]; then
    source $DIRALIASES_WD_FILE
  fi

  DIRALIASES_PWD_FILE="${PWD}/aliases"
  if [ -f $DIRALIASES_WD_FILE ]; then
    source $DIRALIASES_WD_FILE
  fi

#parser une ligne de type alias top="toto" pour connaitre la liste des alias et les enlever

#on peux soit utiliser .diraliases ou /home/agallou/.diraliases/home/agallou/Projets/aliases

#ajout un alias "global" diraliases qui va les liser (ou plutôt afficher le fichier)
  DIRALIASES_OLDWD_FILE="${DIRALIASES_WD}${OLDPWD}/aliases"

  if [ -f $DIRALIASES_OLDWD_FILE ]; then
    while read i
    do
      ALIAS=`echo $i | sed "s/alias \(.*\)=.*/\1/"`
      unalias $ALIAS
    done < $DIRALIASES_OLDWD_FILE
  fi
}
