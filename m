Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/client: Fix double initialize of bluetooth
Date: Wed, 03 Dec 2014 09:14:48 +0100
Message-ID: <13772873.ZZKrfl6tUA@uw000953>
In-Reply-To: <1417002229-3354-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1417002229-3354-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Wednesday 26 of November 2014 12:43:48 Grzegorz Kolodziejczyk wrote:
> Profile initialization loop should omit already initialized profiles
> by process line command.
> ---
>  android/client/haltest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/client/haltest.c b/android/client/haltest.c
> index add1978..f19e671 100644
> --- a/android/client/haltest.c
> +++ b/android/client/haltest.c
> @@ -422,7 +422,7 @@ static void init(void)
>  	}
>  
>  	/* Init what is available to init */
> -	for (i = 2; i < NELEM(interfaces) - 1; ++i) {
> +	for (i = 3; i < NELEM(interfaces) - 1; ++i) {
>  		m = get_interface_method(interfaces[i]->name, "init");
>  		if (m != NULL)
>  			m->func(2, argv);

Both patches applied, thanks.

-- 
Best regards, 
Szymon Janc
