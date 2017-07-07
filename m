Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] bluetooth: btusb: Add support for BCM2045 HCI with
 vend:prod ids set to 0000:0000
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170706140845.11508-1-hdegoede@redhat.com>
Date: Fri, 7 Jul 2017 13:30:35 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <F8CD7406-AF90-47D6-B652-E5778C4292BC@holtmann.org>
References: <20170706140845.11508-1-hdegoede@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hans,

> The GPD Pocket is shipping with a BCM2045 USB HCI with its vend:prod
> ids set to 0000:0000 and also has its interface class set to 255 (Vendor
> Specific Class).
> 
> Which, well sucks. Luckily it does advertise usable manufacturer and
> product strings, so this commit adds 0000:0000 to the usb_device_id
> table, with a special flag of BTUSB_BCM2045_0000_0000, if this flag
> is set btusb_probe will check the strings and if they don't match
> return -ENODEV.
> 
> This is not pretty, but it fixes bluetooth not working under Linux.
> 
> Reported-and-tested-by: Christopher Williamson <home@chrisaw.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> drivers/bluetooth/btusb.c | 15 +++++++++++++++
> 1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 7fa373b428f8..9c3201c0525d 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -66,6 +66,7 @@ static struct usb_driver btusb_driver;
> #define BTUSB_BCM2045		0x40000
> #define BTUSB_IFNUM_2		0x80000
> #define BTUSB_CW6622		0x100000
> +#define BTUSB_BCM2045_0000_0000	0x200000
> 
> static const struct usb_device_id btusb_table[] = {
> 	/* Generic Bluetooth USB device */
> @@ -124,6 +125,10 @@ static const struct usb_device_id btusb_table[] = {
> 	/* Canyon CN-BTU1 with HID interfaces */
> 	{ USB_DEVICE(0x0c10, 0x0000) },
> 
> +	/* Broadcom BCM2045 with the prod:vend ids not filled GRRR */
> +	{ USB_DEVICE(0x0000, 0x0000),
> +	  .driver_info = BTUSB_BCM2045 | BTUSB_BCM2045_0000_0000 },
> +
> 	/* Broadcom BCM20702A0 */
> 	{ USB_DEVICE(0x413c, 0x8197) },
> 
> @@ -2887,6 +2892,16 @@ static int btusb_probe(struct usb_interface *intf,
> 	if (id->driver_info == BTUSB_IGNORE)
> 		return -ENODEV;
> 
> +	if (id->driver_info & BTUSB_BCM2045_0000_0000) {
> +		struct usb_device *udev = interface_to_usbdev(intf);
> +
> +		/* Device with prod:vend id set to 0000:0000, check strings */
> +		if (!udev->manufacturer || !udev->product ||
> +		    strcmp(udev->manufacturer, "Broadcom Corp") != 0 ||
> +		    strcmp(udev->product, "BCM2045A0") != 0)
> +			return -ENODEV;
> +	}
> +

so I reworked this to make it less ugly and be more restrictive in checking the matching details.

What I need is actually a “btmon -w trace.log” from the initialization of this device so that I can make sure that the patchram support does work here.

Regards

Marcel

