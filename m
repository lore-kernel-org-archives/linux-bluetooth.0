Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/7] Bluetooth: Make mgmt_write_scan_failed() return void
Date: Tue, 15 Oct 2013 06:33:56 -0700
Message-Id: <1381844037-24424-7-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The return value of mgmt_write_scan_failed() function is not used
and so just change it to return void.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 2 +-
 net/bluetooth/mgmt.c             | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 997d43d..da21a8d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1102,7 +1102,7 @@ void mgmt_set_powered_failed(struct hci_dev *hdev, int err);
 int mgmt_powered(struct hci_dev *hdev, u8 powered);
 void mgmt_discoverable(struct hci_dev *hdev, u8 discoverable);
 void mgmt_connectable(struct hci_dev *hdev, u8 connectable);
-int mgmt_write_scan_failed(struct hci_dev *hdev, u8 scan, u8 status);
+void mgmt_write_scan_failed(struct hci_dev *hdev, u8 scan, u8 status);
 int mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 		      bool persistent);
 void mgmt_device_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9ffca59..12d1cb02 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4267,7 +4267,7 @@ void mgmt_connectable(struct hci_dev *hdev, u8 connectable)
 		new_settings(hdev, NULL);
 }
 
-int mgmt_write_scan_failed(struct hci_dev *hdev, u8 scan, u8 status)
+void mgmt_write_scan_failed(struct hci_dev *hdev, u8 scan, u8 status)
 {
 	u8 mgmt_err = mgmt_status(status);
 
@@ -4278,8 +4278,6 @@ int mgmt_write_scan_failed(struct hci_dev *hdev, u8 scan, u8 status)
 	if (scan & SCAN_INQUIRY)
 		mgmt_pending_foreach(MGMT_OP_SET_DISCOVERABLE, hdev,
 				     cmd_status_rsp, &mgmt_err);
-
-	return 0;
 }
 
 int mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
-- 
1.8.3.1

