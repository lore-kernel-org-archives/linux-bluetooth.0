Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Clear P-192 values for OOB when in Secure Connections Only mode
Date: Tue, 27 Jan 2015 16:04:31 -0800
Message-Id: <1422403473-3542-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When Secure Connections Only mode has been enabled and remote OOB data
is requested, then only provide P-256 hash and randomizer vaulues. The
fields for P-192 hash and randomizer should be set to zero.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c | 46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index e2b81adc232f..0850cad8c368 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4163,33 +4163,39 @@ static void hci_remote_oob_data_request_evt(struct hci_dev *hdev,
 		goto unlock;
 
 	data = hci_find_remote_oob_data(hdev, &ev->bdaddr, BDADDR_BREDR);
-	if (data) {
-		if (bredr_sc_enabled(hdev)) {
-			struct hci_cp_remote_oob_ext_data_reply cp;
-
-			bacpy(&cp.bdaddr, &ev->bdaddr);
-			memcpy(cp.hash192, data->hash192, sizeof(cp.hash192));
-			memcpy(cp.rand192, data->rand192, sizeof(cp.rand192));
-			memcpy(cp.hash256, data->hash256, sizeof(cp.hash256));
-			memcpy(cp.rand256, data->rand256, sizeof(cp.rand256));
+	if (!data) {
+		struct hci_cp_remote_oob_data_neg_reply cp;
 
-			hci_send_cmd(hdev, HCI_OP_REMOTE_OOB_EXT_DATA_REPLY,
-				     sizeof(cp), &cp);
-		} else {
-			struct hci_cp_remote_oob_data_reply cp;
+		bacpy(&cp.bdaddr, &ev->bdaddr);
+		hci_send_cmd(hdev, HCI_OP_REMOTE_OOB_DATA_NEG_REPLY,
+			     sizeof(cp), &cp);
+		goto unlock;
+	}
 
-			bacpy(&cp.bdaddr, &ev->bdaddr);
-			memcpy(cp.hash, data->hash192, sizeof(cp.hash));
-			memcpy(cp.rand, data->rand192, sizeof(cp.rand));
+	if (bredr_sc_enabled(hdev)) {
+		struct hci_cp_remote_oob_ext_data_reply cp;
 
-			hci_send_cmd(hdev, HCI_OP_REMOTE_OOB_DATA_REPLY,
-				     sizeof(cp), &cp);
+		bacpy(&cp.bdaddr, &ev->bdaddr);
+		if (test_bit(HCI_SC_ONLY, &hdev->dev_flags)) {
+			memset(cp.hash192, 0, sizeof(cp.hash192));
+			memset(cp.rand192, 0, sizeof(cp.rand192));
+		} else {
+			memcpy(cp.hash192, data->hash192, sizeof(cp.hash192));
+			memcpy(cp.rand192, data->rand192, sizeof(cp.rand192));
 		}
+		memcpy(cp.hash256, data->hash256, sizeof(cp.hash256));
+		memcpy(cp.rand256, data->rand256, sizeof(cp.rand256));
+
+		hci_send_cmd(hdev, HCI_OP_REMOTE_OOB_EXT_DATA_REPLY,
+			     sizeof(cp), &cp);
 	} else {
-		struct hci_cp_remote_oob_data_neg_reply cp;
+		struct hci_cp_remote_oob_data_reply cp;
 
 		bacpy(&cp.bdaddr, &ev->bdaddr);
-		hci_send_cmd(hdev, HCI_OP_REMOTE_OOB_DATA_NEG_REPLY,
+		memcpy(cp.hash, data->hash192, sizeof(cp.hash));
+		memcpy(cp.rand, data->rand192, sizeof(cp.rand));
+
+		hci_send_cmd(hdev, HCI_OP_REMOTE_OOB_DATA_REPLY,
 			     sizeof(cp), &cp);
 	}
 
-- 
2.1.0

