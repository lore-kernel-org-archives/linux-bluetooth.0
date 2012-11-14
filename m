Return-Path: <cyrus@holtmann.org>
Date: Wed, 14 Nov 2012 21:09:43 +0200
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: =?UTF-8?B?RnLDqWTDqXJpYw==?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 10/16] sbc: simd support for 8 multiples block size
Message-ID: <20121114210943.1cb40bea@i7>
In-Reply-To: <1351589975-22640-11-git-send-email-frederic.dalleau@linux.intel.com>
References: <1351589975-22640-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1351589975-22640-11-git-send-email-frederic.dalleau@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 30 Oct 2012 10:39:29 +0100
Frédéric Dalleau  <frederic.dalleau@linux.intel.com> wrote:

This looks good. The only potential problem is here:

    http://git.kernel.org/?p=bluetooth/sbc.git;a=blob;f=sbc/sbc_primitives.h;h=17ad4f74da4c#l31

 31 #define SBC_X_BUFFER_SIZE 328

    http://git.kernel.org/?p=bluetooth/sbc.git;a=blob;f=sbc/sbc.c;h=f0c77c7cb546#l908

908         state->position = (SBC_X_BUFFER_SIZE - frame->subbands * 9) & ~7;


    http://git.kernel.org/?p=bluetooth/sbc.git;a=blob;f=sbc/sbc_primitives.c;h=ad780d0800de#l285

285         /* handle X buffer wraparound */
286         if (position < nsamples) {
287                 if (nchannels > 0)
288                         memcpy(&X[0][SBC_X_BUFFER_SIZE - 72], &X[0][position],
289                                                         72 * sizeof(int16_t));
290                 if (nchannels > 1)
291                         memcpy(&X[1][SBC_X_BUFFER_SIZE - 72], &X[1][position],
292                                                         72 * sizeof(int16_t));
293                 position = SBC_X_BUFFER_SIZE - 72;
294         }

As we are going to use divisibility by 16 of position variable as a
way to distinguish between "even" and "odd" blocks (chunks of 8
samples) in the buffer, we need to be sure that the following
conditions are true:

1. assert((SBC_X_BUFFER_SIZE - frame->subbands * 9) & ~7 ==
           SBC_X_BUFFER_SIZE - 72);

Buffer wraparound is handled by copying a portion of still
needed old data to the initial position.

2. assert((SBC_X_BUFFER_SIZE - 72) % 16 == 0);

The initial position is divisible by 16.

3. assert((SBC_X_BUFFER_SIZE - 72) % (15 * 8) % 16 == 0);

When we handle buffer wraparound, the position before memcpy has the
same divisibility by 16 as the new updated position after memcpy.

4. assert((SBC_X_BUFFER_SIZE - 72) % (15 * 8) >= 8);

Just to be sure that "x[-7] = PCM(0 + 7 * nchannels)" does not
do invalid memory writes below the X array. This would be not
necessary if we adjust the "if (position < nsamples)" check.

If anybody decides to change SBC_X_BUFFER_SIZE constant, there is a
risk of doing it wrong. But right now the code seems to fulfil these
requirements :)


And some cosmetic nitpicks.

First the text of the summary:
1. Why "simd"? It's not totally wrong, but still way too generic.
You could use "input permutation" or "input processing" or
"sbc_encoder_process_input_s8 function" instead.
2. That's a multiple of 1 block (or alternatively a multiple of 8
samples).

> ---
>  sbc/sbc_primitives.c |   37 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/sbc/sbc_primitives.c b/sbc/sbc_primitives.c
> index 9311848..b189320 100644
> --- a/sbc/sbc_primitives.c
> +++ b/sbc/sbc_primitives.c
> @@ -309,8 +309,26 @@ static SBC_ALWAYS_INLINE int sbc_encoder_process_input_s8_internal(
>  	#define PCM(i) (big_endian ? \
>  		unaligned16_be(pcm + (i) * 2) : unaligned16_le(pcm + (i) * 2))
>  
> +	if (position % 16 == 8) {
> +		position -= 8;
> +		nsamples -= 8;
> +		if (nchannels > 0) {

That's a somewhat redundant "if" here. Yes, it is also redundant in
the code where both "if (nchannels > 0)" and "if (nchannels > 1)" are
used, but it was there just for cosmetic reasons in order to keep the
same level of indentation.

> +			int16_t *x = &X[0][position];
> +			x[0]  = PCM(0 + (15-8) * nchannels);
> +			x[2]  = PCM(0 + (14-8) * nchannels);
> +			x[3]  = PCM(0 + (8-8) * nchannels);
> +			x[4]  = PCM(0 + (13-8) * nchannels);
> +			x[5]  = PCM(0 + (9-8) * nchannels);
> +			x[6]  = PCM(0 + (12-8) * nchannels);
> +			x[7]  = PCM(0 + (10-8) * nchannels);
> +			x[8]  = PCM(0 + (11-8) * nchannels);
> +		}
> +		/* mSBC is designed for 1 channel */

Thanks for adding this comment. But IMHO it still feels a bit
incomplete. It could be a extended to:

                /* mSBC codec is the only case when the number of
                 * samples to process may be not multiple of 16.
                 * mSBC only supports 1 channel */

Or alternatively just add back the omitted "if (nchannels > 1)" branch
too. Yes, it is not needed for mSBC now, but what if somebody introduces
something like a stereo variant of mSBC later? This way the code is
more orthogonal, "futureproof" and does not need lengthy excuses and
explanations in comments for the parts which are cutting the corners.

Either way is fine.

> +		pcm += 16 * nchannels;
> +	}
> +
>  	/* copy/permutate audio samples */
> -	while ((nsamples -= 16) >= 0) {
> +	while (nsamples >= 16) {
>  		position -= 16;
>  		if (nchannels > 0) {
>  			int16_t *x = &X[0][position];
> @@ -351,6 +369,23 @@ static SBC_ALWAYS_INLINE int sbc_encoder_process_input_s8_internal(
>  			x[15] = PCM(1 + 2 * nchannels);
>  		}
>  		pcm += 32 * nchannels;
> +		nsamples -= 16;
> +	}
> +
> +	if (nsamples == 8) {
> +		position -= 8;
> +		if (nchannels > 0) {
> +			int16_t *x = &X[0][position];
> +			x[-7] = PCM(0 + 7 * nchannels);
> +			x[1]  = PCM(0 + 3 * nchannels);
> +			x[2]  = PCM(0 + 6 * nchannels);
> +			x[3]  = PCM(0 + 0 * nchannels);
> +			x[4]  = PCM(0 + 5 * nchannels);
> +			x[5]  = PCM(0 + 1 * nchannels);
> +			x[6]  = PCM(0 + 4 * nchannels);
> +			x[7]  = PCM(0 + 2 * nchannels);
> +		}
> +		/* mSBC is designed for 1 channel */

Same here.

>  	}
>  	#undef PCM


Well, none of these are really serious issues which could
immediately affect end users. But I would definitely prefer more
verbose commit messages, showing that you know what you are
doing, that the corner cases are under control, the rationale for
your decisions, etc.

-- 
Best regards,
Siarhei Siamashka
