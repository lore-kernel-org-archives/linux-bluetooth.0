Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/5] android/handsfree: Fix possible g_io_channel_shutdown() on NULL channel
Date: Sat, 08 Mar 2014 20:00:34 +0100
Message-ID: <3039812.7AVkPW4BFl@leonov>
In-Reply-To: <1394223800-11961-1-git-send-email-marcin.kraglak@tieto.com>
References: <1394223800-11961-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Friday 07 of March 2014 21:23:16 Marcin Kraglak wrote:
> Return false if listen failed.
> ---
>  android/handsfree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/handsfree.c b/android/handsfree.c
> index dc5c73d..fa27f10 100644
> --- a/android/handsfree.c
> +++ b/android/handsfree.c
> @@ -1192,7 +1192,7 @@ static bool enable_hfp_ag(void)
>  	if (!hfp_server) {
>  		error("Failed to listen on Handsfree rfcomm: %s", err->message);
>  		g_error_free(err);
> -		goto failed;
> +		return false;
>  	}
> 
>  	rec = hfp_ag_record();

This patch is now pushed, thanks.

-- 
BR
Szymon Janc
