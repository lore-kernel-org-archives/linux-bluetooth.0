Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/client: Fix incorrect memory access
Date: Fri, 29 Aug 2014 15:58:31 +0200
Message-ID: <5949935.dO1eoU5aM3@uw000953>
In-Reply-To: <1409060539-14321-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1409060539-14321-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tuesday 26 of August 2014 16:42:19 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> In case argc==3 we might access argv[3]. Make code more readable.
> ---
>  android/client/if-hf.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/android/client/if-hf.c b/android/client/if-hf.c
> index d0e7a66..77216df 100644
> --- a/android/client/if-hf.c
> +++ b/android/client/if-hf.c
> @@ -576,7 +576,7 @@ static void at_response_c(int argc, const char **argv, enum_func *enum_func,
>  static void at_response_p(int argc, const char **argv)
>  {
>  	bthf_at_response_t response_code;
> -	int error_code = 0;
> +	int error_code;
>  
>  	RETURN_IF_NULL(if_hf);
>  
> @@ -588,7 +588,9 @@ static void at_response_p(int argc, const char **argv)
>  	response_code = str2bthf_at_response_t(argv[2]);
>  
>  	/* error code */
> -	if (argc >= 3)
> +	if (argc <= 3)
> +		error_code = 0;
> +	else
>  		error_code = atoi(argv[3]);
>  
>  	EXEC(if_hf->at_response, response_code, error_code);
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
