Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH] Bluetooth: Add parameter validation for ioctl(HCISETACLMTU)
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1370056311-14199-1-git-send-email-anderson.lizardo@openbossa.org>
Date: Sun, 2 Jun 2013 07:17:04 +0900
Cc: linux-bluetooth@vger.kernel.org, stable@vger.kernel.org
Message-Id: <33F0ED7F-C1AA-4B03-A585-DCBAE5E667E5@holtmann.org>
References: <1370056311-14199-1-git-send-email-anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

> Setting ACL MTU to a very low value (or even zero) causes access to
> invalid memory when creating L2CAP connections. The minimum value of 48
> was taken from the L2CAP minimum allowed MTU for BR/EDR (this ioctl() is
> not applicable for LE).

and the value 48 is totally wrong here. Please check the definition of a L2CAP C-frame and table 4.1 which defines the minimum payload as 23 octets for LE-U. We could argue that this ioctl only sets ACL-U, but nevertheless this seems kinda weird as well.

Why are we forcing L2CAP restrictions on a lower-layer here. If someone wants to shoot themselves in the foot, they are allowed to do so. We need to make sure that L2CAP works with whatever value we have here. Since essentially even a broken controller can give us wrong values.

> Also make sure the "maximum number of ACL packets" parameter is at least
> 1, otherwise no connections can be created.

Again, I am fine if people want to shoot themselves in the foot here. We need to just make sure L2CAP works properly.

> This crash happens when modifying the l2cap-tester tool from BlueZ to
> set the MTU to zero prior to running L2CAP connection tests:
> 
> [  371.813278] BUG: unable to handle kernel paging request at f549c000
> [  371.816037] IP: [<c03d94cd>] memcpy+0x1d/0x40
> [  371.816037] *pdpt = 0000000000ac3001 *pde = 00000000373f9067 *pte = 800000003549c060
> [  371.816037] Oops: 0000 [#1] SMP DEBUG_PAGEALLOC
> [  371.816037] Modules linked in: hci_vhci bluetooth i2c_piix4 virtio_balloon uhci_hcd usbcore usb_common
> [  371.816037] CPU: 0 PID: 1126 Comm: kworker/u3:0 Not tainted 3.10.0-rc1+ #11
> [  371.816037] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2007
> [  371.816037] Workqueue: hci0 hci_rx_work [bluetooth]
> [  371.816037] task: f4508000 ti: f549a000 task.ti: f549a000
> [  371.816037] EIP: 0060:[<c03d94cd>] EFLAGS: 00010212 CPU: 0
> [  371.816037] EIP is at memcpy+0x1d/0x40
> [  371.816037] EAX: f55f61c0 EBX: fffffff8 ECX: 3fffff4d EDX: f549bd3a
> [  371.816037] ESI: f549bffe EDI: f55f6484 EBP: f549bce0 ESP: f549bcd4
> [  371.816037]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
> [  371.816037] CR0: 8005003b CR2: f549c000 CR3: 358ce000 CR4: 000006f0
> [  371.816037] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [  371.816037] DR6: ffff0ff0 DR7: 00000400
> [  371.816037] Stack:
> [  371.816037]  fffffff8 0000000a 0000000a f549bd28 f8c6a54c ffffffff f549bcf4 c0149616
> [  371.816037]  f549bd0c c0159919 00000286 00000008 0000000a 011a125b 00000000 f474edb0
> [  371.816037]  f4667180 f474ed01 f474edb0 f467b840 f5ec4cb4 f549bd44 f8c6faf4 00000002
> [  371.816037] Call Trace:
> [  371.816037]  [<f8c6a54c>] l2cap_send_cmd+0x1cc/0x230 [bluetooth]

We might better fix l2cap_build_cmd here to fail if we are trying to build a frame that is larger than our ACL MTU. As I said, if a misbehaving controller gives us a too small value, we might be in trouble as well.

We have seen controllers giving us 0 buffer sizes for SCO packets in the past before. So this just need to be robust.

Regards

Marcel

