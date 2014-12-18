Return-Path: <cyrus@holtmann.org>
Message-ID: <1418911535.2876.25.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH] Bluetooth: 6lowpan: Do not free skb when packet is
 dropped
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Date: Thu, 18 Dec 2014 16:05:35 +0200
In-Reply-To: <1418213993-24884-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1418213993-24884-1-git-send-email-jukka.rissanen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ping.

On ke, 2014-12-10 at 14:19 +0200, Jukka Rissanen wrote:
> If we need to drop the message because of some error in the
> compression etc, then do not free the skb as that is done
> automatically in other part of networking stack.
> 
> Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> ---
>  net/bluetooth/6lowpan.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index bdcaefd..ca5b4ec 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -390,7 +390,6 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
>  
>  drop:
>  	dev->stats.rx_dropped++;
> -	kfree_skb(skb);
>  	return NET_RX_DROP;
>  }
>  


This patch should be applied at least in bluetooth-next. I have not seen
any errors in earlier kernels as we never seem to go to this branch but
because of Alex's ip header compression patches (that are still
pending), this error branch will be hit quite easily in the future. The
patch could be applied also to earlier kernels just in case.


Cheers,
Jukka


