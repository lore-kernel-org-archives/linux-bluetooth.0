Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH_v2 1/5] android/health: Fix wrong mdep config index
Date: Tue, 24 Jun 2014 10:57:19 +0200
Message-ID: <1506158.r3vhe5zJ2o@uw000953>
In-Reply-To: <1403535964-32644-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1403535964-32644-1-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Monday 23 of June 2014 18:06:00 Ravi kumar Veeramally wrote:
> MDEP Id starts from 1, (0 value for Echo). HAL api sends mdep cfg index
> which starts from 0.
> ---
>  android/health.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/health.c b/android/health.c
> index effa5e2..183608b 100644
> --- a/android/health.c
> +++ b/android/health.c
> @@ -137,7 +137,7 @@ static void send_channel_state_notify(struct health_channel *channel,
>  
>  	bdaddr2android(&channel->dev->dst, ev.bdaddr);
>  	ev.app_id = channel->dev->app_id;
> -	ev.mdep_index = channel->mdep_id;
> +	ev.mdep_index = channel->mdep_id - 1;
>  	ev.channel_id = channel->id;
>  	ev.channel_state = state;
>  
> 

All patches applied, thanks.

-- 
Best regards, 
Szymon Janc
