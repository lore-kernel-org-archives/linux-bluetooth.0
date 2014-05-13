Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [RFC 1/2] shared/aes-cmac: Add support for AES-CMAC-128
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1399977868-31937-2-git-send-email-lukasz.rymanowski@tieto.com>
Date: Tue, 13 May 2014 06:24:00 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0C9B7B6F-E3B6-453A-86B2-3ECE979A7796@holtmann.org>
References: <1399977868-31937-1-git-send-email-lukasz.rymanowski@tieto.com> <1399977868-31937-2-git-send-email-lukasz.rymanowski@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

> This patch adds handling AES-CMAC-128 signing as specified in the NIST
> Special Publication 800-38B
> ---
> src/shared/aes-cmac.c | 346 ++++++++++++++++++++++++++++++++++++++++++++++++++
> src/shared/aes-cmac.h |  38 ++++++
> 2 files changed, 384 insertions(+)
> create mode 100644 src/shared/aes-cmac.c
> create mode 100644 src/shared/aes-cmac.h

I really like to see it included in src/shared/crypto.c. Lets try that one first. It is meant to provide the whole crypto toolbox for us.

> 
> diff --git a/src/shared/aes-cmac.c b/src/shared/aes-cmac.c
> new file mode 100644
> index 0000000..660ceff
> --- /dev/null
> +++ b/src/shared/aes-cmac.c
> @@ -0,0 +1,346 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2014  Intel Corporation. All rights reserved.
> + *
> + *
> + *  This library is free software; you can redistribute it and/or
> + *  modify it under typedef struct {
> +	uint64_t a, b;
> +} u128;the terms of the GNU Lesser General Public

Something is broken here.

Regards

Marcel

