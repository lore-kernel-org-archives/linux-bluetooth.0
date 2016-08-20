Return-Path: <larry.finger@gmail.com>
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: Memory (skb) leak in kernel 4.8-rc2
To: Marcel Holtmann <marcel@holtmann.org>
References: <a62119eb-28d2-7b4d-acbb-6ca8d3a0c91d@lwfinger.net>
 <A07D8003-F1EB-4408-A3F2-E043DF678296@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
From: Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <8c4d8931-7ebf-0357-6992-ac5551593ed3@lwfinger.net>
Date: Sat, 20 Aug 2016 11:24:23 -0500
MIME-Version: 1.0
In-Reply-To: <A07D8003-F1EB-4408-A3F2-E043DF678296@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 08/20/2016 01:01 AM, Marcel Holtmann wrote:
> Hi Larry,
>
> I can not see a leak. Maybe Johan has an idea.

Marcel and Johan,

The hardware in question is an Intel device with USB ID 8087:07dc, which is part 
of an Intel Wireless 7260.

The kmemleak backtraces for the two kinds of leaks are:

unreferenced object 0xffff8801e182e000 (size 1024):
   comm "hardirq", pid 0, jiffies 4312467853 (age 61.716s)
   hex dump (first 32 bytes):
     00 84 82 e1 01 88 ff ff 0e 04 01 10 20 00 20 00  ............ . .
     05 06 02 00 00 05 00 00 40 00 40 00 00 00 00 00  ........@.@.....
   backtrace:
     [<ffffffff8169ef8a>] kmemleak_alloc+0x4a/0xa0
     [<ffffffff811e9b18>] __kmalloc_node_track_caller+0x178/0x270
     [<ffffffff815acb41>] __kmalloc_reserve.isra.35+0x31/0x90
     [<ffffffff815aec3e>] __alloc_skb+0x7e/0x280
     [<ffffffffa04c54bb>] btusb_recv_intr+0x12b/0x170 [btusb]
     [<ffffffffa04c55c5>] btusb_intr_complete+0xc5/0x130 [btusb]
     [<ffffffffa00a6f45>] __usb_hcd_giveback_urb+0x85/0x110 [usbcore]
     [<ffffffffa00a70df>] usb_hcd_giveback_urb+0x3f/0x130 [usbcore]
     [<ffffffffa0163cfa>] handle_tx_event+0x4ca/0x13c0 [xhci_hcd]
     [<ffffffffa0164e62>] xhci_irq+0x272/0xa30 [xhci_hcd]
     [<ffffffffa0165631>] xhci_msi_irq+0x11/0x20 [xhci_hcd]
     [<ffffffff810cb42f>] __handle_irq_event_percpu+0x3f/0x1d0
     [<ffffffff810cb5e3>] handle_irq_event_percpu+0x23/0x60
     [<ffffffff810cb65c>] handle_irq_event+0x3c/0x60
     [<ffffffff810ced0b>] handle_edge_irq+0x9b/0x160
     [<ffffffff8101e340>] handle_irq+0x20/0x30

unreferenced object 0xffff88010ccbd200 (size 256):
   comm "kworker/u17:2", pid 684, jiffies 4312467853 (age 61.716s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     1e c6 5f 75 10 90 6c 14 00 00 00 00 00 00 00 00  .._u..l.........
   backtrace:
     [<ffffffff8169ef8a>] kmemleak_alloc+0x4a/0xa0
     [<ffffffff811e8364>] kmem_cache_alloc+0xc4/0x1f0
     [<ffffffff815b04ac>] skb_clone+0x4c/0xa0
     [<ffffffffa0550d08>] hci_event_packet+0xb8/0x30b0 [bluetooth]
     [<ffffffffa054126d>] hci_rx_work+0x18d/0x380 [bluetooth]
     [<ffffffff81089f3b>] process_one_work+0x14b/0x430
     [<ffffffff8108a34b>] worker_thread+0x12b/0x490
     [<ffffffff8108fd49>] kthread+0xc9/0xe0
     [<ffffffff816a8e5f>] ret_from_fork+0x1f/0x40
     [<ffffffffffffffff>] 0xffffffffffffffff

I will attempt a bisection.

Larry
