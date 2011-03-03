Return-Path: <cyrus@holtmann.org>
Date: Wed, 02 Mar 2011 21:54:33 -0800 (PST)
Message-Id: <20110302.215433.39198854.davem@davemloft.net>
To: padovan@profusion.mobi
Cc: linville@tuxdriver.com, linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix BT_L2CAP and BT_SCO in Kconfig
From: David Miller <davem@davemloft.net>
In-Reply-To: <1298684485-3081-1-git-send-email-padovan@profusion.mobi>
References: <20110226013639.GA2166@joana>
	<1298684485-3081-1-git-send-email-padovan@profusion.mobi>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>
Date: Fri, 25 Feb 2011 22:41:25 -0300

> If we want something "bool" built-in in something "tristate" it can't
> "depend on" the tristate config option.
> 
> Report by DaveM:
> 
>    I give it 'y' just to make it happen, for both, and afterways no
>    matter how many times I rerun "make oldconfig" I keep seeing things
>    like this in my build:
> 
> scripts/kconfig/conf --silentoldconfig Kconfig
> include/config/auto.conf:986:warning: symbol value 'm' invalid for BT_SCO
> include/config/auto.conf:3156:warning: symbol value 'm' invalid for BT_L2CAP
> 
> Reported-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>

I think this approach is fine since it mirrors what we use in other similar
situations.

I am assuming this patch will propagate via bluetooth --> wireless --> me.

Thanks.
