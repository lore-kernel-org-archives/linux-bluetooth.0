Return-Path: <cyrus@holtmann.org>
Message-ID: <55735901.9050303@gmail.com>
Date: Sat, 06 Jun 2015 23:33:05 +0300
From: Dmitry Tunin <hanipouspilot@gmail.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>,
 Gustavo Padovan <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>
CC: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] ath3k: Add support of 0489:e076 AR3012 device
References: <1433611540-30860-1-git-send-email-hanipouspilot@gmail.com>
In-Reply-To: <1433611540-30860-1-git-send-email-hanipouspilot@gmail.com>
Content-Type: text/plain; charset=windows-1251; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>



06.06.2015 20:25, Dmitry Tunin пишет:
> BugLink: https://bugs.launchpad.net/bugs/1462614
>
> This device requires new firmware files
>   AthrBT_0x11020100.dfu and ramps_0x11020100_40.dfu added to
> /lib/firmware/ar3k/ that are not included in linux-firmware yet.
>
> T: Bus=03 Lev=01 Prnt=01 Port=09 Cnt=06 Dev#= 7 Spd=12 MxCh= 0
> D: Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
> P: Vendor=0489 ProdID=e076 Rev= 0.01
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> E: Ad=81(I) Atr=03(Int.) MxPS= 16 Ivl=1ms
> E: Ad=82(I) Atr=02(Bulk) MxPS= 64 Ivl=0ms
> E: Ad=02(O) Atr=02(Bulk) MxPS= 64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> E: Ad=83(I) Atr=01(Isoc) MxPS= 0 Ivl=1ms
> E: Ad=03(O) Atr=01(Isoc) MxPS= 0 Ivl=1ms
> I: If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> E: Ad=83(I) Atr=01(Isoc) MxPS= 9 Ivl=1ms
> E: Ad=03(O) Atr=01(Isoc) MxPS= 9 Ivl=1ms
> I: If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> E: Ad=83(I) Atr=01(Isoc) MxPS= 17 Ivl=1ms
> E: Ad=03(O) Atr=01(Isoc) MxPS= 17 Ivl=1ms
> I: If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> E: Ad=83(I) Atr=01(Isoc) MxPS= 25 Ivl=1ms
> E: Ad=03(O) Atr=01(Isoc) MxPS= 25 Ivl=1ms
> I: If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> E: Ad=83(I) Atr=01(Isoc) MxPS= 33 Ivl=1ms
> E: Ad=03(O) Atr=01(Isoc) MxPS= 33 Ivl=1ms
> I: If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> E: Ad=83(I) Atr=01(Isoc) MxPS= 49 Ivl=1ms
> E: Ad=03(O) Atr=01(Isoc) MxPS= 49 Ivl=1ms
>
> Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>
> Cc: stable@vger.kernel.org
> ---
>   drivers/bluetooth/ath3k.c | 2 ++
>   drivers/bluetooth/btusb.c | 1 +
>   2 files changed, 3 insertions(+)
>
> diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
> index 8c81af6..ee64764 100644
> --- a/drivers/bluetooth/ath3k.c
> +++ b/drivers/bluetooth/ath3k.c
> @@ -80,6 +80,7 @@ static const struct usb_device_id ath3k_table[] = {
>   	{ USB_DEVICE(0x0489, 0xe057) },
>   	{ USB_DEVICE(0x0489, 0xe056) },
>   	{ USB_DEVICE(0x0489, 0xe05f) },
> +	{ USB_DEVICE(0x0489, 0xe076) },
>   	{ USB_DEVICE(0x0489, 0xe078) },
>   	{ USB_DEVICE(0x04c5, 0x1330) },
>   	{ USB_DEVICE(0x04CA, 0x3004) },
> @@ -137,6 +138,7 @@ static const struct usb_device_id ath3k_blist_tbl[] = {
>   	{ USB_DEVICE(0x0489, 0xe056), .driver_info = BTUSB_ATH3012 },
>   	{ USB_DEVICE(0x0489, 0xe057), .driver_info = BTUSB_ATH3012 },
>   	{ USB_DEVICE(0x0489, 0xe05f), .driver_info = BTUSB_ATH3012 },
> +	{ USB_DEVICE(0x0489, 0xe076), .driver_info = BTUSB_ATH3012 },
>   	{ USB_DEVICE(0x0489, 0xe078), .driver_info = BTUSB_ATH3012 },
>   	{ USB_DEVICE(0x04c5, 0x1330), .driver_info = BTUSB_ATH3012 },
>   	{ USB_DEVICE(0x04ca, 0x3004), .driver_info = BTUSB_ATH3012 },
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 94c6c04..c9be776 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -179,6 +179,7 @@ static const struct usb_device_id blacklist_table[] = {
>   	{ USB_DEVICE(0x0489, 0xe056), .driver_info = BTUSB_ATH3012 },
>   	{ USB_DEVICE(0x0489, 0xe057), .driver_info = BTUSB_ATH3012 },
>   	{ USB_DEVICE(0x0489, 0xe05f), .driver_info = BTUSB_ATH3012 },
> +	{ USB_DEVICE(0x0489, 0xe076), .driver_info = BTUSB_ATH3012 },
>   	{ USB_DEVICE(0x0489, 0xe078), .driver_info = BTUSB_ATH3012 },
>   	{ USB_DEVICE(0x04c5, 0x1330), .driver_info = BTUSB_ATH3012 },
>   	{ USB_DEVICE(0x04ca, 0x3004), .driver_info = BTUSB_ATH3012 },
I added /sys/kernel/debug/usb/devices when firmware was not loaded.
When I added firmware files it shows

T: Bus=03 Lev=01 Prnt=01 Port=09 Cnt=05 Dev#= 5 Spd=12 MxCh= 0
D: Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
P: Vendor=0489 ProdID=e076 Rev= 0.01
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=81(I) Atr=03(Int.) MxPS= 16 Ivl=1ms
E: Ad=82(I) Atr=02(Bulk) MxPS= 64 Ivl=0ms
E: Ad=02(O) Atr=02(Bulk) MxPS= 64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS= 0 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 0 Ivl=1ms
I: If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS= 9 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 9 Ivl=1ms
I: If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS= 17 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 17 Ivl=1ms
I: If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS= 25 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 25 Ivl=1ms
I: If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS= 33 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 33 Ivl=1ms
I: If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS= 49 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 49 Ivl=1ms

Shall I change the commit message, or is it OK?
