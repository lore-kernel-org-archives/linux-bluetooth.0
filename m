Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Introduce user channel flag for HCI devices
Date: Mon, 26 Aug 2013 21:40:51 -0700
Message-Id: <1377578452-7316-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces a new user channel flag that allows to give full
control of a HCI device to a user application. The kernel will stay away
from the device and does not allow any further modifications of the
device states.

The existing raw flag is not used since it has a bit of unclear meaning
due to its legacy. Using a new flag makes the code clearer.

A device with the user channel flag set can still be enumerate using the
legacy API, but it does not longer enumerate using the new management
interface used by BlueZ 5 and beyond. This is intentional to not confuse
users of modern systems.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_core.c    | 39 ++++++++++++++++++++++++++++++++++++---
 net/bluetooth/hci_sock.c    | 15 +++++++++------
 net/bluetooth/mgmt.c        |  9 +++++++++
 4 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index aaeaf09..128157d 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -109,6 +109,7 @@ enum {
 	HCI_SERVICE_CACHE,
 	HCI_DEBUG_KEYS,
 	HCI_UNREGISTER,
+	HCI_USER_CHANNEL,
 
 	HCI_LE_SCAN,
 	HCI_SSP_ENABLED,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c529e85..541f4d5 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -981,6 +981,11 @@ int hci_inquiry(void __user *arg)
 	if (!hdev)
 		return -ENODEV;
 
+	if (test_bit(HCI_USER_CHANNEL, &hdev->dev_flags)) {
+		err = -EBUSY;
+		goto done;
+	}
+
 	hci_dev_lock(hdev);
 	if (inquiry_cache_age(hdev) > INQUIRY_CACHE_AGE_MAX ||
 	    inquiry_cache_empty(hdev) || ir.flags & IREQ_CACHE_FLUSH) {
@@ -1174,7 +1179,8 @@ int hci_dev_open(__u16 dev)
 		if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
 			set_bit(HCI_RAW, &hdev->flags);
 
-		if (!test_bit(HCI_RAW, &hdev->flags))
+		if (!test_bit(HCI_RAW, &hdev->flags) &&
+		    !test_bit(HCI_USER_CHANNEL, &hdev->dev_flags))
 			ret = __hci_init(hdev);
 	}
 
@@ -1185,6 +1191,7 @@ int hci_dev_open(__u16 dev)
 		set_bit(HCI_UP, &hdev->flags);
 		hci_notify(hdev, HCI_DEV_UP);
 		if (!test_bit(HCI_SETUP, &hdev->dev_flags) &&
+		    !test_bit(HCI_USER_CHANNEL, &hdev->dev_flags) &&
 		    mgmt_valid_hdev(hdev)) {
 			hci_dev_lock(hdev);
 			mgmt_powered(hdev, 1);
@@ -1321,11 +1328,17 @@ int hci_dev_close(__u16 dev)
 	if (!hdev)
 		return -ENODEV;
 
+	if (test_bit(HCI_USER_CHANNEL, &hdev->dev_flags)) {
+		err = -EBUSY;
+		goto done;
+	}
+
 	if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->dev_flags))
 		cancel_delayed_work(&hdev->power_off);
 
 	err = hci_dev_do_close(hdev);
 
+done:
 	hci_dev_put(hdev);
 	return err;
 }
@@ -1346,6 +1359,11 @@ int hci_dev_reset(__u16 dev)
 		goto done;
 	}
 
+	if (test_bit(HCI_USER_CHANNEL, &hdev->dev_flags)) {
+		ret = -EBUSY;
+		goto done;
+	}
+
 	/* Drop queues */
 	skb_queue_purge(&hdev->rx_q);
 	skb_queue_purge(&hdev->cmd_q);
@@ -1379,10 +1397,15 @@ int hci_dev_reset_stat(__u16 dev)
 	if (!hdev)
 		return -ENODEV;
 
