Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 Nov 2013 09:47:20 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Bruce.Ma" <bruce.ma@canonical.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] btusb: add realtek 8723 in the blacklist
Message-ID: <20131104074720.GA29635@x220.p-661hnu-f1>
References: <52774AB7.1010609@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52774AB7.1010609@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bruce,

On Mon, Nov 04, 2013, Bruce.Ma wrote:
> From: Bruce Ma <bruce.ma@canonical.com>
> Date: Tue, 04 Nov 2013 11:21:20 +0800
> Subject: [PATCH] btusb: add Realtek 8723 in the blacklist
> 
> The btusb doesn't work with Realtek 8723 bluetooth device,
> so we want to add it to the blacklist.
> 
> Signed-off-by: Bruce Ma <bruce.ma@canonical.com>
> ---
>  drivers/bluetooth/btusb.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index eae58a1..3097ac8 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -138,6 +138,9 @@ static struct usb_device_id blacklist_table[] = {
> 	{ USB_DEVICE(0x0489, 0xe03d), .driver_info = BTUSB_IGNORE },
> 	{ USB_DEVICE(0x0489, 0xe027), .driver_info = BTUSB_IGNORE },
> +	/* Realtek 8723 Bluetooth */
> +	{ USB_DEVICE(0x0bda, 0xb728), .driver_info = BTUSB_IGNORE },
> +
> 	/* Atheros AR9285 Malbec with sflash firmware */
> 	{ USB_DEVICE(0x03f0, 0x311d), .driver_info = BTUSB_IGNORE },
>  -- 1.8.1.2

I suppose after adding the device to the blacklist it still doesn't
work? :)

What I mean is, what's the value of this patch if the experience the
user gets is the same both with and without it? Wouldn't it make more
sense to put some effort into fixing btusb so that this hardware *does*
work with it, or alternatively providing a separate driver to support
the hardware (after which it *would* be ok to add the id to the btusb
blacklist).

Johan
