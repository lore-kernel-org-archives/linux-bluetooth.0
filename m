Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Clean up advertising initialization in powered_update_hci()
Date: Mon, 30 Nov 2015 11:21:44 +0200
Message-Id: <1448875305-1347-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1448875305-1347-1-git-send-email-johan.hedberg@gmail.com>
References: <1448875305-1347-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The logic in powered_update_hci() to initialize the advertising data &
state is a bit more complicated than it needs to be. It was previously
not doing anything if HCI_LE_ENABLED wasn't set, but this was not
obvious by quickly looking at the code. Now the conditions for the
various actions are more explicit. Another simplification is due to
the fact that __hci_req_schedule_adv_instance() takes care of setting
hdev->cur_adv_instance so there's no need to set it before calling the
function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_request.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index f1529d7740f6..14db777a6bb1 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -2181,7 +2181,6 @@ static void discov_off(struct work_struct *work)
 static int powered_update_hci(struct hci_request *req, unsigned long opt)
 {
 	struct hci_dev *hdev = req->hdev;
-	struct adv_info *adv_instance;
 	u8 link_sec;
 
 	hci_dev_lock(hdev);
@@ -2216,32 +2215,27 @@ static int powered_update_hci(struct hci_request *req, unsigned long opt)
 				    sizeof(cp), &cp);
 	}
 
-	if (lmp_le_capable(hdev)) {
+	if (hci_dev_test_flag(hdev, HCI_LE_ENABLED)) {
 		/* Make sure the controller has a good default for
 		 * advertising data. This also applies to the case
 		 * where BR/EDR was toggled during the AUTO_OFF phase.
 		 */
-		if (hci_dev_test_flag(hdev, HCI_LE_ENABLED) &&
-		    (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
-		     list_empty(&hdev->adv_instances))) {
-			__hci_req_update_adv_data(req, HCI_ADV_CURRENT);
-			__hci_req_update_scan_rsp_data(req, HCI_ADV_CURRENT);
-		}
+		if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
+		    list_empty(&hdev->adv_instances)) {
+			__hci_req_update_adv_data(req, 0x00);
+			__hci_req_update_scan_rsp_data(req, 0x00);
+
+			if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
+				__hci_req_enable_advertising(req);
+		} else if (!list_empty(&hdev->adv_instances)) {
+			struct adv_info *adv_instance;
 
-		if (hdev->cur_adv_instance == 0x00 &&
-		    !list_empty(&hdev->adv_instances)) {
 			adv_instance = list_first_entry(&hdev->adv_instances,
 							struct adv_info, list);
-			hdev->cur_adv_instance = adv_instance->instance;
-		}
-
-		if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
-			__hci_req_enable_advertising(req);
-		else if (!list_empty(&hdev->adv_instances) &&
-			 hdev->cur_adv_instance)
 			__hci_req_schedule_adv_instance(req,
-							hdev->cur_adv_instance,
+							adv_instance->instance,
 							true);
+		}
 	}
 
 	link_sec = hci_dev_test_flag(hdev, HCI_LINK_SECURITY);
-- 
2.5.0

