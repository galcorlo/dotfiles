#!/bin/bash
# copyed from https://github.com/junegunn/fzf/wiki/Examples
# fzf is needed
# 20171228 galcorlo

# Improve choose-tree feature C-b s in tmux2.0.
# You can switch session only searching, ignoring the session number.

# Add the following line to .tmux.conf
# bind s new-window -n menu-choose '~/.tm.sh'

# `tm` will allow you to select your tmux session via fzf.
export PATH=$PATH:'~/.fzf/bin'


current_session=$(tmux display-message -p '#{session_name}')
session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | awk -v cur="$current_session" '{ buffer[NR] = $0; } END { print cur; for(i=NR; i>0; i--) { if (buffer[i] != cur) print buffer[i] } }' | fzf --cycle) && tmux switch-client -t "$session" 
