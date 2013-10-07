Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/9] Bluetooth: Make mgmt_index_added() and mgmt_index_removed() return void
Date: Sun,  6 Oct 2013 23:55:45 -0700
Message-Id: <1381128953-32080-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The return value from mgmt_index_added() and mgmt_index_removed()
functions is never used. So do not pretend that returning an error
would actually be handled and just make both functions return void.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  4 ++--
 net/bluetooth/mgmt.c             | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d80d431..1e6f584 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1092,8 +1092,8 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event);
 #define DISCOV_BREDR_INQUIRY_LEN	0x08
 
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t len);
-int mgmt_index_added(struct hci_dev *hdev);
-int mgmt_index_removed(struct hci_dev *hdev);
+void mgmt_index_added(struct hci_dev *hdev);
+void mgmt_index_removed(struct hci_dev *hdev);
 int mgmt_set_powered_failed(struct hci_dev *hdev, int err);
 int mgmt_powered(struct hci_dev *hdev, u8 powered);
 int mgmt_discoverable(struct hci_dev *hdev, u8 discoverable);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3f628fd..811c411 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3782,24 +3782,24 @@ done:
 	return err;
 }
 
-int mgmt_index_added(struct hci_dev *hdev)
+void mgmt_index_added(struct hci_dev *hdev)
 {
 	if (hdev->dev_type != HCI_BREDR)
-		return -ENOTSUPP;
+		return;
 
-	return mgmt_event(MGMT_EV_INDEX_ADDED, hdev, NULL, 0, NULL);
+	mgmt_event(MGMT_EV_INDEX_ADDED, hdev, NULL, 0, NULL);
 }
 
-int mgmt_index_removed(struct hci_dev *hdev)
+void mgmt_index_removed(struct hci_dev *hdev)
 {
 	u8 status = MGMT_STATUS_INVALID_INDEX;
 
 	if (hdev->dev_type != HCI_BREDR)
-		return -ENOTSUPP;
+		return;
 
 	mgmt_pending_foreach(0, hdev, cmd_status_rsp, &status);
 
-	return mgmt_event(MGMT_EV_INDEX_REMOVED, hdev, NULL, 0, NULL);
+	mgmt_event(MGMT_EV_INDEX_REMOVED, hdev, NULL, 0, NULL);
 }
 
 static void set_bredr_scan(struct hci_request *req)
-- 
1.8.3.1

