Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/10] Bluetooth: Make mgmt_read_local_oob_data_reply_complete() return void
Date: Tue, 15 Oct 2013 14:26:28 -0700
Message-Id: <1381872389-34389-9-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The return value of mgmt_read_local_oob_data_reply_complete() function
is not used and so just change it to return void.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  4 ++--
 net/bluetooth/mgmt.c             | 18 +++++++-----------
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d40212b..5d8d322 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1115,8 +1115,8 @@ void mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status);
 void mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
 				    u8 status);
 void mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status);
-int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
-					    u8 *randomizer, u8 status);
+void mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
+					     u8 *randomizer, u8 status);
 void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		       u8 addr_type, u8 *dev_class, s8 rssi, u8 cfm_name,
 		       u8 ssp, u8 *eir, u16 eir_len);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b4b5cb7..1ed0b3e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4840,35 +4840,31 @@ void mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status)
 		   cmd ? cmd->sk : NULL);
 }
 
-int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
-					    u8 *randomizer, u8 status)
+void mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
+					     u8 *randomizer, u8 status)
 {
 	struct pending_cmd *cmd;
-	int err;
 
 	BT_DBG("%s status %u", hdev->name, status);
 
 	cmd = mgmt_pending_find(MGMT_OP_READ_LOCAL_OOB_DATA, hdev);
 	if (!cmd)
-		return -ENOENT;
+		return;
 
 	if (status) {
-		err = cmd_status(cmd->sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_DATA,
-				 mgmt_status(status));
+		cmd_status(cmd->sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_DATA,
+			   mgmt_status(status));
 	} else {
 		struct mgmt_rp_read_local_oob_data rp;
 
 		memcpy(rp.hash, hash, sizeof(rp.hash));
 		memcpy(rp.randomizer, randomizer, sizeof(rp.randomizer));
 
-		err = cmd_complete(cmd->sk, hdev->id,
-				   MGMT_OP_READ_LOCAL_OOB_DATA, 0, &rp,
-				   sizeof(rp));
+		cmd_complete(cmd->sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_DATA,
+			     0, &rp, sizeof(rp));
 	}
 
 	mgmt_pending_remove(cmd);
-
-	return err;
 }
 
 void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-- 
1.8.3.1

