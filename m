Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/10] Bluetooth: Make mgmt_set_local_name_complete() return void
Date: Tue, 15 Oct 2013 14:26:27 -0700
Message-Id: <1381872389-34389-8-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The return value of mgmt_set_local_name_complete() function is
not used and so just change it to return void.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/mgmt.c             | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b2b472c..d40212b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1114,7 +1114,7 @@ void mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status);
 void mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status);
 void mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
 				    u8 status);
-int mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status);
+void mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status);
 int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
 					    u8 *randomizer, u8 status);
 void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 24da84e..b4b5cb7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4813,13 +4813,13 @@ void mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
 		sock_put(match.sk);
 }
 
-int mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status)
+void mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status)
 {
 	struct mgmt_cp_set_local_name ev;
 	struct pending_cmd *cmd;
 
 	if (status)
-		return 0;
+		return;
 
 	memset(&ev, 0, sizeof(ev));
 	memcpy(ev.name, name, HCI_MAX_NAME_LENGTH);
@@ -4833,11 +4833,11 @@ int mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status)
 		 * HCI dev don't send any mgmt signals.
 		 */
 		if (mgmt_pending_find(MGMT_OP_SET_POWERED, hdev))
-			return 0;
+			return;
 	}
 
-	return mgmt_event(MGMT_EV_LOCAL_NAME_CHANGED, hdev, &ev, sizeof(ev),
-			  cmd ? cmd->sk : NULL);
+	mgmt_event(MGMT_EV_LOCAL_NAME_CHANGED, hdev, &ev, sizeof(ev),
+		   cmd ? cmd->sk : NULL);
 }
 
 int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
-- 
1.8.3.1

