Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 7/7] Bluetooth: Convert local OOB data reading to use HCI request
Date: Mon,  9 Mar 2015 13:03:41 +0200
Message-Id: <1425899021-16414-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1425899021-16414-1-git-send-email-johan.hedberg@gmail.com>
References: <1425899021-16414-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that there's a HCI request API available where the callback receives
the resulting skb, we can convert the local OOB data reading to use this
new API. This patch does the necessary update in mgmt.c (which also
requires moving the callback higher up since it's now a static function)
and removes the custom calls from hci_event.c that are no-longer
necessary.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |   3 --
 net/bluetooth/hci_event.c        |  12 -----
 net/bluetooth/mgmt.c             | 105 ++++++++++++++++++++++++---------------
 3 files changed, 65 insertions(+), 55 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 23da0487c0aa..9b99adedfdb0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1359,9 +1359,6 @@ void mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status);
 void mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
 				    u8 status);
 void mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status);
-void mgmt_read_local_oob_data_complete(struct hci_dev *hdev, u8 *hash192,
-				       u8 *rand192, u8 *hash256, u8 *rand256,
-				       u8 status);
 void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		       u8 addr_type, u8 *dev_class, s8 rssi, u32 flags,
 		       u8 *eir, u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ea332c6a5319..6d1e4f4cbba3 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1045,11 +1045,6 @@ static void hci_cc_read_local_oob_data(struct hci_dev *hdev,
 	struct hci_rp_read_local_oob_data *rp = (void *) skb->data;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
-
-	hci_dev_lock(hdev);
-	mgmt_read_local_oob_data_complete(hdev, rp->hash, rp->rand, NULL, NULL,
-					  rp->status);
-	hci_dev_unlock(hdev);
 }
 
 static void hci_cc_read_local_oob_ext_data(struct hci_dev *hdev,
@@ -1058,15 +1053,8 @@ static void hci_cc_read_local_oob_ext_data(struct hci_dev *hdev,
 	struct hci_rp_read_local_oob_ext_data *rp = (void *) skb->data;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
-
-	hci_dev_lock(hdev);
-	mgmt_read_local_oob_data_complete(hdev, rp->hash192, rp->rand192,
-					  rp->hash256, rp->rand256,
-					  rp->status);
-	hci_dev_unlock(hdev);
 }
 
-
 static void hci_cc_le_set_random_addr(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d769b428b630..b851dbcd8029 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3630,10 +3630,70 @@ failed:
 	return err;
 }
 
+static void read_local_oob_data_complete(struct hci_dev *hdev, u8 status,
+				         u16 opcode, struct sk_buff *skb)
+{
+	struct mgmt_rp_read_local_oob_data mgmt_rp;
+	size_t rp_size = sizeof(mgmt_rp);
+	struct mgmt_pending_cmd *cmd;
+
+	BT_DBG("%s status %u", hdev->name, status);
+
+	cmd = mgmt_pending_find(MGMT_OP_READ_LOCAL_OOB_DATA, hdev);
+	if (!cmd)
+		return;
+
+	if (status || !skb) {
+		mgmt_cmd_status(cmd->sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_DATA,
+				status ? mgmt_status(status) : MGMT_STATUS_FAILED);
+		goto remove;
+	}
+
+	memset(&mgmt_rp, 0, sizeof(mgmt_rp));
+
+	if (opcode == HCI_OP_READ_LOCAL_OOB_DATA) {
+		struct hci_rp_read_local_oob_data *rp = (void *) skb->data;
+
+		if (skb->len < sizeof(*rp)) {
+			mgmt_cmd_status(cmd->sk, hdev->id,
+					MGMT_OP_READ_LOCAL_OOB_DATA,
+					MGMT_STATUS_FAILED);
+			goto remove;
+		}
+
+		memcpy(mgmt_rp.hash192, rp->hash, sizeof(rp->hash));
+		memcpy(mgmt_rp.rand192, rp->rand, sizeof(rp->rand));
+
+		rp_size -= sizeof(mgmt_rp.hash256) + sizeof(mgmt_rp.rand256);
+	} else {
+		struct hci_rp_read_local_oob_ext_data *rp = (void *) skb->data;
+
+		if (skb->len < sizeof(*rp)) {
+			mgmt_cmd_status(cmd->sk, hdev->id,
+					MGMT_OP_READ_LOCAL_OOB_DATA,
+					MGMT_STATUS_FAILED);
+			goto remove;
+		}
+
+		memcpy(mgmt_rp.hash192, rp->hash192, sizeof(rp->hash192));
+		memcpy(mgmt_rp.rand192, rp->rand192, sizeof(rp->rand192));
+
+		memcpy(mgmt_rp.hash256, rp->hash256, sizeof(rp->hash256));
+		memcpy(mgmt_rp.rand256, rp->rand256, sizeof(rp->rand256));
+	}
+
+	mgmt_cmd_complete(cmd->sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_DATA,
+			  MGMT_STATUS_SUCCESS, &mgmt_rp, rp_size);
+
+remove:
+	mgmt_pending_remove(cmd);
+}
+
 static int read_local_oob_data(struct sock *sk, struct hci_dev *hdev,
 			       void *data, u16 data_len)
 {
 	struct mgmt_pending_cmd *cmd;
+	struct hci_request req;
 	int err;
 
 	BT_DBG("%s", hdev->name);
@@ -3664,12 +3724,14 @@ static int read_local_oob_data(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
+	hci_req_init(&req, hdev);
+
 	if (bredr_sc_enabled(hdev))
-		err = hci_send_cmd(hdev, HCI_OP_READ_LOCAL_OOB_EXT_DATA,
-				   0, NULL);
+		hci_req_add(&req, HCI_OP_READ_LOCAL_OOB_EXT_DATA, 0, NULL);
 	else
-		err = hci_send_cmd(hdev, HCI_OP_READ_LOCAL_OOB_DATA, 0, NULL);
+		hci_req_add(&req, HCI_OP_READ_LOCAL_OOB_DATA, 0, NULL);
 
+	err = hci_req_run_skb(&req, read_local_oob_data_complete);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 
@@ -7214,43 +7276,6 @@ void mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status)
 		   cmd ? cmd->sk : NULL);
 }
 
