Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/health: Fix wrong user data passing in set_mcl_cb
Date: Fri, 27 Jun 2014 15:31:53 +0200
Message-ID: <1453660.8hzhqKDWXg@uw000953>
In-Reply-To: <1403816654-19539-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1403816654-19539-1-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Friday 27 of June 2014 00:04:14 Ravi kumar Veeramally wrote:
> It used to be channel, when set_mcl_cb refactored
> it got changed to channed->dev.
> commit 32180fa3a649ec26f9f3891a0ff5e4fe16592b91 introduced it.
> ---
>  android/health.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/health.c b/android/health.c
> index 42c9a6e..30a6166 100644
> --- a/android/health.c
> +++ b/android/health.c
> @@ -1341,7 +1341,7 @@ static void create_mcl_cb(struct mcap_mcl *mcl, GError *err, gpointer data)
>  	channel->dev->mcl_conn = true;
>  	info("MCL connected");
>  
> -	ret = set_mcl_cb(channel->dev->mcl, channel->dev, &gerr);
> +	ret = set_mcl_cb(channel->dev->mcl, channel, &gerr);
>  	if (!ret) {
>  		error("health: error setting mdl callbacks: %s", gerr->message);
>  		g_error_free(gerr);
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
