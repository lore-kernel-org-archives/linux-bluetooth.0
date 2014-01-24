Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/a2dp: Fix audio resume on started stream
Date: Fri, 24 Jan 2014 23:00:51 +0100
Message-ID: <2586637.blSzzQcaJy@athlon>
In-Reply-To: <1390496392-22826-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1390496392-22826-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Thursday 23 January 2014 17:59:52 Andrzej Kaczmarek wrote:
> In case stream is started from remote we'll receive Resume Stream IPC
> when audio is already considered as started (i.e. on first write from
> AudioFlinger). In such case we should not try to send AVDTP_START since
> this will fail but just reply success over IPC instead.
> ---
>  android/a2dp.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/android/a2dp.c b/android/a2dp.c
> index 572e0d1..10e43b1 100644
> --- a/android/a2dp.c
> +++ b/android/a2dp.c
> @@ -1376,10 +1376,12 @@ static void bt_stream_resume(const void *buf,
> uint16_t len) goto failed;
>  	}
> 
> -	err = avdtp_start(setup->dev->session, setup->stream);
> -	if (err < 0) {
> -		error("avdtp_start: %s", strerror(-err));
> -		goto failed;
> +	if (setup->state != HAL_AUDIO_STARTED) {
> +		err = avdtp_start(setup->dev->session, setup->stream);
> +		if (err < 0) {
> +			error("avdtp_start: %s", strerror(-err));
> +			goto failed;
> +		}
>  	}
> 
>  	audio_ipc_send_rsp(AUDIO_OP_RESUME_STREAM, AUDIO_STATUS_SUCCESS);

Applied, thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
