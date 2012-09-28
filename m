Return-Path: <cyrus@holtmann.org>
Message-ID: <1348843982.13371.34.camel@aeonflux>
Subject: Re: [PATCH 1/5] Add msbc encoding and decoding flag
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 28 Sep 2012 16:53:02 +0200
In-Reply-To: <1348757068-31048-2-git-send-email-frederic.dalleau@linux.intel.com>
References: <1348757068-31048-1-git-send-email-frederic.dalleau@linux.intel.com>
	 <1348757068-31048-2-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Also enable 15 blocks support using stdc sbc primitives
> ---
>  Makefile.am               |    1 +
>  sbc/sbc.c                 |  123 +++++++++--------
>  sbc/sbc.h                 |    3 +
>  sbc/sbc_primitives.c      |    8 +-
>  sbc/sbc_primitives.h      |    7 +-
>  sbc/sbc_primitives_stdc.c |  321 +++++++++++++++++++++++++++++++++++++++++++++
>  sbc/sbc_primitives_stdc.h |   36 +++++
>  7 files changed, 443 insertions(+), 56 deletions(-)
>  create mode 100644 sbc/sbc_primitives_stdc.c
>  create mode 100644 sbc/sbc_primitives_stdc.h

can you split this patch into at least two?

> diff --git a/Makefile.am b/Makefile.am
> index cad6a3b..75e3a4a 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -14,6 +14,7 @@ sbc_headers = sbc/sbc.h
>  
>  sbc_sources = sbc/sbc.c sbc/sbc_private.h sbc/sbc_math.h sbc/sbc_tables.h \
>  		sbc/sbc_primitives.h sbc/sbc_primitives.c \
> +		sbc/sbc_primitives_stdc.h sbc/sbc_primitives_stdc.c \
>  		sbc/sbc_primitives_mmx.h sbc/sbc_primitives_mmx.c \
>  		sbc/sbc_primitives_iwmmxt.h sbc/sbc_primitives_iwmmxt.c \
>  		sbc/sbc_primitives_neon.h sbc/sbc_primitives_neon.c \
> diff --git a/sbc/sbc.c b/sbc/sbc.c
> index f0c77c7..7e4faa0 100644
> --- a/sbc/sbc.c
> +++ b/sbc/sbc.c
> @@ -6,6 +6,7 @@
>   *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
>   *  Copyright (C) 2004-2005  Henryk Ploetz <henryk@ploetzli.ch>
>   *  Copyright (C) 2005-2008  Brad Midgley <bmidgley@xmission.com>
> + *  Copyright (C) 2012       Intel Corporation
>   *
>   *
>   *  This library is free software; you can redistribute it and/or
> @@ -51,6 +52,17 @@
>  #include "sbc_primitives.h"
>  
>  #define SBC_SYNCWORD	0x9C
> +#define MSBC_SYNCWORD	0xAD
> +#define SBC_BLOCKS(sbc, blocks) (((sbc)->flags & SBC_MSBC) \
> +				? MSBC_BLOCKS : (blocks))

Not sure about this macro. Why do we need this? Wouldn't it be better to
make it explicit in the code.

> +#define MSBC_BLOCKMODE		SBC_BLK_16
> +#define MSBC_BLOCKS		15
> +#define MSBC_BITPOOL		26
> +#define MSBC_SUBBAND_MODE	1
> +#define MSBC_SUBBANDS		8
> +#define MSBC_CHANNEL		1
> +#define MSBC_ALLOCATION		SBC_AM_LOUDNESS

And as a nitpick, keep an empty line between SBC_ and MSBC_ constants.
 
>  /* This structure contains an unpacked SBC frame.
>     Yes, there is probably quite some unused space herein */
> @@ -373,9 +385,11 @@ static void sbc_calculate_bits(const struct sbc_frame *frame, int (*bits)[8])
>   *  -2   Sync byte incorrect
>   *  -3   CRC8 incorrect
>   *  -4   Bitpool value out of bounds
> + *  -5   msbc reserved byte 1 not 0
> + *  -6   msbc reserved byte 2 not 0
>   */

