Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] android/health: Fix connect channel failure case
Date: Tue, 19 Aug 2014 18:42:30 +0200
Message-ID: <3374360.1SjBy6sgGZ@leonov>
In-Reply-To: <1408352822-21572-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1408352822-21572-1-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Monday 18 of August 2014 12:06:59 Ravi kumar Veeramally wrote:
> There is a possibilty of created channel is being added to queue,
> but on failure case it does channel free but not removed from queue.
> ---
>  android/health.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/android/health.c b/android/health.c
> index f4edc3e..f86fd26 100644
> --- a/android/health.c
> +++ b/android/health.c
> @@ -1978,6 +1978,7 @@ static void bt_health_connect_channel(const void *buf,
> uint16_t len) return;
> 
>  fail:
> +	queue_remove(channel->dev->channels, channel);
>  	free_health_channel(channel);
>  	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH,
>  			HAL_OP_HEALTH_CONNECT_CHANNEL, HAL_STATUS_FAILED);

I've applied patches 1, 3 and 4. Thanks.

-- 
BR
Szymon Janc
