Return-Path: <cyrus@holtmann.org>
From: Antti Julku <antti.julku@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Antti Julku <antti.julku@nokia.com>
Subject: [PATCH v2] Bluetooth: Add mgmt events for blacklisting
Date: Wed, 17 Aug 2011 15:15:58 +0300
Message-Id: <1313583358-1421-1-git-send-email-antti.julku@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add management interface events for blocking/unblocking a device.
Sender of the block device command gets cmd complete and other
mgmt sockets get the event. Event is also sent to mgmt sockets when
blocking is done with ioctl, e.g when blocking a device with
hciconfig. This makes it possible for bluetoothd to track status
of blocked devices when a third party block or unblocks a device.

Event sending is handled in mgmt_device_blocked function which gets
called from hci_blacklist_add in hci_core.c. A pending command is
added in mgmt_block_device, so that it can found when sending the
event - the event is not sent to the socket from which the pending
command came. Locks were moved out from hci_core.c to hci_sock.c
and mgmt.c, because locking is needed also for mgmt_pending_add in
mgmt.c.

Signed-off-by: Antti Julku <antti.julku@nokia.com>
---
 include/net/bluetooth/hci_core.h |    2 +
 include/net/bluetooth/mgmt.h     |   10 ++++++
 net/bluetooth/hci_core.c         |   32 ++++++------------
 net/bluetooth/hci_sock.c         |   18 +++++++++-
 net/bluetooth/mgmt.c             |   64 +++++++++++++++++++++++++++++++++----
 5 files changed, 96 insertions(+), 30 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8f441b8..0662d11 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -858,6 +858,8 @@ int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 *dev_class, s8 rssi,
 								u8 *eir);
 int mgmt_remote_name(u16 index, bdaddr_t *bdaddr, u8 *name);
 int mgmt_discovering(u16 index, u8 discovering);
+int mgmt_device_blocked(u16 index, bdaddr_t *bdaddr);
+int mgmt_device_unblocked(u16 index, bdaddr_t *bdaddr);
 
 /* HCI info for socket */
 #define hci_pi(sk) ((struct hci_pinfo *) sk)
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 5428fd3..c2a052a 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -301,3 +301,13 @@ struct mgmt_ev_remote_name {
 } __packed;
 
 #define MGMT_EV_DISCOVERING		0x0014
+
+#define MGMT_EV_DEVICE_BLOCKED		0x0015
+struct mgmt_ev_device_blocked {
+	bdaddr_t bdaddr;
+} __packed;
+
+#define MGMT_EV_DEVICE_UNBLOCKED	0x0016
+struct mgmt_ev_device_unblocked {
+	bdaddr_t bdaddr;
+} __packed;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 56943ad..2064aaf 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1312,59 +1312,49 @@ int hci_blacklist_clear(struct hci_dev *hdev)
 int hci_blacklist_add(struct hci_dev *hdev, bdaddr_t *bdaddr)
 {
 	struct bdaddr_list *entry;
-	int err;
 
 	if (bacmp(bdaddr, BDADDR_ANY) == 0)
 		return -EBADF;
 
-	hci_dev_lock_bh(hdev);
-
 	if (hci_blacklist_lookup(hdev, bdaddr)) {
-		err = -EEXIST;
-		goto err;
+		return -EEXIST;
 	}
 
 	entry = kzalloc(sizeof(struct bdaddr_list), GFP_KERNEL);
 	if (!entry) {
-		err = -ENOMEM;
-		goto err;
+		return -ENOMEM;
 	}
 
 	bacpy(&entry->bdaddr, bdaddr);
 
 	list_add(&entry->list, &hdev->blacklist);
 
-	err = 0;
+	if (test_bit(HCI_MGMT, &hdev->flags))
+		return mgmt_device_blocked(hdev->id, bdaddr);
 
-err:
-	hci_dev_unlock_bh(hdev);
-	return err;
+	return 0;
 }
 
 int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr)
 {
 	struct bdaddr_list *entry;
-	int err = 0;
-
-	hci_dev_lock_bh(hdev);
 
 	if (bacmp(bdaddr, BDADDR_ANY) == 0) {
-		hci_blacklist_clear(hdev);
-		goto done;
+		return hci_blacklist_clear(hdev);
 	}
 
 	entry = hci_blacklist_lookup(hdev, bdaddr);
 	if (!entry) {
-		err = -ENOENT;
-		goto done;
+		return -ENOENT;
 	}
 
 	list_del(&entry->list);
 	kfree(entry);
 
-done:
-	hci_dev_unlock_bh(hdev);
-	return err;
+	if (test_bit(HCI_MGMT, &hdev->flags))
+		return mgmt_device_unblocked(hdev->id, bdaddr);
+
+	return 0;
 }
 
 static void hci_clear_adv_cache(unsigned long arg)
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index ff02cf5..f6afe3d 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -183,21 +183,35 @@ static int hci_sock_release(struct socket *sock)
 static int hci_sock_blacklist_add(struct hci_dev *hdev, void __user *arg)
 {
 	bdaddr_t bdaddr;
+	int err;
 
 	if (copy_from_user(&bdaddr, arg, sizeof(bdaddr)))
 		return -EFAULT;
 
-	return hci_blacklist_add(hdev, &bdaddr);
+	hci_dev_lock_bh(hdev);
+
+	err = hci_blacklist_add(hdev, &bdaddr);
+
+	hci_dev_unlock_bh(hdev);
+
+	return err;
 }
 
 static int hci_sock_blacklist_del(struct hci_dev *hdev, void __user *arg)
 {
 	bdaddr_t bdaddr;
+	int err;
 
 	if (copy_from_user(&bdaddr, arg, sizeof(bdaddr)))
 		return -EFAULT;
 
-	return hci_blacklist_del(hdev, &bdaddr);
+	hci_dev_lock_bh(hdev);
+
+	err = hci_blacklist_del(hdev, &bdaddr);
+
+	hci_dev_unlock_bh(hdev);
+
+	return err;
 }
 
 /* Ioctls that require bound socket */
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 53e109e..f8581ff 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1689,13 +1689,12 @@ static int block_device(struct sock *sk, u16 index, unsigned char *data,
 								u16 len)
 {
 	struct hci_dev *hdev;
-	struct mgmt_cp_block_device *cp;
+	struct pending_cmd *cmd;
+	struct mgmt_cp_block_device *cp = (void *) data;
 	int err;
 
 	BT_DBG("hci%u", index);
 
-	cp = (void *) data;
-
 	if (len != sizeof(*cp))
 		return cmd_status(sk, index, MGMT_OP_BLOCK_DEVICE,
 							EINVAL);
@@ -1705,6 +1704,14 @@ static int block_device(struct sock *sk, u16 index, unsigned char *data,
 		return cmd_status(sk, index, MGMT_OP_BLOCK_DEVICE,
 							ENODEV);
 
+	hci_dev_lock_bh(hdev);
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_BLOCK_DEVICE, index, NULL, 0);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto failed;
+	}
+
 	err = hci_blacklist_add(hdev, &cp->bdaddr);
 
 	if (err < 0)
