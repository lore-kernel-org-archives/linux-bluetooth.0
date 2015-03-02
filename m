Return-Path: <cyrus@holtmann.org>
Date: Mon, 02 Mar 2015 00:20:00 -0500 (EST)
Message-Id: <20150302.002000.2074179681664043670.davem@davemloft.net>
To: eyal.birger@gmail.com
Cc: willemb@google.com, edumazet@google.com, shmulik.ladkani@gmail.com,
	linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/7] net: move skb->dropcount to skb->cb[]
From: David Miller <davem@davemloft.net>
In-Reply-To: <1425214711-9562-1-git-send-email-eyal.birger@gmail.com>
References: <1425214711-9562-1-git-send-email-eyal.birger@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eyal Birger <eyal.birger@gmail.com>
Date: Sun,  1 Mar 2015 14:58:24 +0200

> Commit 977750076d98 ("af_packet: add interframe drop cmsg (v6)")
> unionized skb->mark and skb->dropcount in order to allow recording
> of the socket drop count while maintaining struct sk_buff size.
> 
> skb->dropcount was introduced since there was no available room
> in skb->cb[] in packet sockets. However, its introduction led to
> the inability to export skb->mark to userspace.
> 
> It was considered to alias skb->priority instead of skb->mark.
> However, that would lead to the inabilty to export skb->priority
> to userspace if desired. Such change may also lead to hard-to-find
> issues as skb->priority is assumed to be alias free, and, as noted
> by Shmulik Ladkani, is not 'naturally orthogonal' with other skb
> fields.
> 
> This patch series follows the suggestions made by Eric Dumazet moving
> the dropcount metric to skb->cb[], eliminating this problem
> at the expense of 4 bytes less in skb->cb[] for protocol families
> using it.
> 
> The patch series include compactization of bluetooth and packet
> use of skb->cb[] as well as the infrastructure for placing dropcount
> in skb->cb[].

Ok, I think I can live with this.

Series applied, thanks.
