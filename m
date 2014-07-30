Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 Jul 2014 08:38:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, alex.aring@gmail.com
Subject: Re: [PATCH 1/5] 6lowpan: iphc: Fix block comments to match
 networking style
Message-ID: <20140730053817.GA14296@t440s.P-661HNU-F1>
References: <1406684924-40906-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406684924-40906-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jul 30, 2014, Marcel Holtmann wrote:
> This patch fixes all the block comment issues found by checkpatch.pl and
> makes them match the network style now.
> 
> WARNING: networking block comments don't use an empty /* line, use /* Comment...
> +/*
> + * Based on patches from Jon Smirl <jonsmirl@gmail.com>
> 
> WARNING: networking block comments don't use an empty /* line, use /* Comment...
> +/*
> + * Uncompress address function for source and
> 
> WARNING: networking block comments don't use an empty /* line, use /* Comment...
> +/*
> + * Uncompress address function for source context
> 
> WARNING: networking block comments don't use an empty /* line, use /* Comment...
> +		/*
> +		 * UDP lenght needs to be infered from the lower layers
> 
> WARNING: networking block comments don't use an empty /* line, use /* Comment...
> +	/*
> +	 * Traffic Class and FLow Label carried in-line
> 
> WARNING: networking block comments don't use an empty /* line, use /* Comment...
> +	/*
> +	 * Traffic class carried in-line
> 
> WARNING: networking block comments don't use an empty /* line, use /* Comment...
> +	/*
> +	 * Flow Label carried in-line
> 
> WARNING: networking block comments don't use an empty /* line, use /* Comment...
> +		/*
> +		 * replace the compressed UDP head by the uncompressed UDP
> 
> WARNING: networking block comments don't use an empty /* line, use /* Comment...
> +	/*
> +	 * As we copy some bit-length fields, in the IPHC encoding bytes,
> 
> WARNING: networking block comments don't use an empty /* line, use /* Comment...
> +	/*
> +	 * Traffic class, flow label
> 
> WARNING: networking block comments don't use an empty /* line, use /* Comment...
> +	/*
> +	 * Hop limit
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/6lowpan/iphc.c | 33 +++++++++++----------------------
>  1 file changed, 11 insertions(+), 22 deletions(-)

All 5 patches in this set have been applied to bluetooth-next. Thanks.

Johan
