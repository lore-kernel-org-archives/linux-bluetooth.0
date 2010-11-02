Return-Path: <cyrus@holtmann.org>
Date: Tue, 2 Nov 2010 08:24:55 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gimli <gimli@dark-green.com>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 3/6] MacBookAir3,1(3,2) btusb support
Message-ID: <20101102152454.GC11778@core.coreip.homeip.net>
References: <9e7738c0461aa509dd55fe470df3855e@mognix.dark-green.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e7738c0461aa509dd55fe470df3855e@mognix.dark-green.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Not sure of you guys monitor LKML...

On Tue, Nov 02, 2010 at 08:19:43AM +0100, gimli wrote:
> This patch add support for the MacBookAir3,1 and MacBookAir3,2 to the btusb
> driver.
> 
> Signed-off-by: Edgar (gimli) Hucek <gimli@dark-green.com>

> --- a/drivers/bluetooth/btusb.c	2010-10-30 21:08:45.170492002 +0200
> +++ b/drivers/bluetooth/btusb.c	2010-10-30 21:18:11.820492000 +0200
> @@ -62,6 +62,9 @@
>  	/* Apple iMac11,1 */
>  	{ USB_DEVICE(0x05ac, 0x8215) },
>  
> +	/* Apple MacBookAir3,1, MacBookAir3,2 */
> +	{ USB_DEVICE(0x05ac, 0x821b) },
> +
>  	/* AVM BlueFRITZ! USB v2.0 */
>  	{ USB_DEVICE(0x057c, 0x3800) },
>  


-- 
Dmitry
