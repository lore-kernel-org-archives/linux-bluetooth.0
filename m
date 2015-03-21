Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix memory leak in le_scan_disable_work_complete()
Date: Sat, 21 Mar 2015 08:02:23 +0200
Message-Id: <1426917743-10597-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The hci_request in le_scan_disable_work_complete() was being initialized
in a general context but only used in a specific branch in the function
(when simultaneous discovery is not supported). This patch moves the
usage to be limited to the branch where hci_req_run() is actually
called.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 773f2164d9a1..17f52a195ba8 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2874,7 +2874,6 @@ static void le_scan_disable_work_complete(struct hci_dev *hdev, u8 status,
 {
 	/* General inquiry access code (GIAC) */
 	u8 lap[3] = { 0x33, 0x8b, 0x9e };
-	struct hci_request req;
 	struct hci_cp_inquiry cp;
 	int err;
 
@@ -2893,13 +2892,6 @@ static void le_scan_disable_work_complete(struct hci_dev *hdev, u8 status,
 		break;
 
 	case DISCOV_TYPE_INTERLEAVED:
-		hci_req_init(&req, hdev);
-
-		memset(&cp, 0, sizeof(cp));
-		memcpy(&cp.lap, lap, sizeof(cp.lap));
-		cp.length = DISCOV_INTERLEAVED_INQUIRY_LEN;
-		hci_req_add(&req, HCI_OP_INQUIRY, sizeof(cp), &cp);
-
 		hci_dev_lock(hdev);
 
 		if (test_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY,
@@ -2914,8 +2906,17 @@ static void le_scan_disable_work_complete(struct hci_dev *hdev, u8 status,
 				hci_discovery_set_state(hdev,
 							DISCOVERY_STOPPED);
 		} else {
+			struct hci_request req;
+
 			hci_inquiry_cache_flush(hdev);
 
+			hci_req_init(&req, hdev);
+
+			memset(&cp, 0, sizeof(cp));
+			memcpy(&cp.lap, lap, sizeof(cp.lap));
+			cp.length = DISCOV_INTERLEAVED_INQUIRY_LEN;
+			hci_req_add(&req, HCI_OP_INQUIRY, sizeof(cp), &cp);
+
 			err = hci_req_run(&req, inquiry_complete);
 			if (err) {
 				BT_ERR("Inquiry request failed: err %d", err);
-- 
2.1.0

