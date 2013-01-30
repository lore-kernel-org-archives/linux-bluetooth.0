Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 Jan 2013 17:31:46 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/5] Bluetooth: Reduce critical section in sco_conn_ready
Message-ID: <20130130193146.GA31386@joana>
References: <1359500396-8184-1-git-send-email-andre.guedes@openbossa.org>
 <1359500396-8184-5-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1359500396-8184-5-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

* Andre Guedes <andre.guedes@openbossa.org> [2013-01-29 19:59:56 -0300]:

> This patch reduces the critical section protected by sco_conn_lock in
> sco_conn_ready function. The lock is acquired only when it is really
> needed.
> 
> This patch fixes the following lockdep warning which is generated
> when the host terminates a SCO connection.
> 
> Today, this warning is a false positive. There is no way those
> two threads reported by lockdep are running at the same time since
> hdev->workqueue (where rx_work is queued) is single-thread. However,
> if somehow this behavior is changed in future, we will have a
> potential deadlock.
> 
> ======================================================
> [ INFO: possible circular locking dependency detected ]
> 3.8.0-rc1+ #7 Not tainted
> -------------------------------------------------------
> kworker/u:1H/1018 is trying to acquire lock:
>  (&(&conn->lock)->rlock){+.+...}, at: [<ffffffffa0033ba6>] sco_chan_del+0x66/0x190 [bluetooth]
> 
> but task is already holding lock:
>  (slock-AF_BLUETOOTH-BTPROTO_SCO){+.+...}, at: [<ffffffffa0033d5a>] sco_conn_del+0x8a/0xe0 [bluetooth]
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (slock-AF_BLUETOOTH-BTPROTO_SCO){+.+...}:
>        [<ffffffff81083011>] lock_acquire+0xb1/0xe0
>        [<ffffffff813efd01>] _raw_spin_lock+0x41/0x80
>        [<ffffffffa003436e>] sco_connect_cfm+0xbe/0x350 [bluetooth]
>        [<ffffffffa0015d6c>] hci_event_packet+0xd3c/0x29b0 [bluetooth]
>        [<ffffffffa0004583>] hci_rx_work+0x133/0x870 [bluetooth]
>        [<ffffffff8104d65f>] process_one_work+0x2bf/0x4f0
>        [<ffffffff81050022>] worker_thread+0x2b2/0x3e0
>        [<ffffffff81056021>] kthread+0xd1/0xe0
>        [<ffffffff813f14bc>] ret_from_fork+0x7c/0xb0
> 
> -> #0 (&(&conn->lock)->rlock){+.+...}:
>        [<ffffffff81082215>] __lock_acquire+0x1465/0x1c70
>        [<ffffffff81083011>] lock_acquire+0xb1/0xe0
>        [<ffffffff813efd01>] _raw_spin_lock+0x41/0x80
>        [<ffffffffa0033ba6>] sco_chan_del+0x66/0x190 [bluetooth]
>        [<ffffffffa0033d6d>] sco_conn_del+0x9d/0xe0 [bluetooth]
>        [<ffffffffa0034653>] sco_disconn_cfm+0x53/0x60 [bluetooth]
>        [<ffffffffa000fef3>] hci_disconn_complete_evt.isra.54+0x363/0x3c0 [bluetooth]
>        [<ffffffffa00150f7>] hci_event_packet+0xc7/0x29b0 [bluetooth]
>        [<ffffffffa0004583>] hci_rx_work+0x133/0x870 [bluetooth]
>        [<ffffffff8104d65f>] process_one_work+0x2bf/0x4f0
>        [<ffffffff81050022>] worker_thread+0x2b2/0x3e0
>        [<ffffffff81056021>] kthread+0xd1/0xe0
>        [<ffffffff813f14bc>] ret_from_fork+0x7c/0xb0
> 
> other info that might help us debug this:
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(slock-AF_BLUETOOTH-BTPROTO_SCO);
>                                lock(&(&conn->lock)->rlock);
>                                lock(slock-AF_BLUETOOTH-BTPROTO_SCO);
>   lock(&(&conn->lock)->rlock);
> 
>  *** DEADLOCK ***
> 
> 4 locks held by kworker/u:1H/1018:
>  #0:  (hdev->name#2){.+.+.+}, at: [<ffffffff8104d5f8>] process_one_work+0x258/0x4f0
>  #1:  ((&hdev->rx_work)){+.+.+.}, at: [<ffffffff8104d5f8>] process_one_work+0x258/0x4f0
>  #2:  (&hdev->lock){+.+.+.}, at: [<ffffffffa000fbe9>] hci_disconn_complete_evt.isra.54+0x59/0x3c0 [bluetooth]
>  #3:  (slock-AF_BLUETOOTH-BTPROTO_SCO){+.+...}, at: [<ffffffffa0033d5a>] sco_conn_del+0x8a/0xe0 [bluetooth]
> 
> stack backtrace:
> Pid: 1018, comm: kworker/u:1H Not tainted 3.8.0-rc1+ #7
> Call Trace:
>  [<ffffffff813e92f9>] print_circular_bug+0x1fb/0x20c
>  [<ffffffff81082215>] __lock_acquire+0x1465/0x1c70
>  [<ffffffff81083011>] lock_acquire+0xb1/0xe0
>  [<ffffffffa0033ba6>] ? sco_chan_del+0x66/0x190 [bluetooth]
>  [<ffffffff813efd01>] _raw_spin_lock+0x41/0x80
>  [<ffffffffa0033ba6>] ? sco_chan_del+0x66/0x190 [bluetooth]
>  [<ffffffffa0033ba6>] sco_chan_del+0x66/0x190 [bluetooth]
>  [<ffffffffa0033d6d>] sco_conn_del+0x9d/0xe0 [bluetooth]
>  [<ffffffffa0034653>] sco_disconn_cfm+0x53/0x60 [bluetooth]
>  [<ffffffffa000fef3>] hci_disconn_complete_evt.isra.54+0x363/0x3c0 [bluetooth]
>  [<ffffffffa000fbd0>] ? hci_disconn_complete_evt.isra.54+0x40/0x3c0 [bluetooth]
>  [<ffffffffa00150f7>] hci_event_packet+0xc7/0x29b0 [bluetooth]
>  [<ffffffff81202e90>] ? __dynamic_pr_debug+0x80/0x90
>  [<ffffffff8133ff7d>] ? kfree_skb+0x2d/0x40
>  [<ffffffffa0021644>] ? hci_send_to_monitor+0x1a4/0x1c0 [bluetooth]
>  [<ffffffffa0004583>] hci_rx_work+0x133/0x870 [bluetooth]
>  [<ffffffff8104d5f8>] ? process_one_work+0x258/0x4f0
>  [<ffffffff8104d65f>] process_one_work+0x2bf/0x4f0
>  [<ffffffff8104d5f8>] ? process_one_work+0x258/0x4f0
>  [<ffffffff8104fdc1>] ? worker_thread+0x51/0x3e0
>  [<ffffffffa0004450>] ? hci_tx_work+0x800/0x800 [bluetooth]
>  [<ffffffff81050022>] worker_thread+0x2b2/0x3e0
>  [<ffffffff8104fd70>] ? busy_worker_rebind_fn+0x100/0x100
>  [<ffffffff81056021>] kthread+0xd1/0xe0
>  [<ffffffff81055f50>] ? flush_kthread_worker+0xc0/0xc0
>  [<ffffffff813f14bc>] ret_from_fork+0x7c/0xb0
>  [<ffffffff81055f50>] ? flush_kthread_worker+0xc0/0xc0
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> 
> This lockdep warning has been around for a long time. I could test
> until Linux 3.4, but it seems it is older than that. However, in
> current bluetooth-next, this warning has been masked by commit
> 53502d69be49e3dd5bc95ab0f2deeaea260bd617 which introduced a bug in
> SCO socket shutdown routine.
> 
> The bug in SCO socket shutdown routine has been fixed by patch 02/05
> from this patchset.
> 
>  net/bluetooth/sco.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
