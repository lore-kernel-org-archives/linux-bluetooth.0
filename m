Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Thu, 24 Mar 2011 16:14:30 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Lee Trager <lt73@cs.drexel.edu>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] ath3k: Add ASUS BT Support
Message-ID: <20110324191430.GE2236@joana>
References: <4D8477B8.4010803@cs.drexel.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D8477B8.4010803@cs.drexel.edu>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lee,

* Lee Trager <lt73@cs.drexel.edu> [2011-03-19 05:30:32 -0400]:

> The ASUS USB Bluetooth module that comes with my motherboard(ASUS P8P67
> Pro) is simply a re-branded Atheros AR3011. This patch add support for
> it in the driver
> 
> Signed-off-by: Lee Trager <lt73@cs.drexel.edu>
> 
> --- drivers/bluetooth/ath3k.c.old	2011-03-18 04:27:26.160161039 -0400
> +++ drivers/bluetooth/ath3k.c	2011-03-18 04:29:05.853945455 -0400
> @@ -36,9 +36,12 @@
>  	/* Atheros AR3011 */
>  	{ USB_DEVICE(0x0CF3, 0x3000) },
> 
> -	/* Atheros AR3011 with sflash firmware*/
> +	/* Atheros AR3011 with sflash firmware */
>  	{ USB_DEVICE(0x0CF3, 0x3002) },
> 
> +	/* ASUS branded Atheros AR3011 */
> +	{ USB_DEVICE(0x0B05, 0x179C) },
> +

This patch doesn't apply to bluetooth-2.6 (or the not yet released
2.6.39-rc1). Please rebase, thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
