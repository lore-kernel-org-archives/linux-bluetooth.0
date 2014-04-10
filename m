Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1397053018-4610-3-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1397053018-4610-1-git-send-email-andrzej.kaczmarek@tieto.com>
	<1397053018-4610-3-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Thu, 10 Apr 2014 11:11:47 +0300
Message-ID: <CABBYNZLqBiCiR6YQ4NZBHFip8wmzSpVCOdiDkLUe0UM1qSWqxA@mail.gmail.com>
Subject: Re: [PATCH 2/7] android/hal-audio: Remove preset with 48000 frequency
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Wed, Apr 9, 2014 at 5:16 PM, Andrzej Kaczmarek
<andrzej.kaczmarek@tieto.com> wrote:
> Having two presets with all parameters identical except of frequency is
> redundant since SNK has mandatory support for both 44100 and 48000 so
> in case we're INT we'll always set 44100 as this is first one we try.
> ---
>  android/hal-audio.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/android/hal-audio.c b/android/hal-audio.c
> index 23eb6b8..2f28b13 100644
> --- a/android/hal-audio.c
> +++ b/android/hal-audio.c
> @@ -265,15 +265,6 @@ static const a2dp_sbc_t sbc_presets[] = {
>                 .min_bitpool = MIN_BITPOOL,
>                 .max_bitpool = MAX_BITPOOL
>         },
> -       {
> -               .frequency = SBC_SAMPLING_FREQ_48000,
> -               .channel_mode = SBC_CHANNEL_MODE_JOINT_STEREO,
> -               .subbands = SBC_SUBBANDS_8,
> -               .allocation_method = SBC_ALLOCATION_LOUDNESS,
> -               .block_length = SBC_BLOCK_LENGTH_16,
> -               .min_bitpool = MIN_BITPOOL,
> -               .max_bitpool = MAX_BITPOOL
> -       },
>  };
>
>  static int sbc_get_presets(struct audio_preset *preset, size_t *len)
> --
> 1.9.1

Well the idea was that we could extend  AUDIO_OP_OPEN_STREAM to
include the preset index but I guess it does not make sense for
Android since it does not support 48Khz, well anything different than
44.1Khz since it cannot mix otherwise, so perhaps it is safe to remove
it. On the other hand we do have support for 48Khz which the remote
can configure but we don't do any resampling so I wonder how this work
out.


-- 
Luiz Augusto von Dentz
