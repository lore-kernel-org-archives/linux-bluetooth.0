Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Restrict access for raw-only controllers
Date: Sun, 29 Jun 2014 12:13:05 +0200
Message-Id: <1404036785-42112-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bluetooth controllers that are marked for raw-only usage can only be
used with user channel access. Any other operation should be rejected.

This simplifies the whole raw-only support since it now depends on
the fact that the controller is marked with HCI_QUIRK_RAW_DEVICE and
runtime raw access is restricted to user channel operation.

The kernel internal processing of HCI commands and events is designed
around the case that either the kernel has full control over the device
or that the device is driven from userspace. This now makes a clear
distinction between these two possible operation modes.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_conn.c |  7 -----
 net/bluetooth/hci_core.c | 74 +++++++++++++++++++++++++++++++++++++-----------
 net/bluetooth/hci_sock.c | 14 ++++++---
 net/bluetooth/mgmt.c     |  6 +++-
 4 files changed, 72 insertions(+), 29 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 8a0c7a0ac1b6..25ee27ddc882 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -346,9 +346,6 @@ static void hci_conn_idle(struct work_struct *work)
 
 	BT_DBG("hcon %p mode %d", conn, conn->mode);
 
-	if (test_bit(HCI_RAW, &hdev->flags))
-		return;
-
 	if (!lmp_sniff_capable(hdev) || !lmp_sniff_capable(conn))
 		return;
 
@@ -539,7 +536,6 @@ struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src)
 
 	list_for_each_entry(d, &hci_dev_list, list) {
 		if (!test_bit(HCI_UP, &d->flags) ||
-		    test_bit(HCI_RAW, &d->flags) ||
 		    test_bit(HCI_USER_CHANNEL, &d->dev_flags) ||
 		    d->dev_type != HCI_BREDR)
 			continue;
@@ -1059,9 +1055,6 @@ void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active)
 
 	BT_DBG("hcon %p mode %d", conn, conn->mode);
 
-	if (test_bit(HCI_RAW, &hdev->flags))
-		return;
-
 	if (conn->mode != HCI_CM_SNIFF)
 		goto timer;
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9852449ac104..50db0201213c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2117,6 +2117,11 @@ int hci_inquiry(void __user *arg)
 		goto done;
 	}
 
+	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks)) {
+		err = -EOPNOTSUPP;
+		goto done;
+	}
+
 	if (hdev->dev_type != HCI_BREDR) {
 		err = -EOPNOTSUPP;
 		goto done;
@@ -2246,10 +2251,7 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 		ret = hdev->setup(hdev);
 
 	if (!ret) {
-		if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
-			set_bit(HCI_RAW, &hdev->flags);
-
-		if (!test_bit(HCI_RAW, &hdev->flags) &&
+		if (!test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks) &&
 		    !test_bit(HCI_USER_CHANNEL, &hdev->dev_flags))
 			ret = __hci_init(hdev);
 	}
@@ -2286,7 +2288,7 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 		}
 
 		hdev->close(hdev);
-		hdev->flags = 0;
+		hdev->flags &= BIT(HCI_RAW);
 	}
 
 done:
@@ -2305,6 +2307,21 @@ int hci_dev_open(__u16 dev)
 	if (!hdev)
 		return -ENODEV;
 
+	/* Devices that are marked for raw-only usage can only be powered
+	 * up as user channel. Trying to bring them up as normal devices
+	 * will result into a failure. Only user channel operation is
+	 * possible.
+	 *
+	 * When this function is called for a user channel, the flag
+	 * HCI_USER_CHANNEL will be set first before attempting to
+	 * open the device.
+	 */
+	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks) &&
+	    !test_bit(HCI_USER_CHANNEL, &hdev->dev_flags)) {
+		err = -EOPNOTSUPP;
+		goto done;
+	}
+
 	/* We need to ensure that no other power on/off work is pending
 	 * before proceeding to call hci_dev_do_open. This is
 	 * particularly important if the setup procedure has not yet
@@ -2321,8 +2338,8 @@ int hci_dev_open(__u16 dev)
 
 	err = hci_dev_do_open(hdev);
 
+done:
 	hci_dev_put(hdev);
-
 	return err;
 }
 
@@ -2374,7 +2391,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	/* Reset device */
 	skb_queue_purge(&hdev->cmd_q);
 	atomic_set(&hdev->cmd_cnt, 1);
