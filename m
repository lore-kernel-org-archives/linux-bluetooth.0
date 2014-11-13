Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] android/client: Fix argc count
Date: Thu, 13 Nov 2014 18:10:46 +0100
Message-ID: <1793394.KRxBlXXJBj@uw000953>
In-Reply-To: <1415805269-6838-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415805269-6838-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wednesday 12 of November 2014 17:14:26 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  android/client/if-hf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/client/if-hf.c b/android/client/if-hf.c
> index 26c0139..269e029 100644
> --- a/android/client/if-hf.c
> +++ b/android/client/if-hf.c
> @@ -386,7 +386,7 @@ static void init_p(int argc, const char **argv)
>  	RETURN_IF_NULL(if_hf);
>  
>  #if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
> -	if (argc < 2)
> +	if (argc <= 2)
>  		max_hf_clients = 1;
>  	else
>  		max_hf_clients = atoi(argv[2]);
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
