Return-Path: <cyrus@holtmann.org>
Message-ID: <50079C49.2060207@qca.qualcomm.com>
Date: Thu, 19 Jul 2012 11:04:01 +0530
From: Bala Shanmugam <bkamatch@qca.qualcomm.com>
MIME-Version: 1.0
To: "Chen, Peng" <pengchen@qca.qualcomm.com>
CC: "gustavo@padovan.org" <gustavo@padovan.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"marcel@holtmann.org" <marcel@holtmann.org>, "Waller, Carolyn"
	<carolyn@qca.qualcomm.com>, "Jeang, Daniel" <dyjeong@qca.qualcomm.com>,
	"Yao, Costa" <cqyao@qca.qualcomm.com>, "Fan, Hong"
	<hongfan@qca.qualcomm.com>, "Balasubramanian, Senthil Kumar"
	<senthilb@qca.qualcomm.com>, "Wu, Frank" <fanwu@qca.qualcomm.com>
Subject: Re: [patch]Add Vendor/Device ID for AR3012
References: <0EC13EFF38B7C84DB595405A8233E35B099AE930@nasanexd01b.na.qualcomm.com>
In-Reply-To: <0EC13EFF38B7C84DB595405A8233E35B099AE930@nasanexd01b.na.qualcomm.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 07/18/2012 02:35 PM, Chen, Peng wrote:
>  From 7340f148e72f2bee78563c0ca9a37d82a5b99d64 Mon Sep 17 00:00:00 2001
> From: Peng Chen<pengchen@qca.qualcomm.com>
> Date: Wed, 18 Jul 2012 16:58:28 +0800
> Subject: [PATCH] [patch]Add Vendor/Device ID for AR3012
>
> Add Vendor/Device ID for Qualcomm Atheros AR3012.
>
> Signed-off-by: Peng Chen<pengchen@qca.qualcomm.com>
> ---
>   drivers/bluetooth/ath3k.c |    1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
> index 10308cd..7ce0aa2 100644
> --- a/drivers/bluetooth/ath3k.c
> +++ b/drivers/bluetooth/ath3k.c
> @@ -79,6 +79,7 @@ static struct usb_device_id ath3k_table[] = {
>   	{ USB_DEVICE(0x13d3, 0x3362) },
>   	{ USB_DEVICE(0x0CF3, 0xE004) },
>   	{ USB_DEVICE(0x0930, 0x0219) },
> +	{ USB_DEVICE(0x0489, 0xE057) },
>
>   	/* Atheros AR5BBU12 with sflash firmware */
>   	{ USB_DEVICE(0x0489, 0xE02C) },
Hi Chen,

I think you also need to add these ids to ath3k blacklist table 
[ath3k_blist_tbl] to load patch,
syscfg files and in btusb blacklist table [blacklist_table] in btusb.c 
to give the control to ath3k
driver to load firmware.

Regards,
Bala.
