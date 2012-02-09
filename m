Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/8] Bluetooth: Add address type to mgmt blacklist messages
Date: Thu,  9 Feb 2012 17:23:47 +0200
Message-Id: <1328801030-24274-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1328801030-24274-1-git-send-email-johan.hedberg@gmail.com>
References: <1328801030-24274-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch updates the implmentation for mgmt_block_device and
mgmt_unblock_device and their corresponding events to match the latest
API specification.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    8 ++++----
 include/net/bluetooth/mgmt.h     |    8 ++++----
 net/bluetooth/hci_core.c         |    8 ++++----
 net/bluetooth/hci_sock.c         |    4 ++--
 net/bluetooth/mgmt.c             |   14 ++++++++------
 5 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5f27694..14a655f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -646,8 +646,8 @@ int hci_inquiry(void __user *arg);
 
 struct bdaddr_list *hci_blacklist_lookup(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int hci_blacklist_clear(struct hci_dev *hdev);
-int hci_blacklist_add(struct hci_dev *hdev, bdaddr_t *bdaddr);
-int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr);
+int hci_blacklist_add(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
+int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 
 int hci_uuids_clear(struct hci_dev *hdev);
 
@@ -992,8 +992,8 @@ int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status);
 int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status);
 int mgmt_discovering(struct hci_dev *hdev, u8 discovering);
-int mgmt_device_blocked(struct hci_dev *hdev, bdaddr_t *bdaddr);
-int mgmt_device_unblocked(struct hci_dev *hdev, bdaddr_t *bdaddr);
+int mgmt_device_blocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
+int mgmt_device_unblocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 
 int mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, u8 persistent);
 
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index f284499..92f85c8 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -299,12 +299,12 @@ struct mgmt_rp_confirm_name {
 
 #define MGMT_OP_BLOCK_DEVICE		0x0026
 struct mgmt_cp_block_device {
-	bdaddr_t bdaddr;
+	struct mgmt_addr_info addr;
 } __packed;
 
 #define MGMT_OP_UNBLOCK_DEVICE		0x0027
 struct mgmt_cp_unblock_device {
-	bdaddr_t bdaddr;
+	struct mgmt_addr_info addr;
 } __packed;
 
 #define MGMT_EV_CMD_COMPLETE		0x0001
@@ -405,10 +405,10 @@ struct mgmt_ev_device_found {
 
 #define MGMT_EV_DEVICE_BLOCKED		0x0014
 struct mgmt_ev_device_blocked {
-	bdaddr_t bdaddr;
+	struct mgmt_addr_info addr;
 } __packed;
 
 #define MGMT_EV_DEVICE_UNBLOCKED	0x0015
 struct mgmt_ev_device_unblocked {
-	bdaddr_t bdaddr;
+	struct mgmt_addr_info addr;
 } __packed;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3d09f4b4..9ada164 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1489,7 +1489,7 @@ int hci_blacklist_clear(struct hci_dev *hdev)
 	return 0;
 }
 
-int hci_blacklist_add(struct hci_dev *hdev, bdaddr_t *bdaddr)
+int hci_blacklist_add(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 {
 	struct bdaddr_list *entry;
 
@@ -1507,10 +1507,10 @@ int hci_blacklist_add(struct hci_dev *hdev, bdaddr_t *bdaddr)
 
 	list_add(&entry->list, &hdev->blacklist);
 
-	return mgmt_device_blocked(hdev, bdaddr);
+	return mgmt_device_blocked(hdev, bdaddr, type);
 }
 
-int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr)
+int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 {
 	struct bdaddr_list *entry;
 
@@ -1524,7 +1524,7 @@ int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr)
 	list_del(&entry->list);
 	kfree(entry);
 
-	return mgmt_device_unblocked(hdev, bdaddr);
+	return mgmt_device_unblocked(hdev, bdaddr, type);
 }
 
 static void hci_clear_adv_cache(struct work_struct *work)
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 0dcc962..9e854d9 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -190,7 +190,7 @@ static int hci_sock_blacklist_add(struct hci_dev *hdev, void __user *arg)
 
 	hci_dev_lock(hdev);
 
-	err = hci_blacklist_add(hdev, &bdaddr);
+	err = hci_blacklist_add(hdev, &bdaddr, 0);
 
 	hci_dev_unlock(hdev);
 
@@ -207,7 +207,7 @@ static int hci_sock_blacklist_del(struct hci_dev *hdev, void __user *arg)
 
 	hci_dev_lock(hdev);
 
-	err = hci_blacklist_del(hdev, &bdaddr);
+	err = hci_blacklist_del(hdev, &bdaddr, 0);
 
 	hci_dev_unlock(hdev);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 763a447..413a0b9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2114,7 +2114,7 @@ static int block_device(struct sock *sk, u16 index, void *data, u16 len)
 
 	hci_dev_lock(hdev);
 
-	err = hci_blacklist_add(hdev, &cp->bdaddr);
+	err = hci_blacklist_add(hdev, &cp->addr.bdaddr, cp->addr.type);
 	if (err < 0)
 		err = cmd_status(sk, index, MGMT_OP_BLOCK_DEVICE,
 							MGMT_STATUS_FAILED);
@@ -2147,7 +2147,7 @@ static int unblock_device(struct sock *sk, u16 index, void *data, u16 len)
 
 	hci_dev_lock(hdev);
 
-	err = hci_blacklist_del(hdev, &cp->bdaddr);
+	err = hci_blacklist_del(hdev, &cp->addr.bdaddr, cp->addr.type);
 
 	if (err < 0)
 		err = cmd_status(sk, index, MGMT_OP_UNBLOCK_DEVICE,
@@ -3026,27 +3026,29 @@ int mgmt_discovering(struct hci_dev *hdev, u8 discovering)
 						sizeof(discovering), NULL);
 }
 
-int mgmt_device_blocked(struct hci_dev *hdev, bdaddr_t *bdaddr)
+int mgmt_device_blocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 {
 	struct pending_cmd *cmd;
 	struct mgmt_ev_device_blocked ev;
 
 	cmd = mgmt_pending_find(MGMT_OP_BLOCK_DEVICE, hdev);
 
-	bacpy(&ev.bdaddr, bdaddr);
+	bacpy(&ev.addr.bdaddr, bdaddr);
+	ev.addr.type = type;
 
 	return mgmt_event(MGMT_EV_DEVICE_BLOCKED, hdev, &ev, sizeof(ev),
 							cmd ? cmd->sk : NULL);
 }
 
-int mgmt_device_unblocked(struct hci_dev *hdev, bdaddr_t *bdaddr)
+int mgmt_device_unblocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 {
 	struct pending_cmd *cmd;
 	struct mgmt_ev_device_unblocked ev;
 
 	cmd = mgmt_pending_find(MGMT_OP_UNBLOCK_DEVICE, hdev);
 
-	bacpy(&ev.bdaddr, bdaddr);
+	bacpy(&ev.addr.bdaddr, bdaddr);
+	ev.addr.type = type;
 
 	return mgmt_event(MGMT_EV_DEVICE_UNBLOCKED, hdev, &ev, sizeof(ev),
 							cmd ? cmd->sk : NULL);
-- 
1.7.9

