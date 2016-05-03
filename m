Return-Path: <stefan@osg.samsung.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: Re: [PATCHv2 bluetooth-next 03/10] 6lowpan: remove ipv6 module
 request
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org
References: <1461140382-4784-1-git-send-email-aar@pengutronix.de>
 <1461140382-4784-4-git-send-email-aar@pengutronix.de>
Cc: kernel@pengutronix.de, marcel@holtmann.org,
 jukka.rissanen@linux.intel.com, hannes@stressinduktion.org,
 mcr@sandelman.ca, werner@almesberger.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Message-ID: <5728EB15.7060801@osg.samsung.com>
Date: Tue, 3 May 2016 20:16:53 +0200
MIME-Version: 1.0
In-Reply-To: <1461140382-4784-4-git-send-email-aar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hello.

On 20/04/16 10:19, Alexander Aring wrote:
> Since we use exported function from ipv6 kernel module we don't need to
> request the module anymore to have ipv6 functionality.
>
> Signed-off-by: Alexander Aring<aar@pengutronix.de>
> ---
>   net/6lowpan/core.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/net/6lowpan/core.c b/net/6lowpan/core.c
> index fbae31e..824d1bc 100644
> --- a/net/6lowpan/core.c
> +++ b/net/6lowpan/core.c
> @@ -158,8 +158,6 @@ static int __init lowpan_module_init(void)
>   		return ret;
>   	}
>   
> -	request_module_nowait("ipv6");
> -
>   	request_module_nowait("nhc_dest");
>   	request_module_nowait("nhc_fragment");
>   	request_module_nowait("nhc_hop");
Good point.

Reviewed-by: Stefan Schmidt<stefan@osg.samsung.com>

regards
Stefan Schmidt
