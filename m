Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/client: Allow empty string for dial command
Date: Mon, 03 Nov 2014 14:43:34 +0100
Message-ID: <7043290.MkJvSqFmIS@uw000953>
In-Reply-To: <1415018178-32132-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415018178-32132-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Monday 03 of November 2014 13:36:18 Lukasz Rymanowski wrote:
> Empty string is used for redial command
> ---
>  android/client/if-hf-client.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/android/client/if-hf-client.c b/android/client/if-hf-client.c
> index 1108639..a837401 100644
> --- a/android/client/if-hf-client.c
> +++ b/android/client/if-hf-client.c
> @@ -533,7 +533,8 @@ static void dial_p(int argc, const char **argv)
>  
>  	/* number string */
>  	if (argc <= 2) {
> -		haltest_error("No number specified\n");
> +		haltest_info("Number not specified. Redial\n");
> +		EXEC(if_hf_client->dial, NULL);
>  		return;
>  	}
>  

Applied, thanks. 

-- 
Best regards, 
Szymon Janc
