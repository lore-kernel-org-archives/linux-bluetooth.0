Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: ath3k: Add support for Qualcomm Atheros 3006
From: Marcel Holtmann <marcel@holtmann.org>
To: "Yao, Costa" <cqyao@qca.qualcomm.com>
Cc: "padovan@profusion.mobi" <padovan@profusion.mobi>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 09 Nov 2011 16:44:32 +0900
In-Reply-To: <07BBB2AAB1A10A488A2AD166C7CB8B0DEE9C89@nasanexd02b.na.qualcomm.com>
References: <07BBB2AAB1A10A488A2AD166C7CB8B0DEE9C89@nasanexd02b.na.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1320824675.15441.324.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Costa,

> AR3006 is a composite device, and interface 0 is used for hid function, not for bluetooth function.
> We should make the following changes:
> 1 Blacklist AR3006 PID/VID in ath3k_table
> 2 Add ath3k_composite_device_table in ath3k.c to register composite device.
> 3 Load patch and sysconfig files for AR3006
> 
> Signed-off-by: Costa Yao <cqyao@qca.qualcomm.com>
> ---
>  drivers/bluetooth/ath3k.c |   64 ++++++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 61 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
> index 1622772..a9d6678 100644
> --- a/drivers/bluetooth/ath3k.c
> +++ b/drivers/bluetooth/ath3k.c
> @@ -40,6 +40,7 @@
>  
>  #define ATH3K_MODE_MASK				0x3F
>  #define ATH3K_NORMAL_MODE			0x0E
> +#define ATH3K_PREBOOT_MODE			0x0D
>  
>  #define ATH3K_PATCH_UPDATE			0x80
>  #define ATH3K_SYSCFG_UPDATE			0x40
> @@ -71,6 +72,7 @@ static struct usb_device_id ath3k_table[] = {
>  
>  	/* Atheros AR3012 with sflash firmware*/
>  	{ USB_DEVICE(0x0CF3, 0x3004) },
> +	{ USB_DEVICE(0x0CF3, 0x3006) },

why not use .driver_info here as well.
 
>  	/* Atheros AR5BBU12 with sflash firmware */
>  	{ USB_DEVICE(0x0489, 0xE02C) },
> @@ -81,16 +83,26 @@ static struct usb_device_id ath3k_table[] = {
>  MODULE_DEVICE_TABLE(usb, ath3k_table);
>  
>  #define BTUSB_ATH3012		0x80
> +#define BTUSB_ATH3006		0x0100
>  /* This table is to load patch and sysconfig files
>   * for AR3012 */
>  static struct usb_device_id ath3k_blist_tbl[] = {
>  
>  	/* Atheros AR3012 with sflash firmware*/
>  	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
> +	{ USB_DEVICE(0x0cf3, 0x3006), .driver_info = BTUSB_ATH3006 },
>  
>  	{ }	/* Terminating entry */
>  };
>  
> +/* Atheros composite devices table
> + */
> +static struct usb_device_id ath3k_composite_device_table[] = {
> +
> +	{ USB_DEVICE(0x0cf3, 0x3006) },
> +
> +	{ }	/* Terminating entry */
> +};

I don't see a point in having another table here. Why can we not use the
driver table?

>  #define USB_REQ_DFU_DNLOAD	1
>  #define BULK_SIZE		4096
>  #define FW_HDR_SIZE		20
> @@ -361,11 +373,19 @@ static int ath3k_probe(struct usb_interface *intf,
>  	const struct firmware *firmware;
>  	struct usb_device *udev = interface_to_usbdev(intf);
>  	int ret;
> +	unsigned char fw_state;
> +	const struct usb_device_id *match_comp_dev;
>  
>  	BT_DBG("intf %p id %p", intf, id);
> -
> -	if (intf->cur_altsetting->desc.bInterfaceNumber != 0)
> -		return -ENODEV;
> +    /* For composite device */
> +	match_comp_dev = usb_match_id(intf, ath3k_composite_device_table);
> +	if (match_comp_dev) {
> +		if (intf->cur_altsetting->desc.bInterfaceNumber != 2)
> +			return -ENODEV;
> +	} else {
> +		if (intf->cur_altsetting->desc.bInterfaceNumber != 0)
> +			return -ENODEV;
> +	}
>  
>  	/* match device ID in ath3k blacklist table */
>  	if (!id->driver_info) {
> @@ -399,6 +419,44 @@ static int ath3k_probe(struct usb_interface *intf,
>  		}
>  		ath3k_switch_pid(udev);
>  		return 0;
> +	} else if (id->driver_info & BTUSB_ATH3006) {
> +
> +		if (le16_to_cpu(udev->descriptor.bcdDevice) > 0x0001) {
> +			BT_ERR("ath3k_probe: udev->descriptor.bcdDevice");
> +			return -ENODEV;
> +		}
> +		ret = ath3k_get_state(udev, &fw_state);
> +		if (ret < 0) {
> +			BT_ERR("ath3k_probe: ath3k_get_state err");
> +			return ret;
> +		}
> +		if ((fw_state & ATH3K_MODE_MASK) == ATH3K_PREBOOT_MODE) {
> +			BT_ERR("ath3k_probe: firmware are in preboot mode now");
> +			BT_ERR("ath3k_probe: try to switch to Normal Mode");
> +			ret = ath3k_set_normal_mode(udev);
> +			if (ret < 0) {
> +				BT_ERR("ath3k_probe: set normal mode failed");
> +				return ret;
> +			}
> +		}
> +		/*Note we should wait for a while*/
> +		mdelay(100);
> +		ret = ath3k_load_patch(udev);
> +		if (ret < 0) {
> +			BT_ERR("ath3k_probe: Load patch file failed");
> +			return ret;
> +		}
> +		ret = ath3k_load_syscfg(udev);
> +		if (ret < 0) {
> +			BT_ERR("ath3k_probe: Load sysconfig file failed");
> +			return ret;
> +		}
> +		ret = ath3k_switch_pid(udev);
> +		if (ret < 0) {
> +			BT_ERR("ath3k_probe: switch pid failed");
> +			return ret;
> +		}
> +		return 0;
>  	}

This code is horrible. Can you please use the core table and
utilize .driver_info. And then you might wanna split this extra handling
into a separate function and not just hack it in via one big if
statement.

Regards

Marcel


