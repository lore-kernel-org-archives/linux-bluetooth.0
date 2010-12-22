Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v3] sbc: detect when bitpool has changed
From: Brian Gix <bgix@codeaurora.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1293010548-25151-1-git-send-email-luiz.dentz@gmail.com>
References: <1293010548-25151-1-git-send-email-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Wed, 22 Dec 2010 09:55:26 -0800
Message-ID: <1293040526.7281.0.camel@sealablnx02.qualcomm.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, 2010-12-22 at 11:35 +0200, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> A2DP spec allow bitpool changes midstream which is why sbc configuration
> has a range of values for bitpool that the encoder can use and decoder
> must support.
> 
> Bitpool changes do not affect the state of encoder/decoder so they don't
> need to be reinitialize when this happens, so the impact is fairly small,
> what it does change is the frame length so encoders may change the
> bitpool to use the link more efficiently.
> ---
>  sbc/sbc.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/sbc/sbc.c b/sbc/sbc.c
> index a6391ae..77fcc5d 100644
> --- a/sbc/sbc.c
> +++ b/sbc/sbc.c
> @@ -978,6 +978,9 @@ ssize_t sbc_decode(sbc_t *sbc, const void *input, size_t input_len,
>  
>  		priv->frame.codesize = sbc_get_codesize(sbc);
>  		priv->frame.length = framelen;
> +	} else if (priv->frame.bitpool != sbc->bitpool) {
> +		priv->frame.length = framelen;
> +		sbc->bitpool = priv->frame.bitpool;
>  	}
>  
>  	if (!output)
> @@ -1050,6 +1053,9 @@ ssize_t sbc_encode(sbc_t *sbc, const void *input, size_t input_len,
>  
>  		sbc_encoder_init(&priv->enc_state, &priv->frame);
>  		priv->init = 1;
> +	} else if (priv->frame.bitpool != sbc->bitpool) {
> +		priv->frame.length = sbc_get_frame_length(sbc);
> +		priv->frame.bitpool = sbc->bitpool;
>  	}
>  
>  	/* input must be large enough to encode a complete frame */
> @@ -1120,7 +1126,7 @@ size_t sbc_get_frame_length(sbc_t *sbc)
>  	struct sbc_priv *priv;
>  
>  	priv = sbc->priv;
> -	if (priv->init)
> +	if (priv->init && priv->frame.bitpool == sbc->bitpool)
>  		return priv->frame.length;
>  
>  	subbands = sbc->subbands ? 8 : 4;

I think this patch is correct.

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

