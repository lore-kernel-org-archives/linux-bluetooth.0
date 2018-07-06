Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH] Bluetooth: btusb: use irqsave() in URB's complete
 callback
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180619215657.13745-1-bigeasy@linutronix.de>
Date: Fri, 6 Jul 2018 12:46:22 +0200
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <7C7F6423-3DFE-47F7-9A68-31817C1A3DC5@holtmann.org>
References: <20180619215657.13745-1-bigeasy@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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

patch has been applied to bluetooth-next tree.

Regards

Marcel