-	if (!test_bit(HCI_RAW, &hdev->flags) &&
+	if (!test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks) &&
 	    !test_bit(HCI_AUTO_OFF, &hdev->dev_flags) &&
 	    test_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks)) {
 		set_bit(HCI_INIT, &hdev->flags);
@@ -2405,7 +2422,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	hdev->close(hdev);
 
 	/* Clear flags */
-	hdev->flags = 0;
+	hdev->flags &= BIT(HCI_RAW);
 	hdev->dev_flags &= ~HCI_PERSISTENT_MASK;
 
 	if (!test_and_clear_bit(HCI_AUTO_OFF, &hdev->dev_flags)) {
@@ -2474,6 +2491,11 @@ int hci_dev_reset(__u16 dev)
 		goto done;
 	}
 
+	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks)) {
+		ret = -EOPNOTSUPP;
+		goto done;
+	}
+
 	/* Drop queues */
 	skb_queue_purge(&hdev->rx_q);
 	skb_queue_purge(&hdev->cmd_q);
@@ -2489,8 +2511,7 @@ int hci_dev_reset(__u16 dev)
 	atomic_set(&hdev->cmd_cnt, 1);
 	hdev->acl_cnt = 0; hdev->sco_cnt = 0; hdev->le_cnt = 0;
 
-	if (!test_bit(HCI_RAW, &hdev->flags))
-		ret = __hci_req_sync(hdev, hci_reset_req, 0, HCI_INIT_TIMEOUT);
+	ret = __hci_req_sync(hdev, hci_reset_req, 0, HCI_INIT_TIMEOUT);
 
 done:
 	hci_req_unlock(hdev);
@@ -2512,6 +2533,11 @@ int hci_dev_reset_stat(__u16 dev)
 		goto done;
 	}
 
+	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks)) {
+		ret = -EOPNOTSUPP;
+		goto done;
+	}
+
 	memset(&hdev->stat, 0, sizeof(struct hci_dev_stats));
 
 done:
@@ -2537,6 +2563,11 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 		goto done;
 	}
 
+	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks)) {
+		err = -EOPNOTSUPP;
+		goto done;
+	}
+
 	if (hdev->dev_type != HCI_BREDR) {
 		err = -EOPNOTSUPP;
 		goto done;
@@ -2760,8 +2791,10 @@ static void hci_power_on(struct work_struct *work)
 				   HCI_AUTO_OFF_TIMEOUT);
 	}
 
-	if (test_and_clear_bit(HCI_SETUP, &hdev->dev_flags))
-		mgmt_index_added(hdev);
+	if (test_and_clear_bit(HCI_SETUP, &hdev->dev_flags)) {
+		if (!test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
+			mgmt_index_added(hdev);
+	}
 }
 
 static void hci_power_off(struct work_struct *work)
@@ -3887,6 +3920,13 @@ int hci_register_dev(struct hci_dev *hdev)
 	list_add(&hdev->list, &hci_dev_list);
 	write_unlock(&hci_dev_list_lock);
 
+	/* Devices that are marked for raw-only usage need to set
+	 * the HCI_RAW flag to indicate that only user channel is
+	 * supported.
+	 */
+	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
+		set_bit(HCI_RAW, &hdev->flags);
+
 	hci_notify(hdev, HCI_DEV_REG);
 	hci_dev_hold(hdev);
 
