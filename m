Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Feb 2009 23:59:06 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: marcandre.lureau@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	=?iso-8859-1?Q?Marc-Andr=E9?= Lureau
	<marc-andre.lureau@nokia.com>
Subject: Re: [PATCH] sbc: don't dereference sbc pointer if NULL
Message-ID: <20090217215906.GB10933@jh-x301>
References: <1234903601-7124-1-git-send-email-marcandre.lureau@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1234903601-7124-1-git-send-email-marcandre.lureau@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Feb 17, 2009, marcandre.lureau@gmail.com wrote:
> diff --git a/sbc/sbc.c b/sbc/sbc.c
> index e2e7c61..a33ed57 100644
> --- a/sbc/sbc.c
> +++ b/sbc/sbc.c
> @@ -985,7 +985,7 @@ int sbc_decode(sbc_t *sbc, void *input, int input_len, void *output,
>  	char *ptr;
>  	int i, ch, framelen, samples;
>  
> -	if (!sbc && !input)
> +	if (!sbc || !input)
>  		return -EIO;
>  
>  	priv = sbc->priv;
> @@ -1053,7 +1053,7 @@ int sbc_encode(sbc_t *sbc, void *input, int input_len, void *output,
>  			const uint8_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
>  			int nsamples, int nchannels);
>  
> -	if (!sbc && !input)
> +	if (!sbc || !input)
>  		return -EIO;
>  
>  	priv = sbc->priv;

This one's now also pushed upstream.

Johan
