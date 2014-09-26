Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/core: Fix extra assignment
Date: Fri, 26 Sep 2014 11:54:02 +0200
Message-ID: <1506993.bGXqPPn6y9@uw000953>
In-Reply-To: <1411719405-14321-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1411719405-14321-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Friday 26 of September 2014 11:16:45 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> prop is assigned in the beginning of for() loop. Fixes warning:
> ...
> android/main.c:336:3: warning: Value stored to 'prop' is never read
>                 prop = buf;
>                 ^      ~~~
> ...
> ---
>  android/main.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/android/main.c b/android/main.c
> index 663995e..2bc2dfe 100644
> --- a/android/main.c
> +++ b/android/main.c
> @@ -334,7 +334,6 @@ static void configuration(const void *buf, uint16_t len)
>  
>  		buf += sizeof(*prop) + prop->len;
>  		len -= sizeof(*prop) + prop->len;
> -		prop = buf;
>  	}
>  
>  	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_CORE, HAL_OP_CONFIGURATION,
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