What are you doing with these return values. If nothing, then just
return sync byte incorrect.

> -static int sbc_unpack_frame(const uint8_t *data, struct sbc_frame *frame,
> -								size_t len)
> +static int sbc_unpack_frame(sbc_t *sbc, const uint8_t *data,
> +		struct sbc_frame *frame, size_t len)
>  {

As in the comment from the other patch, instead of changing the function
prototype, just provide two separate function, that we choose from on
sbc_init.

>  	unsigned int consumed;
>  	/* Will copy the parts of the header that are relevant to crc
> @@ -413,6 +427,8 @@ static int sbc_unpack_frame(const uint8_t *data, struct sbc_frame *frame,
>  		frame->blocks = 16;
>  		break;
>  	}
> +	if (sbc->flags & SBC_MSBC)
> +		frame->blocks = MSBC_BLOCKS;
>  
>  	frame->mode = (data[1] >> 2) & 0x03;
>  	switch (frame->mode) {
> @@ -690,13 +706,13 @@ static int sbc_analyze_audio(struct sbc_encoder_state *state,
>  		for (ch = 0; ch < frame->channels; ch++) {
>  			x = &state->X[ch][state->position - 16 +
>  							frame->blocks * 4];
> -			for (blk = 0; blk < frame->blocks; blk += 4) {
> +			for (blk = 0; blk < frame->blocks; blk += state->inc) {
>  				state->sbc_analyze_4b_4s(
>  					x,
>  					frame->sb_sample_f[blk][ch],
>  					frame->sb_sample_f[blk + 1][ch] -
>  					frame->sb_sample_f[blk][ch]);
> -				x -= 16;
> +				x -= 4 * state->inc;
>  			}
>  		}
>  		return frame->blocks * 4;
> @@ -705,13 +721,13 @@ static int sbc_analyze_audio(struct sbc_encoder_state *state,
>  		for (ch = 0; ch < frame->channels; ch++) {
>  			x = &state->X[ch][state->position - 32 +
>  							frame->blocks * 8];
> -			for (blk = 0; blk < frame->blocks; blk += 4) {
> +			for (blk = 0; blk < frame->blocks; blk += state->inc) {
>  				state->sbc_analyze_4b_8s(
>  					x,
>  					frame->sb_sample_f[blk][ch],
>  					frame->sb_sample_f[blk + 1][ch] -
>  					frame->sb_sample_f[blk][ch]);
> -				x -= 32;
> +				x -= 8 * state->inc;
>  			}
>  		}
>  		return frame->blocks * 8;
> @@ -764,10 +780,9 @@ static int sbc_analyze_audio(struct sbc_encoder_state *state,
>   * -99 not implemented
>   */
>  
> -static SBC_ALWAYS_INLINE ssize_t sbc_pack_frame_internal(uint8_t *data,
> -					struct sbc_frame *frame, size_t len,
> -					int frame_subbands, int frame_channels,
> -					int joint)
> +static SBC_ALWAYS_INLINE ssize_t sbc_pack_frame_internal(sbc_t *sbc,
> +			uint8_t *data, struct sbc_frame *frame, size_t len,
> +			int frame_subbands, int frame_channels, int joint)
>  {
>  	/* Bitstream writer starts from the fourth byte */
>  	uint8_t *data_ptr = data + 4;
> @@ -785,37 +800,37 @@ static SBC_ALWAYS_INLINE ssize_t sbc_pack_frame_internal(uint8_t *data,
>  	uint32_t levels[2][8];	/* levels are derived from that */
>  	uint32_t sb_sample_delta[2][8];
>  
> -	data[0] = SBC_SYNCWORD;
> +		data[0] = SBC_SYNCWORD;
>  
> -	data[1] = (frame->frequency & 0x03) << 6;
> +		data[1] = (frame->frequency & 0x03) << 6;
>  
> -	data[1] |= (frame->block_mode & 0x03) << 4;
> +		data[1] |= (frame->block_mode & 0x03) << 4;
>  
> -	data[1] |= (frame->mode & 0x03) << 2;
> +		data[1] |= (frame->mode & 0x03) << 2;
>  
> -	data[1] |= (frame->allocation & 0x01) << 1;
> +		data[1] |= (frame->allocation & 0x01) << 1;
>  
> -	switch (frame_subbands) {
> -	case 4:
> -		/* Nothing to do */
> -		break;
> -	case 8:
> -		data[1] |= 0x01;
> -		break;
> -	default:
> -		return -4;
> -		break;
> -	}
> +		switch (frame_subbands) {
> +		case 4:
> +			/* Nothing to do */
> +			break;
> +		case 8:
> +			data[1] |= 0x01;
> +			break;
> +		default:
> +			return -4;
> +			break;
> +		}
>  
> -	data[2] = frame->bitpool;
> +		data[2] = frame->bitpool;
>  
> -	if ((frame->mode == MONO || frame->mode == DUAL_CHANNEL) &&
> -			frame->bitpool > frame_subbands << 4)
> -		return -5;
> +		if ((frame->mode == MONO || frame->mode == DUAL_CHANNEL) &&
> +				frame->bitpool > frame_subbands << 4)
> +			return -5;
>  
> -	if ((frame->mode == STEREO || frame->mode == JOINT_STEREO) &&
> -			frame->bitpool > frame_subbands << 5)
> -		return -5;
> +		if ((frame->mode == STEREO || frame->mode == JOINT_STEREO) &&
> +				frame->bitpool > frame_subbands << 5)
> +			return -5;
>  
>  	/* Can't fill in crc yet */
>  
> @@ -881,33 +896,33 @@ static SBC_ALWAYS_INLINE ssize_t sbc_pack_frame_internal(uint8_t *data,
>  	return data_ptr - data;
>  }
>  
> -static ssize_t sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len,
> -								int joint)
> +static ssize_t sbc_pack_frame(sbc_t *sbc, uint8_t *data,
> +		struct sbc_frame *frame, size_t len, int joint)
>  {
>  	if (frame->subbands == 4) {
>  		if (frame->channels == 1)
>  			return sbc_pack_frame_internal(
> -				data, frame, len, 4, 1, joint);
> +				sbc, data, frame, len, 4, 1, joint);
>  		else
>  			return sbc_pack_frame_internal(
> -				data, frame, len, 4, 2, joint);
> +				sbc, data, frame, len, 4, 2, joint);
>  	} else {
>  		if (frame->channels == 1)
>  			return sbc_pack_frame_internal(
> -				data, frame, len, 8, 1, joint);
> +				sbc, data, frame, len, 8, 1, joint);
>  		else
>  			return sbc_pack_frame_internal(
> -				data, frame, len, 8, 2, joint);
> +				sbc, data, frame, len, 8, 2, joint);
>  	}
>  }
>  
> -static void sbc_encoder_init(struct sbc_encoder_state *state,
> +static void sbc_encoder_init(int msbc, struct sbc_encoder_state *state,
>  					const struct sbc_frame *frame)
>  {
>  	memset(&state->X, 0, sizeof(state->X));
>  	state->position = (SBC_X_BUFFER_SIZE - frame->subbands * 9) & ~7;
>  
> -	sbc_init_primitives(state);
> +	sbc_init_primitives(msbc, state);
>  }

I personally prefer having mSBC capable primitives. If this would
actually lead to some sort of issue, then we might need a different
option that allows us to fallback to non-optimized primitives. And then
we might not just bind this for mSBC, then we might just make that an
option for the library users.

Regards

Marcel


