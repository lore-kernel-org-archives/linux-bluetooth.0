Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1417518200-18428-2-git-send-email-lukasz.rymanowski@tieto.com>
References: <1417518200-18428-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1417518200-18428-2-git-send-email-lukasz.rymanowski@tieto.com>
Date: Wed, 3 Dec 2014 11:30:49 +0100
Message-ID: <CAMudyAtJAfwHxXxFS4GpuYScap4+4JUbEGFeKPOaP6g-Ot8J_A@mail.gmail.com>
Subject: Re: [PATCH 1/3] android/handsfree-client: Fix for correct audio state
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 2 December 2014 at 12:03, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> Disconnect audio state shall be set just after bt_sco_disconnect has
> been called.
> ---
>  android/handsfree-client.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/android/handsfree-client.c b/android/handsfree-client.c
> index 9818a47..b84ad79 100644
> --- a/android/handsfree-client.c
> +++ b/android/handsfree-client.c
> @@ -387,6 +387,8 @@ static void handle_disconnect_audio(const void *buf, uint16_t len)
>         }
>
>         bt_sco_disconnect(sco);
> +       set_audio_state(dev, HAL_HF_CLIENT_AUDIO_STATE_DISCONNECTED);
> +

Ignore that patch. Correct fix shall be in sco.c Will send in separate patch.

\Lukasz

>         status = HAL_STATUS_SUCCESS;
>
>  done:
> --
> 1.8.4
>
