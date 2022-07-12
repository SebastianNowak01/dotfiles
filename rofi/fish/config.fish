if status is-interactive
    # Commands to run in interactive sessions can go here
end

#added DOOM Emacs path for the ease of use (only use this if you use DOOM Emacs, otherwise it can make anything go 'command not found')
export PATH="$HOME/.emacs.d/bin:$PATH"

#general settings
set fish_greeting
#supressess the default fish greeting

#"nvim" as manpager
#set -x MANPAGER "nvim -c 'set ft=man' -"

# Functions needed for !! and !$
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end


#The bindings for !! and !$
if [ $fish_key_bindings = "fish_vi_key_bindings" ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

# Function for creating a backup file
# ex: backup file.txt
# result: copies file as file.txt.bak
function backup --argument filename
    cp $filename $filename.bak
end

##ALIASES
alias vim='nvim'
alias ls='exa -l --color=always --group-directories-first' # my preferred listing
alias l='ls'
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first'  # long format
alias unlock='sudo rm /var/lib/pacman/db.lck'    # remove pacman lock
#alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias grep='grep --color=auto'
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'
alias brightness='brightnessctl set'
alias br='brightnessctl set'
alias ..='cd ..'
alias ...='cd .. && cd ..'
alias extendhdmi='xrandr --output HDMI-A-0 --mode 1920x1080 && xrandr --output eDP --left-of HDMI-A-0 && xrandr --output HDMI-A-0 --mode 1920x1080 --rate 144.00 && nitrogen --restore'
alias prep='rm -f test.results average && cargo build && autotest 2 && cat average'
alias ghc='ghc -dynamic'
alias emacs='emacsclient -c -a "emacs"'

## CUSTOM FUNCTIONS

fish_add_path --path /$HOME/.local/bin/lvim /home/sebas/.cargo/bin

# Start X at login
if status is-interactive
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx -- -keeptty
    end
end