@@ -1712,6 +1719,11 @@ static int block_device(struct sock *sk, u16 index, unsigned char *data,
 	else
 		err = cmd_complete(sk, index, MGMT_OP_BLOCK_DEVICE,
 							NULL, 0);
+
+	mgmt_pending_remove(cmd);
+
+failed:
+	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -1721,13 +1733,12 @@ static int unblock_device(struct sock *sk, u16 index, unsigned char *data,
 								u16 len)
 {
 	struct hci_dev *hdev;
-	struct mgmt_cp_unblock_device *cp;
+	struct pending_cmd *cmd;
+	struct mgmt_cp_unblock_device *cp = (void *) data;
 	int err;
 
 	BT_DBG("hci%u", index);
 
-	cp = (void *) data;
-
 	if (len != sizeof(*cp))
 		return cmd_status(sk, index, MGMT_OP_UNBLOCK_DEVICE,
 								EINVAL);
@@ -1737,13 +1748,26 @@ static int unblock_device(struct sock *sk, u16 index, unsigned char *data,
 		return cmd_status(sk, index, MGMT_OP_UNBLOCK_DEVICE,
 								ENODEV);
 
+	hci_dev_lock_bh(hdev);
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_UNBLOCK_DEVICE, index, NULL, 0);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto failed;
+	}
+
 	err = hci_blacklist_del(hdev, &cp->bdaddr);
 
 	if (err < 0)
 		err = cmd_status(sk, index, MGMT_OP_UNBLOCK_DEVICE, -err);
 	else
 		err = cmd_complete(sk, index, MGMT_OP_UNBLOCK_DEVICE,
-								NULL, 0);
+							NULL, 0);
+
+	mgmt_pending_remove(cmd);
+
+failed:
+	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -2286,3 +2310,29 @@ int mgmt_discovering(u16 index, u8 discovering)
 	return mgmt_event(MGMT_EV_DISCOVERING, index, &discovering,
 						sizeof(discovering), NULL);
 }
+
+int mgmt_device_blocked(u16 index, bdaddr_t *bdaddr)
+{
+	struct pending_cmd *cmd;
+	struct mgmt_ev_device_blocked ev;
+
+	cmd = mgmt_pending_find(MGMT_OP_BLOCK_DEVICE, index);
+
+	bacpy(&ev.bdaddr, bdaddr);
+
+	return mgmt_event(MGMT_EV_DEVICE_BLOCKED, index, &ev, sizeof(ev),
+						cmd ? cmd->sk : NULL);
+}
+
+int mgmt_device_unblocked(u16 index, bdaddr_t *bdaddr)
+{
+	struct pending_cmd *cmd;
+	struct mgmt_ev_device_unblocked ev;
+
+	cmd = mgmt_pending_find(MGMT_OP_UNBLOCK_DEVICE, index);
+
+	bacpy(&ev.bdaddr, bdaddr);
+
+	return mgmt_event(MGMT_EV_DEVICE_UNBLOCKED, index, &ev, sizeof(ev),
+						cmd ? cmd->sk : NULL);
+}
-- 
1.7.2.5

