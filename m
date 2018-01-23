Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/8] tools/btpclient: Fix start adv commend comment
Date: Tue, 23 Jan 2018 14:44:39 +0100
Message-ID: <3719411.ZklPXJbIEc@ix>
In-Reply-To: <20180119164133.16767-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180119164133.16767-1-grzegorz.kolodziejczyk@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Friday, 19 January 2018 17:41:26 CET Grzegorz Kolodziejczyk wrote:
> Comment should be aproperiate for advertising command. Device needs to
> be powered to advertise.
> ---
>  tools/btpclient.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/btpclient.c b/tools/btpclient.c
> index af0e75290..33116ce1b 100644
> --- a/tools/btpclient.c
> +++ b/tools/btpclient.c
> @@ -1038,7 +1038,7 @@ static void btp_gap_start_advertising(uint8_t index,
> const void *param, goto failed;
>  	}
> 
> -	/* Adapter needs to be powered to be able to remove devices */
> +	/* Adapter needs to be powered to be able to advertise */
>  	if (!l_dbus_proxy_get_property(adapter->proxy, "Powered", "b", &prop) ||
>  							!prop || ad.registered)
>  		goto failed;

Patches 1 and 2 are now applied. Thanks.

-- 
pozdrawiam
Szymon Janc


