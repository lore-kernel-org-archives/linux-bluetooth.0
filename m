Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH] Bluetooth: btusb: use irqsave() in URB's complete
 callback
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180619215657.13745-1-bigeasy@linutronix.de>
Date: Thu, 21 Jun 2018 14:43:41 +0200
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        linux-usb@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <66D1D85C-A671-45CF-BBB4-974E3063B9F3@holtmann.org>
References: <20180619215657.13745-1-bigeasy@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Greg Kroah-Hartman <greg@kroah.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

> The USB completion callback does not disable interrupts while acquiring
> the ->lock. We want to remove the local_irq_disable() invocation from
> __usb_hcd_giveback_urb() and therefore it is required for the callback
> handler to disable the interrupts while acquiring the lock.
> The callback may be invoked either in IRQ or BH context depending on the
> USB host controller.
> Use the _irqsave variant of the locking primitives.
> 
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: linux-bluetooth@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> drivers/bluetooth/btusb.c | 20 ++++++++++++--------
> 1 file changed, 12 insertions(+), 8 deletions(-)

can I get an ACK from someone ensuring that this is the direction we are going with the USB host controllers?

Regards

Marcel

