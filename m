Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Mar 2013 10:46:05 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 00/16] Bluetooth: Add HCI transaction framework
Message-ID: <20130301084605.GA18044@x220.P-661HNU-F1>
References: <1361951844-13719-1-git-send-email-johan.hedberg@gmail.com>
 <20130228230544.GA25750@samus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130228230544.GA25750@samus>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Thu, Feb 28, 2013, Vinicius Costa Gomes wrote:
> [  295.630668]  (&(&list->lock)->rlock#5){?.+...}, at: [<ffffffff813c5a41>] skb_queue_tail+0x1c/0x46
> [  295.630668] {HARDIRQ-ON-W} state was registered at:
> [  295.630668]   [<ffffffff8106256e>] __lock_acquire+0x323/0xe85
> [  295.630668]   [<ffffffff8106353f>] lock_acquire+0x93/0xb1
> [  295.630668]   [<ffffffff814fd240>] _raw_spin_lock+0x40/0x74
> [  295.630668]   [<ffffffffa0004345>] hci_transaction_run+0x4d/0xb3 [bluetooth]
> [  295.630668]   [<ffffffffa000449a>] __hci_request+0xef/0x1c7 [bluetooth]
> [  295.630668]   [<ffffffffa000565e>] hci_dev_open+0x15d/0x29a [bluetooth]
> [  295.630668]   [<ffffffffa00057d6>] hci_power_on+0x3b/0x8a [bluetooth]
> [  295.630668]   [<ffffffff8103eb46>] process_one_work+0x1c2/0x31b
> [  295.630668]   [<ffffffff8103ef7e>] worker_thread+0x12e/0x1cc
> [  295.630668]   [<ffffffff8104393d>] kthread+0x9d/0xa5
> [  295.630668]   [<ffffffff814fe7bc>] ret_from_fork+0x7c/0xb0

Ok, so if I interpret that right it says that some lock in
hci_transaction_run (the only one it could be is the hdev->cmd_q one) is
deadlocking against a lock taken at:
[<ffffffff813c5a41>] skb_queue_tail+0x1c/0x46

Then, looking at the rest of the trace:

> [  295.630668]  [<ffffffff8106353f>] lock_acquire+0x93/0xb1
> [  295.630668]  [<ffffffff813c5a41>] ? skb_queue_tail+0x1c/0x46
> [  295.630668]  [<ffffffff810c2992>] ? __kmalloc_track_caller+0xf2/0x10a
> [  295.630668]  [<ffffffff814fdccb>] _raw_spin_lock_irqsave+0x55/0x8f
> [  295.630668]  [<ffffffff813c5a41>] ? skb_queue_tail+0x1c/0x46
> [  295.630668]  [<ffffffff810583aa>] ? timekeeping_get_ns.constprop.10+0x12/0x38
> [  295.630668]  [<ffffffff813c5a41>] skb_queue_tail+0x1c/0x46
> [  295.630668]  [<ffffffffa000132f>] hci_recv_frame+0x57/0x71 [bluetooth]
> [  295.630668]  [<ffffffffa0002422>] hci_reassembly+0x15d/0x196 [bluetooth]
> [  295.630668]  [<ffffffffa00024f8>] hci_recv_fragment+0x41/0x66 [bluetooth]
> [  295.630668]  [<ffffffffa006d31d>] btusb_intr_complete+0x8f/0x123 [btusb]

There we have the "[<ffffffff813c5a41>] ? skb_queue_tail+0x1c/0x46" call
which looks like the lock for hdev->rx_q that hci_recv_frame operates on
(hci_recv_frame is typically run in interrupt context).

This doesn't make any sense to me though. How could the lock for
hdev->rx_q deadlock with the lock for hdev->cmd_q? Those are two
different spinlocks. Or am I misinterpreting the backtrace?

Could this be a false-positive report from the kernel, i.e. did
everything work fine even though you got the report? What I could do is
bring back the _irqsave versions of the locking functions (something I
removed since Gustavo asked me to) in case that's what's causing this
deadlock report/warning to be generated.

Johan
