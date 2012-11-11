Return-Path: <cyrus@holtmann.org>
Message-ID: <1352594070.16204.15.camel@aeonflux>
Subject: Re: [RFCv3 1/3] Bluetooth: Add support BT mini-driver
From: Marcel Holtmann <marcel@holtmann.org>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Cc: linux-bluetooth@vger.kernel.org, albert.o.ho@intel.com,
	johan.hedberg@intel.com, tedd.hj.an@gmail.com
Date: Sun, 11 Nov 2012 01:34:30 +0100
In-Reply-To: <1385742.8V9Ax1uMxF@tedd-ubuntu>
References: <1385742.8V9Ax1uMxF@tedd-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

> This patch add mini-driver support in BTUSB
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
>  drivers/bluetooth/btusb.c |   68 +++++++++++++++++++++++++++++++++++++++++----
>  drivers/bluetooth/btusb.h |   44 +++++++++++++++++++++++++++++
>  2 files changed, 106 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/bluetooth/btusb.h
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index f637c25..39a1e6c 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -27,6 +27,8 @@
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
>  
> +#include "btusb.h"
> +
>  #define VERSION "0.6"
>  
>  static bool ignore_dga;
> @@ -47,6 +49,7 @@ static struct usb_driver btusb_driver;
>  #define BTUSB_BROKEN_ISOC	0x20
>  #define BTUSB_WRONG_SCO_MTU	0x40
>  #define BTUSB_ATH3012		0x80
> +#define BTUSB_VENDOR		0x100
>  
>  static struct usb_device_id btusb_table[] = {
>  	/* Generic Bluetooth USB device */
> @@ -206,6 +209,7 @@ struct btusb_data {
>  	struct usb_device    *udev;
>  	struct usb_interface *intf;
>  	struct usb_interface *isoc;
> +	struct btusb_driver_info *driver_info;
>  
>  	spinlock_t lock;
>  
> @@ -952,9 +956,15 @@ static int btusb_probe(struct usb_interface *intf,
>  			return -ENODEV;
>  	}
>  
> -	data = devm_kzalloc(&intf->dev, sizeof(*data), GFP_KERNEL);
> -	if (!data)
> -		return -ENOMEM;
> +/* CHECKME: if mini-driver invokes btusb_probe, btusb_data already has been
> + * allocated. If btusb_probe is directly invoked by usb core, then allocate
> + * here. */
> +	data = usb_get_intfdata(intf);
> +	if (!data) {
> +		data = devm_kzalloc(&intf->dev, sizeof(*data), GFP_KERNEL);
> +		if (!data)
> +			return -ENOMEM;
> +	}
>  
>  	for (i = 0; i < intf->cur_altsetting->desc.bNumEndpoints; i++) {
>  		ep_desc = &intf->cur_altsetting->endpoint[i].desc;
> @@ -1012,6 +1022,17 @@ static int btusb_probe(struct usb_interface *intf,
>  	hdev->send     = btusb_send_frame;
>  	hdev->notify   = btusb_notify;
>  
> +	/* bind the vendor specific mini-driver */
> +	if ((id->driver_info & BTUSB_VENDOR) && data->driver_info) {
> +		if (data->driver_info->bind) {
> +			err = data->driver_info->bind(hdev);
> +			if (err < 0) {
> +				hci_free_dev(hdev);
> +				return err;
> +			}
> +		}
> +	}
> +

I think we can make this even simpler. Had a 12 hours flight to Tokyo
and ran out of movies to watch ;)

So I have a set of patches that add a real hdev->setup() stage to
Bluetooth core. So it can be used from any driver. I also have an
immediate use for it by one of the Broadcom drivers that need to send
one extra HCI command for the HID switching.

Need to refactor the patches a bit in better order and will post them
then.

Regards

Marcel


