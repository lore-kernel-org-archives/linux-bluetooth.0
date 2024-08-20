Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112EF52F88;
	Tue, 20 Aug 2024 05:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724132232; cv=none; b=BExZmX/kwWUjUW7zhW1D41JlZTA9ct7pkRkYSk2GAxBdsZsz0y+GeIRgov/5rxQwkGQFUVSZX9nskCxgtHXZj4+zZ6z2Hlae0tohnxzfAJQjsVHmf32XKThg+i3DbqP8Qh2Vc2gNHwbkfybWlnkIbhPllEeRa/53C6oXlDyecPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724132232; c=relaxed/simple;
	bh=bKRjY+lbF96EA43tlhCbaR+9L/GHml32Xg3v9I0fkbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XRfi+MyWAM84b1kBwtcXyQ94FZ8PqAyPOkql1ZShtbRVR12+Puxdqx43SuJlt0nsRRxRKUJLtG0DhlztKkKDXeJms1+CULIBOK5EQjdvMg19acOjzZ5PZDx3xfpIICLIs5YWrUSB+p/TnC1ysg417hqWHO0LFTheJBgzSK1lv2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af271.dynamic.kabel-deutschland.de [95.90.242.113])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5419161E5FE07;
	Tue, 20 Aug 2024 07:36:43 +0200 (CEST)
Message-ID: <2069542d-1b0c-4539-acf9-0c020fd09754@molgen.mpg.de>
Date: Tue, 20 Aug 2024 07:36:42 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 RESEND] Bluetooth: btrtl: Add the support for RTL8922A
To: Max Chou <max.chou@realtek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hilda Wu <hildawu@realtek.com>, Alex Lu <alex_lu@realsil.com.cn>,
 Kidman Lee <kidman@realtek.com>, Karen Hsu <karenhsu@realtek.com>
References: <20240820051635.25049-1-max.chou@realtek.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240820051635.25049-1-max.chou@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Max,


Thank you for your patch.

Am 20.08.24 um 07:16 schrieb max.chou@realtek.com:
> From: Max Chou <max.chou@realtek.com>

The article *the* in the commit message summary is uncommon. Maybe:

Add support for RTL8922A

> Add the support for RTL8922A BT controller on USB interface.

Ditto.

> The necessary firmware will be submitted to linux-firmware project.

Maybe add the firmware file name `rtl8922au_fw`?

If you could also document the device you tested with, that means which 
has that Bluetooth controller, that might be good to know too.

> The device info from /sys/kernel/debug/usb/devices as below.
> 
> T:  Bus=01 Lev=02 Prnt=02 Port=02 Cnt=01 Dev#=  3 Spd=12   MxCh= 0
> D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0bda ProdID=8922 Rev= 0.00
> S:  Manufacturer=Realtek
> S:  Product=Bluetooth Radio
> S:  SerialNumber=00E04C885A01
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> 
> Signed-off-by: Max Chou <max.chou@realtek.com>
> ---
> change:
> v2: edit commit log
> ---
>   drivers/bluetooth/btrtl.c | 16 ++++++++++++++++
>   drivers/bluetooth/btusb.c | 13 +++++++++++++
>   2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index f2f37143c454..555c2964ec1b 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -30,6 +30,7 @@
>   #define RTL_ROM_LMP_8822B	0x8822
>   #define RTL_ROM_LMP_8852A	0x8852
>   #define RTL_ROM_LMP_8851B	0x8851
> +#define RTL_ROM_LMP_8922A	0x8922
>   #define RTL_CONFIG_MAGIC	0x8723ab55
>   
>   #define RTL_VSC_OP_COREDUMP	0xfcff
> @@ -69,6 +70,7 @@ enum btrtl_chip_id {
>   	CHIP_ID_8852B = 20,
>   	CHIP_ID_8852C = 25,
>   	CHIP_ID_8851B = 36,
> +	CHIP_ID_8922A = 44,
>   	CHIP_ID_8852BT = 47,
>   };
>   
> @@ -309,6 +311,15 @@ static const struct id_table ic_id_table[] = {
>   	  .cfg_name = "rtl_bt/rtl8851bu_config",
>   	  .hw_info  = "rtl8851bu" },
>   
> +	/* 8922A */
> +	{ IC_INFO(RTL_ROM_LMP_8922A, 0xa, 0xc, HCI_USB),
> +	  .config_needed = false,
> +	  .has_rom_version = true,
> +	  .has_msft_ext = true,
> +	  .fw_name  = "rtl_bt/rtl8922au_fw",
> +	  .cfg_name = "rtl_bt/rtl8922au_config",
> +	  .hw_info  = "rtl8922au" },
> +

