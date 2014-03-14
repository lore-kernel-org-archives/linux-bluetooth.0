Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/client: Fix segfault (invalid argv) for gatt scan
Date: Fri, 14 Mar 2014 14:48:16 +0100
Message-ID: <2088077.6xLvG5hkAH@uw000953>
In-Reply-To: <1394801166-5860-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1394801166-5860-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Friday 14 of March 2014 13:46:06 Grzegorz Kolodziejczyk wrote:
> This patch fix segfault driven by lack of 4 element in avrg array.
> If user put only two arguments, reading of lacking (auto set to start=1)
> third argument, will trigger segfault.
> ---
>  android/client/if-gatt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
> index e8837ff..17a491e 100644
> --- a/android/client/if-gatt.c
> +++ b/android/client/if-gatt.c
> @@ -854,7 +854,7 @@ static void scan_p(int argc, const char **argv)
>  	VERIFY_CLIENT_IF(2, client_if);
>  
>  	/* start */
> -	if (argc >= 3)
> +	if (argc >= 4)
>  		start = atoi(argv[3]);
>  
>  	EXEC(if_gatt->client->scan, client_if, start);
> 

Pushed, thanks.

-- 
Best regards, 
Szymon Janc
