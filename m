Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix incorrectly disabling page scan when toggling connectable
Date: Mon, 28 Jul 2014 20:53:58 +0300
Message-Id: <1406570038-18842-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If we have entries in the whitelist we shouldn't disable page scanning
when disabling connectable mode. This patch adds the necessary check to
the Set Connectable command handler.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4d96913484cd..04fa7b2f8d7f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1881,7 +1881,18 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 		if (cp->val) {
 			scan = SCAN_PAGE;
 		} else {
-			scan = 0;
+			/* If we don't have any whitelist entries just
+			 * disable all scanning. If there are entries
+			 * and we had both page and inquiry scanning
+			 * enabled then fall back to only page scanning.
+			 * Otherwise no changes are needed.
+			 */
+			if (list_empty(&hdev->whitelist))
+				scan = SCAN_DISABLED;
+			else if (test_bit(HCI_ISCAN, &hdev->flags))
+				scan = SCAN_PAGE;
+			else
+				goto no_scan_update;
 
 			if (test_bit(HCI_ISCAN, &hdev->flags) &&
 			    hdev->discov_timeout > 0)
@@ -1891,6 +1902,7 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 		hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
 	}
 
+no_scan_update:
 	/* If we're going from non-connectable to connectable or
 	 * vice-versa when fast connectable is enabled ensure that fast
 	 * connectable gets disabled. write_fast_connectable won't do
-- 
1.9.3

