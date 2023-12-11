# Source private values
# source ~/.bash_profile_private_includes


# Remove ALL pre-defined aliases
unalias -a

######################################################
# Setup Initial Path                    
######################################################
export MY_USER_HOME_DIR="/Users/joey"

# Clear the Path to start with  
export PATH="" 

# ----- Add home/bin directory -----
export PATH="~/bin"


# ----- Add Local Bin dirs -----
export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

#---- Add Brew sbin
export PATH="/usr/local/sbin:$PATH"


# ----- Add Node Versions -----
# export PATH="$PATH:/Users/joey/.nvm/versions/node/v18.16.1/bin:/Users/joey/.nvm/versions/node/v16.13.0/bin:/Users/joey/.nvm/versions/node/v12.21.0/bin:/Users/joey/bin:/Users/joey/.nvm/versions/node/v15.12.0/bin:/var/lib"

# ----- Setup Homebrew -----
# Unsure why this is needed.....
eval "$(/opt/homebrew/bin/brew shellenv)"


# ----- Add Python -----
# export PATH="$PATH:/usr/bin/python3"
# export PYTHON_BIN_PATH="$(python3 -m site --user-base)/bin"
# /usr/local/lib/python3.10/site-packages/
# export PATH="$PATH:$PYTHON_BIN_PATH"

# Increase Node Heap Size to 8GB
export NODE_OPTIONS=--max-old-space-size=8192


######################################################
# Directory Variables/Aliases/Commands
######################################################
export REPOS_DIR="$MY_USER_HOME_DIR/repos"
export LEET_CODE_DIR="$REPOS_DIR/LeetCodeJS"

# export DATABASE_BACKUPS_DIR="$MDK_BASE/backup/databaseBackups"

alias cdh="cd $MY_USER_HOME_DIR"
alias cdhome="cd $MY_USER_HOME_DIR"
alias cdrepos="cd $REPOS_DIR"
alias cdleetcode="cd $LEET_CODE_DIR"

# alias cddatabasebackups="cd $DATABASE_BACKUPS_DIR"


alias eleetcode="(cdleetcode && code .)"



################## Needed Exports ##################
export BASH_SILENCE_DEPRECATION_WARNING=1
export COMPOSE_DOCKER_CLI_BUILD=0



######################################################
# Docker Command Aliases                   
######################################################

alias dc="docker-compose"
alias dls="docker container ls"

### Clean Docker Volume's (full slash and burn)
alias dockerclean='docker system prune --all && docker volume rm $(docker volume ls -qf dangling=true)'
alias dockercleanandstartagain='docker system prune --all && docker volume rm $(docker volume ls -qf dangling=true) && mdk start'
alias dockerclean2='docker volume rm $(docker volume ls -qf dangling=true)'


######################################################
# Other Command Aliases                      
######################################################
 
# -- Enable color support of ls and also add handy aliases -- 
export LSCOLORS="eAfxBxdxcxegecabagacad"
alias ls='ls -alGH'
alias lst='ls -alGHt'
# -- Mongo Aliases --
alias mongo="mongosh"
# -- Python Alias --
alias python='/usr/bin/python3'
# -- Open Sublime Editor Alias --
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

# -- Check Ports in Use --
alias portwho="sudo lsof -iTCP -sTCP:LISTEN -n -P | grep "
alias showports="sudo lsof -iTCP -sTCP:LISTEN -n -P"


######################################################
# Git Command Aliases                   
######################################################
### Update last commit to now date/time
alias gitupdatelastcommitdate='git commit --amend --date="now"'
alias gitundolastcommit="git reset HEAD~"
alias gitcreateemptycommit="git commit --allow-empty -m 'Empty commit' && git push"

######################################################
# Run custom scripts                    
######################################################

export MY_SCRIPTS_DIR="$MY_USER_HOME_DIR/bin/scripts"
alias cdscripts="cd $MY_SCRIPTS_DIR"


######################################################
# Generic Helper Commands
######################################################
## Refresh Shell (Pick up changes from this file)
alias reload='source ~/.bash_profile' 
 
 # Common Editing Aliases
alias ebashprofile="subl ~/.bash_profile"

# Kill GPG Agent
alias killgpgagent='sudo killall gpg-agent'

# Function to find files and list their info
function findnamed {
    find ${2:-.} -name "*$1*" -printf "%M %-6u %-6g  %-${3:-40}p %TY-%Tm-%Td %TH:%TM\n"
}

######################################################
# Personal Directory/Projects/Shortcuts
######################################################

alias cdreactcourse='cd ~/repos/courses/algo-react-course'
alias ereactcourse='cdreactcourse && code .'


######################################################
# Prompts/Colors 
######################################################
# set a fancy prompt 
case "$TERM" in 
    xterm-color) color_prompt=yes;; 
esac 
force_color_prompt=yes 
if [ -n "$force_color_prompt" ]; then 
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then 
# We have color support; assume it's compliant with Ecma-48 
        color_prompt=yes 
    else 
        color_prompt= 
    fi 
fi 
if [ "$color_prompt" = yes ]; then 
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ ' 
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;34m\]\w\[\033[00m\] > ' 
else 
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ ' 
fi 
unset color_prompt force_color_prompt 
# If this is an xterm set the title to user@host:dir 
case "$TERM" in 
    xterm*|rxvt*) 
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1" 
    ;; 
*) 
    ;; 
esac 
 


######################################################
# Git auto completion
######################################################
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

######################################################
# Git GPG Key Signing
######################################################

[ -f ~/.gpg-agent-info ] && source ~/.gpg-agent-info
if [ -S "${GPG_AGENT_INFO%%:*}" ]; then
   export GPG_AGENT_INFO
else
   eval $( gpg-agent --daemon )
fi


######################################################
# NVM  & Node Version Manager Auto Switching
######################################################
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# cdnvm() {
#     command cd "$@" || return $?
#     nvm_path=$(nvm_find_up .nvmrc | tr -d '\n')

#     # If there are no .nvmrc file, use the default nvm version
#     if [[ ! $nvm_path = *[^[:space:]]* ]]; then

#         declare default_version;
#         default_version=$(nvm version default);

#         # If there is no default version, set it to `node`
#         # This will use the latest version on your machine
#         if [[ $default_version == "N/A" ]]; then
#             nvm alias default node;
#             default_version=$(nvm version default);
#         fi

#         # If the current version is not the default version, set it to use the default version
#         if [[ $(nvm current) != "$default_version" ]]; then
#             nvm use default;
#         fi

#     elif [[ -s $nvm_path/.nvmrc && -r $nvm_path/.nvmrc ]]; then
#         declare nvm_version
#         nvm_version=$(<"$nvm_path"/.nvmrc)

#         declare locally_resolved_nvm_version
#         # `nvm ls` will check all locally-available versions
#         # If there are multiple matching versions, take the latest one
#         # Remove the `->` and `*` characters and spaces
#         # `locally_resolved_nvm_version` will be `N/A` if no local versions are found
#         locally_resolved_nvm_version=$(nvm ls --no-colors "$nvm_version" | tail -1 | tr -d '\->*' | tr -d '[:space:]')

#         # If it is not already installed, install it
#         # `nvm install` will implicitly use the newly-installed version
#         if [[ "$locally_resolved_nvm_version" == "N/A" ]]; then
#             nvm install "$nvm_version";
#         elif [[ $(nvm current) != "$locally_resolved_nvm_version" ]]; then
#             nvm use "$nvm_version";
#         fi
#     fi
# }


# alias cd='cdnvm'
# cd "$PWD"



