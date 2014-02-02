Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1391177929-31416-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1391177929-31416-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Sun, 2 Feb 2014 07:46:41 -0800
Message-ID: <CABBYNZLCQ9mEykyXA8Q-G3J+QnpA7epjESQ8d9kNo2HRv-VaNA@mail.gmail.com>
Subject: Re: [PATCH 1/4] android/hal-audio: Check calloc return value
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Jan 31, 2014 at 6:18 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> calloc() might return NULL and is usually checked for NULL in BlueZ.
> ---
>  android/hal-audio.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/android/hal-audio.c b/android/hal-audio.c
> index b1323b0..35bafe7 100644
> --- a/android/hal-audio.c
> +++ b/android/hal-audio.c
> @@ -313,6 +313,8 @@ static int sbc_codec_init(struct audio_preset *preset, uint16_t mtu,
>         }
>
>         sbc_data = calloc(sizeof(struct sbc_data), 1);
> +       if (!sbc_data)
> +               return AUDIO_STATUS_FAILED;
>
>         memcpy(&sbc_data->sbc, preset->data, preset->len);
>
> --
> 1.8.3.2

Pushed, thanks.


-- 
Luiz Augusto von Dentz
