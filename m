Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/10] Bluetooth: Make mgmt_set_class_of_dev_complete() return void
Date: Tue, 15 Oct 2013 14:26:26 -0700
Message-Id: <1381872389-34389-7-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The return value of mgmt_set_class_of_dev_complete() function is
not used and so just change it to return void.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  4 ++--
 net/bluetooth/mgmt.c             | 11 ++++-------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 734b09f..b2b472c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1112,8 +1112,8 @@ void mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		      u8 addr_type, u8 status);
 void mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status);
 void mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status);
-int mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
-				   u8 status);
+void mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
+				    u8 status);
 int mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status);
 int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
 					    u8 *randomizer, u8 status);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 969dbaa..24da84e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4796,24 +4796,21 @@ static void sk_lookup(struct pending_cmd *cmd, void *data)
 	}
 }
 
-int mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
-				   u8 status)
+void mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
+				    u8 status)
 {
 	struct cmd_lookup match = { NULL, hdev, mgmt_status(status) };
-	int err = 0;
 
 	mgmt_pending_foreach(MGMT_OP_SET_DEV_CLASS, hdev, sk_lookup, &match);
 	mgmt_pending_foreach(MGMT_OP_ADD_UUID, hdev, sk_lookup, &match);
 	mgmt_pending_foreach(MGMT_OP_REMOVE_UUID, hdev, sk_lookup, &match);
 
 	if (!status)
-		err = mgmt_event(MGMT_EV_CLASS_OF_DEV_CHANGED, hdev, dev_class,
-				 3, NULL);
+		mgmt_event(MGMT_EV_CLASS_OF_DEV_CHANGED, hdev, dev_class, 3,
+			   NULL);
 
 	if (match.sk)
 		sock_put(match.sk);
-
-	return err;
 }
 
 int mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status)
-- 
1.8.3.1

