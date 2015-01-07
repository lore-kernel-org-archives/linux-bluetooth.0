Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH] Bluetooth: Add support for yet another BCM20702A0 variant (0489:e031)
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1420663834-16333-1-git-send-email-tiwai@suse.de>
Date: Wed, 7 Jan 2015 15:15:49 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <A5EDFACF-25C0-4102-8C17-1913B9EA905D@holtmann.org>
References: <1420663834-16333-1-git-send-email-tiwai@suse.de>
To: Takashi Iwai <tiwai@suse.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Takashi,

> 0489:e031 needs BTUSB_BCM_PATCHRAM, too.

for the ones that require patching, we prefer to include the instructions on how to get the firmware into the commit log.

Also please include /sys/kernel/debug/usb/devices section for this. It is good to have them for reference.

> Bugzilla: https://bugzilla.opensuse.org/show_bug.cgi?id=911311
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> drivers/bluetooth/btusb.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 19cf2cf22e87..a6f8182e6d3a 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -108,6 +108,8 @@ static const struct usb_device_id btusb_table[] = {
> 	{ USB_DEVICE(0x413c, 0x8197) },
> 	{ USB_DEVICE(0x13d3, 0x3404),
> 	  .driver_info = BTUSB_BCM_PATCHRAM },
> +	{ USB_DEVICE(0x13d3, 0xe031),
> +	  .driver_info = BTUSB_BCM_PATCHRAM },

I wonder if we should just start using USB_VENDOR_AND_INTERFACE_INFO() for this one like we have done for other Broadcom based Bluetooth dongles.

> 	/* Foxconn - Hon Hai */
> 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),

Regards

Marcel

