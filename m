Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Added support for bluetooth controller shipped with
 iMac i5
From: Marcel Holtmann <marcel@holtmann.org>
To: Cyril Lacoux <clacoux@ifeelgood.org>
Cc: linux-bluetooth@vger.kernel.org,
	Cyril Lacoux <clacoux@easter-eggs.com>
In-Reply-To: <1278671689-9444-1-git-send-email-clacoux@ifeelgood.org>
References: <1278671689-9444-1-git-send-email-clacoux@ifeelgood.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 09 Jul 2010 10:21:18 -0300
Message-ID: <1278681678.10421.114.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Cyril,

> Device class is ff(vend.) instead of e0(wlcon).
> 
> Output from command `usb-devices`:
> T:  Bus=01 Lev=03 Prnt=03 Port=00 Cnt=01 Dev#=  6 Spd=12  MxCh= 0
> D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=05ac ProdID=8215 Rev=01.82
> S:  Manufacturer=Apple Inc.
> S:  Product=Bluetooth USB Host Controller
> S:  SerialNumber=7C6D62936607
> C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)

you need to add a Signed-off-by: line here.

> ---
>  drivers/bluetooth/btusb.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 5d9cc53..8eb6be5 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -75,6 +75,9 @@ static struct usb_device_id btusb_table[] = {
>  	/* Canyon CN-BTU1 with HID interfaces */
>  	{ USB_DEVICE(0x0c10, 0x0000) },
>  
> +	/* Apple iMac11,1 */
> +	{ USB_DEVICE(0x05ac, 0x8215) },
> +

And since this a more likely device since all the other ones that are
not even sold anymore, just put it after the generic entry and before
the AVM one.

Regards

Marcel


