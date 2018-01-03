Return-Path: <foo00@h08.hostsharing.net>
Date: Wed, 3 Jan 2018 14:56:53 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Frederic Danis <frederic.danis.oss@gmail.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>, Max Shavrick <mxms@me.com>,
	Leif Liddy <leif.liddy@gmail.com>,
	Daniel Roschka <danielroschka@phoenitydawn.de>,
	Ronald Tschalaer <ronald@innovation.ch>,
	"Peter Y. Chuang" <peteryuchuang@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 06/10] Bluetooth: hci_bcm: Silence IRQ printk
Message-ID: <20180103135653.GA31810@wunner.de>
References: <cover.1514916630.git.lukas@wunner.de>
 <ae2d4efbe3ffbaf8b979f1b8a192cbb17d97499d.1514916630.git.lukas@wunner.de>
 <1514984939.7000.571.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1514984939.7000.571.camel@linux.intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jan 03, 2018 at 03:08:59PM +0200, Andy Shevchenko wrote:
> On Tue, 2018-01-02 at 20:08 +0100, Lukas Wunner wrote:
> > @@ -798,7 +798,7 @@ static int bcm_get_resources(struct bcm_device
> > *dev)
> >  		dev->irq = gpiod_to_irq(gpio);
> >  	}
> >  
> > -	dev_info(dev->dev, "BCM irq: %d\n", dev->irq);
> > +	dev_dbg(dev->dev, "BCM irq: %d\n", dev->irq);
> 
> Perhaps, instead you may add same check
> 
> if (dev->irq > 0)
>  dev_info(...);
> else
>  dev_info(..., "BCM irq not in use\n");
> 
> ?

gpiod_to_irq() returns different negative errnos depending on the exact
error condition.  We wouldn't be able to easily differentiate them if
we do it this way.

Thanks,

Lukas
