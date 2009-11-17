Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] DFU Driver and firmware for Atheros bluetooth chipset
 AR3011
From: Marcel Holtmann <marcel@holtmann.org>
To: Kandukuri Vikram <vkandukuri@atheros.com>
Cc: linux-bluetooth@vger.kernel.org,
	"Luis R. Rodriguez" <lrodriguez@atheros.com>
In-Reply-To: <20091117143613.GA29705@atheros-laptop>
References: <20091117143613.GA29705@atheros-laptop>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 17 Nov 2009 15:59:00 +0100
Message-ID: <1258469940.2003.25.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vikram,

your email ended up in my spam folder because of your binary attachment.

> Signed-off-by: Vikram Kandukuri <Vikram.Kandukuri@atheors.com>
> 
> ---
>  drivers/bluetooth/Kconfig  |   12 +++
>  drivers/bluetooth/Makefile |    2 +
>  drivers/bluetooth/athbt.c  |  208 ++++++++++++++++++++++++++++++++++++++++++++
>  firmware/atherosbt.bin     |  Bin 0 -> 246804 bytes
>  4 files changed, 222 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/bluetooth/athbt.c
>  create mode 100644 firmware/atherosbt.bin

Following the naming convention from your WiFi drivers, this should
either by ath3k or ar3011 or ar30xx or something like that.

> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 652367a..5bc174e 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -195,5 +195,17 @@ config BT_MRVL_SDIO
>  	  Say Y here to compile support for Marvell BT-over-SDIO driver
>  	  into the kernel or say M to compile it as module.
>  
> +config BT_ATHR
> +	tristate "Atheros firmware download driver"
> +	depends on BT_HCIBTUSB
> +	select FW_LOADER
> +	help
> +	  Bluetooth firmware download driver.
> +	  This driver loads the firmware into the Atheros bluetooth
> +          chipset.
> +
> +	  Say Y here to compile support for "Atheros firmware download driver"
> +          into the  kernel or say M to compile it as module (athbt).
> +
>  endmenu

To make this a little bit more consistent for the planned future
changes, I would propose that you use BT_ATH30XX or BT_ATH3K for this.

> diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
> index b3f57d2..f5b27e0 100644
> --- a/drivers/bluetooth/Makefile
> +++ b/drivers/bluetooth/Makefile
> @@ -18,6 +18,8 @@ obj-$(CONFIG_BT_HCIBTSDIO)	+= btsdio.o
>  obj-$(CONFIG_BT_MRVL)		+= btmrvl.o
>  obj-$(CONFIG_BT_MRVL_SDIO)	+= btmrvl_sdio.o
>  
> +obj-$(CONFIG_BT_ATHR)	        += athbt.o
> +
>  btmrvl-y			:= btmrvl_main.o
>  btmrvl-$(CONFIG_DEBUG_FS)	+= btmrvl_debugfs.o

Just sort this before the MRVL driver since this is a one file driver.

> diff --git a/drivers/bluetooth/athbt.c b/drivers/bluetooth/athbt.c
> new file mode 100644
> index 0000000..cb940c9
> --- /dev/null
> +++ b/drivers/bluetooth/athbt.c
> @@ -0,0 +1,208 @@
> +/*
> + * Copyright (c) 2008-2009 Atheros Communications Inc.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + *
> + */
> +
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +#include <linux/errno.h>
> +#include <linux/device.h>
> +#include <linux/firmware.h>
> +#include <linux/usb.h>
> +#include <net/bluetooth/bluetooth.h>
> +
> +#define DRV_VERSION "1.1"

We just use VERSION "1.1" in all the other drivers.

> +
> +MODULE_AUTHOR("Atheros Communications");
> +MODULE_DESCRIPTION("Atheros AR3011 firmware driver");
> +MODULE_VERSION(DRV_VERSION);
> +MODULE_SUPPORTED_DEVICE("Atheros AR3011 chipset");
> +MODULE_LICENSE("GPL");
> +MODULE_FIRMWARE("atherosbt.bin");

And to be consistent, please put this at the end of the driver. The
module author needs to have a contact information and not just the
company name. Read it as who maintains this driver.

For the firmware file name, I prefer ar3011.fw or similar like you do
for your other WiFi devices. Be at least a little bit consistent across
your own products here.

> +static struct usb_device_id athbt_table[] = {
> +	/* Atheros USB deviceID */
> +	{ USB_DEVICE(0x0CF3, 0x3000) },
> +	{ }	/* Terminating entry */
> +};

The word "deviceID" is pointless here. Use /* Atheros AR3011 without
firmware */

> +MODULE_DEVICE_TABLE(usb, athbt_table);
> +
> +#define USB_REQ_DFU_DNLOAD	1
> +#define FIRST_20BYTE            20
> +#define BLUK_SIZE               4096

BLUK? Typo?

> +#define ATHBT_IN_EP(data)       (0x81)
> +#define ATHBT_OUT_EP(data)	(0x02)
> +
> +struct athbt_data {
> +    struct usb_device *udev;
> +    u8 *fw_data;
> +    u32 fw_size;
> +    u32 fw_sent;
> +};

Tabs versus spaces.

