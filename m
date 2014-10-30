Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] shared/hfp: Remove reduntant check
Date: Thu, 30 Oct 2014 10:56:22 +0100
Message-ID: <5280356.hO7J17kob9@leonov>
In-Reply-To: <1414624583-29236-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1414624583-29236-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Thursday 30 of October 2014 00:16:22 Lukasz Rymanowski wrote:
> This check is not needed. Below memcmp check is sufficient
> ---
>  src/shared/hfp.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/src/shared/hfp.c b/src/shared/hfp.c
> index 22e9622..f5a812d 100644
> --- a/src/shared/hfp.c
> +++ b/src/shared/hfp.c
> @@ -135,9 +135,6 @@ static bool match_handler_prefix(const void *a, const
> void *b) const struct cmd_handler *handler = a;
>  	const char *prefix = b;
> 
> -	if (strlen(handler->prefix) != strlen(prefix))
> -		return false;
> -
>  	if (memcmp(handler->prefix, prefix, strlen(prefix)))
>  		return false;

So, why not just use strcmp here instead?

-- 
BR
Szymon Janc
