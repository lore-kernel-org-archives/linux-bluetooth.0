Return-Path: <cyrus@holtmann.org>
Date: Thu, 1 Mar 2012 12:05:17 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btusb: Add USB device ID "0a5c 21e8"
Message-ID: <20120301150517.GA26261@joana>
References: <20120229234414.GA19829@joana>
 <1330608227-14636-1-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1330608227-14636-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi João,

* João Paulo Rechi Vita <jprvita@openbossa.org> [2012-03-01 10:23:47 -0300]:

> One more vendor-specific ID for BCM20702A0.
> 
> T:  Bus=01 Lev=03 Prnt=05 Port=02 Cnt=01 Dev#=  9 Spd=12  MxCh= 0
> D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0a5c ProdID=21e8 Rev=01.12
> S:  Manufacturer=Broadcom Corp
> S:  Product=BCM20702A0
> S:  SerialNumber=00027221F4E2
> C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)
> 
> Signed-off-by: João Paulo Rechi Vita <jprvita@openbossa.org>
> ---
>  drivers/bluetooth/btusb.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index c5606ef..b4d9d2f 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -102,6 +102,7 @@ static struct usb_device_id btusb_table[] = {
>  
>  	/* Broadcom BCM20702A0 */
>  	{ USB_DEVICE(0x0a5c, 0x21e3) },
> +	{ USB_DEVICE(0x0a5c, 0x21e8) },
>  	{ USB_DEVICE(0x0a5c, 0x21f3) },
>  	{ USB_DEVICE(0x413c, 0x8197) },

Acked-by: Gustavo F. Padovan <padovan@profusion.mobi>

	Gustavo
