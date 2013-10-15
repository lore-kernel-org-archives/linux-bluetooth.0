Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/7] Bluetooth: Make mgmt_connectable() return void
Date: Tue, 15 Oct 2013 06:33:55 -0700
Message-Id: <1381844037-24424-6-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The return value of mgmt_connectable() function is not used
and so just change it to return void.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/mgmt.c             | 22 ++++++++--------------
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 783c70cf30..997d43d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1101,7 +1101,7 @@ void mgmt_index_removed(struct hci_dev *hdev);
 void mgmt_set_powered_failed(struct hci_dev *hdev, int err);
 int mgmt_powered(struct hci_dev *hdev, u8 powered);
 void mgmt_discoverable(struct hci_dev *hdev, u8 discoverable);
-int mgmt_connectable(struct hci_dev *hdev, u8 connectable);
+void mgmt_connectable(struct hci_dev *hdev, u8 connectable);
 int mgmt_write_scan_failed(struct hci_dev *hdev, u8 scan, u8 status);
 int mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 		      bool persistent);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 62c5312..9ffca59 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4247,30 +4247,24 @@ void mgmt_discoverable(struct hci_dev *hdev, u8 discoverable)
 		new_settings(hdev, NULL);
 }
 
-int mgmt_connectable(struct hci_dev *hdev, u8 connectable)
+void mgmt_connectable(struct hci_dev *hdev, u8 connectable)
 {
-	bool changed = false;
-	int err = 0;
+	bool changed;
 
 	/* Nothing needed here if there's a pending command since that
 	 * commands request completion callback takes care of everything
 	 * necessary.
 	 */
 	if (mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, hdev))
-		return 0;
+		return;
 
-	if (connectable) {
-		if (!test_and_set_bit(HCI_CONNECTABLE, &hdev->dev_flags))
-			changed = true;
-	} else {
-		if (test_and_clear_bit(HCI_CONNECTABLE, &hdev->dev_flags))
-			changed = true;
-	}
+	if (connectable)
+		changed = !test_and_set_bit(HCI_CONNECTABLE, &hdev->dev_flags);
+	else
+		changed = test_and_clear_bit(HCI_CONNECTABLE, &hdev->dev_flags);
 
 	if (changed)
-		err = new_settings(hdev, NULL);
-
-	return err;
+		new_settings(hdev, NULL);
 }
 
 int mgmt_write_scan_failed(struct hci_dev *hdev, u8 scan, u8 status)
-- 
1.8.3.1

