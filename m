Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove unnecessary params variable from process_adv_report()
Date: Tue, 15 Jul 2014 08:07:59 +0300
Message-Id: <1405400879-28788-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The params variable was just used for storing the return value from the
hci_pend_le_action_lookup() function and then checking whether it's NULL
or not. We can simplify the code by checking the return value directly.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8980bd24b8c0..bf2926b2e4a9 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4314,14 +4314,11 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	 * device found events.
 	 */
 	if (hdev->le_scan_type == LE_SCAN_PASSIVE) {
-		struct hci_conn_params *param;
-
 		if (type == LE_ADV_DIRECT_IND)
 			return;
 
-		param = hci_pend_le_action_lookup(&hdev->pend_le_reports,
-						  bdaddr, bdaddr_type);
-		if (!param)
+		if (!hci_pend_le_action_lookup(&hdev->pend_le_reports,
+					       bdaddr, bdaddr_type))
 			return;
 
 		if (type == LE_ADV_NONCONN_IND || type == LE_ADV_SCAN_IND)
-- 
1.9.3

