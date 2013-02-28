Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Feb 2013 20:05:44 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 00/16] Bluetooth: Add HCI transaction framework
Message-ID: <20130228230544.GA25750@samus>
References: <1361951844-13719-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1361951844-13719-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 09:57 Wed 27 Feb, Johan Hedberg wrote:
> Hi,
> 
> Here's a revised set with the left-over init_last_cmd patch inserted
> where it belongs in the set.
> 
> The other changes are based on an (off-list) review from Gustavo
> Padovan, resulting in removing unnecessary _irqsave versions of spinlock
> functions (for the skb queue), adding a hci_ prefix to some static
> hci_core.c functions as well as really removing the HCI_PENDING_CLASS
> flag (and not just its users).

Just got this while pluging a controller while bluetoothd was already running
(don't know if this is relevant):

[  294.725077] usb 1-2: new full-speed USB device number 2 using uhci_hcd
[  294.880486] usb 1-2: New USB device found, idVendor=0409, idProduct=55aa
[  294.881671] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  294.882815] usb 1-2: Product: QEMU USB Hub
[  294.883476] usb 1-2: Manufacturer: QEMU
[  294.884092] usb 1-2: SerialNumber: 314159-0000:00:01.2-2
[  294.887922] hub 1-2:1.0: USB hub found
[  294.889696] hub 1-2:1.0: 8 ports detected
[  295.333565] usb 1-2.1: new full-speed USB device number 3 using uhci_hcd
[  295.590206] usb 1-2.1: New USB device found, idVendor=0a5c, idProduct=21e8
[  295.590928] usb 1-2.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  295.591799] usb 1-2.1: Product: BCM20702A0
[  295.592315] usb 1-2.1: Manufacturer: Broadcom Corp
[  295.592810] usb 1-2.1: SerialNumber: 000272D69969
[  295.627414] usbcore: registered new interface driver btusb
[  295.629706] 
[  295.630090] =================================
[  295.630668] [ INFO: inconsistent lock state ]
[  295.630668] 3.8.0-rc1-13045-g6303877 #1 Tainted: G        W   
[  295.630668] ---------------------------------
[  295.630668] inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
[  295.630668] swapper/1/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
[  295.630668]  (&(&list->lock)->rlock#5){?.+...}, at: [<ffffffff813c5a41>] skb_queue_tail+0x1c/0x46
[  295.630668] {HARDIRQ-ON-W} state was registered at:
[  295.630668]   [<ffffffff8106256e>] __lock_acquire+0x323/0xe85
[  295.630668]   [<ffffffff8106353f>] lock_acquire+0x93/0xb1
[  295.630668]   [<ffffffff814fd240>] _raw_spin_lock+0x40/0x74
[  295.630668]   [<ffffffffa0004345>] hci_transaction_run+0x4d/0xb3 [bluetooth]
[  295.630668]   [<ffffffffa000449a>] __hci_request+0xef/0x1c7 [bluetooth]
[  295.630668]   [<ffffffffa000565e>] hci_dev_open+0x15d/0x29a [bluetooth]
[  295.630668]   [<ffffffffa00057d6>] hci_power_on+0x3b/0x8a [bluetooth]
[  295.630668]   [<ffffffff8103eb46>] process_one_work+0x1c2/0x31b
[  295.630668]   [<ffffffff8103ef7e>] worker_thread+0x12e/0x1cc
[  295.630668]   [<ffffffff8104393d>] kthread+0x9d/0xa5
[  295.630668]   [<ffffffff814fe7bc>] ret_from_fork+0x7c/0xb0
[  295.630668] irq event stamp: 289936
[  295.630668] hardirqs last  enabled at (289933): [<ffffffff81008a7c>] default_idle+0x25/0x4a
[  295.630668] hardirqs last disabled at (289934): [<ffffffff814fdf2d>] common_interrupt+0x6d/0x72
[  295.630668] softirqs last  enabled at (289936): [<ffffffff810309f9>] _local_bh_enable+0xe/0x10
[  295.630668] softirqs last disabled at (289935): [<ffffffff81030fb5>] irq_enter+0x3f/0x71
[  295.630668] 
[  295.630668] other info that might help us debug this:
[  295.630668]  Possible unsafe locking scenario:
[  295.630668] 
[  295.630668]        CPU0
[  295.630668]        ----
[  295.630668]   lock(&(&list->lock)->rlock#5);
[  295.630668]   <Interrupt>
[  295.630668]     lock(&(&list->lock)->rlock#5);
[  295.630668] 
[  295.630668]  *** DEADLOCK ***
[  295.630668] 
[  295.630668] no locks held by swapper/1/0.
[  295.630668] 
[  295.630668] stack backtrace:
[  295.630668] Pid: 0, comm: swapper/1 Tainted: G        W    3.8.0-rc1-13045-g6303877 #1
[  295.630668] Call Trace:
[  295.630668]  <IRQ>  [<ffffffff814f6c7c>] print_usage_bug+0x1f7/0x208
[  295.630668]  [<ffffffff8100c3d6>] ? save_stack_trace+0x27/0x44
[  295.630668]  [<ffffffff81060548>] ? check_usage_backwards+0x96/0x96
[  295.630668]  [<ffffffff81060d45>] mark_lock+0x11b/0x247
[  295.630668]  [<ffffffff810624ff>] __lock_acquire+0x2b4/0xe85
[  295.630668]  [<ffffffff81060c57>] ? mark_lock+0x2d/0x247
[  295.630668]  [<ffffffff8106353f>] lock_acquire+0x93/0xb1
[  295.630668]  [<ffffffff813c5a41>] ? skb_queue_tail+0x1c/0x46
[  295.630668]  [<ffffffff810c2992>] ? __kmalloc_track_caller+0xf2/0x10a
[  295.630668]  [<ffffffff814fdccb>] _raw_spin_lock_irqsave+0x55/0x8f
[  295.630668]  [<ffffffff813c5a41>] ? skb_queue_tail+0x1c/0x46
[  295.630668]  [<ffffffff810583aa>] ? timekeeping_get_ns.constprop.10+0x12/0x38
[  295.630668]  [<ffffffff813c5a41>] skb_queue_tail+0x1c/0x46
[  295.630668]  [<ffffffffa000132f>] hci_recv_frame+0x57/0x71 [bluetooth]
[  295.630668]  [<ffffffffa0002422>] hci_reassembly+0x15d/0x196 [bluetooth]
[  295.630668]  [<ffffffffa00024f8>] hci_recv_fragment+0x41/0x66 [bluetooth]
[  295.630668]  [<ffffffffa006d31d>] btusb_intr_complete+0x8f/0x123 [btusb]
[  295.630668]  [<ffffffff81355f46>] usb_hcd_giveback_urb+0x76/0xbe
[  295.630668]  [<ffffffff813746b1>] uhci_giveback_urb+0x107/0x20c
[  295.630668]  [<ffffffff81060c57>] ? mark_lock+0x2d/0x247
[  295.630668]  [<ffffffff81374cfa>] uhci_scan_schedule+0x544/0x7b2
[  295.630668]  [<ffffffff81061c4b>] ? lock_acquired+0x1b5/0x1cf
[  295.630668]  [<ffffffff81376034>] uhci_irq+0xf4/0x10a
[  295.630668]  [<ffffffff813553bb>] usb_hcd_irq+0x41/0x75
[  295.630668]  [<ffffffff8107afaa>] handle_irq_event_percpu+0x2a/0x135
[  295.630668]  [<ffffffff8107b0f1>] handle_irq_event+0x3c/0x5f
[  295.630668]  [<ffffffff814fd26c>] ? _raw_spin_lock+0x6c/0x74
[  295.630668]  [<ffffffff8107d778>] ? handle_fasteoi_irq+0x19/0xb0
[  295.630668]  [<ffffffff8107d7d9>] handle_fasteoi_irq+0x7a/0xb0
[  295.630668]  [<ffffffff81003593>] handle_irq+0x1a/0x24
[  295.630668]  [<ffffffff810032aa>] do_IRQ+0x48/0xa0
[  295.630668]  [<ffffffff814fdf32>] common_interrupt+0x72/0x72
[  295.630668]  <EOI>  [<ffffffff8101eca3>] ? native_safe_halt+0x6/0x8
[  295.630668]  [<ffffffff810610c4>] ? trace_hardirqs_on+0xd/0xf
[  295.630668]  [<ffffffff81008a81>] default_idle+0x2a/0x4a
[  295.630668]  [<ffffffff8100920d>] cpu_idle+0x6a/0xb8
[  295.630668]  [<ffffffff814f0814>] start_secondary+0x21e/0x220


Cheers,
-- 
Vinicius
