Return-Path: <cyrus@holtmann.org>
Message-ID: <1324511946.1965.192.camel@aeonflux>
Subject: Re: [PATCH] Add USB ID of HP's Broadcom BCM2035 Bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: Albert Pool <albertpool@solcon.nl>
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Date: Wed, 21 Dec 2011 15:59:06 -0800
In-Reply-To: <4EF24036.3010400@solcon.nl>
References: <4EF24036.3010400@solcon.nl>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Albert,

> HP's Broadcom Bluetooth 1.2 interface (USB 03f0:011d) found in HP Compaq 
> nc6120 laptop, fails to detect other devices, and pair with them.
> With BTUSB_BCM92035 it now works.
> 
> I've also tried using BTUSB_WRONG_SCO_MTU, but with that setting it 
> failed to enable the device 50% of the time.
> 
> If I didn't properly submit the patch, please let me know.

don't include such a sentence in the commit message. It belongs after
--- and before the diffstat.

Include the output of usb-devices in the commit message.

> 
> Signed-off-by: Albert Pool <albertpool@solcon.nl>
> - - -

And please fix your email client. It is messing up whitespaces.

>   drivers/bluetooth/btusb.c |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -142,7 +142,8 @@ static struct usb_device_id blacklist_ta
>       { USB_DEVICE(0x0a5c, 0x201e), .driver_info = BTUSB_WRONG_SCO_MTU },
>       { USB_DEVICE(0x0a5c, 0x2110), .driver_info = BTUSB_WRONG_SCO_MTU },
> 
> -    /* HP laptop with Broadcom chip */
> +    /* HP laptops with Broadcom chip */
> +    { USB_DEVICE(0x03f0, 0x011d), .driver_info = BTUSB_BCM92035 },

You need a tab here and not space.

>       { USB_DEVICE(0x03f0, 0x171d), .driver_info = BTUSB_WRONG_SCO_MTU },
> 
>       /* Dell laptop with Broadcom chip */
> 

Regards

Marcel


