Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/6] android/bluetooth: Fix passing NULL pointer to memcpy
Date: Mon, 14 Apr 2014 10:24:05 +0200
Message-ID: <11846673.LzvPsPqHlb@uw000953>
In-Reply-To: <1397202087-1203-1-git-send-email-szymon.janc@tieto.com>
References: <1397202087-1203-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday 11 of April 2014 09:41:22 Szymon Janc wrote:
> It is possible to have property with empty value (ie. bonded devices)
> so check len before calling memcpy.
> ---
>  android/bluetooth.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index 4e4397a..70b0849 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -1160,7 +1160,9 @@ static int fill_hal_prop(void *buf, uint8_t type, uint16_t len,
>  
>  	prop->type = type;
>  	prop->len = len;
> -	memcpy(prop->val, val, len);
> +
> +	if (len)
> +		memcpy(prop->val, val, len);
>  
>  	return sizeof(*prop) + len;
>  }
> 

This serie is now upstream.

-- 
Best regards, 
Szymon Janc
