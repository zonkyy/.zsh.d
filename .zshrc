#---- プロンプト設定 ------#
# 左プロンプト
PROMPT="%B%{[32m%}%~%%%{[m%}%b "
PROMPT2="%{[31m%}%_%%%{[m%} "
SPROMPT="%{[31m%}%r is correct? [n,y,a,e]:%{[m%} "

## <エスケープシーケンス>
## prompt_bang が有効な場合、!=現在の履歴イベント番号, !!='!' (リテラル)
# ${WINDOW:+"[$WINDOW]"} = screen 実行時にスクリーン番号を表示 (prompt_subst が必要)
# %B = underline
# %/ or %d = ディレクトリ (0=全て, -1=前方からの数)
# %~ = ディレクトリ
# %h or %! = 現在の履歴イベント番号
# %L = 現在の $SHLVL の値
# %M = マシンのフルホスト名
#  %m = ホスト名の最初の `.' までの部分
# %S (%s) = 突出モードの開始 (終了)
# %U (%u) = 下線モードの開始 (終了)
# %B (%b) = 太字モードの開始 (終了)
# %t or %@ = 12 時間制, am/pm 形式での現在時刻
# %n or $USERNAME = ユーザー ($USERNAME は環境変数なので setopt prompt_subst が必要)
# %N = シェル名
# %i = %N によって与えられるスクリプト, ソース, シェル関数で, 現在実行されている行の番号 (debug用)
# %T = 24 時間制での現在時刻
# %* = 24 時間制での現在時刻, 秒付き
# %w = `曜日-日' の形式での日付
# %W = `月/日/年' の形式での日付
# %D = `年-月-日' の形式での日付
# %D{string} = strftime 関数を用いて整形された文字列 (man 3 strftime でフォーマット指定が分かる)
# %l = ユーザがログインしている端末から, /dev/ プレフィックスを取り除いたもの
# %y = ユーザがログインしている端末から, /dev/ プレフィックスを取り除いたもの (/dev/tty* はソノママ)
# %? = プロンプトの直前に実行されたコマンドのリターンコード
# %_ = パーサの状態
# %E = 行末までクリア
# %# = 特権付きでシェルが実行されているならば `#', そうでないならば `%' == %(!.#.%%)
# %v = psvar 配列パラメータの最初の要素の値
# %{...%} = リテラルのエスケープシーケンスとして文字列をインクルード
# %(x.true-text.false-text) = 三つ組の式
# %<string<, %>string>, %[xstring] = プロンプトの残りの部分に対する, 切り詰めの振る舞い
#         `<' の形式は文字列の左側を切り詰め, `>' の形式は文字列の右側を切り詰めます
# %c, %., %C = $PWD の後ろ側の構成要素


#PROMPT='%{[$[32+$RANDOM % 5]m%}%U%B$HOST'"{`whoami`}%b%%%{[m%}%u " # prompt_subst が必要
# 右プロンプト
#RPROMPT='%{[33m%}[%~]%{[m%}'

#---- その他特殊変数 -------#
HISTFILE=~/.zsh_history         # ヒストリ保存ファイル
HISTSIZE=1000                 # メモリ内の履歴の数
SAVEHIST=1000                 # 保存される履歴の数
LISTMAX=1000 # 補完リストを尋ねる数 (1=黙って表示, 0=ウィンドウから溢れるときは尋ねる)

if [ $UID = 0 ]; then          # root のコマンドはヒストリに追加しない
    unset HISTFILE
    SAVEHIST=0
fi


#---- zmv ---------------#
autoload -U zmv
# # % zmv '(*).jpeg' '$1.jpg'
# # % zmv '(**/)foo(*).jpeg' '$1bar$2.jpg'
# # % zmv -n '(**/)foo(*).jpeg' '$1bar$2.jpg' # 実行せずパターン表示のみ
# # % zmv '(*)' '${(L)1}; # 大文字→小文字
# # % zmv -W '*.c.org' 'org/*.c' #「(*)」「$1」を「*」で済ませられる
# alias mmv='noglob zmv -W'  # 引数のクォートも面倒なので
# # % mmv *.c.org org/*.c
# #zmv -C # 移動ではなくコピー(zcp として使う方法もあるみたいだけど)
# #zmv -L # 移動ではなくリンク(zln として使う方法もあるみたいだけど)

# 履歴による予測入力 (man zshcontrib)
#autoload -U predict-on
#predict-on
#zle -N predict-on
#zle -N predict-off
#bindkey '^xp' predict-on
#bindkey '^x^p' predict-off

# core抑制
#unlimit
#limit core 0
#limit -s
#limit   coredumpsize    0

# ファイル作成時のパーミッション
umask 022

# screen 時に ssh, telnet でログインしたホスト名を window 名にする
#if [ "$TERM" = "screen" ]; then
#    function ssh() {
#        echo -n "^[k$1^[\\"
#        /usr/bin/ssh $1
#    }
#fi

# メールチェック
## autoload -U colors; colors   # ↓のために。設定してなければしておく
# MAILCHECK=300                 # 300秒毎にチェック
## MAILPATH="/var/mail$USER"    # チェックするメールボックス
# MAILPATH="/var/mail$USER?{fg[red]}New mail"   # メッセージと色を変更
## --enable-maildir-support を指定してコンパイルすればMaildir 形式でも可能
# MAILPATH="$HOME/Maildir?{fg_bold[red]}New mail in $_" # 「$_」は変更されたfile
## : で区切れば複数のメールスプールをチェックできる
# MAILPATH="$HOME/Maildir?{fg_bold[red]}New mail in $_:$HOME/Maildir-foo?{fg_bold[green]}New mail in $_:"

# カレントディレクトリ中にサブディレクトリが無い場合に cd が検索するディレクトリのリスト
cdpath=($HOME)
# zsh関数のサーチパス
#fpath=($fpath ~/.zfunc )

autoload zed                    # zsh用のエディタ




#### シェルスクリプト
# 引数 - $*
# vim(){
#         /cygdrive/g/utils/vim/gvim.exe $* &
# };

#---- その他設定 ------#
# 言語設定
#export LANG=ja_JP.UTF-8
#export LANG=ja_JP.eucJP
#export LANG=ja_JP.SJIS

# 自分設定
[ -f ~/.zsh.d/.zshrc.opt ] && source ~/.zsh.d/.zshrc.opt
[ -f ~/.zsh.d/.zshrc.func ] && source ~/.zsh.d/.zshrc.func
[ -f ~/.zsh.d/.zshrc.comp ] && source ~/.zsh.d/.zshrc.comp
[ -f ~/.zsh.d/.zshrc.alias ] && source ~/.zsh.d/.zshrc.alias
[ -f ~/.zsh.d/.zshrc.bind ] && source ~/.zsh.d/.zshrc.bind
