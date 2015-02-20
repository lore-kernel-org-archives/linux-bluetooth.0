Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Mariusz Skamra <mariusz.skamra@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 1/2] android/handsfree: Fix not sending proper call hold status
Date: Fri, 20 Feb 2015 16:30:36 +0100
Message-ID: <1627618.rSDr1i4ff6@uw000953>
In-Reply-To: <1424442171-15402-1-git-send-email-mariusz.skamra@tieto.com>
References: <1424442171-15402-1-git-send-email-mariusz.skamra@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mariusz,

On Friday 20 of February 2015 15:22:51 Mariusz Skamra wrote:
> This patch fixes not sending callheld=1 +CIEV to HF in Lollipop after
> active/held calls swapping.
> 
> On KitKat phone_state_change calls during active/held swapping looks as follows:
> state=4  active=1  held=0   <= we have another connection
> state=6  active=1  held=1   <= swapped connections
> 
> On Lollipop there is additional bogus state:
> state=4  active=1  held=0
> state=4  active=0  held=1   <= hold current call
> state=6  active=1  held=1
> so the "if (num_held > dev->num_held)" condition is no longer applicable.
> 
> Fixed TC: TC_AG_ECS_BV_03_I, TC_AG_TWC_BV_03_I, TC_AG_TWC_BV_04_I
> ---
>  android/handsfree.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/android/handsfree.c b/android/handsfree.c
> index b7aa1dd..89dceb9 100644
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
> @@ -2380,7 +2383,7 @@ static void phone_state_idle(struct hf_device *dev, int num_active,
>  				connect_audio(dev);
>  		}
>  
> -		if (num_held > dev->num_held)
> +		if (num_held >= dev->num_held && num_held != 0)
>  			update_indicator(dev, IND_CALLHELD, 1);
>  
>  		update_indicator(dev, IND_CALLSETUP, 0);
> 

Patch applied, thanks.
(I've modified commit message a bit since it is not about call swapping
but accepting waiting call and placing active call on hold)

-- 
Best regards, 
Szymon Janc
