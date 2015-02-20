Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Mariusz Skamra <mariusz.skamra@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] android/handsfree: Fix SCO disconnection while dialing
Date: Fri, 20 Feb 2015 16:29:37 +0100
Message-ID: <1474927.h0juZcpg0K@uw000953>
In-Reply-To: <1424427986-31620-2-git-send-email-mariusz.skamra@tieto.com>
References: <1424427986-31620-1-git-send-email-mariusz.skamra@tieto.com> <1424427986-31620-2-git-send-email-mariusz.skamra@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mariusz,

On Friday 20 of February 2015 11:26:26 Mariusz Skamra wrote:
> If we decide to hang up while dialing or alerting, SCO needs to be closed.
> Fixes: TC_AG_TCA_BV_04_C
> ---
>  android/handsfree.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/android/handsfree.c b/android/handsfree.c
> index f4d6cf0..b0d8058 100644
> --- a/android/handsfree.c
> +++ b/android/handsfree.c
> @@ -2403,6 +2403,10 @@ static void phone_state_idle(struct hf_device *dev, int num_active,
>  					num_held ? (num_active ? 1 : 2) : 0);
>  
>  		update_indicator(dev, IND_CALLSETUP, 0);
> +
> +		/* disconnect SCO if we hang up while dialing or alerting */
> +		if (num_active == 0 && num_held == 0)
> +			disconnect_sco(dev);
>  		break;
>  	case HAL_HANDSFREE_CALL_STATE_IDLE:
>  		if (dev->call_hanging_up) {
> 

This patch is now applied, thanks.

-- 
Best regards, 
Szymon Janc