Why not sort it?

>   	/* 8852BT/8852BE-VT */
>   	{ IC_INFO(RTL_ROM_LMP_8852A, 0x87, 0xc, HCI_USB),
>   	  .config_needed = false,
> @@ -655,6 +666,7 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
>   		{ RTL_ROM_LMP_8852A, 20 },	/* 8852B */
>   		{ RTL_ROM_LMP_8852A, 25 },	/* 8852C */
>   		{ RTL_ROM_LMP_8851B, 36 },	/* 8851B */
> +		{ RTL_ROM_LMP_8922A, 44 },	/* 8922A */
>   		{ RTL_ROM_LMP_8852A, 47 },	/* 8852BT */
>   	};
>   
> @@ -1255,6 +1267,7 @@ int btrtl_download_firmware(struct hci_dev *hdev,
>   	case RTL_ROM_LMP_8852A:
>   	case RTL_ROM_LMP_8703B:
>   	case RTL_ROM_LMP_8851B:
> +	case RTL_ROM_LMP_8922A:
>   		err = btrtl_setup_rtl8723b(hdev, btrtl_dev);
>   		break;
>   	default:
> @@ -1286,6 +1299,7 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
>   	case CHIP_ID_8852B:
>   	case CHIP_ID_8852C:
>   	case CHIP_ID_8851B:
> +	case CHIP_ID_8922A:
>   	case CHIP_ID_8852BT:

Why not sort it?

>   		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
>   		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
> @@ -1529,3 +1543,5 @@ MODULE_FIRMWARE("rtl_bt/rtl8852btu_config.bin");
>   MODULE_FIRMWARE("rtl_bt/rtl8852cu_fw.bin");
>   MODULE_FIRMWARE("rtl_bt/rtl8852cu_fw_v2.bin");
>   MODULE_FIRMWARE("rtl_bt/rtl8852cu_config.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8922au_fw.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8922au_config.bin");
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index acdba5d77694..8f931cfbac11 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -540,6 +540,8 @@ static const struct usb_device_id quirks_table[] = {
>   						     BTUSB_WIDEBAND_SPEECH },
>   	{ USB_DEVICE(0x13d3, 0x3592), .driver_info = BTUSB_REALTEK |
>   						     BTUSB_WIDEBAND_SPEECH },
> +	{ USB_DEVICE(0x0489, 0xe122), .driver_info = BTUSB_REALTEK |
> +						     BTUSB_WIDEBAND_SPEECH },

Why not sort it?

>   
>   	/* Realtek 8852BE Bluetooth devices */
>   	{ USB_DEVICE(0x0cb8, 0xc559), .driver_info = BTUSB_REALTEK |
> @@ -564,6 +566,17 @@ static const struct usb_device_id quirks_table[] = {
>   	/* Realtek 8852BT/8852BE-VT Bluetooth devices */
>   	{ USB_DEVICE(0x0bda, 0x8520), .driver_info = BTUSB_REALTEK |
>   						     BTUSB_WIDEBAND_SPEECH },
> +
> +	/* Realtek 8922AE Bluetooth devices */
> +	{ USB_DEVICE(0x0bda, 0x8922), .driver_info = BTUSB_REALTEK |
> +						     BTUSB_WIDEBAND_SPEECH },
> +	{ USB_DEVICE(0x13d3, 0x3617), .driver_info = BTUSB_REALTEK |
> +						     BTUSB_WIDEBAND_SPEECH },
> +	{ USB_DEVICE(0x13d3, 0x3616), .driver_info = BTUSB_REALTEK |
> +						     BTUSB_WIDEBAND_SPEECH },

Why not sort it?

> +	{ USB_DEVICE(0x0489, 0xe130), .driver_info = BTUSB_REALTEK |
> +						     BTUSB_WIDEBAND_SPEECH },
> +
>   	/* Realtek Bluetooth devices */
>   	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
>   	  .driver_info = BTUSB_REALTEK },