-void mgmt_read_local_oob_data_complete(struct hci_dev *hdev, u8 *hash192,
-				       u8 *rand192, u8 *hash256, u8 *rand256,
-				       u8 status)
-{
-	struct mgmt_pending_cmd *cmd;
-
-	BT_DBG("%s status %u", hdev->name, status);
-
-	cmd = mgmt_pending_find(MGMT_OP_READ_LOCAL_OOB_DATA, hdev);
-	if (!cmd)
-		return;
-
-	if (status) {
-		mgmt_cmd_status(cmd->sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_DATA,
-			        mgmt_status(status));
-	} else {
-		struct mgmt_rp_read_local_oob_data rp;
-		size_t rp_size = sizeof(rp);
-
-		memcpy(rp.hash192, hash192, sizeof(rp.hash192));
-		memcpy(rp.rand192, rand192, sizeof(rp.rand192));
-
-		if (bredr_sc_enabled(hdev) && hash256 && rand256) {
-			memcpy(rp.hash256, hash256, sizeof(rp.hash256));
-			memcpy(rp.rand256, rand256, sizeof(rp.rand256));
-		} else {
-			rp_size -= sizeof(rp.hash256) + sizeof(rp.rand256);
-		}
-
-		mgmt_cmd_complete(cmd->sk, hdev->id,
-				  MGMT_OP_READ_LOCAL_OOB_DATA, 0,
-				  &rp, rp_size);
-	}
-
-	mgmt_pending_remove(cmd);
-}
-
 static inline bool has_uuid(u8 *uuid, u16 uuid_count, u8 (*uuids)[16])
 {
 	int i;
-- 
2.1.0

