Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix locking issue when creating l2cap connection
Date: Tue, 30 Sep 2014 14:07:25 +0300
Message-Id: <1412075245-15682-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

l2cap_chan_connect() was taking locks in different order than
other connection functions like l2cap_connect(). This makes
it possible to have a deadlock when conn->chan_lock (used to
protect the channel list) and chan->lock (used to protect
individual channel) are used in different order in different
kernel threads.

======================================================
[ INFO: possible circular locking dependency detected ]
3.17.0-bt6lowpan #1 Not tainted
-------------------------------------------------------
kworker/u3:2/375 is trying to acquire lock:
 (&chan->lock){+.+.+.}, at: [<d0ab05fd>] l2cap_connect_cfm+0x1dd/0x3f0 [bluetooth]

but task is already holding lock:
 (&conn->chan_lock){+.+...}, at: [<d0ab05be>] l2cap_connect_cfm+0x19e/0x3f0 [bluetooth]

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:
-> #1 (&conn->chan_lock){+.+...}:
       [<c109324d>] lock_acquire+0x9d/0x140
       [<c188459c>] mutex_lock_nested+0x6c/0x420
       [<d0aab48e>] l2cap_chan_add+0x1e/0x40 [bluetooth]
       [<d0aac618>] l2cap_chan_connect+0x348/0x8f0 [bluetooth]
       [<d0cc9a91>] lowpan_control_write+0x221/0x2d0 [bluetooth_6lowpan]
       [<c116cf34>] vfs_write+0x94/0x1a0
       [<c116d5d2>] SyS_write+0x52/0xb0
       [<c1889536>] syscall_after_call+0x0/0x4
-> #0 (&chan->lock){+.+.+.}:
       [<c10928d8>] __lock_acquire+0x1a18/0x1d20
       [<c109324d>] lock_acquire+0x9d/0x140
       [<c188459c>] mutex_lock_nested+0x6c/0x420
       [<d0ab05fd>] l2cap_connect_cfm+0x1dd/0x3f0 [bluetooth]
       [<d0a909c4>] hci_le_meta_evt+0x11a4/0x1260 [bluetooth]
       [<d0a910eb>] hci_event_packet+0x3ab/0x3120 [bluetooth]
       [<d0a7cb08>] hci_rx_work+0x208/0x4a0 [bluetooth]
       [<c106234a>] process_one_work+0x19a/0x4a0
       [<c10629e9>] worker_thread+0x39/0x440
       [<c1066dc8>] kthread+0xa8/0xc0
       [<c1889381>] ret_from_kernel_thread+0x21/0x30

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&conn->chan_lock);
                               lock(&chan->lock);
                               lock(&conn->chan_lock);
  lock(&chan->lock);

 *** DEADLOCK ***

4 locks held by kworker/u3:2/375:
 #0:  ("%s"hdev->name#2){.+.+.+}, at: [<c10622c3>] process_one_work+0x113/0x4a0
 #1:  ((&hdev->rx_work)){+.+.+.}, at: [<c10622c3>] process_one_work+0x113/0x4a0
 #2:  (&hdev->lock){+.+.+.}, at: [<d0a8f887>] hci_le_meta_evt+0x67/0x1260 [bluetooth]
 #3:  (&conn->chan_lock){+.+...}, at: [<d0ab05be>] l2cap_connect_cfm+0x19e/0x3f0 [bluetooth]

stack backtrace:
CPU: 0 PID: 375 Comm: kworker/u3:2 Not tainted 3.16.0-bt6lowpan #1
Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
Workqueue: hci0 hci_rx_work [bluetooth]
 c2339c00 00000000 cf355c04 c1880839 c2339ad0 cf355c30 c108dd04 c1ad7ad0
 cf355c78 cf355c30 c108ca94 cf355c7c ccc141a0 ccc147dc ccc14240 ccc147b4
 cf355cac c10928d8 ccc147b4 cf73e490 00073c3c 00000000 00000004 00000000
