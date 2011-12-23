Return-Path: <cyrus@holtmann.org>
Message-ID: <1324660011.1965.260.camel@aeonflux>
Subject: Re: [PATCH v2] Add USB ID of HP's Broadcom BCM2035 Bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: Albert Pool <albertpool@solcon.nl>
Cc: padovan@profusion.mobi, linux-bluetooth@vger.kernel.org
Date: Fri, 23 Dec 2011 09:06:51 -0800
In-Reply-To: <1324636919.2912.0.camel@albert-ASUSTeK-P4P800SE>
References: <1324636919.2912.0.camel@albert-ASUSTeK-P4P800SE>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Albert,

> Add USB ID of HP's Broadcom BCM2035 Bluetooth 03f0:011d
> 
> Signed-off-by: Albert Pool <albertpool@solcon.nl> 
> - - - 
> With this patch the Bluetooth device of the HP Compaq nc6120 is able to pair to other devices.
> I've also tried using BTUSB_WRONG_SCO_MTU, but with that setting it often failed to enable the device.
> 
> From usb-devices:
> T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=03f0 ProdID=011d Rev=00.17
> S:  Manufacturer=Broadcom
> S:  Product=HP integrated Bluetooth module
> C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)

both comments can go into the commit message (above ---). Just the "I
don't know if this patch is correct" thing is a comment that should have
been here.

> 
> --- a/drivers/bluetooth/btusb.c 
> +++ b/drivers/bluetooth/btusb.c 
> @@ -142,7 +142,8 @@ static struct usb_device_id blacklist_ta 
>  	{ USB_DEVICE(0x0a5c, 0x201e), .driver_info = BTUSB_WRONG_SCO_MTU }, 
>  	{ USB_DEVICE(0x0a5c, 0x2110), .driver_info = BTUSB_WRONG_SCO_MTU }, 
>  
> -	/* HP laptop with Broadcom chip */ 
> +	/* HP laptops with Broadcom chip */ 
> +	{ USB_DEVICE(0x03f0, 0x011d), .driver_info = BTUSB_BCM92035 }, 
>  	{ USB_DEVICE(0x03f0, 0x171d), .driver_info = BTUSB_WRONG_SCO_MTU }, 
>  
>  	/* Dell laptop with Broadcom chip */ 

Regards

Marcel


