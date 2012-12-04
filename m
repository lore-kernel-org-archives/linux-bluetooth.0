Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH 1/3] Bluetooth: Rename stop_discovery_failed() to
 stop_discovery_complete()
Date: Tue, 04 Dec 2012 15:59:25 +0530
Message-id: <1354616967-1088-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This renaming has done since in success case also this function can
be used to send complete event.

Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
---
 include/net/bluetooth/hci_core.h |    2 +-
 net/bluetooth/hci_event.c        |    4 ++--
 net/bluetooth/mgmt.c             |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ef5b85d..dfbba38 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1093,7 +1093,7 @@ int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		     u8 addr_type, s8 rssi, u8 *name, u8 name_len);
 int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status);
-int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status);
+int mgmt_stop_discovery_complete(struct hci_dev *hdev, u8 status);
 int mgmt_discovering(struct hci_dev *hdev, u8 discovering);
 int mgmt_interleaved_discovery(struct hci_dev *hdev);
 int mgmt_device_blocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 9f5c5f2..8f63298 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -42,7 +42,7 @@ static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (status) {
 		hci_dev_lock(hdev);
-		mgmt_stop_discovery_failed(hdev, status);
+		mgmt_stop_discovery_complete(hdev, status);
 		hci_dev_unlock(hdev);
 		return;
 	}
@@ -1266,7 +1266,7 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 	case LE_SCANNING_DISABLED:
 		if (status) {
 			hci_dev_lock(hdev);
-			mgmt_stop_discovery_failed(hdev, status);
+			mgmt_stop_discovery_complete(hdev, status);
 			hci_dev_unlock(hdev);
 			return;
 		}
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index dedbb1d..994f87b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3684,7 +3684,7 @@ int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status)
 	return err;
 }
 
-int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status)
+int mgmt_stop_discovery_complete(struct hci_dev *hdev, u8 status)
 {
 	struct pending_cmd *cmd;
 	int err;
-- 
1.7.9.5

