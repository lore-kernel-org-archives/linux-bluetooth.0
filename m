Return-Path: <bigeasy@linutronix.de>
Date: Sun, 1 Jul 2018 17:19:41 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <greg@kroah.com>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	linux-usb@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: use irqsave() in URB's complete
 callback
Message-ID: <20180701151940.cbtbgpv3vncwugqz@linutronix.de>
References: <20180621125207.7xtz2jpnp2vdvaau@linutronix.de>
 <Pine.LNX.4.44L0.1806211130460.2381-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <Pine.LNX.4.44L0.1806211130460.2381-100000@iolanthe.rowland.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On 2018-06-21 11:34:15 [-0400], Alan Stern wrote:
> On Thu, 21 Jun 2018, Sebastian Andrzej Siewior wrote:
> 
> > On 2018-06-21 14:43:41 [+0200], Marcel Holtmann wrote:
> > > can I get an ACK from someone ensuring that this is the direction we are going with the USB host controllers?
> > +Alan.
> > 
> > EHCI completes in BH since v3.12-rc1. In order to get rid of that
> > local_irq_save() in USB core code I need to make sure that the USB
> > device driver(s) use irqsave primitives. See
> >   https://lkml.kernel.org/r/Pine.LNX.4.44L0.1806011629140.1404-100000@iolanthe.rowland.org
> 
> Hi, Marcel!
Hi Marcel,

> Yes, Sebastian is right.  We are aiming to make it possible for the USB 
> core to invoke URB completion handlers with interrupts enabled, in 
> order to reduce latency (since USB interrupt processing can take a 
> fairly long time).  And of course, this means completion handlers have 
> to work correctly regardless of whether interrupts are enabled or 
> disabled.

I don't see this patch in linux-next. Do you still need some kind of
confirmation or has this been resolved?

> Currently ehci-hcd supports this possibility.  Other host controller 
> drivers may follow along; I'd like to see xhci-hcd do this too.
> 
> Alan Stern

Sebastian