@@ -3929,7 +3969,8 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	cancel_work_sync(&hdev->power_on);
 
 	if (!test_bit(HCI_INIT, &hdev->flags) &&
-	    !test_bit(HCI_SETUP, &hdev->dev_flags)) {
+	    !test_bit(HCI_SETUP, &hdev->dev_flags) &&
+	    !test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks)) {
 		hci_dev_lock(hdev);
 		mgmt_index_removed(hdev);
 		hci_dev_unlock(hdev);
@@ -4694,7 +4735,7 @@ static inline int __get_blocks(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void __check_timeout(struct hci_dev *hdev, unsigned int cnt)
 {
-	if (!test_bit(HCI_RAW, &hdev->flags)) {
+	if (!test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks)) {
 		/* ACL tx timeout must be longer than maximum
 		 * link supervision timeout (40.9 seconds) */
 		if (!cnt && time_after(jiffies, hdev->acl_last_tx +
@@ -4877,7 +4918,7 @@ static void hci_sched_le(struct hci_dev *hdev)
 	if (!hci_conn_num(hdev, LE_LINK))
 		return;
 
-	if (!test_bit(HCI_RAW, &hdev->flags)) {
+	if (!test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks)) {
 		/* LE tx timeout must be longer than maximum
 		 * link supervision timeout (40.9 seconds) */
 		if (!hdev->le_cnt && hdev->le_pkts &&
@@ -5122,8 +5163,7 @@ static void hci_rx_work(struct work_struct *work)
 			hci_send_to_sock(hdev, skb);
 		}
 
-		if (test_bit(HCI_RAW, &hdev->flags) ||
-		    test_bit(HCI_USER_CHANNEL, &hdev->dev_flags)) {
+		if (test_bit(HCI_USER_CHANNEL, &hdev->dev_flags)) {
 			kfree_skb(skb);
 			continue;
 		}
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 80d25c150a65..54e4e8fd5d97 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -453,7 +453,8 @@ static int hci_sock_release(struct socket *sock)
 
 	if (hdev) {
 		if (hci_pi(sk)->channel == HCI_CHANNEL_USER) {
-			mgmt_index_added(hdev);
+			if (!test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
+				mgmt_index_added(hdev);
 			clear_bit(HCI_USER_CHANNEL, &hdev->dev_flags);
 			hci_dev_close(hdev->id);
 		}
@@ -517,6 +518,9 @@ static int hci_sock_bound_ioctl(struct sock *sk, unsigned int cmd,
 	if (test_bit(HCI_USER_CHANNEL, &hdev->dev_flags))
 		return -EBUSY;
 
+	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
+		return -EOPNOTSUPP;
+
 	if (hdev->dev_type != HCI_BREDR)
 		return -EOPNOTSUPP;
 
@@ -702,12 +706,14 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 			goto done;
 		}
 
-		mgmt_index_removed(hdev);
+		if (!test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
+			mgmt_index_removed(hdev);
 
 		err = hci_dev_open(hdev->id);
 		if (err) {
 			clear_bit(HCI_USER_CHANNEL, &hdev->dev_flags);
-			mgmt_index_added(hdev);
+			if (!test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
+				mgmt_index_added(hdev);
 			hci_dev_put(hdev);
 			goto done;
 		}
@@ -960,7 +966,7 @@ static int hci_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 			goto drop;
 		}
 
-		if (test_bit(HCI_RAW, &hdev->flags) || (ogf == 0x3f)) {
+		if (ogf == 0x3f) {
 			skb_queue_tail(&hdev->raw_q, skb);
 			queue_work(hdev->workqueue, &hdev->tx_work);
 		} else {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1197b9666365..55d330fd7f08 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -347,6 +347,9 @@ static int read_index_list(struct sock *sk, struct hci_dev *hdev, void *data,
 		if (test_bit(HCI_USER_CHANNEL, &d->dev_flags))
 			continue;
 
+		if (test_bit(HCI_QUIRK_RAW_DEVICE, &d->quirks))
+			continue;
+
 		if (d->dev_type == HCI_BREDR) {
 			rp->index[count++] = cpu_to_le16(d->id);
 			BT_DBG("Added hci%u", d->id);
@@ -5067,7 +5070,8 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 		}
 
 		if (test_bit(HCI_SETUP, &hdev->dev_flags) ||
-		    test_bit(HCI_USER_CHANNEL, &hdev->dev_flags)) {
+		    test_bit(HCI_USER_CHANNEL, &hdev->dev_flags) ||
+		    test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks)) {
 			err = cmd_status(sk, index, opcode,
 					 MGMT_STATUS_INVALID_INDEX);
 			goto done;
-- 
1.9.3

