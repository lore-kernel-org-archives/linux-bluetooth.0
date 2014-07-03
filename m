Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH_v2] android/hal-health: Fix do not modify fd flags in non connected state
Date: Thu, 03 Jul 2014 15:34:59 +0200
Message-ID: <1606516.mEYMr2KfOU@uw000953>
In-Reply-To: <1404394161-31721-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1404394161-31721-1-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Thursday 03 of July 2014 16:29:21 Ravi kumar Veeramally wrote:
> Only on BTHL_CONN_STATE_CONNECTED state valid fd will be passed. Other states
> fd value is -1. Just call channel status call back.
> ---
>  android/hal-health.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/android/hal-health.c b/android/hal-health.c
> index 1ed9fb1..01bc432 100644
> --- a/android/hal-health.c
> +++ b/android/hal-health.c
> @@ -49,6 +49,9 @@ static void handle_channel_state(void *buf, uint16_t len, int fd)
>  	struct hal_ev_health_channel_state *ev = buf;
>  	int flags;
>  
> +	if (fd < 0)
> +		goto end;
> +
>  	flags = fcntl(fd, F_GETFL, 0);
>  	if (flags < 0) {
>  		error("health: fcntl GETFL error: %s", strerror(errno));
> @@ -61,6 +64,7 @@ static void handle_channel_state(void *buf, uint16_t len, int fd)
>  		return;
>  	}
>  
> +end:
>  	if (cbacks->channel_state_cb)
>  		cbacks->channel_state_cb(ev->app_id, (bt_bdaddr_t *) ev->bdaddr,
>  						ev->mdep_index, ev->channel_id,
> 

Patch applied, thanks.

-- 
Best regards, 
Szymon Janc
