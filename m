Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Subject: Re: [PATCH v2] Bluetooth: hci_ldisc: Allow sleeping while proto locks
 are held.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20171026051453.GA15910@innovation.ch>
Date: Sun, 29 Oct 2017 14:04:50 +0100
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Dean Jenkins <Dean_Jenkins@mentor.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Message-Id: <8C1DB14E-95C7-4B2C-8D5B-047787C28435@holtmann.org>
References: <20171026051453.GA15910@innovation.ch>
To: =?us-ascii?B?PT9VVEYtOD9xP1JvbmFsZD0yMFRzY2hhbD1DMz1BNHI/PQ==?=
        <ronald@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ronald,

> Commit dec2c92880cc5435381d50e3045ef018a762a917 ("Bluetooth: hci_ldisc:
> Use rwlocking to avoid closing proto races") introduced locks in
> hci_ldisc that are held while calling the proto functions. These locks
> are rwlock's, and hence do not allow sleeping while they are held.
> However, the proto functions that hci_bcm registers use mutexes and
> hence need to be able to sleep.
> 
> In more detail: hci_uart_tty_receive() and hci_uart_dequeue() both
> acquire the rwlock, after which they call proto->recv() and
> proto->dequeue(), respectively. In the case of hci_bcm these point to
> bcm_recv() and bcm_dequeue(). The latter both acquire the
> bcm_device_lock, which is a mutex, so doing so results in a call to
> might_sleep(). But since we're holding a rwlock in hci_ldisc, that
> results in the following BUG (this for the dequeue case - a similar
> one for the receive case is omitted for brevity):
> 
>  BUG: sleeping function called from invalid context at kernel/locking/mutex.c
>  in_atomic(): 1, irqs_disabled(): 0, pid: 7303, name: kworker/7:3
>  INFO: lockdep is turned off.
>  CPU: 7 PID: 7303 Comm: kworker/7:3 Tainted: G        W  OE   4.13.2+ #17
>  Hardware name: Apple Inc. MacBookPro13,3/Mac-A5C67F76ED83108C, BIOS MBP133.8
>  Workqueue: events hci_uart_write_work [hci_uart]
>  Call Trace:
>   dump_stack+0x8e/0xd6
>   ___might_sleep+0x164/0x250
>   __might_sleep+0x4a/0x80
>   __mutex_lock+0x59/0xa00
>   ? lock_acquire+0xa3/0x1f0
>   ? lock_acquire+0xa3/0x1f0
>   ? hci_uart_write_work+0xd3/0x160 [hci_uart]
>   mutex_lock_nested+0x1b/0x20
>   ? mutex_lock_nested+0x1b/0x20
>   bcm_dequeue+0x21/0xc0 [hci_uart]
>   hci_uart_write_work+0xe6/0x160 [hci_uart]
>   process_one_work+0x253/0x6a0
>   worker_thread+0x4d/0x3b0
>   kthread+0x133/0x150
> 
> We can't replace the mutex in hci_bcm, because there are other calls
> there that might sleep. Therefore this replaces the rwlock's in
> hci_ldisc with rw_semaphore's (which allow sleeping). This is a safer
> approach anyway as it reduces the restrictions on the proto callbacks.
> Also, because acquiring write-lock is very rare compared to acquiring
> the read-lock, the percpu variant of rw_semaphore is used.
> 
> Lastly, because hci_uart_tx_wakeup() may be called from an IRQ context,
> we can't block (sleep) while trying acquire the read lock there, so we
> use the trylock variant.
> 
> Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Gustavo Padovan <gustavo@padovan.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: Dean Jenkins <Dean_Jenkins@mentor.com>
> ---
> Changes in v2:
>  - Add back locking in hci_uart_tx_wakeup(). Removing the locking
>    altogether there was wrong, as nicely pointed out by Dean Jenkins.
> 
> drivers/bluetooth/hci_ldisc.c | 38 ++++++++++++++++++++++----------------
> drivers/bluetooth/hci_uart.h  |  2 +-
> 2 files changed, 23 insertions(+), 17 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
