Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Oct 2010 16:56:05 -0400
From: "Luis R. Rodriguez" <lrodriguez@atheros.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Vikram <vkandukuri@atheros.com>, linux-bluetooth@vger.kernel.org,
	lrodriguez@atheros.com
Subject: Re: [PATCH] ath3k: add support for new firmware
Message-ID: <20101001205605.GA30496@bombadil.infradead.org>
References: <1275564023.19511.31.camel@ATH-LT-538>
 <1275586452.2182.30.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1275586452.2182.30.camel@localhost.localdomain>
Sender: "Luis R. Rodriguez" <mcgrof@infradead.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Jun 03, 2010 at 10:34:12AM -0700, Marcel Holtmann wrote:
> Hi Vikram,
> 
> > updated new firmware has few critical bug fixes and shared antenna
> > support.
> > 
> > Signed-off-by: Vikram Kandukuri <vkandukuri@atheros.com>
> > ---
> >  drivers/bluetooth/ath3k.c |    9 ++++++---
> >  1 files changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
> > index 128cae4..7bda549 100644
> > --- a/drivers/bluetooth/ath3k.c
> > +++ b/drivers/bluetooth/ath3k.c
> > @@ -122,9 +122,12 @@ static int ath3k_probe(struct usb_interface *intf,
> >  
> >  	data->udev = udev;
> >  
> > -	if (request_firmware(&firmware, "ath3k-1.fw", &udev->dev) < 0) {
> > -		kfree(data);
> > -		return -EIO;
> > +	if (request_firmware(&firmware, "ath3k-2.fw", &udev->dev) < 0) {
> > +		BT_DBG("requesting old firmware");
> > +		if (request_firmware(&firmware, "ath3k-1.fw", &udev->dev) < 0) {
> > +			kfree(data);
> > +			return -EIO;
> > +		}
> >  	}
> >  
> >  	size = max_t(uint, firmware->size, 4096);
> 
> can we just have a list of supported firmware in a table instead of just
> hardcoding this. I think something similar to what iwlwifi for WiFi has
> beend doing would be nice.

Vikram, you never followed up so this patch is not yet upstream....
Mind you, ath3k-2.fw is on the linux-firmware.git tree though.

  Luis
