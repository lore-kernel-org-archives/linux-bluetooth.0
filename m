Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/10] Bluetooth: Make mgmt_ssp_enable_complete() return void
Date: Tue, 15 Oct 2013 14:26:25 -0700
Message-Id: <1381872389-34389-6-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The return value of mgmt_ssp_enable_complete() function is not
used and so just change it to return void.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/mgmt.c             | 12 ++++--------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3ee5691..734b09f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1111,7 +1111,7 @@ int mgmt_user_passkey_notify(struct hci_dev *hdev, bdaddr_t *bdaddr,
 void mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		      u8 addr_type, u8 status);
 void mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status);
-int mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status);
+void mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status);
 int mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
 				   u8 status);
 int mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0672a8c..969dbaa 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4737,12 +4737,11 @@ static void clear_eir(struct hci_request *req)
 	hci_req_add(req, HCI_OP_WRITE_EIR, sizeof(cp), &cp);
 }
 
-int mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
+void mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
 {
 	struct cmd_lookup match = { NULL, hdev };
 	struct hci_request req;
 	bool changed = false;
-	int err = 0;
 
 	if (status) {
 		u8 mgmt_err = mgmt_status(status);
@@ -4750,13 +4749,12 @@ int mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
 		if (enable && test_and_clear_bit(HCI_SSP_ENABLED,
 						 &hdev->dev_flags)) {
 			clear_bit(HCI_HS_ENABLED, &hdev->dev_flags);
-			err = new_settings(hdev, NULL);
+			new_settings(hdev, NULL);
 		}
 
 		mgmt_pending_foreach(MGMT_OP_SET_SSP, hdev, cmd_status_rsp,
 				     &mgmt_err);
-
-		return err;
+		return;
 	}
 
 	if (enable) {
@@ -4773,7 +4771,7 @@ int mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
 	mgmt_pending_foreach(MGMT_OP_SET_SSP, hdev, settings_rsp, &match);
 
 	if (changed)
-		err = new_settings(hdev, match.sk);
+		new_settings(hdev, match.sk);
 
 	if (match.sk)
 		sock_put(match.sk);
@@ -4786,8 +4784,6 @@ int mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
 		clear_eir(&req);
 
 	hci_req_run(&req, NULL);
-
-	return err;
 }
 
 static void sk_lookup(struct pending_cmd *cmd, void *data)
-- 
1.8.3.1

