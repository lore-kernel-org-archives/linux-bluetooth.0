Return-Path: <cyrus@holtmann.org>
Message-ID: <53A40687.80004@ahsoftware.de>
Date: Fri, 20 Jun 2014 12:01:43 +0200
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: Peng Chen <pengchen@qti.qualcomm.com>, gustavo@padovan.org,
 linux-bluetooth@vger.kernel.org, marcel@holtmann.org
CC: kumo@qca.qualcomm.com, taowang@qti.qualcomm.com
Subject: Re: [PATCH] Add a new PID/VID 0cf3/e005 for AR3012.
References: <1377853792-17589-1-git-send-email-pengchen@qca.qualcomm.com>
In-Reply-To: <1377853792-17589-1-git-send-email-pengchen@qca.qualcomm.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Am 30.08.2013 11:09, schrieb Peng Chen:
> ---
>   drivers/bluetooth/ath3k.c |    2 ++
>   drivers/bluetooth/btusb.c |    1 +
>   2 files changed, 3 insertions(+)
>
> diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
> index 11f467c..10e9a64 100644
> --- a/drivers/bluetooth/ath3k.c
> +++ b/drivers/bluetooth/ath3k.c
> @@ -85,6 +85,7 @@ static struct usb_device_id ath3k_table[] = {
>   	{ USB_DEVICE(0x04CA, 0x3008) },
>   	{ USB_DEVICE(0x13d3, 0x3362) },
>   	{ USB_DEVICE(0x0CF3, 0xE004) },
> +	{ USB_DEVICE(0x0CF3, 0xE005) },
>   	{ USB_DEVICE(0x0930, 0x0219) },
>   	{ USB_DEVICE(0x0489, 0xe057) },
>   	{ USB_DEVICE(0x13d3, 0x3393) },
> @@ -122,6 +123,7 @@ static struct usb_device_id ath3k_blist_tbl[] = {
>   	{ USB_DEVICE(0x04ca, 0x3008), .driver_info = BTUSB_ATH3012 },
>   	{ USB_DEVICE(0x13d3, 0x3362), .driver_info = BTUSB_ATH3012 },
>   	{ USB_DEVICE(0x0cf3, 0xe004), .driver_info = BTUSB_ATH3012 },
> +	{ USB_DEVICE(0x0cf3, 0xe005), .driver_info = BTUSB_ATH3012 },
>   	{ USB_DEVICE(0x0930, 0x0219), .driver_info = BTUSB_ATH3012 },
>   	{ USB_DEVICE(0x0489, 0xe057), .driver_info = BTUSB_ATH3012 },
>   	{ USB_DEVICE(0x13d3, 0x3393), .driver_info = BTUSB_ATH3012 },
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index de4cf4d..299df99 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -148,6 +148,7 @@ static struct usb_device_id blacklist_table[] = {
>   	{ USB_DEVICE(0x04ca, 0x3008), .driver_info = BTUSB_ATH3012 },
>   	{ USB_DEVICE(0x13d3, 0x3362), .driver_info = BTUSB_ATH3012 },
>   	{ USB_DEVICE(0x0cf3, 0xe004), .driver_info = BTUSB_ATH3012 },
> +	{ USB_DEVICE(0x0cf3, 0xe005), .driver_info = BTUSB_ATH3012 },
>   	{ USB_DEVICE(0x0930, 0x0219), .driver_info = BTUSB_ATH3012 },
>   	{ USB_DEVICE(0x0489, 0xe057), .driver_info = BTUSB_ATH3012 },
>   	{ USB_DEVICE(0x13d3, 0x3393), .driver_info = BTUSB_ATH3012 },

This patch ended up in 3.15 as

-----
[aholler@krabat linux]# git diff ca58e5~1..ca58e5
diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 59b2e6a..bc5cf90 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -89,6 +89,7 @@ static const struct usb_device_id ath3k_table[] = {
         { USB_DEVICE(0x0b05, 0x17d0) },
         { USB_DEVICE(0x0CF3, 0x0036) },
         { USB_DEVICE(0x0CF3, 0x3004) },
+       { USB_DEVICE(0x0CF3, 0x3005) },
         { USB_DEVICE(0x0CF3, 0x3008) },
         { USB_DEVICE(0x0CF3, 0x311D) },
         { USB_DEVICE(0x0CF3, 0x311E) },
@@ -137,6 +138,7 @@ static const struct usb_device_id ath3k_blist_tbl[] = {
         { USB_DEVICE(0x0b05, 0x17d0), .driver_info = BTUSB_ATH3012 },
         { USB_DEVICE(0x0CF3, 0x0036), .driver_info = BTUSB_ATH3012 },
         { USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
+       { USB_DEVICE(0x0cf3, 0x3005), .driver_info = BTUSB_ATH3012 },
         { USB_DEVICE(0x0cf3, 0x3008), .driver_info = BTUSB_ATH3012 },
         { USB_DEVICE(0x0cf3, 0x311D), .driver_info = BTUSB_ATH3012 },
         { USB_DEVICE(0x0cf3, 0x311E), .driver_info = BTUSB_ATH3012 },
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 199b9d4..f338b0c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -159,6 +159,7 @@ static const struct usb_device_id blacklist_table[] = {
         { USB_DEVICE(0x0b05, 0x17d0), .driver_info = BTUSB_ATH3012 },
         { USB_DEVICE(0x0cf3, 0x0036), .driver_info = BTUSB_ATH3012 },
         { USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
+       { USB_DEVICE(0x0cf3, 0x3005), .driver_info = BTUSB_ATH3012 },
         { USB_DEVICE(0x0cf3, 0x3008), .driver_info = BTUSB_ATH3012 },
         { USB_DEVICE(0x0cf3, 0x311d), .driver_info = BTUSB_ATH3012 },
         { USB_DEVICE(0x0cf3, 0x311e), .driver_info = BTUSB_ATH3012 },
-----

which is wrong and disables the ath3k driver.

Alexander Holler
