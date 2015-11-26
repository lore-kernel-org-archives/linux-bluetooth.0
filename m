Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Remove unnecessary HCI_ADVERTISING_INSTANCE flag
Date: Thu, 26 Nov 2015 12:15:59 +0200
Message-Id: <1448532959-21912-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1448532959-21912-1-git-send-email-johan.hedberg@gmail.com>
References: <1448532959-21912-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This flag just tells us whether hdev->adv_instances is empty or not.
We can equally well use the list_empty() function to get this
information.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h |  1 -
 net/bluetooth/hci_request.c | 19 ++++++++-----------
 net/bluetooth/mgmt.c        |  8 +-------
 3 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index cc2216727655..339ea57be423 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -239,7 +239,6 @@ enum {
 	HCI_LE_ENABLED,
 	HCI_ADVERTISING,
 	HCI_ADVERTISING_CONNECTABLE,
-	HCI_ADVERTISING_INSTANCE,
 	HCI_CONNECTABLE,
 	HCI_DISCOVERABLE,
 	HCI_LIMITED_DISCOVERABLE,
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 7cc24f1448bd..adfcd6f1d0de 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -822,7 +822,7 @@ static u8 get_current_adv_instance(struct hci_dev *hdev)
 	 * setting was set. When neither apply, default to the global settings,
 	 * represented by instance "0".
 	 */
-	if (hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE) &&
+	if (!list_empty(&hdev->adv_instances) &&
 	    !hci_dev_test_flag(hdev, HCI_ADVERTISING))
 		return hdev->cur_adv_instance;
 
@@ -1144,7 +1144,7 @@ void hci_req_reenable_advertising(struct hci_dev *hdev)
 	u8 instance;
 
 	if (!hci_dev_test_flag(hdev, HCI_ADVERTISING) &&
-	    !hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE))
+	    list_empty(&hdev->adv_instances))
 		return;
 
 	instance = get_current_adv_instance(hdev);
@@ -1202,7 +1202,7 @@ int __hci_req_schedule_adv_instance(struct hci_request *req, u8 instance,
 	u16 timeout;
 
 	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
-	    !hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE))
+	    list_empty(&hdev->adv_instances))
 		return -EPERM;
 
 	if (hdev->adv_instance_timeout)
@@ -1319,10 +1319,8 @@ void hci_req_clear_adv_instance(struct hci_dev *hdev, struct hci_request *req,
 		}
 	}
 
-	if (list_empty(&hdev->adv_instances)) {
+	if (list_empty(&hdev->adv_instances))
 		hdev->cur_adv_instance = 0x00;
-		hci_dev_clear_flag(hdev, HCI_ADVERTISING_INSTANCE);
-	}
 
 	if (!req || !hdev_is_powered(hdev) ||
 	    hci_dev_test_flag(hdev, HCI_ADVERTISING))
@@ -1525,7 +1523,7 @@ static int connectable_update(struct hci_request *req, unsigned long opt)
 
 	/* Update the advertising parameters if necessary */
 	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
-	    hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE))
+	    !list_empty(&hdev->adv_instances))
 		__hci_req_enable_advertising(req);
 
 	__hci_update_background_scan(req);
@@ -2226,13 +2224,12 @@ static int powered_update_hci(struct hci_request *req, unsigned long opt)
 		 */
 		if (hci_dev_test_flag(hdev, HCI_LE_ENABLED) &&
 		    (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
-		     !hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE))) {
+		     list_empty(&hdev->adv_instances))) {
 			__hci_req_update_adv_data(req, HCI_ADV_CURRENT);
 			__hci_req_update_scan_rsp_data(req, HCI_ADV_CURRENT);
 		}
 
-		if (hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE) &&
-		    hdev->cur_adv_instance == 0x00 &&
+		if (hdev->cur_adv_instance == 0x00 &&
 		    !list_empty(&hdev->adv_instances)) {
 			adv_instance = list_first_entry(&hdev->adv_instances,
 							struct adv_info, list);
@@ -2241,7 +2238,7 @@ static int powered_update_hci(struct hci_request *req, unsigned long opt)
 
 		if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
 			__hci_req_enable_advertising(req);
-		else if (hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE) &&
+		else if (!list_empty(&hdev->adv_instances) &&
 			 hdev->cur_adv_instance)
 			__hci_req_schedule_adv_instance(req,
 							hdev->cur_adv_instance,
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9ce2bb2fc977..03a65e89a7d7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3734,7 +3734,6 @@ static void set_advertising_complete(struct hci_dev *hdev, u8 status,
 	 * set up earlier, then re-enable multi-instance advertising.
 	 */
 	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
-	    !hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE) ||
 	    list_empty(&hdev->adv_instances))
 		goto unlock;
 
@@ -5892,9 +5891,6 @@ static void add_advertising_complete(struct hci_dev *hdev, u8 status,
 
 	cmd = pending_find(MGMT_OP_ADD_ADVERTISING, hdev);
 
-	if (status)
-		hci_dev_clear_flag(hdev, HCI_ADVERTISING_INSTANCE);
-
 	list_for_each_entry_safe(adv_instance, n, &hdev->adv_instances, list) {
 		if (!adv_instance->pending)
 			continue;
@@ -6012,8 +6008,6 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 	if (hdev->adv_instance_cnt > prev_instance_cnt)
 		mgmt_advertising_added(sk, hdev, cp->instance);
 
-	hci_dev_set_flag(hdev, HCI_ADVERTISING_INSTANCE);
-
 	if (hdev->cur_adv_instance == cp->instance) {
 		/* If the currently advertised instance is being changed then
 		 * cancel the current advertising and schedule the next
@@ -6129,7 +6123,7 @@ static int remove_advertising(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
-	if (!hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE)) {
+	if (list_empty(&hdev->adv_instances)) {
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_REMOVE_ADVERTISING,
 				      MGMT_STATUS_INVALID_PARAMS);
 		goto unlock;
-- 
2.5.0

