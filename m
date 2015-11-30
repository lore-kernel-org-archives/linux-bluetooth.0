Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Clean up current advertising instance tracking
Date: Mon, 30 Nov 2015 11:21:45 +0200
Message-Id: <1448875305-1347-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1448875305-1347-1-git-send-email-johan.hedberg@gmail.com>
References: <1448875305-1347-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We can simplify a lot of code by making sure hdev->cur_adv_instance is
always up-to-date. This allows e.g. the removal of the
get_current_adv_instance() helper function and the special
HCI_ADV_CURRENT value. This patch also makes selecting instance 0x00
explicit in the various calls where advertising instances aren't
enabled, e.g. when HCI_ADVERTISING is set or we've just finished
enabling LE.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c    | 12 +++++---
 net/bluetooth/hci_request.c | 68 ++++++++++-----------------------------------
 net/bluetooth/hci_request.h |  8 ++----
 net/bluetooth/mgmt.c        | 10 ++++---
 4 files changed, 32 insertions(+), 66 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index eac3f6fa1272..9fb443a5473a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1769,7 +1769,7 @@ static void hci_update_scan_state(struct hci_dev *hdev, u8 scan)
 		hci_dev_set_flag(hdev, HCI_BREDR_ENABLED);
 
 		if (hci_dev_test_flag(hdev, HCI_LE_ENABLED))
-			hci_req_update_adv_data(hdev, HCI_ADV_CURRENT);
+			hci_req_update_adv_data(hdev, hdev->cur_adv_instance);
 
 		mgmt_new_settings(hdev);
 	}
@@ -2610,9 +2610,12 @@ int hci_remove_adv_instance(struct hci_dev *hdev, u8 instance)
 
 	BT_DBG("%s removing %dMR", hdev->name, instance);
 
-	if (hdev->cur_adv_instance == instance && hdev->adv_instance_timeout) {
-		cancel_delayed_work(&hdev->adv_instance_expire);
-		hdev->adv_instance_timeout = 0;
+	if (hdev->cur_adv_instance == instance) {
+		if (hdev->adv_instance_timeout) {
+			cancel_delayed_work(&hdev->adv_instance_expire);
+			hdev->adv_instance_timeout = 0;
+		}
+		hdev->cur_adv_instance = 0x00;
 	}
 
 	list_del(&adv_instance->list);
@@ -2639,6 +2642,7 @@ void hci_adv_instances_clear(struct hci_dev *hdev)
 	}
 
 	hdev->adv_instance_cnt = 0;
+	hdev->cur_adv_instance = 0x00;
 }
 
 /* This function requires the caller holds hdev->lock */
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 14db777a6bb1..9997c31ef987 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -815,23 +815,9 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 		    &enable_cp);
 }
 
