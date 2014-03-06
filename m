Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 01/11] shared/hfp: Fix not freeing cmd_handler prefix
Date: Thu, 06 Mar 2014 10:21:47 +0100
Message-ID: <2289016.VB6flxH51s@uw000953>
In-Reply-To: <1394047376-11495-1-git-send-email-marcin.kraglak@tieto.com>
References: <1394047376-11495-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Wednesday 05 of March 2014 20:22:46 Marcin Kraglak wrote:
> It should be freed while destroy.
> ---
>  src/shared/hfp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/src/shared/hfp.c b/src/shared/hfp.c
> index 08393d8..9523243 100644
> --- a/src/shared/hfp.c
> +++ b/src/shared/hfp.c
> @@ -82,6 +82,8 @@ static void destroy_cmd_handler(void *data)
>  	if (handler->destroy)
>  		handler->destroy(handler->user_data);
>  
> +	free(handler->prefix);
> +
>  	free(handler);
>  }
>  

All patches applied, thanks.

-- 
Best regards, 
Szymon Janc
