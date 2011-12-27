Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Tue, 27 Dec 2011 14:03:23 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Albert Pool <albertpool@solcon.nl>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] Add USB ID of HP's Broadcom BCM2035 Bluetooth
Message-ID: <20111227160323.GA8298@joana>
References: <1324728064.3074.5.camel@albert-ASUSTeK-P4P800SE>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1324728064.3074.5.camel@albert-ASUSTeK-P4P800SE>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Albert,

* Albert Pool <albertpool@solcon.nl> [2011-12-24 13:01:04 +0100]:

> Add USB ID of HP's Broadcom BCM2035 Bluetooth 03f0:011d
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
> 
> Signed-off-by: Albert Pool <albertpool@solcon.nl> 
> - - - 
> It now pairs to my laptop (which has the other HP device 03f0:171d) but does not yet pair to my desktop with 0a12:0001 Cambridge Silicon Radio dongle.
> I've also tried using BTUSB_WRONG_SCO_MTU, but with that setting it often failed to enable the device.
> This patch is at least an improvement as it used to pair to nothing at all. Perhaps anyone knows a better solution with which it pairs to everything just like on Windows XP?
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

Please fix this and resend. Also add "Bluetooth: " to your commit subject.


Applying: Add USB ID of HP's Broadcom BCM2035 Bluetooth
/home/padovan/p/linux-trees/bluetooth-next/.git/rebase-apply/patch:8: trailing whitespace.
        /* HP laptops with Broadcom chip */ 
/home/padovan/p/linux-trees/bluetooth-next/.git/rebase-apply/patch:9: trailing whitespace.
        { USB_DEVICE(0x03f0, 0x011d), .driver_info = BTUSB_BCM92035 }, 
error: drivers/bluetooth/btusb.c : does not exist in index
Patch failed at 0001 Add USB ID of HP's Broadcom BCM2035 Bluetooth

	Gustavo
