Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1514995533.7000.574.camel@linux.intel.com>
Subject: Re: [PATCH v2 06/10] Bluetooth: hci_bcm: Silence IRQ printk
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Frederic Danis <frederic.danis.oss@gmail.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Max Shavrick <mxms@me.com>, Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        Ronald Tschalaer <ronald@innovation.ch>,
        "Peter Y. Chuang" <peteryuchuang@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date: Wed, 03 Jan 2018 18:05:33 +0200
In-Reply-To: <20180103135653.GA31810@wunner.de>
References: <cover.1514916630.git.lukas@wunner.de>
         <ae2d4efbe3ffbaf8b979f1b8a192cbb17d97499d.1514916630.git.lukas@wunner.de>
         <1514984939.7000.571.camel@linux.intel.com>
         <20180103135653.GA31810@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2018-01-03 at 14:56 +0100, Lukas Wunner wrote:
> On Wed, Jan 03, 2018 at 03:08:59PM +0200, Andy Shevchenko wrote:
> > On Tue, 2018-01-02 at 20:08 +0100, Lukas Wunner wrote:

> > > -	dev_info(dev->dev, "BCM irq: %d\n", dev->irq);
> > > +	dev_dbg(dev->dev, "BCM irq: %d\n", dev->irq);
> > 
> > Perhaps, instead you may add same check
> > 
> > if (dev->irq > 0)
> >  dev_info(...);
> > else
> >  dev_info(..., "BCM irq not in use\n");

dev_dbg(..., "... (rc: %d)\n", dev->irq);

?

But okay, it's a bikeshedding, when something goes wrong the debug is
the first on the plate to enable anyway.

> gpiod_to_irq() returns different negative errnos depending on the
> exact
> error condition.  We wouldn't be able to easily differentiate them if
> we do it this way.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
