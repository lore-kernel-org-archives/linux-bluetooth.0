Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH 6/6] Bluetooth: Add support for 105b:e065
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1417589145-30467-6-git-send-email-jesse.sung@canonical.com>
Date: Wed, 3 Dec 2014 10:04:47 +0000
Cc: linux-bluetooth@vger.kernel.org, Adam Lee <adam.lee@canonical.com>
Message-Id: <36E5BE1B-0ACB-4DAF-AE5F-207BB11C8823@holtmann.org>
References: <1417589145-30467-1-git-send-email-jesse.sung@canonical.com> <1417589145-30467-6-git-send-email-jesse.sung@canonical.com>
To: Wen-chien Jesse Sung <jesse.sung@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Wen-chien,

> BugLink: https://launchpad.net/bugs/1161261
> 
> These devices require external patchram firmware to work.
> 
> T:  Bus=01 Lev=02 Prnt=02 Port=02 Cnt=01 Dev#=  9 Spd=12  MxCh= 0
> D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=105b ProdID=e065 Rev=01.12
> S:  Manufacturer=Broadcom Corp
> S:  Product=BCM43142A0
> S:  SerialNumber=0090A295B4C6
> C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)
> 
> Signed-off-by: Adam Lee <adam.lee@canonical.com>
> Signed-off-by: Wen-chien Jesse Sung <jesse.sung@canonical.com>
> ---
> drivers/bluetooth/btusb.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 740c854..04d7958 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -113,6 +113,8 @@ static const struct usb_device_id btusb_table[] = {
> 	/* Broadcom BCM43142A0 */
> 	{ USB_DEVICE(0x04ca, 0x2007),
> 	  .driver_info = BTUSB_BCM_PATCHRAM },
> +	{ USB_DEVICE(0x105b, 0xe065),
> +	  .driver_info = BTUSB_BCM_PATCHRAM },
> 
> 	/* Foxconn - Hon Hai */
> 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),

same here, lets use USB_VENDOR_AND_INTERFACE_INFO and have an explanation on how to get the firmware.

Regards

Marcel

