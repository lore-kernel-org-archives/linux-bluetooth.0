Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [RFC] android/hal-audio: Fix wrong memory access
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1400764022-26666-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Thu, 22 May 2014 07:21:48 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0ADD0151-224B-418E-94D6-B88CBD760BA8@holtmann.org>
References: <1400764022-26666-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> downmix_buf is allocated to have buffer size FIXED_BUFFER_SIZE / 2, when
> we access it as (int16_t *) we shall device index by 2.
> ---
> android/hal-audio.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/hal-audio.c b/android/hal-audio.c
> index 7305bb6..96fa5c3 100644
> --- a/android/hal-audio.c
> +++ b/android/hal-audio.c
> @@ -984,7 +984,7 @@ static void downmix_to_mono(struct a2dp_stream_out *out, const uint8_t *buffer,
> 	int16_t *output = (void *) out->downmix_buf;
> 	size_t i;
> 
> -	for (i = 0; i < bytes / 2; i++) {
> +	for (i = 0; i < bytes / (2 * sizeof(int16_t)); i++) {
> 		int16_t l = le16_to_cpu(get_unaligned(&input[i * 2]));
> 		int16_t r = le16_to_cpu(get_unaligned(&input[i * 2 + 1]));

I wonder actually what this get_unaligned is doing here? You cast the const void into const int16_t buffer. Is this really needed? Where is our input and output buffer coming from? Aren’t these aligned anyway? Meaning aren’t they allocated?

I also wonder why we are not doing the unaligned access directly on the void buffer and do proper offset calculation into the stream. Instead of casting it to an int16 array.

Regards

Marcel

