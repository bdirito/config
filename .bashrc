# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# bdirito custom

# get current branch in git repo
function parse_git_branch() {
    BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ ! "${BRANCH}" == "" ]
    then
        STAT=`parse_git_dirty`
        echo " (${BRANCH}${STAT})"
    else
        echo ""
    fi
}

# get current status of git repo
function parse_git_dirty {
    status=`git status 2>&1 | tee`
    dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
    untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
    ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
    newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
    renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
    deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
    bits=''
    if [ "${renamed}" == "0" ]; then
        bits=">${bits}"
    fi
    if [ "${ahead}" == "0" ]; then
        bits="*${bits}"
    fi
    if [ "${newfile}" == "0" ]; then
        bits="+${bits}"
    fi
    if [ "${untracked}" == "0" ]; then
        bits="?${bits}"
    fi
    if [ "${deleted}" == "0" ]; then
        bits="x${bits}"
    fi
    if [ "${dirty}" == "0" ]; then
        bits="!${bits}"
    fi
    if [ ! "${bits}" == "" ]; then
        echo " ${bits}"
    else
        echo ""
    fi
}

# on windows use runemacs to not lock the shell
if [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    alias emacs=runemacs
fi

PROMPT_WARN="false"

RED=$'\e[1;31m'
GREEN=$'\e[1;32m'
YELLOW=$'\e[1;33m'
BLUE=$'\e[1;34m'
MAGNENTA=$'\e[1;35m'
CYAN=$'\e[1;36m'
NOCOLOR=$'\e[0m'


KUBE_PS1_SYMBOL_ENABLE=false
KUBE_PS1_CLUSTER_FUNCTION=get_kube_cluster
KUBE_PS1_NAMESPACE_FUNCTION=get_kube_ns

. /home/bdirito/dev/tools/kube-ps1/kube-ps1.sh


# this is a bit messed up. This MUST return non-null. else you get N/A : N:A because the script shortcuts
get_kube_cluster() {
    echo "ns"
}
# get_kube_cluster() {
#     echo "${NOCOLOR}`echo "${1}" | cut -d. -f1 | cut -d@ -f2`${NOCOLOR}"
# }

get_kube_ns() {
    if [[ "$1" == "prod" ]]; then
        PROMPT_WARN="true"
        echo "${RED}>>>${1}<<<${NOCOLOR}"
    else
        echo "${CYAN}${1}${NOCOLOR}"
    fi
}

maybe_do_k() {
    if [[ "${KUBERNETES_SHELL}" == "true" ]]; then
        echo `kube_ps1`
    else
        echo ''
    fi
}

maybe_shell_warn() {
    if [[ "${PROMPT_WARN}" == "true"  ]]; then
        echo "${RED}"
    else
        echo ""
    fi
}

# maybe_do_k is purposly color unescaped - thus if we are in prod the whole prompt will be red
export PS1="${BLUE}\u${NOCOLOR}@${YELLOW}\h:${GREEN}\w${CYAN}\`parse_git_branch\`${NOCOLOR} \`maybe_do_k\`${NOCOLOR} \\n\`maybe_shell_warn\`\$ "

# kubernetes
alias k=kubectl
alias kcx=kubectx
alias kns=kubens
alias k_edit_secret="KUBE_EDITOR=kube-secret-editor.py kubectl edit secret"
eval "$(direnv hook bash)"
source <(kubectl completion bash)


export EDITOR=emacs
export VISUAL=emacs

# android exports
#export ANDROID_EMULATOR_USE_SYSTEM_LIBS=1
export ANDROID_HOME=${HOME}/Android/Sdk
export PATH=${PATH}:${HOME}/Android/Sdk/tools/:${HOME}/Android/platform-tools/

export SPLUNK_TOKEN=0cad55ee-98e4-4225-8bf3-58d9eb910556
export SPLUNK_INDEX=bdirito-tmp
# autojump
source /usr/share/autojump/autojump.sh

# common tools bin link
export PATH=${PATH}:${HOME}/go/bin/:${HOME}/dev/tools/binlink/

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
export NODE_OPTIONS=--max-old-space-size=14096
# use local node_modules if they are there
export PATH=./node_modules/.bin/:${PATH}
