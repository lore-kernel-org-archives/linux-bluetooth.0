Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH 4/5] ipv6: addrconf: fix 48 bit 6lowpan autoconfiguration
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20170209145551.12747-1-luiz.dentz@gmail.com>
 <20170209145551.12747-5-luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, patrik.flykt@linux.intel.com
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <625c88f2-8063-3bcc-8d8e-46a0c43c44e4@pengutronix.de>
Date: Wed, 15 Feb 2017 08:29:32 +0100
MIME-Version: 1.0
In-Reply-To: <20170209145551.12747-5-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi,

On 02/09/2017 03:55 PM, Luiz Augusto von Dentz wrote:
> From: Alexander Aring <aar@pengutronix.de>
> 
> This patch adds support for 48 bit 6LoWPAN address length
> autoconfiguration which is the case for BTLE 6LoWPAN.
> 
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/ipv6/addrconf.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index ac9bd56..dede33f 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -2050,12 +2050,19 @@ static void addrconf_leave_anycast(struct inet6_ifaddr *ifp)
>  	__ipv6_dev_ac_dec(ifp->idev, &addr);
>  }
>  
> -static int addrconf_ifid_eui64(u8 *eui, struct net_device *dev)
> +static int addrconf_ifid_6lowpan(u8 *eui, struct net_device *dev)
>  {
> -	if (dev->addr_len != EUI64_ADDR_LEN)
> +	switch (dev->addr_len) {
> +	case ETH_ALEN:
> +		return addrconf_ifid_eui48(eui, dev);
> +	case EUI64_ADDR_LEN:
> +		memcpy(eui, dev->dev_addr, EUI64_ADDR_LEN);
> +		eui[0] ^= 2;
> +		break;
> +	default:
>  		return -1;
> -	memcpy(eui, dev->dev_addr, EUI64_ADDR_LEN);
> -	eui[0] ^= 2;
> +	}
> +
>  	return 0;
>  }
>

The question is here to evaluate the link-layer type here... I see
problems coming if another 6LoWPAN adaptation is there and use the same
address length but RFC describes different handling to generate SLAAC.

Nevertheless it should work right now, we can always touch the code
again. :-)

- Alex