> +static int athbt_load_firmware(struct athbt_data *data, unsigned char *firmware
> +				, int count)
> +{
> +	u8 *send_buf;
> +	int err, pipe, len, size, sent = 0;
> +
> +	BT_INFO("athbt %p udev %p\n", data, data->udev);

This is BT_DBG for and not BT_INFO.

> +
> +	BT_INFO("ATHBT! USB loading firmware\n");

And this is pointless. Or at least include the firmware name and ATHBT
makes no sense to anybody.

> +
> +	pipe = usb_sndctrlpipe(data->udev, 0);
> +
> +	if ((usb_control_msg(data->udev, pipe,
> +				USB_REQ_DFU_DNLOAD,
> +				USB_TYPE_VENDOR, 0, 0,
> +				firmware, 20, USB_CTRL_SET_TIMEOUT)) < 0) {
> +		BT_INFO("Can't change to loading configuration err\n");

This is BT_ERR.

> +		return -EBUSY;
> +	}
> +	sent += 20;
> +	count -= 20;
> +
> +	send_buf = kmalloc(BLUK_SIZE, GFP_ATOMIC);
> +	if (!send_buf) {
> +		BT_INFO("Can't allocate memory chunk for firmware\n");

Same here.

> +		return -ENOMEM;
> +	}
> +
> +	while (count) {
> +		size = min_t(uint, count, BLUK_SIZE);
> +		pipe = usb_sndbulkpipe(data->udev, ATHBT_OUT_EP(data));
> +		memcpy(send_buf, firmware + sent, size);
> +
> +		err = usb_bulk_msg(data->udev, pipe, send_buf, size,
> +					&len, 3000);
> +
> +		if (err || (len != size)) {
> +			BT_INFO("Error in firmware loading err = %d,"
> +				"len = %d, size = %d\n", err, len, size);

And here.

> +			goto error;
> +		}
> +
> +		sent  += size;
> +		count -= size;
> +	}
> +
> +	kfree(send_buf);
> +	return 0;
> +
> +error:
> +	kfree(send_buf);
> +	return err;
> +}
> +
> +static int athbt_probe(struct usb_interface *intf,
> +			const struct usb_device_id *id)
> +{
> +	const struct firmware *firmware;
> +	struct usb_device *udev = interface_to_usbdev(intf);
> +	struct athbt_data *data;
> +	int size;
> +
> +	BT_INFO("athbt_probe intf %p id %p\n", intf, id);

BT_DBG.

> +
> +	/* Check number of endpoints */
> +	BT_INFO("intf->cur_altsetting->desc.bInterfaceNumber = %d\n",
> +		intf->cur_altsetting->desc.bInterfaceNumber);

Don't do that. Pointless information.

> +
> +	if (intf->cur_altsetting->desc.bInterfaceNumber != 0) {
> +		BT_INFO("athbt_probe: ENODEV\n");

This is not an error. Just return -ENODEV. Stop spamming dmesg like
crazy. This driver is suppose to load a firmware and not operate a
nuclear reactor.

> +		return -ENODEV;
> +	}
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data) {
> +		BT_INFO("Can't allocate memory for data structure");

BT_ERR.

> +		return -ENOMEM;
> +	}
> +
> +	data->udev  = udev;
> +
> +	if (request_firmware(&firmware, "atherosbt.bin", &udev->dev) < 0) {
> +		BT_INFO("atherosbt firmware request failed");
> +		kfree(data);
> +		return -EIO;
> +	}
> +
> +	size = max_t(uint, firmware->size, 4096);
> +	data->fw_data = kmalloc(size, GFP_KERNEL);
> +	if (!data->fw_data) {
> +		BT_INFO("Can't allocate memory for firmware\n");

BT_ERR.

> +		release_firmware(firmware);
> +		kfree(data);
> +		return -ENOMEM;
> +	}
> +
> +	memcpy(data->fw_data, firmware->data, firmware->size);
> +	data->fw_size = firmware->size;
> +	data->fw_sent = 0;
> +	release_firmware(firmware);
> +
> +	usb_set_intfdata(intf, data);
> +	if (athbt_load_firmware(data, data->fw_data, data->fw_size))
> +		BT_INFO("ath_load_firmware   failed\n");

If it fails loading the firmware you wanna keep it claiming the
interface. That is stupid. Return an error here and give some other
drivers a chance.

> +
> +	return 0;
> +}
> +
> +static void athbt_disconnect(struct usb_interface *intf)
> +{
> +	struct athbt_data *data = usb_get_intfdata(intf);
> +
> +	BT_INFO("athbt_disconnect intf %p\n", intf);

BT_DBG.

> +
> +	kfree(data->fw_data);
> +	kfree(data);
> +}
> +
> +static struct usb_driver athbt_driver = {
> +	.name		= "athbt",
> +	.probe		= athbt_probe,
> +	.disconnect	= athbt_disconnect,
> +	.id_table	= athbt_table,
> +};
> +
> +static int __init athbt_init(void)
> +{
> +	int err;
> +
> +	BT_INFO("Atheros firmware driver ver %s", DRV_VERSION);
> +
> +	err = usb_register(&athbt_driver);
> +	if (err < 0)
> +		BT_INFO("Failed to register USB driver");

Pointless. Just to return usb_register().

> +
> +	return err;
> +}
> +
> +static void __exit athbt_exit(void)
> +{
> +	BT_INFO("athbt_exit\n");

Don't even bother with that info here.

> +	usb_deregister(&athbt_driver);
> +}
> +
> +module_init(athbt_init);
> +module_exit(athbt_exit);
> diff --git a/firmware/atherosbt.bin b/firmware/atherosbt.bin
> new file mode 100644
> index 0000000000000000000000000000000000000000..4a5ffb8de898fab1595662742f287493689e2b3b
> GIT binary patch

What license is on this firmware. We can't include it into the Linux
kernel unless it us under GPL. If it is a binary license and has a
proper distribution license then it can go to the linux-firmware tree
once you fixed the name of it of course.

Regards

Marcel