-static u8 get_current_adv_instance(struct hci_dev *hdev)
-{
-	/* The "Set Advertising" setting supersedes the "Add Advertising"
-	 * setting. Here we set the advertising data based on which
-	 * setting was set. When neither apply, default to the global settings,
-	 * represented by instance "0".
-	 */
-	if (!list_empty(&hdev->adv_instances) &&
-	    !hci_dev_test_flag(hdev, HCI_ADVERTISING))
-		return hdev->cur_adv_instance;
-
-	return 0x00;
-}
-
 static u8 get_cur_adv_instance_scan_rsp_len(struct hci_dev *hdev)
 {
-	u8 instance = get_current_adv_instance(hdev);
+	u8 instance = hdev->cur_adv_instance;
 	struct adv_info *adv_instance;
 
 	/* Ignore instance 0 */
@@ -890,7 +876,6 @@ void __hci_req_enable_advertising(struct hci_request *req)
 	struct hci_cp_le_set_adv_param cp;
 	u8 own_addr_type, enable = 0x01;
 	bool connectable;
-	u8 instance;
 	u32 flags;
 
 	if (hci_conn_num(hdev, LE_LINK) > 0)
@@ -906,8 +891,7 @@ void __hci_req_enable_advertising(struct hci_request *req)
 	 */
 	hci_dev_clear_flag(hdev, HCI_LE_ADV);
 
-	instance = get_current_adv_instance(hdev);
-	flags = get_adv_instance_flags(hdev, instance);
+	flags = get_adv_instance_flags(hdev, hdev->cur_adv_instance);
 
 	/* If the "connectable" instance flag was not set, then choose between
 	 * ADV_IND and ADV_NONCONN_IND based on the global connectable setting.
@@ -985,7 +969,7 @@ static u8 create_instance_scan_rsp_data(struct hci_dev *hdev, u8 instance,
 	return adv_instance->scan_rsp_len;
 }
 
-static void update_inst_scan_rsp_data(struct hci_request *req, u8 instance)
+void __hci_req_update_scan_rsp_data(struct hci_request *req, u8 instance)
 {
 	struct hci_dev *hdev = req->hdev;
 	struct hci_cp_le_set_scan_rsp_data cp;
@@ -1013,14 +997,6 @@ static void update_inst_scan_rsp_data(struct hci_request *req, u8 instance)
 	hci_req_add(req, HCI_OP_LE_SET_SCAN_RSP_DATA, sizeof(cp), &cp);
 }
 
-void __hci_req_update_scan_rsp_data(struct hci_request *req, int instance)
-{
-	if (instance == HCI_ADV_CURRENT)
-		instance = get_current_adv_instance(req->hdev);
-
-	update_inst_scan_rsp_data(req, instance);
-}
-
 static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 {
 	struct adv_info *adv_instance = NULL;
@@ -1089,7 +1065,7 @@ static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 	return ad_len;
 }
 
-static void update_inst_adv_data(struct hci_request *req, u8 instance)
+void __hci_req_update_adv_data(struct hci_request *req, u8 instance)
 {
 	struct hci_dev *hdev = req->hdev;
 	struct hci_cp_le_set_adv_data cp;
@@ -1115,15 +1091,7 @@ static void update_inst_adv_data(struct hci_request *req, u8 instance)
 	hci_req_add(req, HCI_OP_LE_SET_ADV_DATA, sizeof(cp), &cp);
 }
 
-void __hci_req_update_adv_data(struct hci_request *req, int instance)
-{
-	if (instance == HCI_ADV_CURRENT)
-		instance = get_current_adv_instance(req->hdev);
-
-	update_inst_adv_data(req, instance);
-}
-
-int hci_req_update_adv_data(struct hci_dev *hdev, int instance)
+int hci_req_update_adv_data(struct hci_dev *hdev, u8 instance)
 {
 	struct hci_request req;
 
@@ -1141,21 +1109,19 @@ static void adv_enable_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 void hci_req_reenable_advertising(struct hci_dev *hdev)
 {
 	struct hci_request req;
-	u8 instance;
 
 	if (!hci_dev_test_flag(hdev, HCI_ADVERTISING) &&
 	    list_empty(&hdev->adv_instances))
 		return;
 
-	instance = get_current_adv_instance(hdev);
-
 	hci_req_init(&req, hdev);
 
-	if (instance) {
-		__hci_req_schedule_adv_instance(&req, instance, true);
+	if (hdev->cur_adv_instance) {
+		__hci_req_schedule_adv_instance(&req, hdev->cur_adv_instance,
+						true);
 	} else {
-		__hci_req_update_adv_data(&req, HCI_ADV_CURRENT);
-		__hci_req_update_scan_rsp_data(&req, HCI_ADV_CURRENT);
+		__hci_req_update_adv_data(&req, 0x00);
+		__hci_req_update_scan_rsp_data(&req, 0x00);
 		__hci_req_enable_advertising(&req);
 	}
 
@@ -1176,7 +1142,7 @@ static void adv_timeout_expire(struct work_struct *work)
 
 	hdev->adv_instance_timeout = 0;
 
-	instance = get_current_adv_instance(hdev);
+	instance = hdev->cur_adv_instance;
 	if (instance == 0x00)
 		goto unlock;
 
@@ -1246,8 +1212,8 @@ int __hci_req_schedule_adv_instance(struct hci_request *req, u8 instance,
 		return 0;
 
 	hdev->cur_adv_instance = instance;
-	__hci_req_update_adv_data(req, HCI_ADV_CURRENT);
-	__hci_req_update_scan_rsp_data(req, HCI_ADV_CURRENT);
+	__hci_req_update_adv_data(req, instance);
+	__hci_req_update_scan_rsp_data(req, instance);
 	__hci_req_enable_advertising(req);
 
 	return 0;
@@ -1301,7 +1267,6 @@ void hci_req_clear_adv_instance(struct hci_dev *hdev, struct hci_request *req,
 			if (!err)
 				mgmt_advertising_removed(NULL, hdev, rem_inst);
 		}
-		hdev->cur_adv_instance = 0x00;
 	} else {
 		adv_instance = hci_find_adv_instance(hdev, instance);
 
@@ -1318,9 +1283,6 @@ void hci_req_clear_adv_instance(struct hci_dev *hdev, struct hci_request *req,
 		}
 	}
 
-	if (list_empty(&hdev->adv_instances))
-		hdev->cur_adv_instance = 0x00;
-
 	if (!req || !hdev_is_powered(hdev) ||
 	    hci_dev_test_flag(hdev, HCI_ADVERTISING))
 		return;
@@ -1518,7 +1480,7 @@ static int connectable_update(struct hci_request *req, unsigned long opt)
 	 * advertising flags.
 	 */
 	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
-		__hci_req_update_adv_data(req, HCI_ADV_CURRENT);
+		__hci_req_update_adv_data(req, hdev->cur_adv_instance);
 
 	/* Update the advertising parameters if necessary */
 	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
@@ -1627,7 +1589,7 @@ static int discoverable_update(struct hci_request *req, unsigned long opt)
 	 * only update AD if advertising was enabled using Set Advertising.
 	 */
 	if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
-		__hci_req_update_adv_data(req, HCI_ADV_CURRENT);
+		__hci_req_update_adv_data(req, 0x00);
 
 	hci_dev_unlock(hdev);
 
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index a24d3b55094c..64ff8c040d50 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -64,14 +64,12 @@ void __hci_req_update_eir(struct hci_request *req);
 void hci_req_add_le_scan_disable(struct hci_request *req);
 void hci_req_add_le_passive_scan(struct hci_request *req);
 
-#define HCI_ADV_CURRENT (-1)
-
 void hci_req_reenable_advertising(struct hci_dev *hdev);
 void __hci_req_enable_advertising(struct hci_request *req);
 void __hci_req_disable_advertising(struct hci_request *req);
-void __hci_req_update_adv_data(struct hci_request *req, int instance);
-int hci_req_update_adv_data(struct hci_dev *hdev, int instance);
-void __hci_req_update_scan_rsp_data(struct hci_request *req, int instance);
+void __hci_req_update_adv_data(struct hci_request *req, u8 instance);
+int hci_req_update_adv_data(struct hci_dev *hdev, u8 instance);
+void __hci_req_update_scan_rsp_data(struct hci_request *req, u8 instance);
 
 int __hci_req_schedule_adv_instance(struct hci_request *req, u8 instance,
 				    bool force);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 03a65e89a7d7..621f6fdd0dd1 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1626,8 +1626,8 @@ static void le_enable_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 		struct hci_request req;
 
 		hci_req_init(&req, hdev);
-		__hci_req_update_adv_data(&req, HCI_ADV_CURRENT);
-		__hci_req_update_scan_rsp_data(&req, HCI_ADV_CURRENT);
+		__hci_req_update_adv_data(&req, 0x00);
+		__hci_req_update_scan_rsp_data(&req, 0x00);
 		hci_req_run(&req, NULL);
 		hci_update_background_scan(hdev);
 	}
