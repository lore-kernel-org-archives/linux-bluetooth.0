Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v7 12/16] sbc: Declare and implement sbc_init_msbc
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1364465943-959-13-git-send-email-frederic.dalleau@linux.intel.com>
Date: Thu, 28 Mar 2013 08:39:01 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <16363D98-CE8A-46EC-B204-B629CB28EEAD@holtmann.org>
References: <1364465943-959-1-git-send-email-frederic.dalleau@linux.intel.com> <1364465943-959-13-git-send-email-frederic.dalleau@linux.intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> ---
> sbc/sbc.c   |   31 +++++++++++++++++++++++++++++++
> sbc/sbc.h   |    1 +
> sbc/sbc.sym |    1 +
> 3 files changed, 33 insertions(+)
> 
> diff --git a/sbc/sbc.c b/sbc/sbc.c
> index 137757b..3c7f7b3 100644
> --- a/sbc/sbc.c
> +++ b/sbc/sbc.c
> @@ -6,6 +6,7 @@
>  *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
>  *  Copyright (C) 2004-2005  Henryk Ploetz <henryk@ploetzli.ch>
>  *  Copyright (C) 2005-2008  Brad Midgley <bmidgley@xmission.com>
> + *  Copyright (C) 2012-2013  Intel Corporation
>  *
>  *
>  *  This library is free software; you can redistribute it and/or
> @@ -966,6 +967,36 @@ SBC_EXPORT int sbc_init(sbc_t *sbc, unsigned long flags)
> 	return 0;
> }
> 
> +SBC_EXPORT int sbc_init_msbc(sbc_t *sbc, unsigned long flags)
> +{
> +	if (!sbc)
> +		return -EIO;
> +
> +	memset(sbc, 0, sizeof(sbc_t));
> +
> +	sbc->priv_alloc_base = malloc(sizeof(struct sbc_priv) + SBC_ALIGN_MASK);
> +	if (!sbc->priv_alloc_base)
> +		return -ENOMEM;
> +
> +	sbc->priv = (void *) (((uintptr_t) sbc->priv_alloc_base +
> +			SBC_ALIGN_MASK) & ~((uintptr_t) SBC_ALIGN_MASK));
> +
> +	memset(sbc->priv, 0, sizeof(struct sbc_priv));
> +
> +	((struct sbc_priv *)sbc->priv)->msbc = true;

this is the only thing that makes me cringe a little bit. I can overlook it if there is no other way to handle it.

> +
> +	sbc_set_defaults(sbc, flags);
> +
> +	sbc->frequency = SBC_FREQ_16000;
> +	sbc->blocks = MSBC_BLOCKS;
> +	sbc->subbands = SBC_SB_8;
> +	sbc->mode = SBC_MODE_MONO;
> +	sbc->allocation = SBC_AM_LOUDNESS;
> +	sbc->bitpool = 26;
> +
> +	return 0;
> +}

Regards

Marcel

