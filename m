Return-Path: <cyrus@holtmann.org>
Date: Tue, 18 Sep 2012 20:18:20 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: AceLan Kao <acelan.kao@canonical.com>
Cc: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH] Bluetooth: Add support for BCM20702A0 [0a5c:21f1]
Message-ID: <20120918231820.GB24689@joana>
References: <1347871235-11538-1-git-send-email-acelan.kao@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1347871235-11538-1-git-send-email-acelan.kao@canonical.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi AceLan,

* AceLan Kao <acelan.kao@canonical.com> [2012-09-17 16:40:35 +0800]:

> Add another vendor specific ID for BCM20702A0.
> 
> output of usb-devices:
> T:  Bus=02 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
> D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0a5c ProdID=21f1 Rev=01.12
> S:  Manufacturer=Broadcom Corp
> S:  Product=BCM20702A0
> S:  SerialNumber=9CB70D807395
> C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)
> 
> Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
> ---
>  drivers/bluetooth/btusb.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index f637c25..817f661 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -99,6 +99,7 @@ static struct usb_device_id btusb_table[] = {
>  	{ USB_DEVICE(0x0a5c, 0x21e8) },
>  	{ USB_DEVICE(0x0a5c, 0x21f3) },
>  	{ USB_DEVICE(0x413c, 0x8197) },
> +	{ USB_DEVICE(0x0a5c, 0x21f1) },
>  
>  	/* Foxconn - Hon Hai */
>  	{ USB_DEVICE(0x0489, 0xe033) },

This patch is not needed anymore, we already supports it in latest
bluetooth.git tree.

	Gustavo
