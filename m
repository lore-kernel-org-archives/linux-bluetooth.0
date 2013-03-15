Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 03/26] Bluetooth: Wait for HCI command completion with mgmt_set_powered
Date: Fri, 15 Mar 2013 17:06:53 -0500
Message-Id: <1363385236-25704-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1363385236-25704-1-git-send-email-johan.hedberg@gmail.com>
References: <1363385236-25704-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We should only notify user space that the adapter has been powered on
after all HCI commands related to the action have completed. This patch
fixes the issue by instating an async request complete callback for
these HCI commands and only notifies user space in the callback.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c |   46 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4726876..bf17a62 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3082,6 +3082,24 @@ static void set_bredr_scan(struct hci_request *req)
 		hci_req_add(req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
 }
 
+static void powered_complete(struct hci_dev *hdev, u8 status)
+{
+	struct cmd_lookup match = { NULL, hdev };
+
+	BT_DBG("status 0x%02x", status);
+
+	hci_dev_lock(hdev);
+
+	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
+
+	new_settings(hdev, match.sk);
+
+	hci_dev_unlock(hdev);
+
+	if (match.sk)
+		sock_put(match.sk);
+}
+
 static int powered_update_hci(struct hci_dev *hdev)
 {
 	struct hci_request req;
@@ -3123,32 +3141,36 @@ static int powered_update_hci(struct hci_dev *hdev)
 		update_eir(&req);
 	}
 
-	return hci_req_run(&req, NULL);
+	return hci_req_run(&req, powered_complete);
 }
 
 int mgmt_powered(struct hci_dev *hdev, u8 powered)
 {
 	struct cmd_lookup match = { NULL, hdev };
+	u8 status_not_powered = MGMT_STATUS_NOT_POWERED;
+	u8 zero_cod[] = { 0, 0, 0 };
 	int err;
 
 	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
 		return 0;
 
-	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
-
 	if (powered) {
-		powered_update_hci(hdev);
-	} else {
-		u8 status = MGMT_STATUS_NOT_POWERED;
-		u8 zero_cod[] = { 0, 0, 0 };
-
-		mgmt_pending_foreach(0, hdev, cmd_status_rsp, &status);
+		if (powered_update_hci(hdev) == 0)
+			return 0;
 
-		if (memcmp(hdev->dev_class, zero_cod, sizeof(zero_cod)) != 0)
-			mgmt_event(MGMT_EV_CLASS_OF_DEV_CHANGED, hdev,
-				   zero_cod, sizeof(zero_cod), NULL);
+		mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp,
+				     &match);
+		goto new_settings;
 	}
 
+	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
+	mgmt_pending_foreach(0, hdev, cmd_status_rsp, &status_not_powered);
+
+	if (memcmp(hdev->dev_class, zero_cod, sizeof(zero_cod)) != 0)
+		mgmt_event(MGMT_EV_CLASS_OF_DEV_CHANGED, hdev,
+			   zero_cod, sizeof(zero_cod), NULL);
+
+new_settings:
 	err = new_settings(hdev, match.sk);
 
 	if (match.sk)
-- 
1.7.10.4

