Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: [PATCH] btusb: add realtek 8723 in the blacklist
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <527090CF.9080606@canonical.com>
Date: Wed, 30 Oct 2013 08:21:36 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <8D4C32FC-1B76-4962-BF54-A8CCAFAE5578@holtmann.org>
References: <527090CF.9080606@canonical.com>
To: "Bruce.Ma" <bruce.ma@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bruce,

> From: Bruce Ma <bruce.ma@canonical.com>
> Date: Tue, 22 Oct 2013 11:21:20 +0800
> Subject: [PATCH] btusb: add realtek 8723 in the blacklist
> 
> The vendor realtek provides an off-tree driver for realtek 8723, so we
> add realtek 8723 in the in-tree driver's blacklist.

we do not care about out-of-tree drivers. Get the Realtek driver merged upstream.

> Signed-off-by: Bruce Ma <bruce.ma@canonical.com>
> ---
> drivers/bluetooth/btusb.c | 3 +++
> 1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index eae58a1..3097ac8 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -138,6 +138,9 @@ static struct usb_device_id blacklist_table[] = {
>     { USB_DEVICE(0x0489, 0xe03d), .driver_info = BTUSB_IGNORE },
>     { USB_DEVICE(0x0489, 0xe027), .driver_info = BTUSB_IGNORE },
> 
> +    /* Realtek 8723 Bluetooth */
> +    { USB_DEVICE(0x0bda, 0xb728), .driver_info = BTUSB_IGNORE },
> +
>     /* Atheros AR9285 Malbec with sflash firmware */
>     { USB_DEVICE(0x03f0, 0x311d), .driver_info = BTUSB_IGNORE },

And as an extra advice, using proper tabs vs spaces is important.

Regards

Marcel

