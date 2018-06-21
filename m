Return-Path: <stern+5b37fb5a@rowland.harvard.edu>
Date: Thu, 21 Jun 2018 11:34:15 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc: Marcel Holtmann <marcel@holtmann.org>, Greg Kroah-Hartman <greg@kroah.com>,
    "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
     <linux-usb@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
    Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: use irqsave() in URB's complete callback
In-Reply-To: <20180621125207.7xtz2jpnp2vdvaau@linutronix.de>
Message-ID: <Pine.LNX.4.44L0.1806211130460.2381-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 21 Jun 2018, Sebastian Andrzej Siewior wrote:

> On 2018-06-21 14:43:41 [+0200], Marcel Holtmann wrote:
> > Hi Sebastian,
> Hi Marcel,
> 
> > > The USB completion callback does not disable interrupts while acquiring
> > > the ->lock. We want to remove the local_irq_disable() invocation from
> > > __usb_hcd_giveback_urb() and therefore it is required for the callback
> > > handler to disable the interrupts while acquiring the lock.
> > > The callback may be invoked either in IRQ or BH context depending on the
> > > USB host controller.
> > > Use the _irqsave variant of the locking primitives.
> > > 
> > > Cc: Marcel Holtmann <marcel@holtmann.org>
> > > Cc: Johan Hedberg <johan.hedberg@gmail.com>
> > > Cc: linux-bluetooth@vger.kernel.org
> > > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > ---
> > > drivers/bluetooth/btusb.c | 20 ++++++++++++--------
> > > 1 file changed, 12 insertions(+), 8 deletions(-)
> > 
> > can I get an ACK from someone ensuring that this is the direction we are going with the USB host controllers?
> +Alan.
> 
> EHCI completes in BH since v3.12-rc1. In order to get rid of that
> local_irq_save() in USB core code I need to make sure that the USB
> device driver(s) use irqsave primitives. See
>   https://lkml.kernel.org/r/Pine.LNX.4.44L0.1806011629140.1404-100000@iolanthe.rowland.org

Hi, Marcel!

Yes, Sebastian is right.  We are aiming to make it possible for the USB 
core to invoke URB completion handlers with interrupts enabled, in 
order to reduce latency (since USB interrupt processing can take a 
fairly long time).  And of course, this means completion handlers have 
to work correctly regardless of whether interrupts are enabled or 
disabled.

Currently ehci-hcd supports this possibility.  Other host controller 
drivers may follow along; I'd like to see xhci-hcd do this too.

Alan Stern
