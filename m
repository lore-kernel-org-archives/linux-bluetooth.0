Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Simplify request cleanup code
Date: Thu, 12 Nov 2015 15:15:00 +0200
Message-Id: <1447334100-10167-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The hci_req_sync_cancel() is just as much related to the request
cleanup as hci_request_cancel_all() is. Just move the former into the
latter and do the cleanup from a single place in hci_dev_do_close().
The important thing is to avoid deadlocks by holding the req_sync
lock: previously hci_request_cancel_all was done right after releasing
the lock and with this patch it's right before taking it.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c    | 4 +---
 net/bluetooth/hci_request.c | 2 ++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index fb618d6bcded..63fd31d7b27a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1523,7 +1523,7 @@ int hci_dev_do_close(struct hci_dev *hdev)
 
 	cancel_delayed_work(&hdev->power_off);
 
-	hci_req_sync_cancel(hdev, ENODEV);
+	hci_request_cancel_all(hdev);
 	hci_req_sync_lock(hdev);
 
 	if (!test_and_clear_bit(HCI_UP, &hdev->flags)) {
@@ -1625,8 +1625,6 @@ int hci_dev_do_close(struct hci_dev *hdev)
 
 	hci_req_sync_unlock(hdev);
 
-	hci_request_cancel_all(hdev);
-
 	hci_dev_put(hdev);
 	return 0;
 }
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index e8345d8106b5..76bd912be9fe 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1270,6 +1270,8 @@ void hci_request_setup(struct hci_dev *hdev)
 
 void hci_request_cancel_all(struct hci_dev *hdev)
 {
+	hci_req_sync_cancel(hdev, ENODEV);
+
 	cancel_work_sync(&hdev->discov_update);
 	cancel_work_sync(&hdev->bg_scan_update);
 	cancel_delayed_work_sync(&hdev->le_scan_disable);
-- 
2.5.0

