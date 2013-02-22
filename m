Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 11/15] Bluetooth: Wait for HCI command completion with mgmt_set_powered
Date: Fri, 22 Feb 2013 16:48:28 +0200
Message-Id: <1361544512-4056-12-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1361544512-4056-1-git-send-email-johan.hedberg@gmail.com>
References: <1361544512-4056-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We should only notify user space that the adapter has been powered on
after all HCI commands related to the action have completed. This patch
fixes the issue by instating a transaction complete callback for these
HCI commands and only notifies user space in the callback.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e76581d..b2a9697 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3091,12 +3091,26 @@ static int set_bredr_scan(struct hci_transaction *transaction)
 				   1, &scan);
 }
 
+static void powered_complete(struct hci_dev *hdev, u16 opcode, int status)
+{
+	struct cmd_lookup match = { NULL, hdev };
+
+	BT_DBG("opcode 0x%04x status %d", opcode, status);
+
+	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
+
+	new_settings(hdev, match.sk);
+
+	if (match.sk)
+		sock_put(match.sk);
+}
+
 static int powered_update_hci(struct hci_dev *hdev)
 {
 	struct hci_transaction transaction;
 	u8 link_sec;
 
-	hci_transaction_init(&transaction, hdev, NULL);
+	hci_transaction_init(&transaction, hdev, powered_complete);
 
 	if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags) &&
 			!lmp_host_ssp_capable(hdev)) {
@@ -3140,26 +3154,30 @@ static int powered_update_hci(struct hci_dev *hdev)
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
+		if (powered_update_hci(hdev) == 0)
+			return 0;
 
-		mgmt_pending_foreach(0, hdev, cmd_status_rsp, &status);
-
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

