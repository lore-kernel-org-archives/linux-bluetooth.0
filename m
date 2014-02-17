Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android: Fix for BT Turn off while pairing
Date: Mon, 17 Feb 2014 14:46:04 +0100
Message-ID: <3736763.bny4WZ95Dz@uw000953>
In-Reply-To: <1392288692-5917-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1392288692-5917-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Thursday 13 of February 2014 11:51:32 Lukasz Rymanowski wrote:
> This patch fix an issue when Android disables BT during ongoing
> paring. In this case mgmt did not accept any commands and BT gets
> in some unknown state.
> Since Android turns off BT anyway, it is ok to just cancel all
> the mgmt requests before send power off command.
> ---
>  android/bluetooth.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index ff41627..ad8cfec 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -2907,6 +2907,9 @@ static void handle_disable_cmd(const void *buf, uint16_t len)
>  		goto reply;
>  	}
>  
> +	/* Cancel all pending requests. Need it in case of ongoing paring */
> +	mgmt_cancel_index(mgmt_if, adapter.index);
> +
>  	if (!set_mode(MGMT_OP_SET_POWERED, 0x00)) {
>  		status = HAL_STATUS_FAILED;
>  		goto reply;

Applied, thanks. 

-- 
Best regards, 
Szymon Janc
