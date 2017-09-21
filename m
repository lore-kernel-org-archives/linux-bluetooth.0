Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1505996346.12143.1.camel@linux.intel.com>
Subject: Re: [PATCH] Bluetooth: 6lowpan: Fix multi-link setup
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date: Thu, 21 Sep 2017 15:19:06 +0300
In-Reply-To: <20170920095253.8634-1-luiz.dentz@gmail.com>
References: <20170920095253.8634-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, 2017-09-20 at 12:52 +0300, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If there are more than one node connected and there isn't any route
> information attempt to check if destination address matches any of
> the
> link-local peer addresses.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/6lowpan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index 4e2576fc0c59..55370c330386 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -190,7 +190,7 @@ static inline struct lowpan_peer
> *peer_lookup_dst(struct lowpan_btle_dev *dev,
>  		nexthop = &lowpan_cb(skb)->gw;
>  
>  		if (ipv6_addr_any(nexthop))
> -			return NULL;
> +			nexthop = daddr;
>  	} else {
>  		nexthop = rt6_nexthop(rt, daddr);
>  


Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>


Cheers,
Jukka

