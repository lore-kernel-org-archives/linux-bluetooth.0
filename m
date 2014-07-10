Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: Refactor ioctl scan state update to its own function
Date: Thu, 10 Jul 2014 12:09:07 +0300
Message-Id: <1404983349-6105-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404983349-6105-1-git-send-email-johan.hedberg@gmail.com>
References: <1404983349-6105-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

With subsequent patches we'll also need to update the discoverable
state. As the code grows bigger it's better to move this out from the
switch statement into its own function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3844eeb85453..27c40e4901a3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2655,6 +2655,26 @@ done:
 	return ret;
 }
 
+static void hci_update_scan_state(struct hci_dev *hdev, u8 scan)
+{
+	bool conn_changed;
+
+	BT_DBG("%s scan 0x%02x", hdev->name, scan);
+
+	if ((scan & SCAN_PAGE))
+		conn_changed = !test_and_set_bit(HCI_CONNECTABLE,
+						 &hdev->dev_flags);
+	else
+		conn_changed = test_and_clear_bit(HCI_CONNECTABLE,
+						  &hdev->dev_flags);
+
+	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
+		return;
+
+	if (conn_changed)
+		mgmt_new_settings(hdev);
+}
+
 int hci_dev_cmd(unsigned int cmd, void __user *arg)
 {
 	struct hci_dev *hdev;
@@ -2719,19 +2739,8 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 		/* Ensure that the connectable state gets correctly
 		 * modified as this was a non-mgmt change.
 		 */
-		if (!err) {
-			bool changed;
-
-			if ((dr.dev_opt & SCAN_PAGE))
-				changed = !test_and_set_bit(HCI_CONNECTABLE,
-							    &hdev->dev_flags);
-			else
-				changed = test_and_clear_bit(HCI_CONNECTABLE,
-							     &hdev->dev_flags);
-
-			if (changed && test_bit(HCI_MGMT, &hdev->dev_flags))
-				mgmt_new_settings(hdev);
-		}
+		if (!err)
+			hci_update_scan_state(hdev, dr.dev_opt);
 		break;
 
 	case HCISETLINKPOL:
-- 
1.9.3

