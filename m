Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 Jun 2014 08:18:02 -0700 (PDT)
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/gatt: Remove dead code
Message-ID: <3179188.quvouCAdva@uw000953>
In-Reply-To: <1403173701-23206-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403173701-23206-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thursday 19 of June 2014 13:28:21 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> The code apparently left after wrong rebase as it duplicates code
> several lines above.
> ---
>  android/gatt.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 24884e9..5007817 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -5310,11 +5310,6 @@ static uint8_t find_info_handle(const uint8_t *cmd, uint16_t cmd_len,
>  
>  	}
>  
> -	if (!adl) {
> -		queue_destroy(q, NULL);
> -		return ATT_ECODE_INSUFF_RESOURCES;
> -	}
> -
>  	len = enc_find_info_resp(ATT_FIND_INFO_RESP_FMT_16BIT, adl, rsp,
>  								rsp_size);
>  	if (!len)
> 

Patch applied, thanks.

-- 
Best regards, 
Szymon Janc
