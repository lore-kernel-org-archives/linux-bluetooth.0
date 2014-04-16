Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/gatt: Fix caching included services descriptors
Date: Wed, 16 Apr 2014 10:26:47 +0200
Message-ID: <2053080.O4OVkYrQ3G@uw000953>
In-Reply-To: <1397471991-21200-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1397471991-21200-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Monday 14 of April 2014 12:39:50 Jakub Tyszkowski wrote:
> ---
>  android/gatt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 004063c..f303aea 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -1839,7 +1839,7 @@ static bool build_descr_cache(int32_t conn_id, struct gatt_device *dev,
>  
>  	/* Clip range to given characteristic */
>  	start = ch->ch.value_handle + 1;
> -	end = srvc->prim.range.end;
> +	end = srvc->primary ? srvc->prim.range.end : srvc->incl.range.end;
>  
>  	/* Use next characteristic start as end. If there is none -
>  	 * service end is valid end.
> 

Both patches applied, thanks.

-- 
Best regards, 
Szymon Janc
