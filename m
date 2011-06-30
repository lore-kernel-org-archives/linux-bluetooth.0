Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Thu, 30 Jun 2011 00:31:19 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Joe Perches <joe@perches.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"David S. Miller" <davem@davemloft.net>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] bluetooth: Add bt_printk, convert logging macros to
 lower case
Message-ID: <20110630033119.GA3438@joana>
References: <1309370457.2208.48.camel@aeonflux>
 <cover.1309396408.git.joe@perches.com>
 <dde77465697e4a8fed630a9528cd8c1fcb092ce4.1309396408.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <dde77465697e4a8fed630a9528cd8c1fcb092ce4.1309396408.git.joe@perches.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joe,

* Joe Perches <joe@perches.com> [2011-06-29 18:18:30 -0700]:

> Use the more common logging styles.
> 
> bt_print uses vsprintf extension %pV.
> This saves 2 to 3 % of code/text space.
> 
> $ find net/bluetooth -name "built-in.o.*" | xargs size
>    text	   data	    bss	    dec	    hex	filename
>   14778	   1012	   3408	  19198	   4afe	net/bluetooth/bnep/built-in.o.new
>   15067	   1012	   3408	  19487	   4c1f	net/bluetooth/bnep/built-in.o.old
>   18483	   1172	   4264	  23919	   5d6f	net/bluetooth/cmtp/built-in.o.new
>   18927	   1172	   4264	  24363	   5f2b	net/bluetooth/cmtp/built-in.o.old
>   59461	   3884	  14464	  77809	  12ff1	net/bluetooth/rfcomm/built-in.o.new
>   61206	   3884	  14464	  79554	  136c2	net/bluetooth/rfcomm/built-in.o.old
>   19237	   1172	   5152	  25561	   63d9	net/bluetooth/hidp/built-in.o.new
>   19581	   1172	   5152	  25905	   6531	net/bluetooth/hidp/built-in.o.old
>  346600	  19163	  86080	 451843	  6e503	net/bluetooth/built-in.o.new
>  353751	  19163	  86064	 458978	  700e2	net/bluetooth/built-in.o.old
> 
> $ find drivers/bluetooth/ -name "built-in.o.*" | xargs size
>    text	   data	    bss	    dec	    hex	filename
>  129956	   8632	  36096	 174684	  2aa5c	drivers/bluetooth/built-in.o.new
>  134402	   8632	  36064	 179098	  2bb9a	drivers/bluetooth/built-in.o.old

This is really nice, but can we keep the lower case? I think applying this
patch now will break things to people developing on top of my tree.
Then someday in the future when development becomes calm or just after the
next merge window I run a s/BT_*/bt_*/ on everything.

Thanks a lot for looking into this, reduce code/text by 3% only changing
logging is awesome.

	Gustavo
