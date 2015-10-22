Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5] Bluetooth: Fix crash in SMP when unpairing
Date: Thu, 22 Oct 2015 09:38:35 +0300
Message-Id: <1445495915-21059-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1445495915-21059-1-git-send-email-johan.hedberg@gmail.com>
References: <1445495915-21059-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When unpairing the keys stored in hci_dev are removed. If SMP is
ongoing the SMP context will also have references to these keys, so
removing them from the hci_dev lists will make the pointers invalid.
This can result in the following type of crashes:

 BUG: unable to handle kernel paging request at 6b6b6b6b
 IP: [<c11f26be>] __list_del_entry+0x44/0x71
 *pde = 00000000
 Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC
 Modules linked in: hci_uart btqca btusb btintel btbcm btrtl hci_vhci rfcomm bluetooth_6lowpan bluetooth
 CPU: 0 PID: 723 Comm: kworker/u5:0 Not tainted 4.3.0-rc3+ #1379
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.8.1-20150318_183358- 04/01/2014
 Workqueue: hci0 hci_rx_work [bluetooth]
 task: f19da940 ti: f1a94000 task.ti: f1a94000
 EIP: 0060:[<c11f26be>] EFLAGS: 00010202 CPU: 0
 EIP is at __list_del_entry+0x44/0x71
 EAX: c0088d20 EBX: f30fcac0 ECX: 6b6b6b6b EDX: 6b6b6b6b
 ESI: f4b60000 EDI: c0088d20 EBP: f1a95d90 ESP: f1a95d8c
  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
 CR0: 8005003b CR2: 6b6b6b6b CR3: 319e5000 CR4: 00000690
 Stack:
  f30fcac0 f1a95db0 f82dc3e1 f1bfc000 00000000 c106524f f1bfc000 f30fd020
  f1a95dc0 f1a95dd0 f82dcbdb f1a95de0 f82dcbdb 00000067 f1bfc000 f30fd020
  f1a95de0 f1a95df0 f82d1126 00000067 f82d1126 00000006 f30fd020 f1bfc000
 Call Trace:
  [<f82dc3e1>] smp_chan_destroy+0x192/0x240 [bluetooth]
  [<c106524f>] ? trace_hardirqs_on_caller+0x14e/0x169
  [<f82dcbdb>] smp_teardown_cb+0x47/0x64 [bluetooth]
  [<f82dcbdb>] ? smp_teardown_cb+0x47/0x64 [bluetooth]
  [<f82d1126>] l2cap_chan_del+0x5d/0x14d [bluetooth]
  [<f82d1126>] ? l2cap_chan_del+0x5d/0x14d [bluetooth]
  [<f82d40ef>] l2cap_conn_del+0x109/0x17b [bluetooth]
  [<f82d40ef>] ? l2cap_conn_del+0x109/0x17b [bluetooth]
  [<f82c0205>] ? hci_event_packet+0x5b1/0x2092 [bluetooth]
  [<f82d41aa>] l2cap_disconn_cfm+0x49/0x50 [bluetooth]
  [<f82d41aa>] ? l2cap_disconn_cfm+0x49/0x50 [bluetooth]
  [<f82c0228>] hci_event_packet+0x5d4/0x2092 [bluetooth]
  [<c1332c16>] ? skb_release_data+0x6a/0x95
  [<f82ce5d4>] ? hci_send_to_monitor+0xe7/0xf4 [bluetooth]
  [<c1409708>] ? _raw_spin_unlock_irqrestore+0x44/0x57
  [<f82b3bb0>] hci_rx_work+0xf1/0x28b [bluetooth]
  [<f82b3bb0>] ? hci_rx_work+0xf1/0x28b [bluetooth]
  [<c10635a0>] ? __lock_is_held+0x2e/0x44
  [<c104772e>] process_one_work+0x232/0x432
  [<c1071ddc>] ? rcu_read_lock_sched_held+0x50/0x5a
  [<c104772e>] ? process_one_work+0x232/0x432
  [<c1047d48>] worker_thread+0x1b8/0x255
  [<c1047b90>] ? rescuer_thread+0x23c/0x23c
  [<c104bb71>] kthread+0x91/0x96
  [<c14096a7>] ? _raw_spin_unlock_irq+0x27/0x44
  [<c1409d61>] ret_from_kernel_thread+0x21/0x30
  [<c104bae0>] ? kthread_parkme+0x1e/0x1e

To solve the issue, introduce a new smp_cancel_pairing() API that can
be used to clean up the SMP state before touching the hci_dev lists.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |  3 +++
 net/bluetooth/smp.c  | 26 ++++++++++++++++++++++++++
 net/bluetooth/smp.h  |  1 +
 3 files changed, 30 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e1083c928d5c..7f22119276f3 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3099,6 +3099,9 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto done;
 	}
 
+	/* Abort any ongoing SMP pairing */
+	smp_cancel_pairing(conn);
+
 	/* Defer clearing up the connection parameters until closing to
 	 * give a chance of keeping them if a repairing happens.
 	 */
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 94f9c4ca68f1..c91353841e40 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2380,6 +2380,32 @@ unlock:
 	return ret;
 }
 
+void smp_cancel_pairing(struct hci_conn *hcon)
+{
+	struct l2cap_conn *conn = hcon->l2cap_data;
+	struct l2cap_chan *chan;
+	struct smp_chan *smp;
+
+	if (!conn)
+		return;
+
+	chan = conn->smp;
+	if (!chan)
+		return;
+
+	l2cap_chan_lock(chan);
+
+	smp = chan->data;
+	if (smp) {
+		if (test_bit(SMP_FLAG_COMPLETE, &smp->flags))
+			smp_failure(conn, 0);
+		else
+			smp_failure(conn, SMP_UNSPECIFIED);
+	}
+
+	l2cap_chan_unlock(chan);
+}
+
 static int smp_cmd_encrypt_info(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_cmd_encrypt_info *rp = (void *) skb->data;
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index 6cf872563ea7..ffcc70b6b199 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -180,6 +180,7 @@ enum smp_key_pref {
 };
 
 /* SMP Commands */
+void smp_cancel_pairing(struct hci_conn *hcon);
 bool smp_sufficient_security(struct hci_conn *hcon, u8 sec_level,
 			     enum smp_key_pref key_pref);
 int smp_conn_security(struct hci_conn *hcon, __u8 sec_level);
-- 
2.5.0

