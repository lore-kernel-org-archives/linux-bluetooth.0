Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] shared/hfp: Improve prefix comparing
Date: Wed, 03 Dec 2014 11:06:40 +0100
Message-ID: <2856408.IYG60yLa7R@uw000953>
In-Reply-To: <1417518069-18289-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1417518069-18289-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Tuesday 02 of December 2014 12:01:09 Lukasz Rymanowski wrote:
> ---
>  src/shared/hfp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/shared/hfp.c b/src/shared/hfp.c
> index 5a91d12..ead082e 100644
> --- a/src/shared/hfp.c
> +++ b/src/shared/hfp.c
> @@ -936,7 +936,7 @@ static bool match_handler_event_prefix(const void *a, const void *b)
>  	const struct event_handler *handler = a;
>  	const char *prefix = b;
>  
> -	if (memcmp(handler->prefix, prefix, strlen(prefix)))
> +	if (strcmp(handler->prefix, prefix) != 0)
>  		return false;
>  
>  	return true;

Applied, thanks. 

-- 
Best regards, 
Szymon Janc
