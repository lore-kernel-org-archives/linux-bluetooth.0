Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Oct 2014 15:36:31 +0200
From: Alexander Aring <alex.aring@gmail.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Incorrect locking when sending data in softirq
Message-ID: <20141015133629.GA17138@omega>
References: <1413376985-25812-1-git-send-email-jukka.rissanen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1413376985-25812-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

I am not sure but I think this issue occurs because the bt_xmit callback
is called in an atomic context.

The function hci_queue_acl seems to be some function which is used in
some others context which isn't an atomic context, means maybe in
some workqueue context or something else, where "might_sleep()" is
allowed. Simple this function isn't irqsafe.

With this patch you would make it allowed that this function can called
inside of an "atomic context", so you make it irqsafe.

By changing these locking mechanism to spin_lock_irqsave/spin_unlock_irqrestore
you need to be sure that all others which locks the queue->lock should
also call spin_lock_irqsave/spin_unlock_irqrestore and not
spin_lock/spin_unlock anymore.

This would be a huge design change in bluetooth, maybe the bluetooth
maintainers will ack this, I don't know. Maybe there exist also some
other calling path where "might_sleep()" is allowed and you have the
issue again.



Another "possible" solution would be a similar function but this is irqsafe.
Maybe "hci_queue_acl_irqsafe". I don't know how possible that is, simple
that not every context call the spin_foo_irqave functions. If the lock
is used somewhere else... this would be hard to solve to change
spin__foo/spin_foo_irqsave.




A second "possible" easy solution would maybe that bt_xmit setups a
workqueue, at the end of the xmit call you should schedule the workqueue
then. But this is a terrible solution, because you lost all context
information from bt_xmit calls (atomic context, lockings, etc...), also
that "might_sleep()" is allowed while transmit isn't nice.

We have the same issue in 802.15.4 because some driver calls spi_sync(),
then we start a workqueue for it and run the work callback afterwards
which calls spi_sync at least.

spi_sync is just a framework above spi_async with some fancy scheduler
function like wait_for_completion. We can't run spi_sync in the xmit
function because this call wait_for_completion ("might_sleep()") and
this isn't allowed in atomic context.



I don't can't say what you need to do here. I only want to let you know
my suggestions to this patch.

- Alex