@@ -3006,7 +3006,7 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 	 * no need to udpate the advertising data here.
 	 */
 	if (lmp_le_capable(hdev))
-		__hci_req_update_scan_rsp_data(&req, HCI_ADV_CURRENT);
+		__hci_req_update_scan_rsp_data(&req, hdev->cur_adv_instance);
 
 	err = hci_req_run(&req, set_name_complete);
 	if (err < 0)
@@ -3799,6 +3799,7 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 		bool changed;
 
 		if (cp->val) {
+			hdev->cur_adv_instance = 0x00;
 			changed = !hci_dev_test_and_set_flag(hdev, HCI_ADVERTISING);
 			if (cp->val == 0x02)
 				hci_dev_set_flag(hdev, HCI_ADVERTISING_CONNECTABLE);
@@ -3846,6 +3847,7 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 		 * We cannot use update_[adv|scan_rsp]_data() here as the
 		 * HCI_ADVERTISING flag is not yet set.
 		 */
+		hdev->cur_adv_instance = 0x00;
 		__hci_req_update_adv_data(&req, 0x00);
 		__hci_req_update_scan_rsp_data(&req, 0x00);
 		__hci_req_enable_advertising(&req);
@@ -4195,7 +4197,7 @@ static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	/* Since only the advertising data flags will change, there
 	 * is no need to update the scan response data.
 	 */
-	__hci_req_update_adv_data(&req, HCI_ADV_CURRENT);
+	__hci_req_update_adv_data(&req, hdev->cur_adv_instance);
 
 	err = hci_req_run(&req, set_bredr_complete);
 	if (err < 0)
-- 
2.5.0

