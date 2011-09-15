Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Sep 2011 13:28:21 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Jurgen Kramer <gtmkramer@xs4all.nl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] btusb.c: add support for 2011 mac mini
Message-ID: <20110915162821.GA4690@joana>
References: <1316102688.1973.5.camel@paragon.slim>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1316102688.1973.5.camel@paragon.slim>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jurgen,

* Jurgen Kramer <gtmkramer@xs4all.nl> [2011-09-15 18:04:44 +0200]:

> Hopefully this patch is now correct.
> Patch against current kernel git to add ID for MacMini5,1 to btusb.c
> 
> Signed-off-by: Jurgen Kramer <gtmkramer@xs4all.nl>
> --- linux/drivers/bluetooth/btusb.c	2011-09-14 17:31:09.411475756 +0200
> +++ linux.new/drivers/bluetooth/btusb.c	2011-09-14 17:33:37.727484053
> +0200
> @@ -75,6 +75,9 @@ static struct usb_device_id btusb_table[
>  	/* Apple MacBookPro8,2 */
>  	{ USB_DEVICE(0x05ac, 0x821a) },
>  
> +	/* Apple MacMini5,1 */
> +	{ USB_DEVICE(0x05ac, 0x8281) },
> +
>  	/* AVM BlueFRITZ! USB v2.0 */
>  	{ USB_DEVICE(0x057c, 0x3800) },


Applied, thanks.

	Gustavo
