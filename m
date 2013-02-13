Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/12] Bluetooth: Fix mgmt powered indication by using a HCI transaction
Date: Wed, 13 Feb 2013 16:50:40 +0200
Message-Id: <1360767045-26958-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1360767045-26958-1-git-send-email-johan.hedberg@gmail.com>
References: <1360767045-26958-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The response to mgmt_set_powered should be returned only when all
related HCI commands have completed. To properly do this make use of a
HCI transaction with a callback to indicate its completion.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 39395c7..042a6c7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3058,19 +3058,33 @@ static int set_bredr_scan(struct hci_dev *hdev)
 	return hci_send_cmd(hdev, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
 }
 
+static void powered_complete(struct hci_dev *hdev, u16 opcode, int status)
+{
+	struct cmd_lookup match = { NULL, hdev };
+
+	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
+
+	new_settings(hdev, match.sk);
+
+	if (match.sk)
+		sock_put(match.sk);
+}
+
 int mgmt_powered(struct hci_dev *hdev, u8 powered)
 {
 	struct cmd_lookup match = { NULL, hdev };
+	u8 status = MGMT_STATUS_NOT_POWERED;
+	u8 zero_cod[] = { 0, 0, 0 };
 	int err;
 
 	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
 		return 0;
 
-	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
-
 	if (powered) {
 		u8 link_sec;
 
+		hci_start_transaction(hdev);
+
 		if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags) &&
 		    !lmp_host_ssp_capable(hdev)) {
 			u8 ssp = 1;
@@ -3105,17 +3119,28 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
 			update_name(hdev, hdev->dev_name);
 			update_eir(hdev);
 		}
-	} else {
-		u8 status = MGMT_STATUS_NOT_POWERED;
-		u8 zero_cod[] = { 0, 0, 0 };
 
-		mgmt_pending_foreach(0, hdev, cmd_status_rsp, &status);
+		err = hci_complete_transaction(hdev, powered_complete);
+		if (err == 0)
+			return 0;
 
-		if (memcmp(hdev->dev_class, zero_cod, sizeof(zero_cod)) != 0)
-			mgmt_event(MGMT_EV_CLASS_OF_DEV_CHANGED, hdev,
-				   zero_cod, sizeof(zero_cod), NULL);
+		/* If hci_complete_transaction fails it means no HCI
+		 * commands were pushed to the queue, i.e. we can go
+		 * ahead and indicate success directly.
+		 */
+		mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp,
+				     &match);
+		goto new_settings;
 	}
 
+	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
+	mgmt_pending_foreach(0, hdev, cmd_status_rsp, &status);
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

