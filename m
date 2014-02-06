Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/client-av: Close audio output stream on a2dp disconnection
Date: Thu, 06 Feb 2014 15:12:49 +0100
Message-ID: <1919933.3vRk5J1SY2@uw000953>
In-Reply-To: <1391677561-5522-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1391677561-5522-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Thursday 06 of February 2014 10:06:01 Jakub Tyszkowski wrote:
> This patch makes haltest's audio part aware of a2dp disconnection and
> closes audio output stream. This fixes the issue with CPU cycles being
> eaten up by playback thread still trying to send audio data after
> disconnection.
> ---
>  android/client/if-av.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/android/client/if-av.c b/android/client/if-av.c
> index 8d1f69b..ef1d997 100644
> --- a/android/client/if-av.c
> +++ b/android/client/if-av.c
> @@ -41,6 +41,13 @@ static void connection_state(btav_connection_state_t state,
>  	haltest_info("%s: connection_state=%s remote_bd_addr=%s\n", __func__,
>  					btav_connection_state_t2str(state),
>  					bt_bdaddr_t2str(bd_addr, last_addr));
> +
> +	if (state == BTAV_CONNECTION_STATE_DISCONNECTED) {
> +		const struct method *m = get_interface_method("audio",
> +							"close_output_stream");
> +		if (m)
> +			m->func(0, NULL);
> +	}
>  }

I think haltest should not be that smart and interaction of audio and av should
be handled by user (it is 'emulating' mediaserver, right?). I pushed fix for CPU
eating myself.

>  
>  static void audio_state(btav_audio_state_t state, bt_bdaddr_t *bd_addr)
> 

-- 
Best regards, 
Szymon Janc
