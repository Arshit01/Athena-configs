# =============================================================================
# ~/.zshrc
# =============================================================================

# Only continue for interactive shells
[[ -o interactive ]] || return

# =============================================================================
# PATH
# =============================================================================

typeset -U path PATH

path+=(
    "$HOME/.local/bin"
    "/usr/local/sbin"
    "/usr/local/bin"
    "/usr/lib/jvm/default/bin"
    "/usr/bin/site_perl"
    "/usr/bin/vendor_perl"
    "/usr/bin/core_perl"
)

# =============================================================================
# Environment
# =============================================================================

export EDITOR=/usr/bin/kwrite
export VISUAL=nano
export PAGER=most
export TERM=xterm-256color

export SECLISTS="/usr/share/seclists"
export PAYLOADSALLTHETHINGS="/usr/share/payloadsallthethings"
export FUZZDB="/usr/share/fuzzdb"

export MIMIKATZ="/usr/share/windows/mimikatz"
export POWERSPLOIT="/usr/share/windows/powersploit"

export ROCKYOU="$SECLISTS/Passwords/Leaked-Databases/rockyou.txt"

export DIRSMALL="$SECLISTS/Discovery/Web-Content/DirBuster-2007_directory-list-2.3-small.txt"
export DIRMEDIUM="$SECLISTS/Discovery/Web-Content/DirBuster-2007_directory-list-2.3-medium.txt"
export DIRBIG="$SECLISTS/Discovery/Web-Content/DirBuster-2007_directory-list-2.3-big.txt"

export WEBAPI_COMMON="$SECLISTS/Discovery/Web-Content/api/api-endpoints.txt"
export WEBAPI_MAZEN="$SECLISTS/Discovery/Web-Content/common-api-endpoints-mazen160.txt"
export WEBCOMMON="$SECLISTS/Discovery/Web-Content/common.txt"
export WEBPARAM="$SECLISTS/Discovery/Web-Content/burp-parameter-names.txt"

# =============================================================================
# History
# =============================================================================

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=2000000

setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS

# =============================================================================
# Shell Options
# =============================================================================

setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt GLOB_DOTS
setopt INTERACTIVE_COMMENTS
setopt COMPLETE_IN_WORD
setopt PROMPT_SUBST
setopt NUMERIC_GLOB_SORT

unsetopt BEEP

# =============================================================================
# Keybindings
# =============================================================================

WORDCHARS='*?.-[]~=&;!#$%^(){}<>'
bindkey -e

bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[7~" beginning-of-line
bindkey "\e[8~" end-of-line
bindkey "\e[3~" delete-char
bindkey "\e[3;5~" kill-word
bindkey "\e[2~" quoted-insert
bindkey "\e[5C" forward-word
bindkey "\e[5D" backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# =============================================================================
# Completion
# =============================================================================

autoload -Uz compinit
compinit

autoload -Uz bashcompinit
bashcompinit

# =============================================================================
# Aliases
# =============================================================================

[[ -f ~/.zsh_aliases ]] && source ~/.zsh_aliases

# =============================================================================
# Plugins
# =============================================================================

[[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] &&
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

[[ -f /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]] &&
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

[[ -f /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ]] &&
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

[[ -f /usr/share/fzf/key-bindings.zsh ]] &&
source /usr/share/fzf/key-bindings.zsh

[[ -f /usr/share/fzf/completion.zsh ]] &&
source /usr/share/fzf/completion.zsh

export FZF_DEFAULT_OPTS='--height -12 --border --color=pointer:red,hl:red --preview "bat --style=numbers --color=always {}"'

fzf-history-widget() {
  local selected
  setopt localoptions noglobsubst noshortloops pipefail no_aliases 2>/dev/null
  selected=( $(fc -rl 1 | awk '{ $1=""; print substr($0,2) }' | FZF_DEFAULT_OPTS='--height 20% --border --color=pointer:red,hl:red' fzf) )
  local ret=$?
  if [ -n "$selected" ]; then
    BUFFER=$selected
    CURSOR=$#BUFFER
  fi
  zle reset-prompt
  return $ret
}
zle -N fzf-history-widget

zle_highlight+=(paste:none)

# =============================================================================
# Fastfetch once
# =============================================================================

# if [[ -z "$NO_REPETITION" ]]; then
#     export NO_REPETITION=1
#     fastfetch
# fi

# =============================================================================
# Extract helper
# =============================================================================

ex() {

    [[ -f "$1" ]] || {
        echo "'$1' is not a valid file"
        return 1
    }

    case "$1" in
        *.tar.bz2) tar xjf "$1" ;;
        *.tar.gz) tar xzf "$1" ;;
        *.bz2) bunzip2 "$1" ;;
        *.rar) unrar x "$1" ;;
        *.gz) gunzip "$1" ;;
        *.tar) tar xf "$1" ;;
        *.tbz2) tar xjf "$1" ;;
        *.tgz) tar xzf "$1" ;;
        *.zip) unzip "$1" ;;
        *.Z) uncompress "$1" ;;
        *.7z) 7z x "$1" ;;
        *.deb) ar x "$1" ;;
        *.tar.xz) tar xf "$1" ;;
        *.tar.zst) tar xf "$1" ;;
        *) echo "'$1' cannot be extracted." ;;
    esac
}

