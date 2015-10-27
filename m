Return-Path: <cyrus@holtmann.org>
Message-ID: <1445933714.2902.3.camel@linux.intel.com>
Subject: Re: [PATCH bluetooth-next] bluetooth: 6lowpan: fix NOHZ:
 local_softirq_pending
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, kernel@pengutronix.de
Date: Tue, 27 Oct 2015 10:15:14 +0200
In-Reply-To: <1445931324-1524-1-git-send-email-alex.aring@gmail.com>
References: <1445931324-1524-1-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I have verified that this works.

Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>


Cheers,
Jukka


On ti, 2015-10-27 at 08:35 +0100, Alexander Aring wrote:
> Jukka reported about the following warning:
> 
> "NOHZ: local_softirq_pending 08"
> 
> I remember this warning and we had a similar issue when using workqueues
> and calling netif_rx. See commit 5ff3fec ("mac802154: fix NOHZ
> local_softirq_pending 08 warning").
> 
> This warning occurs when calling "netif_rx" inside the wrong context
> (non softirq context). The net core api offers "netif_rx_ni" to call
> netif_rx inside the correct softirq context.
> 
> Reported-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>  net/bluetooth/6lowpan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index d85af23..9e9cca3 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -263,7 +263,7 @@ static int give_skb_to_upper(struct sk_buff *skb, struct net_device *dev)
>  	if (!skb_cp)
>  		return NET_RX_DROP;
>  
> -	return netif_rx(skb_cp);
> +	return netif_rx_ni(skb_cp);
>  }
>  
>  static int iphc_decompress(struct sk_buff *skb, struct net_device *netdev,


