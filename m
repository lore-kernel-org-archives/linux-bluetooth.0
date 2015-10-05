Return-Path: <cyrus@holtmann.org>
From: Kuba Pawlak <kubax.t.pawlak@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Kuba Pawlak <kubax.t.pawlak@intel.com>
Subject: [PATCH 5/5] Bluetooth: Fix crash on fast disconnect of SCO
Date: Mon,  5 Oct 2015 18:44:19 +0200
Message-Id: <1444063459-28577-6-git-send-email-kubax.t.pawlak@intel.com>
In-Reply-To: <1444063459-28577-1-git-send-email-kubax.t.pawlak@intel.com>
References: <088CC8BACB3382439E91D9919CE350243655EB71@IRSMSX107.ger.corp.intel.com>
 <1444063459-28577-1-git-send-email-kubax.t.pawlak@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix a crash that may happen when a connection is closed before it was fully
established. Mapping conn->hcon was released by shutdown function, but it
is still referenced in (not yet finished) connection established handling
function.

[ 4635.254073] BUG: unable to handle kernel NULL pointer dereference at 00000013
[ 4635.262058] IP: [<c11659f0>] memcmp+0xe/0x25
[ 4635.266835] *pdpt = 0000000024190001 *pde = 0000000000000000
[ 4635.273261] Oops: 0000 [#1] PREEMPT SMP
[ 4635.277652] Modules linked in: evdev ecb vfat fat libcomposite usb2380 isofs zlib_inflate rfcomm(O) udc_core bnep(O) btusb(O) btbcm(O) btintel(O) bluetooth(O) cdc_acm arc4 uinput hid_mule
[ 4635.321761] Pid: 363, comm: kworker/u:2H Tainted: G           O 3.8.0-119.1-plk-adaptation-byt-ivi-brd #1
[ 4635.332642] EIP: 0060:[<c11659f0>] EFLAGS: 00010206 CPU: 0
[ 4635.338767] EIP is at memcmp+0xe/0x25
[ 4635.342852] EAX: e4720678 EBX: 00000000 ECX: 00000006 EDX: 00000013
[ 4635.349849] ESI: 00000000 EDI: fb85366c EBP: e40c7dc0 ESP: e40c7db4
[ 4635.356846]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
[ 4635.362873] CR0: 8005003b CR2: 00000013 CR3: 24191000 CR4: 001007f0
[ 4635.369869] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[ 4635.376865] DR6: ffff0ff0 DR7: 00000400
[ 4635.381143] Process kworker/u:2H (pid: 363, ti=e40c6000 task=e40c5510 task.ti=e40c6000)
[ 4635.390080] Stack:
[ 4635.392319]  e4720400 00000000 fb85366c e40c7df4 fb842285 e40c7de2 fb853200 00000013
[ 4635.401003]  e3f101c4 e4720678 e3f101c0 e403be0a e40c7dfc e416a000 e403be0a fb85366c
[ 4635.409692]  e40c7e1c fb820186 020f6c00 e47c49ac e47c4008 00000000 e416a000 e47c402c
[ 4635.418380] Call Trace:
[ 4635.421153]  [<fb842285>] sco_connect_cfm+0xff/0x236 [bluetooth]
[ 4635.427893]  [<fb820186>] hci_sync_conn_complete_evt.clone.101+0x227/0x268 [bluetooth]
[ 4635.436758]  [<fb82370f>] hci_event_packet+0x1caa/0x21d3 [bluetooth]
[ 4635.443859]  [<c106231f>] ? trace_hardirqs_on+0xb/0xd
[ 4635.449502]  [<c1375b8a>] ? _raw_spin_unlock_irqrestore+0x42/0x59
[ 4635.456340]  [<fb814b67>] hci_rx_work+0xb9/0x350 [bluetooth]
[ 4635.462663]  [<c1039f1e>] ? process_one_work+0x17b/0x2e6
[ 4635.468596]  [<c1039f77>] process_one_work+0x1d4/0x2e6
[ 4635.474333]  [<c1039f1e>] ? process_one_work+0x17b/0x2e6
[ 4635.480294]  [<fb814aae>] ? hci_cmd_work+0xda/0xda [bluetooth]
[ 4635.486810]  [<c103a3fa>] worker_thread+0x171/0x20f
[ 4635.492257]  [<c10456c5>] ? complete+0x34/0x3e
[ 4635.497219]  [<c103ea06>] kthread+0x90/0x95
[ 4635.501888]  [<c103a289>] ? manage_workers+0x1df/0x1df
[ 4635.507628]  [<c1376537>] ret_from_kernel_thread+0x1b/0x28
[ 4635.513755]  [<c103e976>] ? __init_kthread_worker+0x42/0x42
[ 4635.519975] Code: 74 0d 3c 79 74 04 3c 59 75 0c c6 02 01 eb 03 c6 02 00 31 c0 eb 05 b8 ea ff ff ff 5d c3 55 89 e5 57 56 53 31 db eb 0e 0f b6 34 18 <0f> b6 3c 1a 43 29 fe 75 07 49 85 c9 7f
[ 4635.541264] EIP: [<c11659f0>] memcmp+0xe/0x25 SS:ESP 0068:e40c7db4
[ 4635.548166] CR2: 0000000000000013
[ 4635.552177] ---[ end trace e05ce9b8ce6182f6 ]---
[

Signed-off-by: Kuba Pawlak <kubax.t.pawlak@intel.com>
---
 net/bluetooth/sco.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index bcc3c6d8066bba0b6d801fe8182734636bf6d94a..de6eaf5abd259cc5dfae957fffdf96bcaa53805b 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1029,6 +1029,11 @@ static void sco_conn_ready(struct sco_conn *conn)
 		bh_unlock_sock(sk);
 	} else {
 
+		if (!conn->hcon) {
+			sco_conn_unlock(conn);
+			return;
+		}
+
 		parent = sco_get_sock_listen(&conn->hcon->src);
 		if (!parent) {
 			sco_conn_unlock(conn);
-- 
1.9.3

Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Prof. Dr. Hermann Eul
Chairperson of the Supervisory Board: Tiffany Doon Silva
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928

