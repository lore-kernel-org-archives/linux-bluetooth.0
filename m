Return-Path: <cyrus@holtmann.org>
Message-ID: <1350578820.2026.4.camel@aeonflux>
Subject: Re: [PATCH 04/11] Add msbc encoding and decoding flag
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 18 Oct 2012 09:47:00 -0700
In-Reply-To: <1350576911-14678-5-git-send-email-frederic.dalleau@linux.intel.com>
References: <1350576911-14678-1-git-send-email-frederic.dalleau@linux.intel.com>
	 <1350576911-14678-5-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

>  sbc/sbc.c |   16 ++++++++++++++++
>  sbc/sbc.h |    3 +++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/sbc/sbc.c b/sbc/sbc.c
> index 6fff132..c40aa15 100644
> --- a/sbc/sbc.c
> +++ b/sbc/sbc.c
> @@ -52,6 +52,9 @@
>  
>  #define SBC_SYNCWORD	0x9C
>  
> +#define MSBC_SYNCWORD       0xAD
> +#define MSBC_BLOCKS         15
> +
>  /* This structure contains an unpacked SBC frame.
>     Yes, there is probably quite some unused space herein */
>  struct sbc_frame {
> @@ -920,6 +923,7 @@ struct sbc_priv {
>  
>  static void sbc_set_defaults(sbc_t *sbc, unsigned long flags)
>  {
> +	sbc->flags = flags;
>  	sbc->frequency = SBC_FREQ_44100;
>  	sbc->mode = SBC_MODE_STEREO;
>  	sbc->subbands = SBC_SB_8;
> @@ -982,6 +986,8 @@ SBC_EXPORT ssize_t sbc_decode(sbc_t *sbc, const void *input, size_t input_len,
>  		sbc->mode = priv->frame.mode;
>  		sbc->subbands = priv->frame.subband_mode;
>  		sbc->blocks = priv->frame.block_mode;
> +		if (sbc->flags & SBC_MSBC)
> +			sbc->blocks = MSBC_BLOCKS;

Why are we doing this for every single call of sbc_decode.

And even we wanted to do that, why do we first assign it to
priv->frame.block_mode so we overwrite it one line later.

>  		sbc->allocation = priv->frame.allocation;
>  		sbc->bitpool = priv->frame.bitpool;
>  
> @@ -1056,6 +1062,8 @@ SBC_EXPORT ssize_t sbc_encode(sbc_t *sbc, const void *input, size_t input_len,
>  		priv->frame.subbands = sbc->subbands ? 8 : 4;
>  		priv->frame.block_mode = sbc->blocks;
>  		priv->frame.blocks = 4 + (sbc->blocks * 4);
> +		if (sbc->flags & SBC_MSBC)
> +			priv->frame.blocks = MSBC_BLOCKS;

Same here.

>  		priv->frame.bitpool = sbc->bitpool;
>  		priv->frame.codesize = sbc_get_codesize(sbc);
>  		priv->frame.length = sbc_get_frame_length(sbc);
> @@ -1140,6 +1148,8 @@ SBC_EXPORT size_t sbc_get_frame_length(sbc_t *sbc)
>  
>  	subbands = sbc->subbands ? 8 : 4;
>  	blocks = 4 + (sbc->blocks * 4);
> +	if (sbc->flags & SBC_MSBC)
> +		blocks = MSBC_BLOCKS;

And here again.

>  	channels = sbc->mode == SBC_MODE_MONO ? 1 : 2;
>  	joint = sbc->mode == SBC_MODE_JOINT_STEREO ? 1 : 0;
>  	bitpool = sbc->bitpool;
> @@ -1169,6 +1179,9 @@ SBC_EXPORT unsigned sbc_get_frame_duration(sbc_t *sbc)
>  		blocks = priv->frame.blocks;
>  	}
>  
> +	if (sbc->flags & SBC_MSBC)
> +		blocks = MSBC_BLOCKS;
> +
>  	switch (sbc->frequency) {
>  	case SBC_FREQ_16000:
>  		frequency = 16000;
> @@ -1208,6 +1221,9 @@ SBC_EXPORT size_t sbc_get_codesize(sbc_t *sbc)
>  		channels = priv->frame.channels;
>  	}
>  
> +	if (sbc->flags & SBC_MSBC)
> +		blocks = MSBC_BLOCKS;
> +
>  	return subbands * blocks * channels * 2;
>  }
>  
> diff --git a/sbc/sbc.h b/sbc/sbc.h
> index bbd45da..3511119 100644
> --- a/sbc/sbc.h
> +++ b/sbc/sbc.h
> @@ -64,6 +64,9 @@ extern "C" {
>  #define SBC_LE			0x00
>  #define SBC_BE			0x01
>  
> +/* Additional features */
> +#define SBC_MSBC		0x01
> +
>  struct sbc_struct {
>  	unsigned long flags;
>  

I think you get the idea. Just corrected an already assigned value in
case of mSBC is a bad idea. It is either an if clause or we assign the
proper value once in the private structure.

Regards

Marcel


