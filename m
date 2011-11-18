Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: ath3k: Add supports for Qualcomm Atherose
 3012 composite chip
From: Marcel Holtmann <marcel@holtmann.org>
To: "Yao, Costa" <cqyao@qca.qualcomm.com>
Cc: "padovan@profusion.mobi" <padovan@profusion.mobi>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Fri, 18 Nov 2011 13:07:09 +0100
In-Reply-To: <07BBB2AAB1A10A488A2AD166C7CB8B0DEF3E6E@nasanexd02b.na.qualcomm.com>
References: <07BBB2AAB1A10A488A2AD166C7CB8B0DEF3E6E@nasanexd02b.na.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321618032.15441.615.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Costa,

> 1 Use USB_DEVICE_AND_INTERFACE_INFO to do device matching with PID/VID 0x3006/0x0cf3.
> 2 Delete desc.bInterfaceNumber != 0 check.
> 3 Add function ath3k_download_3006 to download firmware to hardware for 0x3006
> 
> Signed-off-by: Costa Yao <cqyao@qca.qualcomm.com>
> ---
>  drivers/bluetooth/ath3k.c |   65 ++++++++++++++++++++++++++++++++++++++++++---
>  1 files changed, 61 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
> index 1622772..b38cd16 100644
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
> @@ -49,6 +50,9 @@
>  #define ATH3K_XTAL_FREQ_19P2			0x02
>  #define ATH3K_NAME_LEN				0xFF
>  
> +#define BTUSB_ATH3012		0x80
> +#define BTUSB_ATH3006		0x0100
> +

this is ath3k.c specific. So do not use BTUSB_ prefux.

>  struct ath3k_version {
>  	unsigned int	rom_version;
>  	unsigned int	build_version;
> @@ -71,6 +75,7 @@ static struct usb_device_id ath3k_table[] = {
>  
>  	/* Atheros AR3012 with sflash firmware*/
>  	{ USB_DEVICE(0x0CF3, 0x3004) },
> +	{ USB_DEVICE_AND_INTERFACE_INFO(0x0CF3, 0x3006, 0xe0, 0x01, 0x01) },
>  
>  	/* Atheros AR5BBU12 with sflash firmware */
>  	{ USB_DEVICE(0x0489, 0xE02C) },
> @@ -80,13 +85,13 @@ static struct usb_device_id ath3k_table[] = {
>  
>  MODULE_DEVICE_TABLE(usb, ath3k_table);
>  
> -#define BTUSB_ATH3012		0x80
>  /* This table is to load patch and sysconfig files
>   * for AR3012 */
>  static struct usb_device_id ath3k_blist_tbl[] = {
>  
>  	/* Atheros AR3012 with sflash firmware*/
>  	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
> +	{ USB_DEVICE(0x0CF3, 0x3006), .driver_info = BTUSB_ATH3006 },
>  
>  	{ }	/* Terminating entry */
>  };
> @@ -355,6 +360,52 @@ static int ath3k_load_syscfg(struct usb_device *udev)
>  	return ret;
>  }
>  
> +static int ath3k_download_3006(struct usb_device *udev)
> +{
> +	int ret;
> +	unsigned char fw_state;
> +
> +	if (le16_to_cpu(udev->descriptor.bcdDevice) > 0x0001) {
> +		BT_ERR("ath3k_probe: udev->descriptor.bcdDevice");
> +		return -ENODEV;
> +	}
> +
> +	ret = ath3k_get_state(udev, &fw_state);
> +	if (ret < 0) {
> +		BT_ERR("ath3k_probe: ath3k_get_state err");
> +		return ret;
> +	}
> +
> +	if ((fw_state & ATH3K_MODE_MASK) == ATH3K_PREBOOT_MODE) {
> +		BT_ERR("ath3k_probe: firmware are in preboot mode now");
> +		BT_ERR("ath3k_probe: try to switch to Normal Mode");
> +		ret = ath3k_set_normal_mode(udev);
> +		if (ret < 0) {
> +			BT_ERR("ath3k_probe: set normal mode failed");
> +			return ret;
> +		}
> +	}
> +
> +	/* Note we should wait for a while */
> +	mdelay(100);
> +	ret = ath3k_load_patch(udev);
> +	if (ret < 0) {
> +		BT_ERR("ath3k_probe: Load patch file failed");
> +		return ret;
> +	}
> +	ret = ath3k_load_syscfg(udev);
> +	if (ret < 0) {
> +		BT_ERR("ath3k_probe: Load sysconfig file failed");
> +		return ret;
> +	}
> +	ret = ath3k_switch_pid(udev);
> +	if (ret < 0) {
> +		BT_ERR("ath3k_probe: switch pid failed");
> +		return ret;
> +	}
> +	return 0;
> +}
> +
>  static int ath3k_probe(struct usb_interface *intf,
>  			const struct usb_device_id *id)
>  {
> @@ -364,9 +415,6 @@ static int ath3k_probe(struct usb_interface *intf,
>  
>  	BT_DBG("intf %p id %p", intf, id);
>  
> -	if (intf->cur_altsetting->desc.bInterfaceNumber != 0)
> -		return -ENODEV;
> -
>  	/* match device ID in ath3k blacklist table */
>  	if (!id->driver_info) {
>  		const struct usb_device_id *match;
> @@ -401,6 +449,15 @@ static int ath3k_probe(struct usb_interface *intf,
>  		return 0;
>  	}
>  
> +	if (id->driver_info & BTUSB_ATH3006) {
> +		ret = ath3k_download_3006(udev);
> +		if (ret < 0) {
> +			BT_ERR("ath3k_probe: download_3006 failed");
> +			return ret;
> +		}
> +		return 0;
> +	}
> +
>  	ret = request_firmware(&firmware, ATH3K_FIRMWARE, &udev->dev);
>  	if (ret < 0) {
>  		if (ret == -ENOENT)

The rest is fine with me.

Regards

Marcel


