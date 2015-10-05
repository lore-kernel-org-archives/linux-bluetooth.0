Return-Path: <cyrus@holtmann.org>
From: Kuba Pawlak <kubax.t.pawlak@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Kuba Pawlak <kubax.t.pawlak@intel.com>
Subject: [PATCH 2/5] Bluetooth: Fix locking issue on SCO disconnection
Date: Mon,  5 Oct 2015 18:44:16 +0200
Message-Id: <1444063459-28577-3-git-send-email-kubax.t.pawlak@intel.com>
In-Reply-To: <1444063459-28577-1-git-send-email-kubax.t.pawlak@intel.com>
References: <088CC8BACB3382439E91D9919CE350243655EB71@IRSMSX107.ger.corp.intel.com>
 <1444063459-28577-1-git-send-email-kubax.t.pawlak@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thread handling SCO disconnection may get preempted in '__sco_sock_close'
after dropping a reference to hci_conn but before marking this as NULL
in associated struct sco_conn. When execution returs to this thread,
this connection will possibly be released, resulting in kernel crash

Lock connection before this point.

BUG: unable to handle kernel NULL pointer dereference at   (null)
IP: [<fb770ab9>] __sco_sock_close+0x194/0x1ff [bluetooth]
*pdpt = 0000000023da6001 *pde = 0000000000000000
Oops: 0002 [#1] PREEMPT SMP
Modules linked in: evdev ecb rfcomm(O) libcomposite usb2380 udc_core bnep(O) btusb(O) btbcm(O) cdc_acm btintel(O) bluetooth(O) arc4 uinput hid_multitouch usbhid iwlmvm(O) hide
Pid: 984, comm: bluetooth Tainted: G           O 3.8.0-115.1-plk-adaptation-byt-ivi-brd #1
EIP: 0060:[<fb770ab9>] EFLAGS: 00010282 CPU: 2
EIP is at __sco_sock_close+0x194/0x1ff [bluetooth]
EAX: 00000000 EBX: e49d7600 ECX: ef1ec3c2 EDX: 000000c3
ESI: e4c12000 EDI: 00000000 EBP: ef1edf5c ESP: ef1edf4c
 DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
CR0: 80050033 CR2: 00000000 CR3: 23da7000 CR4: 001007f0
DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
DR6: ffff0ff0 DR7: 00000400
Process bluetooth (pid: 984, ti=ef1ec000 task=e47f2550 task.ti=ef1ec000)
Stack:
 e4c120d0 e49d7600 00000000 08421a40 ef1edf70 fb770b7a 00000002 e8a4cc80
 08421a40 ef1ec000 c12966b1 00000001 00000000 0000000b 084954c8 c1296b6c
 0000001b 00000002 0000001b 00000002 00000000 00000002 b2524880 00000046
Call Trace:
 [<fb770b7a>] ? sco_sock_shutdown+0x56/0x95 [bluetooth]
 [<c12966b1>] ? sys_shutdown+0x37/0x53
 [<c1296b6c>] ? sys_socketcall+0x12e/0x1be
 [<c134ae7e>] ? sysenter_do_call+0x12/0x26
 [<c1340000>] ? ip_vs_control_net_cleanup+0x46/0xb1
Code: e8 90 6b 8c c5 f6 05 72 5d 78 fb 04 74 17 8b 46 08 50 56 68 0a fd 77 fb 68 60 5d 78 fb e8 68 95 9e c5 83 c4 10 8b 83 fc 01 00 00 <c7> 00 00 00 00 00 eb 32 ba 68 00 00 0b
EIP: [<fb770ab9>] __sco_sock_close+0x194/0x1ff [bluetooth] SS:ESP 0068:ef1edf4c
CR2: 0000000000000000
---[ end trace 47fa2f55a9544e69 ]---

Signed-off-by: Kuba Pawlak <kubax.t.pawlak@intel.com>
---
 net/bluetooth/sco.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index e21c53b08da4b69d1954891ff91850bedbeb66ff..09051e4cbade132fd6e106fd48c1e5e36f36eb1a 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -416,8 +416,10 @@ static void __sco_sock_close(struct sock *sk)
 		if (sco_pi(sk)->conn->hcon) {
 			sk->sk_state = BT_DISCONN;
 			sco_sock_set_timer(sk, SCO_DISCONN_TIMEOUT);
+			sco_conn_lock(sco_pi(sk)->conn);
 			hci_conn_drop(sco_pi(sk)->conn->hcon);
 			sco_pi(sk)->conn->hcon = NULL;
+			sco_conn_unlock(sco_pi(sk)->conn);
 		} else
 			sco_chan_del(sk, ECONNRESET);
 		break;
-- 
1.9.3

Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Prof. Dr. Hermann Eul
Chairperson of the Supervisory Board: Tiffany Doon Silva
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928

