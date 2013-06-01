Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: Add parameter validation for ioctl(HCISETACLMTU)
Date: Fri, 31 May 2013 23:11:51 -0400
Message-Id: <1370056311-14199-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Setting ACL MTU to a very low value (or even zero) causes access to
invalid memory when creating L2CAP connections. The minimum value of 48
was taken from the L2CAP minimum allowed MTU for BR/EDR (this ioctl() is
not applicable for LE).

Also make sure the "maximum number of ACL packets" parameter is at least
1, otherwise no connections can be created.

This crash happens when modifying the l2cap-tester tool from BlueZ to
set the MTU to zero prior to running L2CAP connection tests:

[  371.813278] BUG: unable to handle kernel paging request at f549c000
[  371.816037] IP: [<c03d94cd>] memcpy+0x1d/0x40
[  371.816037] *pdpt = 0000000000ac3001 *pde = 00000000373f9067 *pte = 800000003549c060
[  371.816037] Oops: 0000 [#1] SMP DEBUG_PAGEALLOC
[  371.816037] Modules linked in: hci_vhci bluetooth i2c_piix4 virtio_balloon uhci_hcd usbcore usb_common
[  371.816037] CPU: 0 PID: 1126 Comm: kworker/u3:0 Not tainted 3.10.0-rc1+ #11
[  371.816037] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2007
[  371.816037] Workqueue: hci0 hci_rx_work [bluetooth]
[  371.816037] task: f4508000 ti: f549a000 task.ti: f549a000
[  371.816037] EIP: 0060:[<c03d94cd>] EFLAGS: 00010212 CPU: 0
[  371.816037] EIP is at memcpy+0x1d/0x40
[  371.816037] EAX: f55f61c0 EBX: fffffff8 ECX: 3fffff4d EDX: f549bd3a
[  371.816037] ESI: f549bffe EDI: f55f6484 EBP: f549bce0 ESP: f549bcd4
[  371.816037]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[  371.816037] CR0: 8005003b CR2: f549c000 CR3: 358ce000 CR4: 000006f0
[  371.816037] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  371.816037] DR6: ffff0ff0 DR7: 00000400
[  371.816037] Stack:
[  371.816037]  fffffff8 0000000a 0000000a f549bd28 f8c6a54c ffffffff f549bcf4 c0149616
[  371.816037]  f549bd0c c0159919 00000286 00000008 0000000a 011a125b 00000000 f474edb0
[  371.816037]  f4667180 f474ed01 f474edb0 f467b840 f5ec4cb4 f549bd44 f8c6faf4 00000002
[  371.816037] Call Trace:
[  371.816037]  [<f8c6a54c>] l2cap_send_cmd+0x1cc/0x230 [bluetooth]
[  371.816037]  [<c0149616>] ? add_timer+0x16/0x20
[  371.816037]  [<c0159919>] ? __queue_delayed_work+0x79/0x150
[  371.816037]  [<f8c6faf4>] l2cap_do_start+0xb4/0xd0 [bluetooth]
[  371.816037]  [<f8c749e7>] l2cap_connect_cfm+0x127/0x330 [bluetooth]
[  371.816037]  [<f8c4c0f5>] ? hci_send_cmd+0x55/0xc0 [bluetooth]
[  371.816037]  [<f8c52c99>] hci_remote_ext_features_evt.isra.56+0x459/0x4e0 [bluetooth]
[  371.816037]  [<f8c52872>] ? hci_remote_ext_features_evt.isra.56+0x32/0x4e0 [bluetooth]
[  371.816037]  [<c01a125b>] ? trace_hardirqs_on+0xb/0x10
[  371.816037]  [<f8c5b1b5>] hci_event_packet+0xc75/0x2940 [bluetooth]
[  371.816037]  [<c064ea86>] ? _raw_spin_unlock_irqrestore+0x36/0x60
[  371.816037]  [<c01a118c>] ? trace_hardirqs_on_caller+0xec/0x1b0
[  371.816037]  [<c01a125b>] ? trace_hardirqs_on+0xb/0x10
[  371.816037]  [<c0542a2e>] ? skb_dequeue+0x4e/0x70
[  371.816037]  [<f8c48f80>] hci_rx_work+0x2c0/0x810 [bluetooth]
[  371.816037]  [<c0158979>] process_one_work+0x1a9/0x600
[  371.816037]  [<c01588fb>] ? process_one_work+0x12b/0x600
[  371.816037]  [<c015922e>] ? worker_thread+0x19e/0x320
[  371.816037]  [<c015922e>] ? worker_thread+0x19e/0x320
[  371.816037]  [<c0159187>] worker_thread+0xf7/0x320
[  371.816037]  [<c0159090>] ? rescuer_thread+0x290/0x290
[  371.816037]  [<c01602f8>] kthread+0xa8/0xb0
[  371.816037]  [<c0656777>] ret_from_kernel_thread+0x1b/0x28
[  371.816037]  [<c0160250>] ? flush_kthread_worker+0x120/0x120
[  371.816037] Code: c3 90 8d 74 26 00 e8 63 fc ff ff eb e8 90 55 89 e5 83 ec 0c 89 5d f4 89 75 f8 89 7d fc 3e 8d 74 26 00 89 cb 89 c7 c1 e9 02 89 d6 <f3> a5 89 d9 83 e1 03 74 02 f3 a4 8b 5d f4 8b 75 f8 8b 7d fc 89
[  371.816037] EIP: [<c03d94cd>] memcpy+0x1d/0x40 SS:ESP 0068:f549bcd4
[  371.816037] CR2: 00000000f549c000
[  371.816037] ---[ end trace 1ad0df320ca83072 ]---

Signed-off-by: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: stable@vger.kernel.org
---
 include/net/bluetooth/hci.h |    1 +
 net/bluetooth/hci_core.c    |   11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 3c592cf..b33382e 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -29,6 +29,7 @@
 #define HCI_MAX_SCO_SIZE	255
 #define HCI_MAX_EVENT_SIZE	260
 #define HCI_MAX_FRAME_SIZE	(HCI_MAX_ACL_SIZE + 4)
+#define HCI_ACL_MIN_MTU		48
 
 #define HCI_LINK_KEY_SIZE	16
 #define HCI_AMP_LINK_KEY_SIZE	(2 * HCI_LINK_KEY_SIZE)
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 09f4bb2..abad532 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1363,6 +1363,7 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 {
 	struct hci_dev *hdev;
 	struct hci_dev_req dr;
+	unsigned int acl_mtu, acl_pkts;
 	int err = 0;
 
 	if (copy_from_user(&dr, arg, sizeof(dr)))
@@ -1416,8 +1417,14 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 		break;
 
 	case HCISETACLMTU:
-		hdev->acl_mtu  = *((__u16 *) &dr.dev_opt + 1);
-		hdev->acl_pkts = *((__u16 *) &dr.dev_opt + 0);
+		acl_mtu = *((__u16 *) &dr.dev_opt + 1);
+		acl_pkts = *((__u16 *) &dr.dev_opt + 0);
+		if (acl_mtu < HCI_ACL_MIN_MTU || acl_pkts < 1) {
+			err = -EINVAL;
+		} else {
+			hdev->acl_mtu  = acl_mtu;
+			hdev->acl_pkts = acl_pkts;
+		}
 		break;
 
 	case HCISETSCOMTU:
-- 
1.7.9.5

