Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/7] Bluetooth: Make mgmt_discoverable() return void
Date: Tue, 15 Oct 2013 06:33:54 -0700
Message-Id: <1381844037-24424-5-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The return value of mgmt_discoverable() function is not used
and so just change it to return void.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/mgmt.c             | 22 ++++++++--------------
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4a186ec..783c70cf30 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1100,7 +1100,7 @@ void mgmt_index_added(struct hci_dev *hdev);
 void mgmt_index_removed(struct hci_dev *hdev);
 void mgmt_set_powered_failed(struct hci_dev *hdev, int err);
 int mgmt_powered(struct hci_dev *hdev, u8 powered);
-int mgmt_discoverable(struct hci_dev *hdev, u8 discoverable);
+void mgmt_discoverable(struct hci_dev *hdev, u8 discoverable);
 int mgmt_connectable(struct hci_dev *hdev, u8 connectable);
 int mgmt_write_scan_failed(struct hci_dev *hdev, u8 scan, u8 status);
 int mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d5eaa28..62c5312 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4227,30 +4227,24 @@ void mgmt_set_powered_failed(struct hci_dev *hdev, int err)
 	mgmt_pending_remove(cmd);
 }
 
-int mgmt_discoverable(struct hci_dev *hdev, u8 discoverable)
+void mgmt_discoverable(struct hci_dev *hdev, u8 discoverable)
 {
-	bool changed = false;
-	int err = 0;
+	bool changed;
 
 	/* Nothing needed here if there's a pending command since that
 	 * commands request completion callback takes care of everything
 	 * necessary.
 	 */
 	if (mgmt_pending_find(MGMT_OP_SET_DISCOVERABLE, hdev))
-		return 0;
+		return;
 
-	if (discoverable) {
-		if (!test_and_set_bit(HCI_DISCOVERABLE, &hdev->dev_flags))
-			changed = true;
-	} else {
-		if (test_and_clear_bit(HCI_DISCOVERABLE, &hdev->dev_flags))
-			changed = true;
-	}
+	if (discoverable)
+		changed = !test_and_set_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
+	else
+		changed = test_and_clear_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
 
 	if (changed)
-		err = new_settings(hdev, NULL);
-
-	return err;
+		new_settings(hdev, NULL);
 }
 
 int mgmt_connectable(struct hci_dev *hdev, u8 connectable)
-- 
1.8.3.1

