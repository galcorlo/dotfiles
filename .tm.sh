#!/bin/bash
# copyed from https://github.com/junegunn/fzf/wiki/Examples
# fzf is needed
# 20171228 galcorlo

# Improve choose-tree feature C-b s in tmux2.0.
# You can switch session only searching, ignoring the session number.

# Add the following line to .tmux.conf
# bind s new-window -n menu-choose '~/.tm.sh'

# tm - create new tmux session, or switch to existing one. Works from within tmux too. (@bag-man)
# `tm` will allow you to select your tmux session via fzf.
# `tm irc` will attach to the irc session (if it exists), else it will create it.
export PATH=$PATH:'~/.fzf/bin'

[[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
if [ $1 ]; then
  tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
fi

current_session=$(tmux display-message -p '#S')
session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | grep -v "$current_session" | tac | sed -e "1i${current_session}" | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
