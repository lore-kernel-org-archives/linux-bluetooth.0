Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix redundant device (un)blocked events
Date: Tue,  1 Jul 2014 22:09:47 +0300
Message-Id: <1404241787-8224-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

For the Block/Unblock Device mgmt commands we should only emit the
Blocked/Unblocked events on any socket except for the one which received
the command. The code was previously incorrectly trying to look up a
non-existent pending command and thereby ending up not skipping the
command socket for the event.

We can simplify the code a lot by simply sending the event directly from
the command handler functions. We have the reference to the command
socket available there which makes it easy to pass to the mgmt_event
function for skipping.

The only notable side-effect of this is that the old blacklisting
ioctl's no-longer cause mgmt events to be emitted, however as user space
versions using these ioctl's are not mgmt-aware this is acceptable.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 --
 net/bluetooth/hci_core.c         |  4 ++--
 net/bluetooth/mgmt.c             | 50 +++++++++++++---------------------------
 3 files changed, 18 insertions(+), 38 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9078da681f16..3404f9bd2da0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1325,8 +1325,6 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		      u8 addr_type, s8 rssi, u8 *name, u8 name_len);
 void mgmt_discovering(struct hci_dev *hdev, u8 discovering);
-int mgmt_device_blocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
-int mgmt_device_unblocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent);
 void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk);
 void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 25ed6d3de410..72eb41424d04 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3275,7 +3275,7 @@ int hci_blacklist_add(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 
 	list_add(&entry->list, &hdev->blacklist);
 
-	return mgmt_device_blocked(hdev, bdaddr, type);
+	return 0;
 }
 
 int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
@@ -3294,7 +3294,7 @@ int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 	list_del(&entry->list);
 	kfree(entry);
 
-	return mgmt_device_unblocked(hdev, bdaddr, type);
+	return 0;
 }
 
 struct bdaddr_list *hci_white_list_lookup(struct hci_dev *hdev,
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 408468c07a8a..ba5e215a7561 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3773,11 +3773,16 @@ static int block_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	hci_dev_lock(hdev);
 
 	err = hci_blacklist_add(hdev, &cp->addr.bdaddr, cp->addr.type);
-	if (err < 0)
+	if (err < 0) {
 		status = MGMT_STATUS_FAILED;
-	else
-		status = MGMT_STATUS_SUCCESS;
+		goto done;
+	}
+
+	mgmt_event(MGMT_EV_DEVICE_BLOCKED, hdev, &cp->addr, sizeof(cp->addr),
+		   sk);
+	status = MGMT_STATUS_SUCCESS;
 
+done:
 	err = cmd_complete(sk, hdev->id, MGMT_OP_BLOCK_DEVICE, status,
 			   &cp->addr, sizeof(cp->addr));
 
@@ -3803,11 +3808,16 @@ static int unblock_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	hci_dev_lock(hdev);
 
 	err = hci_blacklist_del(hdev, &cp->addr.bdaddr, cp->addr.type);
-	if (err < 0)
+	if (err < 0) {
 		status = MGMT_STATUS_INVALID_PARAMS;
-	else
-		status = MGMT_STATUS_SUCCESS;
+		goto done;
+	}
+
+	mgmt_event(MGMT_EV_DEVICE_UNBLOCKED, hdev, &cp->addr, sizeof(cp->addr),
+		   sk);
+	status = MGMT_STATUS_SUCCESS;
 
+done:
 	err = cmd_complete(sk, hdev->id, MGMT_OP_UNBLOCK_DEVICE, status,
 			   &cp->addr, sizeof(cp->addr));
 
@@ -6346,34 +6356,6 @@ void mgmt_discovering(struct hci_dev *hdev, u8 discovering)
 	mgmt_event(MGMT_EV_DISCOVERING, hdev, &ev, sizeof(ev), NULL);
 }
 
-int mgmt_device_blocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
-{
-	struct pending_cmd *cmd;
-	struct mgmt_ev_device_blocked ev;
-
-	cmd = mgmt_pending_find(MGMT_OP_BLOCK_DEVICE, hdev);
-
-	bacpy(&ev.addr.bdaddr, bdaddr);
-	ev.addr.type = type;
-
-	return mgmt_event(MGMT_EV_DEVICE_BLOCKED, hdev, &ev, sizeof(ev),
-			  cmd ? cmd->sk : NULL);
-}
-
-int mgmt_device_unblocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
-{
-	struct pending_cmd *cmd;
-	struct mgmt_ev_device_unblocked ev;
-
-	cmd = mgmt_pending_find(MGMT_OP_UNBLOCK_DEVICE, hdev);
-
-	bacpy(&ev.addr.bdaddr, bdaddr);
-	ev.addr.type = type;
-
-	return mgmt_event(MGMT_EV_DEVICE_UNBLOCKED, hdev, &ev, sizeof(ev),
-			  cmd ? cmd->sk : NULL);
-}
-
 static void adv_enable_complete(struct hci_dev *hdev, u8 status)
 {
 	BT_DBG("%s status %u", hdev->name, status);
-- 
1.9.3

