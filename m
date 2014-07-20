Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Disable HCI_CONNECTABLE based passive scanning for now
Date: Sun, 20 Jul 2014 17:10:45 +0300
Message-Id: <1405865445-4441-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When HCI_CONNECTABLE is set the code has been enabling passive scanning
in order to be consistent with BR/EDR and accept connections from any
device doing directed advertising to us. However, some hardware
(particularly CSR) can get very noisy even when doing duplicates
filtering, making this feature waste resources.

Considering that the feature is for fairly corner-case use (devices
who'd use directed advertising would likely be in the whitelist anyway)
it's better to disable it for now. It may still be brought back later,
possibly with a better implementation (e.g. through improved scan
parameters).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f575abdf2b4e..f82a6cf1aaa8 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -5465,8 +5465,7 @@ void hci_update_background_scan(struct hci_dev *hdev)
 
 	hci_req_init(&req, hdev);
 
-	if (!test_bit(HCI_CONNECTABLE, &hdev->dev_flags) &&
-	    list_empty(&hdev->pend_le_conns) &&
+	if (list_empty(&hdev->pend_le_conns) &&
 	    list_empty(&hdev->pend_le_reports)) {
 		/* If there is no pending LE connections or devices
 		 * to be scanned for, we should stop the background
-- 
1.9.3

