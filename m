Return-Path: <cyrus@holtmann.org>
Date: Tue, 13 Sep 2011 20:43:52 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Pieter-Augustijn Van Malleghem <p-a@scarlet.be>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add MacBookAir4,1 support
Message-ID: <20110913234352.GH16856@joana>
References: <20110907062810.GA4755@Caligula>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110907062810.GA4755@Caligula>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pieter-Augustijn,

* Pieter-Augustijn Van Malleghem <p-a@scarlet.be> [2011-09-07 02:28:10 -0400]:

> This patch against current git adds the hardware ID for the Apple 
> MacBookAir4,1, released in July 2011. The device features a BCM2046 
> USB chip. The patch was inspired by the previous modifications adding 
> support for the MacBookAir3,x. 
> 
> Signed-off-by: Pieter-Augustijn Van Malleghem <p-a@scarlet.be>
> --- linux/drivers/bluetooth/btusb.c	2011-09-06 23:41:57.000000000 -0400
> +++ patched/drivers/bluetooth/btusb.c	2011-09-06 23:50:27.000000000 -0400
> @@ -72,6 +72,9 @@
>  	/* Apple MacBookAir3,1, MacBookAir3,2 */
>  	{ USB_DEVICE(0x05ac, 0x821b) },
>  
> +	/* Apple MacBookAir4,1 */
> +	{ USB_DEVICE(0x05ac, 0x821f) },
> +
>  	/* Apple MacBookPro8,2 */
>  	{ USB_DEVICE(0x05ac, 0x821a) },

Patch has been applied, thanks.

	Gustavo
