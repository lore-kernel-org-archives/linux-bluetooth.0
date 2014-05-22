Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1400764022-26666-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1400764022-26666-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Date: Thu, 22 May 2014 15:54:34 +0200
Message-ID: <CAF3PWx07QbSs69pCHtCxX-BqvTHGHHSiu4YqFT=MyN_Jg0+LTg@mail.gmail.com>
Subject: Re: [RFC] android/hal-audio: Fix wrong memory access
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On 22 May 2014 15:07, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> downmix_buf is allocated to have buffer size FIXED_BUFFER_SIZE / 2, when
> we access it as (int16_t *) we shall device index by 2.
> ---
>  android/hal-audio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/android/hal-audio.c b/android/hal-audio.c
> index 7305bb6..96fa5c3 100644
> --- a/android/hal-audio.c
> +++ b/android/hal-audio.c
> @@ -984,7 +984,7 @@ static void downmix_to_mono(struct a2dp_stream_out *out, const uint8_t *buffer,
>         int16_t *output = (void *) out->downmix_buf;
>         size_t i;
>
> -       for (i = 0; i < bytes / 2; i++) {
> +       for (i = 0; i < bytes / (2 * sizeof(int16_t)); i++) {
>                 int16_t l = le16_to_cpu(get_unaligned(&input[i * 2]));
>                 int16_t r = le16_to_cpu(get_unaligned(&input[i * 2 + 1]));

Fix is correct, but commit message does not explain properly why this
is required. Basically we need to downmix X frames from input buffer
and this number is "bytes / (number_of_channels * sample_size)" - so
we were missing "sample_size" here. I think adding inline comment to
explain this would be also good.

BR,
Andrzej