+	if (test_bit(HCI_USER_CHANNEL, &hdev->dev_flags)) {
+		ret = -EBUSY;
+		goto done;
+	}
+
 	memset(&hdev->stat, 0, sizeof(struct hci_dev_stats));
 
+done:
 	hci_dev_put(hdev);
-
 	return ret;
 }
 
@@ -1399,6 +1422,11 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 	if (!hdev)
 		return -ENODEV;
 
+	if (test_bit(HCI_USER_CHANNEL, &hdev->dev_flags)) {
+		err = -EBUSY;
+		goto done;
+	}
+
 	switch (cmd) {
 	case HCISETAUTH:
 		err = hci_req_sync(hdev, hci_auth_req, dr.dev_opt,
@@ -1457,6 +1485,7 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 		break;
 	}
 
+done:
 	hci_dev_put(hdev);
 	return err;
 }
@@ -1565,6 +1594,9 @@ static int hci_rfkill_set_block(void *data, bool blocked)
 
 	BT_DBG("%p name %s blocked %d", hdev, hdev->name, blocked);
 
+	if (test_bit(HCI_USER_CHANNEL, &hdev->dev_flags))
+		return -EBUSY;
+
 	if (!blocked)
 		return 0;
 
@@ -3451,7 +3483,8 @@ static void hci_rx_work(struct work_struct *work)
 			hci_send_to_sock(hdev, skb);
 		}
 
-		if (test_bit(HCI_RAW, &hdev->flags)) {
+		if (test_bit(HCI_RAW, &hdev->flags) ||
+		    test_bit(HCI_USER_CHANNEL, &hdev->dev_flags)) {
 			kfree_skb(skb);
 			continue;
 		}
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index ab57038..59e68f1 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -500,6 +500,9 @@ static int hci_sock_bound_ioctl(struct sock *sk, unsigned int cmd,
 	if (!hdev)
 		return -EBADFD;
 
+	if (test_bit(HCI_USER_CHANNEL, &hdev->dev_flags))
+		return -EBUSY;
+
 	switch (cmd) {
 	case HCISETRAW:
 		if (!capable(CAP_NET_ADMIN))
@@ -530,19 +533,19 @@ static int hci_sock_bound_ioctl(struct sock *sk, unsigned int cmd,
 		if (!capable(CAP_NET_ADMIN))
 			return -EPERM;
 		return hci_sock_blacklist_del(hdev, (void __user *) arg);
-
-	default:
-		if (hdev->ioctl)
-			return hdev->ioctl(hdev, cmd, arg);
-		return -EINVAL;
 	}
+
+	if (hdev->ioctl)
+		return hdev->ioctl(hdev, cmd, arg);
+
+	return -EINVAL;
 }
 
 static int hci_sock_ioctl(struct socket *sock, unsigned int cmd,
 			  unsigned long arg)
 {
-	struct sock *sk = sock->sk;
 	void __user *argp = (void __user *) arg;
+	struct sock *sk = sock->sk;
 	int err;
 
 	BT_DBG("cmd %x arg %lx", cmd, arg);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fedc539..3070e77 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -339,6 +339,9 @@ static int read_index_list(struct sock *sk, struct hci_dev *hdev, void *data,
 		if (test_bit(HCI_SETUP, &d->dev_flags))
 			continue;
 
+		if (test_bit(HCI_USER_CHANNEL, &d->dev_flags))
+			continue;
+
 		if (!mgmt_valid_hdev(d))
 			continue;
 
@@ -3320,6 +3323,12 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 					 MGMT_STATUS_INVALID_INDEX);
 			goto done;
 		}
+
+		if (test_bit(HCI_USER_CHANNEL, &hdev->dev_flags)) {
+			err = cmd_status(sk, index, opcode,
+					 MGMT_STATUS_INVALID_INDEX);
+			goto done;
+		}
 	}
 
 	if (opcode >= ARRAY_SIZE(mgmt_handlers) ||
-- 
1.8.3.1

