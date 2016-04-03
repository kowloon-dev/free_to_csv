#!/bin/bash

# freeの実行結果を取得してカンマ区切りで出力
# 2016/04/02

free | awk '

    BEGIN {
	# 区切り文字をカンマに変更
	OFS=",";
	# 現在日時を取得
	time=strftime("%Y-%m-%d %T");
    }

    # 「Mem:」列の各値を取得
    /^Mem:/{
        total=$2;
	used=$3;
	free=$4;
	shared=$5;
	buffers=$6;
	cached=$7;
    }

    # 「buffers/cache:」列の各値を取得
    /\-\/\+/{
	b_used=$3;
	b_free=$4;
    }

    # 「Swap」列の各値を取得
    /Swap:/{
	s_total=$2;
	s_used=$3;
	s_free=$4;
    }

    # 日時と取得した全ての値を1行で標準出力し終了
    END{
	print(time,total,used,free,shared,buffers,cached,b_used,b_free,s_total,s_used,s_free);
    }';

exit 0

