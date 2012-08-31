Return-Path: <cyrus@holtmann.org>
Message-ID: <1346429464.23377.19.camel@aeonflux>
Subject: Re: [PATCH 1/2] Implement broadcom patchram firmware loader
From: Marcel Holtmann <marcel@holtmann.org>
To: Jesse Sung <jesse.sung@canonical.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 31 Aug 2012 09:11:04 -0700
In-Reply-To: <1346390510-18538-2-git-send-email-jesse.sung@canonical.com>
References: <1346390510-18538-1-git-send-email-jesse.sung@canonical.com>
	 <1346390510-18538-2-git-send-email-jesse.sung@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jesse,

> From: Wen-chien Jesse Sung <jesse.sung@canonical.com>
> 
> 
> Signed-off-by: Wen-chien Jesse Sung <jesse.sung@canonical.com>

please learn on how to write commit messages. I want a full blown commit
messages with /sys/kernel/debug/usb/devices output (before and after)
and something that explains what is actually done.

> ---
>  drivers/bluetooth/btusb.c |  103 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 99 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 654e248..7189fed 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -23,6 +23,8 @@
>  
>  #include <linux/module.h>
>  #include <linux/usb.h>
> +#include <linux/delay.h>
> +#include <linux/firmware.h>
>  
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
> @@ -47,6 +49,7 @@ static struct usb_driver btusb_driver;
>  #define BTUSB_BROKEN_ISOC	0x20
>  #define BTUSB_WRONG_SCO_MTU	0x40
>  #define BTUSB_ATH3012		0x80
> +#define BTUSB_BCM_PATCHRAM	0x100
>  
>  static struct usb_device_id btusb_table[] = {
>  	/* Generic Bluetooth USB device */
> @@ -96,14 +99,15 @@ static struct usb_device_id btusb_table[] = {
>  	{ USB_DEVICE(0x0c10, 0x0000) },
>  
>  	/* Broadcom BCM20702A0 */
> +	{ USB_DEVICE(0x0489, 0xe031), .driver_info = BTUSB_BCM_PATCHRAM },
>  	{ USB_DEVICE(0x0489, 0xe042) },
> -	{ USB_DEVICE(0x413c, 0x8197) },
> +	{ USB_DEVICE(0x413c, 0x8197), .driver_info = BTUSB_BCM_PATCHRAM },

These drivers did work without firmware before. So why is this change
required? Or is that Broadcom wide?
 
>  	/* Foxconn - Hon Hai */
>  	{ USB_DEVICE(0x0489, 0xe033) },
>  
>  	/*Broadcom devices with vendor specific id */
> -	{ USB_VENDOR_AND_INTERFACE_INFO(0x0a5c, 0xff, 0x01, 0x01) },
> +	{ USB_VENDOR_AND_INTERFACE_INFO(0x0a5c, 0xff, 0x01, 0x01), .driver_info = BTUSB_BCM_PATCHRAM },
>  
>  	{ }	/* Terminating entry */
>  };
> @@ -197,6 +201,37 @@ static struct usb_device_id blacklist_table[] = {
>  	{ }	/* Terminating entry */
>  };
>  
> +#define PATCHRAM_TIMEOUT	1000
> +#define FW_0489_E031		"fw-0489_e031.hcd"
> +#define FW_0A5C_21D3		"fw-0a5c_21d3.hcd"
> +#define FW_0A5C_21D7		"fw-0a5c_21d7.hcd"
> +#define FW_0A5C_21E6		"fw-0a5c_21e6.hcd"
> +#define FW_0A5C_21F3		"fw-0a5c_21f3.hcd"
> +#define FW_0A5C_21F4		"fw-0a5c_21f4.hcd"
> +#define FW_413C_8197		"fw-413c_8197.hcd"
> +
> +MODULE_FIRMWARE(FW_0489_E031);
> +MODULE_FIRMWARE(FW_0A5C_21D3);
> +MODULE_FIRMWARE(FW_0A5C_21D7);
> +MODULE_FIRMWARE(FW_0A5C_21E6);
> +MODULE_FIRMWARE(FW_0A5C_21F3);
> +MODULE_FIRMWARE(FW_0A5C_21F4);
> +MODULE_FIRMWARE(FW_413C_8197);
> +
> +static struct usb_device_id patchram_table[] = {
> +	/* Dell DW1704 */
> +	{ USB_DEVICE(0x0a5c, 0x21d3), .driver_info = (kernel_ulong_t) FW_0A5C_21D3 },
> +	{ USB_DEVICE(0x0a5c, 0x21d7), .driver_info = (kernel_ulong_t) FW_0A5C_21D7 },
> +	/* Dell DW380 */
> +	{ USB_DEVICE(0x413c, 0x8197), .driver_info = (kernel_ulong_t) FW_413C_8197 },
> +	/* FoxConn Hon Hai */
> +	{ USB_DEVICE(0x0489, 0xe031), .driver_info = (kernel_ulong_t) FW_0489_E031 },
> +	/* Lenovo */
> +	{ USB_DEVICE(0x0a5c, 0x21e6), .driver_info = (kernel_ulong_t) FW_0A5C_21E6 },
> +	{ USB_DEVICE(0x0a5c, 0x21f3), .driver_info = (kernel_ulong_t) FW_0A5C_21F3 },
> +	{ USB_DEVICE(0x0a5c, 0x21f4), .driver_info = (kernel_ulong_t) FW_0A5C_21F4 },
> +};
> +

And this looks like totally wasted details to me. Either build the
firmware name from USB VID:PID or only include the ones that we are
actually supporting.

>  #define BTUSB_MAX_ISOC_FRAMES	10
>  
>  #define BTUSB_INTR_RUNNING	0
> @@ -914,6 +949,55 @@ static void btusb_waker(struct work_struct *work)
>  	usb_autopm_put_interface(data->intf);
>  }
>  
> +static inline void load_patchram_fw(struct usb_device *udev, const struct usb_device_id *id)
> +{
> +	size_t pos = 0;
> +	int err = 0;
> +	const struct firmware *fw;
> +
> +	unsigned char reset_cmd[] = { 0x03, 0x0c, 0x00 };
> +	unsigned char download_cmd[] = { 0x2e, 0xfc, 0x00 };
> +
> +	if (request_firmware(&fw, (const char *) id->driver_info, &udev->dev) < 0) {
> +		BT_INFO("can't load firmware, may not work correctly");
> +		return;
> +	}
> +
> +	if (usb_control_msg(udev, usb_sndctrlpipe(udev, 0), 0, USB_TYPE_CLASS, 0, 0,
> +		reset_cmd, sizeof(reset_cmd), PATCHRAM_TIMEOUT) < 0) {
> +		err = -1;
> +		goto out;
> +	}
> +	msleep(300);
> +
> +	if (usb_control_msg(udev, usb_sndctrlpipe(udev, 0), 0, USB_TYPE_CLASS, 0, 0,
> +		download_cmd, sizeof(download_cmd), PATCHRAM_TIMEOUT) < 0) {
> +		err = -1;
> +		goto out;
> +	}
> +	msleep(300);
> +
> +	while (pos < fw->size) {
> +		size_t len;
> +		len = fw->data[pos + 2] + 3;
> +		if ((pos + len > fw->size) ||
> +			(usb_control_msg(udev, usb_sndctrlpipe(udev, 0), 0,
> +			USB_TYPE_CLASS, 0, 0, (void *)fw->data + pos, len,
> +			PATCHRAM_TIMEOUT) < 0)) {
> +			err = -1;
> +			goto out;
> +		}
> +		pos += len;
> +	}
> +
> +	err = (usb_control_msg(udev, usb_sndctrlpipe(udev, 0), 0, USB_TYPE_CLASS, 0, 0,
> +		reset_cmd, sizeof(reset_cmd), PATCHRAM_TIMEOUT) < 0);
> +out:
> +	if (err)
> +		BT_INFO("fail to load firmware, may not work correctly");
> +	release_firmware(fw);
> +}
> +
>  static int btusb_probe(struct usb_interface *intf,
>  				const struct usb_device_id *id)
>  {
> @@ -1078,15 +1162,26 @@ static int btusb_probe(struct usb_interface *intf,
>  		}
>  	}
>  
> +	usb_set_intfdata(intf, data);
> +
> +	if (id->driver_info & BTUSB_BCM_PATCHRAM) {
> +		const struct usb_device_id *match;
> +		match = usb_match_id(intf, patchram_table);
> +		if (match) {
> +			btusb_open(hdev);
> +			load_patchram_fw(interface_to_usbdev(intf), match);
> +			btusb_close(hdev);
> +		}
> +	}
> +

So we are now blocking every other USB devices on that bus here? I
actually do not like this idea very much.

Also the call of btusb_open() before hdev is actually registered is
kinda fishy to me. I am not even sure that works how you think it would.

And why can't Broadcom just change the PID once the patchram has been
loaded to something else. That way we can nicely iterate through this.

This also does not really belong in a standard driver. Quirks fine, but
a complete ROM patches procedure that is vendor specific.

As I said above, I want to see the /sys/kernel/debug/usb/devices from
before and after first. Until then NAK.

Regards

Marcel


