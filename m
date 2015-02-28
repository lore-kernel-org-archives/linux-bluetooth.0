Return-Path: <cyrus@holtmann.org>
Date: Sat, 28 Feb 2015 14:21:35 -0500 (EST)
Message-Id: <20150228.142135.470339626705046722.davem@davemloft.net>
To: eyal.birger@gmail.com
Cc: willemb@google.com, edumazet@google.com, shmulik.ladkani@gmail.com,
	linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/7] net: packet: use skb->dev as storage
 for skb orig len instead of skb->cb[]
From: David Miller <davem@davemloft.net>
In-Reply-To: <1424977624-649-5-git-send-email-eyal.birger@gmail.com>
References: <1424977624-649-1-git-send-email-eyal.birger@gmail.com>
	<1424977624-649-5-git-send-email-eyal.birger@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eyal Birger <eyal.birger@gmail.com>
Date: Thu, 26 Feb 2015 21:07:01 +0200

> As part of an effort to move skb->dropcount to skb->cb[], 4 bytes
> of additional room are needed in skb->cb[] in packet sockets.
> 
> Store the skb original length in skb->dev instead of skb->cb[] for
> this purpose.
> 
> Signed-off-by: Eyal Birger <eyal.birger@gmail.com>

I'm a little confused, why is this even needed?

packet_skb_cb is 24 bytes by my calculations, which is much
smaller than the cb[] size which is 48 bytes.
