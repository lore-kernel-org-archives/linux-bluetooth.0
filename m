Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH] Bluetooth: btusb: match generic class code in interface descriptor
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1437153145-5387-1-git-send-email-drake@endlessm.com>
Date: Thu, 30 Jul 2015 13:43:44 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, larry.finger@lwfinger.net,
	sjoerd.simons@collabora.co.uk, xry111@outlook.com,
	linux-usb@vger.kernel.org
Message-Id: <CF5BAA70-E535-416A-BB8A-0F5F9C51AB1B@holtmann.org>
References: <1437153145-5387-1-git-send-email-drake@endlessm.com>
To: Daniel Drake <drake@endlessm.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

> btusb currently has a generic match on USB device descriptors:
>        { USB_DEVICE_INFO(0xe0, 0x01, 0x01) },
> 
> However, http://www.usb.org/developers/defined_class states:
> 
>  Base Class E0h (Wireless Controller)
>  This base class is defined for devices that are Wireless controllers.
>  Values not shown in the table below are reserved. These class codes are
>  to be used in Interface Descriptors, with the exception of the Bluetooth
>  class code which can also be used in a Device Descriptor.
> 
> Add a match on the interface descriptors accordingly.
> 
> This fixes compatibility with the RTL8723AU device shown below.
> This device conforms to the USB Interface Association Descriptor
> specification, which requires the device to have class ef/02/01.
> The extra IAD descriptor then specifies that interfaces 0 and 1
> belong to the same function/driver, which is true. Provided that
> the Bluetooth device class spec accepts use of the IAD, I imagine that
> technically, all btusb devices should be configured like this.
> 
> T:  Bus=01 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  3 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0bda ProdID=0724 Rev= 2.00
> S:  Manufacturer=Realtek
> S:  Product=802.11n WLAN Adapter
> S:  SerialNumber=00e04c000001
> C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=500mA
> A:  FirstIf#= 0 IfCount= 2 Cls=e0(wlcon) Sub=01 Prot=01
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
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
> I:* If#= 2 Alt= 0 #EPs= 4 Cls=ff(vend.) Sub=ff Prot=ff Driver=rtl8723au
> E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=87(I) Atr=03(Int.) MxPS=  64 Ivl=500us
> 
> Signed-off-by: Daniel Drake <drake@endlessm.com>
> ---
> drivers/bluetooth/btusb.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> This replaces/obsoletes:
>  [PATCH] Bluetooth: btusb: Recognize Realtek shared wifi/bluetooth devices
>  [PATCH] Bluetooth: btusb: Add Realtek devices into module device table
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 93339a4..9874aac 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -64,6 +64,7 @@ static struct usb_driver btusb_driver;
> static const struct usb_device_id btusb_table[] = {
> 	/* Generic Bluetooth USB device */
> 	{ USB_DEVICE_INFO(0xe0, 0x01, 0x01) },
> +	{ USB_INTERFACE_INFO(0xe0, 0x01, 0x01) },

I moved this into its own line with its own comment before applying your patch.

Regards

Marcel

