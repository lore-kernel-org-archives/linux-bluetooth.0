Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 12/12] Bluetooth: Use hci_pend_le_action_lookup to look up report entries
Date: Fri,  4 Jul 2014 12:37:27 +0300
Message-Id: <1404466647-16352-13-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404466647-16352-1-git-send-email-johan.hedberg@gmail.com>
References: <1404466647-16352-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Instead of looking through the entire list of entries we can more
efficiently use the new hci_pend_le_action_lookup() function to look up
entries specifically in the pend_le_reports list. Since the search is
now limited to the right list we can also remove an unnecessary check
for list_empty() before the lookup.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 9274cd228995..c380545f1e92 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4244,14 +4244,12 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 				return;
 		}
 
-		if (list_empty(&hdev->pend_le_reports))
-			return;
-
 		if (type == LE_ADV_DIRECT_IND)
 			return;
 
-		param = hci_conn_params_lookup(hdev, bdaddr, bdaddr_type);
-		if (!param || param->auto_connect != HCI_AUTO_CONN_REPORT)
+		param = hci_pend_le_action_lookup(&hdev->pend_le_reports,
+						  bdaddr, bdaddr_type);
+		if (!param)
 			return;
 
 		if (type == LE_ADV_NONCONN_IND || type == LE_ADV_SCAN_IND)
-- 
1.9.3