Call Trace:
 [<c1880839>] dump_stack+0x4b/0x75
 [<c108dd04>] print_circular_bug+0x1b4/0x2b0
 [<c108ca94>] ? check_noncircular+0x44/0x80
 [<c10928d8>] __lock_acquire+0x1a18/0x1d20
 [<c109324d>] lock_acquire+0x9d/0x140
 [<d0ab05fd>] ? l2cap_connect_cfm+0x1dd/0x3f0 [bluetooth]
 [<c188459c>] mutex_lock_nested+0x6c/0x420
 [<d0ab05fd>] ? l2cap_connect_cfm+0x1dd/0x3f0 [bluetooth]
 [<d0ab05fd>] ? l2cap_connect_cfm+0x1dd/0x3f0 [bluetooth]
 [<d0aab1ea>] ? l2cap_global_fixed_chan+0xda/0x110 [bluetooth]
 [<d0ab05fd>] l2cap_connect_cfm+0x1dd/0x3f0 [bluetooth]
 [<c13abb92>] ? kobject_set_name_vargs+0x42/0x60
 [<c1553364>] ? get_device+0x14/0x30
 [<c108f31b>] ? trace_hardirqs_on+0xb/0x10
 [<d0a909c4>] hci_le_meta_evt+0x11a4/0x1260 [bluetooth]
 [<c13ce90f>] ? __this_cpu_preempt_check+0xf/0x20
 [<c108f1c4>] ? trace_hardirqs_on_caller+0xf4/0x240
 [<c108c996>] ? trace_hardirqs_off_caller+0xb6/0x160
 [<c108f31b>] ? trace_hardirqs_on+0xb/0x10
 [<c108cbf4>] ? get_lock_stats+0x24/0x40
 [<d0a910eb>] hci_event_packet+0x3ab/0x3120 [bluetooth]
 [<c18886d5>] ? _raw_spin_unlock_irqrestore+0x55/0x70
 [<c13ce90f>] ? __this_cpu_preempt_check+0xf/0x20
 [<c108f1c4>] ? trace_hardirqs_on_caller+0xf4/0x240
 [<c108f31b>] ? trace_hardirqs_on+0xb/0x10
 [<c18886c1>] ? _raw_spin_unlock_irqrestore+0x41/0x70
 [<c1760615>] ? skb_dequeue+0x45/0x60
 [<d0a7cb08>] hci_rx_work+0x208/0x4a0 [bluetooth]
 [<c106234a>] process_one_work+0x19a/0x4a0
 [<c10622c3>] ? process_one_work+0x113/0x4a0
 [<c10629e9>] worker_thread+0x39/0x440
 [<c10629b0>] ? init_pwq+0xc0/0xc0
 [<c1066dc8>] kthread+0xa8/0xc0
 [<c108f31b>] ? trace_hardirqs_on+0xb/0x10
 [<c1889381>] ret_from_kernel_thread+0x21/0x30
 [<c1066d20>] ? kthread_create_on_node+0x160/0x160

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 net/bluetooth/l2cap_core.c | 79 ++++++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 35 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 8d53fc5..29eb2b0 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6980,6 +6980,47 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 
 	hci_dev_lock(hdev);
 
+	if (bdaddr_type_is_le(dst_type)) {
+		u8 addr_type;
+		u8 role;
+
+		/* Convert from L2CAP channel address type to HCI address type
+		 */
+		if (dst_type == BDADDR_LE_PUBLIC)
+			addr_type = ADDR_LE_DEV_PUBLIC;
+		else
+			addr_type = ADDR_LE_DEV_RANDOM;
+
+		if (test_bit(HCI_ADVERTISING, &hdev->dev_flags))
+			role = HCI_ROLE_SLAVE;
+		else
+			role = HCI_ROLE_MASTER;
+
+		hcon = hci_connect_le(hdev, dst, addr_type, chan->sec_level,
+				      HCI_LE_CONN_TIMEOUT, role);
+	} else {
+		u8 auth_type;
+
+		l2cap_chan_lock(chan);
+		auth_type = l2cap_get_auth_type(chan);
+		l2cap_chan_unlock(chan);
+
+		hcon = hci_connect_acl(hdev, dst, chan->sec_level, auth_type);
+	}
+
+	if (IS_ERR(hcon)) {
+		err = PTR_ERR(hcon);
+		goto done_no_lock;
+	}
+
+	conn = l2cap_conn_add(hcon);
+	if (!conn) {
+		hci_conn_drop(hcon);
+		err = -ENOMEM;
+		goto done_no_lock;
+	}
+
+	mutex_lock(&conn->chan_lock);
 	l2cap_chan_lock(chan);
 
 	if (!is_valid_psm(__le16_to_cpu(psm), dst_type) && !cid &&
@@ -7044,40 +7085,6 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 	chan->psm = psm;
 	chan->dcid = cid;
 
-	if (bdaddr_type_is_le(dst_type)) {
-		u8 role;
-
-		/* Convert from L2CAP channel address type to HCI address type
-		 */
-		if (dst_type == BDADDR_LE_PUBLIC)
-			dst_type = ADDR_LE_DEV_PUBLIC;
-		else
-			dst_type = ADDR_LE_DEV_RANDOM;
-
-		if (test_bit(HCI_ADVERTISING, &hdev->dev_flags))
-			role = HCI_ROLE_SLAVE;
-		else
-			role = HCI_ROLE_MASTER;
-
-		hcon = hci_connect_le(hdev, dst, dst_type, chan->sec_level,
-				      HCI_LE_CONN_TIMEOUT, role);
-	} else {
-		u8 auth_type = l2cap_get_auth_type(chan);
-		hcon = hci_connect_acl(hdev, dst, chan->sec_level, auth_type);
-	}
-
-	if (IS_ERR(hcon)) {
-		err = PTR_ERR(hcon);
-		goto done;
-	}
-
-	conn = l2cap_conn_add(hcon);
-	if (!conn) {
-		hci_conn_drop(hcon);
-		err = -ENOMEM;
-		goto done;
-	}
-
 	if (cid && __l2cap_get_chan_by_dcid(conn, cid)) {
 		hci_conn_drop(hcon);
 		err = -EBUSY;
@@ -7088,7 +7095,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 	bacpy(&chan->src, &hcon->src);
 	chan->src_type = bdaddr_type(hcon, hcon->src_type);
 
-	l2cap_chan_add(conn, chan);
+	__l2cap_chan_add(conn, chan);
 
 	/* l2cap_chan_add takes its own ref so we can drop this one */
 	hci_conn_drop(hcon);
@@ -7116,6 +7123,8 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 
 done:
 	l2cap_chan_unlock(chan);
+	mutex_unlock(&conn->chan_lock);
+done_no_lock:
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 	return err;
-- 
1.8.3.1

