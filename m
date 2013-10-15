Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/10] Bluetooth: Make mgmt_auth_enable_complete() return void
Date: Tue, 15 Oct 2013 14:26:24 -0700
Message-Id: <1381872389-34389-5-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The return value of mgmt_auth_enable_complete() function is not
used and so just change it to return void.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/mgmt.c             | 24 ++++++++++--------------
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c742716..3ee5691 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1110,7 +1110,7 @@ int mgmt_user_passkey_notify(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			     u8 entered);
 void mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		      u8 addr_type, u8 status);
-int mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status);
+void mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status);
 int mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status);
 int mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
 				   u8 status);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3c44990..0672a8c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4693,37 +4693,33 @@ void mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	mgmt_event(MGMT_EV_AUTH_FAILED, hdev, &ev, sizeof(ev), NULL);
 }
 
-int mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status)
+void mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status)
 {
 	struct cmd_lookup match = { NULL, hdev };
-	bool changed = false;
-	int err = 0;
+	bool changed;
 
 	if (status) {
 		u8 mgmt_err = mgmt_status(status);
 		mgmt_pending_foreach(MGMT_OP_SET_LINK_SECURITY, hdev,
 				     cmd_status_rsp, &mgmt_err);
-		return 0;
+		return;
 	}
 
-	if (test_bit(HCI_AUTH, &hdev->flags)) {
-		if (!test_and_set_bit(HCI_LINK_SECURITY, &hdev->dev_flags))
-			changed = true;
-	} else {
-		if (test_and_clear_bit(HCI_LINK_SECURITY, &hdev->dev_flags))
-			changed = true;
-	}
+	if (test_bit(HCI_AUTH, &hdev->flags))
+		changed = !test_and_set_bit(HCI_LINK_SECURITY,
+					    &hdev->dev_flags);
+	else
+		changed = test_and_clear_bit(HCI_LINK_SECURITY,
+					     &hdev->dev_flags);
 
 	mgmt_pending_foreach(MGMT_OP_SET_LINK_SECURITY, hdev, settings_rsp,
 			     &match);
 
 	if (changed)
-		err = new_settings(hdev, match.sk);
+		new_settings(hdev, match.sk);
 
 	if (match.sk)
 		sock_put(match.sk);
-
-	return err;
 }
 
 static void clear_eir(struct hci_request *req)
-- 
1.8.3.1

