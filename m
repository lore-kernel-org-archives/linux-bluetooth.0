Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix mgmt response status when removing adapter
Date: Fri, 12 Dec 2014 11:15:21 +0200
Message-Id: <1418375721-31057-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When an adapter is removed (hci_unregister_dev) any pending mgmt
commands for that adapter should get the appropriate INVALID_INDEX
response. Since hci_unregister_dev() calls hci_dev_do_close() first
that'd so far have caused "not powered" responses to be sent.

Skipping the HCI_UNREGISTER case in mgmt_powered() is also not a
solution since before reaching the mgmt_index_removed() stage any
hci_conn callbacks (e.g. used by pairing) will get called, thereby
causing "disconnected" status responses to be sent.

The fix that covers all scenarios is to handle both INVALID_INDEX and
NOT_POWERED responses through the mgmt_powered() function. The
INVALID_INDEX response sending from mgmt_index_removed() is left
untouched since there are a couple of places not related to powering off
or removing an adapter that call it (e.g. configuring a new bdaddr).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 827107d5a424..b0782668cd22 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6146,8 +6146,7 @@ static int powered_update_hci(struct hci_dev *hdev)
 int mgmt_powered(struct hci_dev *hdev, u8 powered)
 {
 	struct cmd_lookup match = { NULL, hdev };
-	u8 status_not_powered = MGMT_STATUS_NOT_POWERED;
-	u8 zero_cod[] = { 0, 0, 0 };
+	u8 status, zero_cod[] = { 0, 0, 0 };
 	int err;
 
 	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
@@ -6163,7 +6162,20 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
 	}
 
 	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
-	mgmt_pending_foreach(0, hdev, cmd_complete_rsp, &status_not_powered);
+
+	/* If the power off is because of hdev unregistration let
+	 * use the appropriate INVALID_INDEX status. Otherwise use
+	 * NOT_POWERED. We cover both scenarios here since later in
+	 * mgmt_index_removed() any hci_conn callbacks will have already
+	 * been triggered, potentially causing misleading DISCONNECTED
+	 * status responses.
+	 */
+	if (test_bit(HCI_UNREGISTER, &hdev->dev_flags))
+		status = MGMT_STATUS_INVALID_INDEX;
+	else
+		status = MGMT_STATUS_NOT_POWERED;
+
+	mgmt_pending_foreach(0, hdev, cmd_complete_rsp, &status);
 
 	if (memcmp(hdev->dev_class, zero_cod, sizeof(zero_cod)) != 0)
 		mgmt_event(MGMT_EV_CLASS_OF_DEV_CHANGED, hdev,
-- 
2.1.0

