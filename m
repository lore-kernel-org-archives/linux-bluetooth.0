Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
Date: Fri, 18 Jun 2010 21:28:07 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	marcel@holtmann.org
Subject: Re: [PATCH] Bluetooth: Bring back var 'i' increment
Message-ID: <20100619002807.GD14514@vigoh>
References: <20100619002213.GC14514@vigoh>
 <1276907040-23229-1-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1276907040-23229-1-git-send-email-padovan@profusion.mobi>
List-ID: <linux-bluetooth.vger.kernel.org>

* Gustavo F. Padovan <padovan@profusion.mobi> [2010-06-18 21:24:00 -0300]:

> commit ff6e2163f28a1094fb5ca5950fe2b43c3cf6bc7a accidentally added a
> regression on the bnep code. Fixing it.
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  net/bluetooth/bnep/netdev.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/bnep/netdev.c b/net/bluetooth/bnep/netdev.c
> index 0faad5c..8c100c9 100644
> --- a/net/bluetooth/bnep/netdev.c
> +++ b/net/bluetooth/bnep/netdev.c
> @@ -104,6 +104,8 @@ static void bnep_net_set_mc_list(struct net_device *dev)
>  				break;
>  			memcpy(__skb_put(skb, ETH_ALEN), ha->addr, ETH_ALEN);
>  			memcpy(__skb_put(skb, ETH_ALEN), ha->addr, ETH_ALEN);
> +
> +			i++;
>  		}
>  		r->len = htons(skb->len - len);
>  	}
> -- 

Marcel, if you want I can carry the fix on my tree for -next.

-- 
Gustavo F. Padovan
http://padovan.org