# =============================================================================
# cd up helper
# =============================================================================

cu() {

    local count="${1:-1}"
    local up=""

    local i

    for (( i=1; i<=count; i++ ))
    do
        up+="../"
    done

    builtin cd "$up"
}

# =============================================================================
# Memory helper
# =============================================================================

buffer_clean() {

    free -h

    sudo sh -c 'echo 1 > /proc/sys/vm/drop_caches'

    free -h
}

# =============================================================================
# Git Prompt Helper
# =============================================================================

gitPrompt() {

    git symbolic-ref --short HEAD 2>/dev/null
}

# =============================================================================
# Prompt
# =============================================================================

build_prompt() {

    local last_status=$?

    local status_symbol status_color

    if (( last_status == 0 )); then
        status_symbol="🗸"
        status_color="%F{green}"
    elif (( last_status == 1 )); then
        status_symbol="✘"
        status_color="%F{red}"
    else
        status_symbol="$last_status"
        status_color="%F{red}"
    fi

    local tty_device
    tty_device=$(tty)

    local ip
    ip=$(
        command ip -br -4 -f inet addr |
        awk '$1 != "lo" && $2 != "DOWN" {
            sub(/\/.*/, "", $3)
            printf "%s%s", sep, $3
            sep = "|"
        }'
    )

    local user="%n"
    local host="%m"
    local cwd="%~"

    local branch
    branch=$(gitPrompt)

    local hq_prefix=""
    local flame=""
    local robot=""

    if [[ "$tty_device" == /dev/tty* ]]; then
        hq_prefix="HQ─"
        flame=""
        robot="[> ${status_color}${last_status}]"
    else
        hq_prefix="🌐"
        flame="🔥"
        robot="[👾 ${status_color}${status_symbol}%F{35}]"
    fi

    local user_host="%F{red}(${user}@${host})%f"

    local time_now="[$(date '+%d-%m-%Y %H:%M:%S %Z')]"

    local line1="%F{35}╭─[${user_host}${hq_prefix}%F{168}${ip}%F{35}${flame}]―%F{103}${time_now}"

    if [[ -n "$branch" ]]; then
        line1+="%F{220}[ ${branch}]%f"
    fi

    local line2="%F{35}╰─❯${robot}%F{45}${cwd} %F{red}#%f"

    PROMPT="${line1}"$'\n'"${line2} "
}

# =============================================================================
# Prompt Hook
# =============================================================================

autoload -Uz add-zsh-hook
add-zsh-hook precmd build_prompt

# Build prompt immediately
build_prompt

# =============================================================================
# Useful Completion Styles
# =============================================================================

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list \
    'm:{a-z}={A-Za-z}' \
    'r:|=*' \
    'l:|=*'

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# =============================================================================
# Better Navigation
# =============================================================================

setopt AUTO_MENU
setopt AUTO_LIST
setopt ALWAYS_TO_END

# =============================================================================
# Enable colors
# =============================================================================

autoload -Uz colors
colors

autoload -Uz zmv

# =============================================================================
# Load dircolors if available
# =============================================================================

if command -v dircolors >/dev/null 2>&1; then
    [[ -f ~/.dircolors ]] && eval "$(dircolors -b ~/.dircolors)"
fi

# =============================================================================
# Ensure aliases are expanded in functions
# =============================================================================

setopt COMPLETE_ALIASES
echo -ne '\e[5 q'

# =============================================================================
# Automatic terminal logging
# =============================================================================

if [[ -o interactive && -z "$TERMLOG_ACTIVE" ]]; then
    export TERMLOG_ACTIVE=1

    daydir="$HOME/.termlog/$(date '+%A-%Y-%m-%d')"
    mkdir -p "$daydir"

    # Count existing logs today
    count=$(find "$daydir" -maxdepth 1 -name '*.log' | wc -l)

    # Convert number -> Excel style letters (A, B ... Z, AA, AB ...)
    excel_col() {
        local n=$1
        local s=""
        while (( n >= 0 )); do
            local r=$(( n % 26 ))
            s="$(printf "\\$(printf '%03o' $((65+r)))")$s"
            n=$(( n / 26 - 1 ))
        done
        printf "%s" "$s"
    }

    prefix=$(excel_col "$count")

    logfile="$daydir/${prefix}_$(date '+%H-%M-%S').log"

    exec script -qf "$logfile"
fi

# =============================================================================
# End of ~/.zshrc
# =============================================================================
