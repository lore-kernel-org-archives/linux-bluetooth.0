Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Apr 2010 08:55:55 -0700
From: "Luis R. Rodriguez" <lrodriguez@atheros.com>
To: Suraj Sumangala <Suraj.Sumangala@Atheros.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, Luis Rodriguez
	<Luis.Rodriguez@Atheros.com>, Jothikumar Mothilal
	<Jothikumar.Mothilal@Atheros.com>, "marcel@holtmann.org"
	<marcel@holtmann.org>, Vikram Kandukuri <Vikram.Kandukuri@Atheros.com>
Subject: Re: [PATCH] patch to request new firmware for AR3011 Chip
Message-ID: <20100427155555.GA7423@tux>
References: <1268629296.21425.23.camel@atheros013-desktop>
 <1271758832.6585.33.camel@atheros013-desktop>
 <1271845337.15010.1.camel@atheros013-desktop>
 <1271927414.1409.3.camel@atheros013-desktop>
 <1272279623.11239.1.camel@atheros013-desktop>
 <1272349190.1393.11.camel@atheros013-desktop>
 <1272356922.1393.14.camel@atheros013-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1272356922.1393.14.camel@atheros013-desktop>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Apr 27, 2010 at 01:28:42AM -0700, Suraj Sumangala wrote:
> 
> Signed-off-by: Vikram Kandukuri <vkandukuri@atheros.com>
> ---
>  drivers/bluetooth/ath3k.c |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
> index 128cae4..7bda549 100644
> --- a/drivers/bluetooth/ath3k.c
> +++ b/drivers/bluetooth/ath3k.c
> @@ -122,9 +122,12 @@ static int ath3k_probe(struct usb_interface *intf,
>  
>  	data->udev = udev;
>  
> -	if (request_firmware(&firmware, "ath3k-1.fw", &udev->dev) < 0) {
> -		kfree(data);
> -		return -EIO;
> +	if (request_firmware(&firmware, "ath3k-2.fw", &udev->dev) < 0) {
> +		BT_DBG("requesting old firmware");
> +		if (request_firmware(&firmware, "ath3k-1.fw", &udev->dev) < 0) {
> +			kfree(data);
> +			return -EIO;
> +		}
>  	}
>  
>  	size = max_t(uint, firmware->size, 4096);
> 

Looks OK but your subject should be something like:

[PATCH] ath3k: add support for new firmware

And your commit log is empty, other than your subject, please
be a little more descriptive. Describe what are the shiny new bells
and whistles added onto the new firmware. The more description
you can provide, the better.

  Luis
