Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/handsfree: Connect audio when Android framemework expects it
Date: Sat, 15 Mar 2014 23:52:55 +0100
Message-ID: <51668219.dQrEIM1jV7@leonov>
In-Reply-To: <1394913517-14228-1-git-send-email-marcin.kraglak@tieto.com>
References: <1394913517-14228-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Saturday 15 of March 2014 20:58:37 Marcin Kraglak wrote:
> There are few cases when framework doesn't call connect_audio method
> from HAL but we should do it internally. Call connect_audio if
> we started dialing or we accepted incoming call. Also if headset
> connects during active call, start SCO connection. We don't have to
> disconnect SCO internally, because Android always call disconect_audio
> when call has finished.
> ---
>  android/handsfree.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/android/handsfree.c b/android/handsfree.c
> index d4dc596..ec59287 100644
> --- a/android/handsfree.c
> +++ b/android/handsfree.c
> @@ -1653,6 +1653,9 @@ static bool disconnect_sco(void)
> 
>  static bool connect_audio(void)
>  {
> +	if (device.audio_state != HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED)
> +		return false;
> +
>  	/* we haven't negotiated codec, start selection */
>  	if ((device.features & HFP_HF_FEAT_CODEC) && !device.negotiated_codec) {
>  		select_codec(0);
> @@ -1989,6 +1992,8 @@ static void phone_state_dialing(int num_active, int
> num_held)
> 
>  	if (num_active == 0 && num_held > 0)
>  		update_indicator(IND_CALLHELD, 2);
> +
> +	connect_audio();
>  }
> 
>  static void phone_state_alerting(int num_active, int num_held)
> @@ -2057,8 +2062,10 @@ static void phone_state_idle(int num_active, int
> num_held)
> 
>  	switch (device.setup_state) {
>  	case HAL_HANDSFREE_CALL_STATE_INCOMING:
> -		if (num_active > device.num_active)
> +		if (num_active > device.num_active) {
>  			update_indicator(IND_CALL, 1);
> +			connect_audio();
> +		}
> 
>  		if (num_held > device.num_held)
>  			update_indicator(IND_CALLHELD, 1);
> @@ -2088,6 +2095,9 @@ static void phone_state_idle(int num_active, int
> num_held) update_indicator(IND_CALLSETUP, 0);
> 
>  		break;
> +	case HAL_HANDSFREE_CALL_STATE_ACTIVE:
> +		connect_audio();
> +		break;
>  	default:
>  		DBG("unhandled state %u", device.setup_state);
>  		break;

Patch applied. Thanks.

-- 
BR
Szymon Janc
