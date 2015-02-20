Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Mariusz Skamra <mariusz.skamra@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/handsfree: Fix not sending proper call hold status
Date: Fri, 20 Feb 2015 13:29:49 +0100
Message-ID: <1462854.5Z6QnhHAIO@uw000953>
In-Reply-To: <1424427986-31620-1-git-send-email-mariusz.skamra@tieto.com>
References: <1424427986-31620-1-git-send-email-mariusz.skamra@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mariusz,

On Friday 20 of February 2015 11:26:25 Mariusz Skamra wrote:
> This patch fixes not sending callheld=1 +CIEV to HF in lollipop after
> active/held calls swapping.

Patch itself looks OK but I'd really appreciate better commit message.
Ie. what phone_state seq we get on KK and on L. 

> Fixed TC: TC_AG_ECS_BV_03_I, TC_AG_TWC_BV_03_I, TC_AG_TWC_BV_04_I
> ---
>  android/handsfree.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/android/handsfree.c b/android/handsfree.c
> index b7aa1dd..f4d6cf0 100644
> --- a/android/handsfree.c
> +++ b/android/handsfree.c
> @@ -2304,6 +2304,9 @@ static void phone_state_incoming(struct hf_device *dev, int num_active,
>  	if (dev->setup_state == HAL_HANDSFREE_CALL_STATE_INCOMING) {
>  		if (dev->num_active != num_active ||
>  						dev->num_held != num_held) {
> +			if (dev->num_active == num_held &&
> +						dev->num_held == num_active)
> +				return;
>  			/*
>  			 * calls changed while waiting call ie. due to
>  			 * termination of active call
> @@ -2380,11 +2383,11 @@ static void phone_state_idle(struct hf_device *dev, int num_active,
>  				connect_audio(dev);
>  		}
>  
> -		if (num_held > dev->num_held)
> -			update_indicator(dev, IND_CALLHELD, 1);
> -
>  		update_indicator(dev, IND_CALLSETUP, 0);
>  
> +		if (num_held >= dev->num_held && num_held != 0)
> +			update_indicator(dev, IND_CALLHELD, 1);
> +
>  		if (num_active == 0 && num_held == 0 &&
>  				num_active == dev->num_active &&
>  				num_held == dev->num_held)
> 

-- 
Best regards, 
Szymon Janc
