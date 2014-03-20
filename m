Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/handsfree: Improve audio connection handling
Date: Thu, 20 Mar 2014 13:36:35 +0100
Message-ID: <1706809.0fgfNfC4aM@uw000953>
In-Reply-To: <1395213926-16351-1-git-send-email-szymon.janc@tieto.com>
References: <1395213926-16351-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wednesday 19 of March 2014 08:25:25 Szymon Janc wrote:
> This add disconnecting SCO if last call was dropped (required by
> Java 'virtual voice call'). Also make sure that SCO is connected
> only there were no calls present before phone state change. This
> makes sure SCO won't be re-connected in three way calling scenarios
> when user choose to not use audio on BT headset.
> ---
>  android/handsfree.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/android/handsfree.c b/android/handsfree.c
> index c8e5f8a..ebeb751 100644
> --- a/android/handsfree.c
> +++ b/android/handsfree.c
> @@ -1995,7 +1995,8 @@ static void phone_state_dialing(int num_active, int num_held)
>  	if (num_active == 0 && num_held > 0)
>  		update_indicator(IND_CALLHELD, 2);
>  
> -	connect_audio();
> +	if (device.num_active == 0 && device.num_held == 0)
> +		connect_audio();
>  }
>  
>  static void phone_state_alerting(int num_active, int num_held)
> @@ -2066,7 +2067,9 @@ static void phone_state_idle(int num_active, int num_held)
>  	case HAL_HANDSFREE_CALL_STATE_INCOMING:
>  		if (num_active > device.num_active) {
>  			update_indicator(IND_CALL, 1);
> -			connect_audio();
> +
> +			if (device.num_active == 0 && device.num_held == 0)
> +				connect_audio();
>  		}
>  
>  		if (num_held > device.num_held)
> @@ -2089,14 +2092,16 @@ static void phone_state_idle(int num_active, int num_held)
>  			/* TODO better way for forcing indicator */
>  			device.inds[IND_CALLHELD].val = 0;
>  			update_indicator(IND_CALLHELD, 1);
> -		} else if (num_active > 0 && device.num_active == 0) {
> -			/* If number of active calls change but there was no
> -			 * call setup change this means that there were active
> +		} else if ((num_active > 0 || num_held > 0) &&
> +						device.num_active == 0 &&
> +						device.num_held == 0) {
> +			/* If number of active or held calls change but there
> +			 * was no call setup change this means that there were
>  			 * calls present when headset was connected.
> -			 *
> -			 * TODO should we care about held calls here as well?
>  			 */
>  			connect_audio();
> +		} else if (num_active == 0 && num_held == 0) {
> +			disconnect_sco();
>  		} else {
>  			update_indicator(IND_CALLHELD,
>  					num_held ? (num_active ? 1 : 2) : 0);
> 

Pushed.

-- 
Best regards, 
Szymon Janc
