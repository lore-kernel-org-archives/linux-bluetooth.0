Return-Path: <tglx@linutronix.de>
Date: Thu, 31 Aug 2017 16:56:37 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc: Mart van de Wege <mvdwege@gmail.com>,
    Marcel Holtmann <marcel@holtmann.org>,
    Johan Hedberg <johan.hedberg@intel.com>,
    Gustavo Padovan <gustavo@padovan.org>, linux-bluetooth@vger.kernel.org,
    linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
    Peter Zijlstra <peterz@infradead.org>
Subject: Re: Possible BT deadlock due to recursive read locking (Was: Re:
 kernel BUG at kernel/locking/rtmutex.c:1059)
In-Reply-To: <20170831145211.xlu6cvocqdkzevsl@linutronix.de>
Message-ID: <alpine.DEB.2.20.1708311654240.1874@nanos>
References: <86val4928u.fsf@gaheris.avalon.lan> <20170831145211.xlu6cvocqdkzevsl@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 31 Aug 2017, Sebastian Andrzej Siewior wrote:

> On 2017-08-30 23:25:53 [+0200], Mart van de Wege wrote:
> > Hi,
> Hi,
> 
> > The issue persists up to v4.11.12-rt10
> Does
> 	CONFIG_RWLOCK_RT_READER_BIASED=y
> make it go away?
> 
> > Stacktrace:
> > 
> > Aug 29 17:28:04 localhost kernel: [   46.483810] ------------[ cut here ]------------
> > Aug 29 17:28:04 localhost kernel: [   46.483812] kernel BUG at kernel/locking/rtmutex.c:1059!
> 
> this is a deadlock on RT however !RT has a hidden problem which not
> yelled at by lockdep. We have the following call path:
> 
> | hci_send_monitor_ctrl_event()
> |   read_lock(&hci_sk_list.lock);
> |
> |   hci_send_to_channel()
> |      read_lock(&hci_sk_list.lock);
> 
> So both functions acquire the same read_lock. If a write comes along
> between the first read_lock() and second read_lock() then we have a
> deadlock because the write_lock() will lock down further readers from
> acquiring the read-lock until the writer completed its task.
> 
> This recursive locking was introduced in 38ceaa00d02d ("Bluetooth: Add
> support for sending MGMT commands and events to monitor").

Just for clarification: This is a mainline issue because qrlock based
rwlocks are writer fair, while the traditional rwlocks are reader
biased. Lockdep does not yell about it yet, because the wrapper function
use read-recursive mode.

Thanks,

	tglx
