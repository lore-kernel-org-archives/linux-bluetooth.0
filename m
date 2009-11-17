Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Nov 2009 11:11:12 -0800
From: "Luis R. Rodriguez" <lrodriguez@atheros.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Vikram Kandukuri <Vikram.Kandukuri@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Luis
 Rodriguez <Luis.Rodriguez@Atheros.com>
Subject: Re: [PATCH] DFU Driver and firmware for Atheros bluetooth chipset
	AR3011
Message-ID: <20091117191112.GD11382@tux>
References: <20091117143613.GA29705@atheros-laptop> <1258469940.2003.25.camel@violet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1258469940.2003.25.camel@violet>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Nov 17, 2009 at 06:59:00AM -0800, Marcel Holtmann wrote:
> > +MODULE_AUTHOR("Atheros Communications");
> > +MODULE_DESCRIPTION("Atheros AR3011 firmware driver");
> > +MODULE_VERSION(DRV_VERSION);
> > +MODULE_SUPPORTED_DEVICE("Atheros AR3011 chipset");
> > +MODULE_LICENSE("GPL");
> > +MODULE_FIRMWARE("atherosbt.bin");
> 
> The
> module author needs to have a contact information and not just the
> company name. Read it as who maintains this driver.

This is probably just following what we have on ath9k / ath9k_common / ath9k_hw / ath
modules which so far no one has asked us to change:

MODULE_AUTHOR("Atheros Communications");
MODULE_DESCRIPTION("Support for Atheros 802.11n wireless LAN cards.");
MODULE_SUPPORTED_DEVICE("Atheros 802.11n WLAN cards");
MODULE_LICENSE("Dual BSD/GPL");

Using one contact point for ath9k stuff doesn't work for us as we have a group
and for that the MAINTAINERS file seems just suitable. Plus -- some module authors
are sometimes not the current maintainers so the MDOULE_AUTHOR really doesn't mean
much. Wouldn't updating the MAINTAINERS file accordingly be better?

Also Vikram -- why not just ISC license the files as we do with ath9k ? Then also
use:

MODULE_LICENSE("Dual BSD/GPL");

This would be more consistant with what we do with our other upstream Atheros
modules.

  Luis
