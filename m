Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/client: Add a2dp audio config callback
Date: Thu, 27 Nov 2014 18:16:51 +0100
Message-ID: <2687365.OAm2ReHCmt@uw000953>
In-Reply-To: <1416818807-24433-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1416818807-24433-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Monday 24 of November 2014 09:46:46 Jakub Tyszkowski wrote:
> This is Android 5 API callback.
> ---
>  android/client/if-av.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/android/client/if-av.c b/android/client/if-av.c
> index 8d1f69b..85c641b 100644
> --- a/android/client/if-av.c
> +++ b/android/client/if-av.c
> @@ -50,10 +50,22 @@ static void audio_state(btav_audio_state_t state, bt_bdaddr_t *bd_addr)
>  					bt_bdaddr_t2str(bd_addr, last_addr));
>  }
>  
> +#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
> +static void audio_config(bt_bdaddr_t *bd_addr, uint32_t sample_rate,
> +							uint8_t channel_count) {
> +	haltest_info("%s: remote_addr=%s\n sample_rate=%d\n channel_count=%d\n",
> +				__func__, bt_bdaddr_t2str(bd_addr, last_addr),
> +				sample_rate, channel_count);
> +}
> +#endif
> +
>  static btav_callbacks_t av_cbacks = {
>  	.size = sizeof(av_cbacks),
>  	.connection_state_cb = connection_state,
> -	.audio_state_cb = audio_state
> +	.audio_state_cb = audio_state,
> +#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
> +	.audio_config_cb = audio_config,
> +#endif
>  };
>  
>  /* init */

Both patches applied, thanks. 

-- 
Best regards, 
Szymon Janc
