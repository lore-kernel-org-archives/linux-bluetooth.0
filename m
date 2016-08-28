Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: mgmt: Fix sending redundant event for Advertising Instance
Date: Sun, 28 Aug 2016 20:53:34 +0300
Message-Id: <1472406814-25388-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When an Advertising Instance is removed, the Advertising Removed event
shouldn't be sent to the same socket that issued the Remove
Advertising command (it gets a command complete event instead). The
mgmt_advertising_removed() function already has a parameter for
skipping a specific socket, but there was no code to propagate the
right value to this parameter. This patch fixes the issue by making
sure the intermediate hci_req_clear_adv_instance() function gets the
socket pointer.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_request.c | 11 ++++++-----
 net/bluetooth/hci_request.h |  5 +++--
 net/bluetooth/mgmt.c        |  6 +++---
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index c045b3c54768..d78469617c9b 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1192,7 +1192,7 @@ static void adv_timeout_expire(struct work_struct *work)
 
 	hci_req_init(&req, hdev);
 
-	hci_req_clear_adv_instance(hdev, &req, instance, false);
+	hci_req_clear_adv_instance(hdev, NULL, &req, instance, false);
 
 	if (list_empty(&hdev->adv_instances))
 		__hci_req_disable_advertising(&req);
@@ -1282,8 +1282,9 @@ static void cancel_adv_timeout(struct hci_dev *hdev)
  *   setting.
  * - force == false: Only instances that have a timeout will be removed.
  */
-void hci_req_clear_adv_instance(struct hci_dev *hdev, struct hci_request *req,
-				u8 instance, bool force)
+void hci_req_clear_adv_instance(struct hci_dev *hdev, struct sock *sk,
+				struct hci_request *req, u8 instance,
+				bool force)
 {
 	struct adv_info *adv_instance, *n, *next_instance = NULL;
 	int err;
@@ -1309,7 +1310,7 @@ void hci_req_clear_adv_instance(struct hci_dev *hdev, struct hci_request *req,
 			rem_inst = adv_instance->instance;
 			err = hci_remove_adv_instance(hdev, rem_inst);
 			if (!err)
-				mgmt_advertising_removed(NULL, hdev, rem_inst);
+				mgmt_advertising_removed(sk, hdev, rem_inst);
 		}
 	} else {
 		adv_instance = hci_find_adv_instance(hdev, instance);
@@ -1323,7 +1324,7 @@ void hci_req_clear_adv_instance(struct hci_dev *hdev, struct hci_request *req,
 
 			err = hci_remove_adv_instance(hdev, instance);
 			if (!err)
-				mgmt_advertising_removed(NULL, hdev, instance);
+				mgmt_advertising_removed(sk, hdev, instance);
 		}
 	}
 
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index b2d044bdc732..ac1e11006f38 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -73,8 +73,9 @@ void __hci_req_update_scan_rsp_data(struct hci_request *req, u8 instance);
 
 int __hci_req_schedule_adv_instance(struct hci_request *req, u8 instance,
 				    bool force);
-void hci_req_clear_adv_instance(struct hci_dev *hdev, struct hci_request *req,
-				u8 instance, bool force);
+void hci_req_clear_adv_instance(struct hci_dev *hdev, struct sock *sk,
+				struct hci_request *req, u8 instance,
+				bool force);
 
 void __hci_req_update_class(struct hci_request *req);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9071886df194..f9af5f7c2ea2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -929,7 +929,7 @@ static int clean_up_hci_state(struct hci_dev *hdev)
 		hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
 	}
 
-	hci_req_clear_adv_instance(hdev, NULL, 0x00, false);
+	hci_req_clear_adv_instance(hdev, NULL, NULL, 0x00, false);
 
 	if (hci_dev_test_flag(hdev, HCI_LE_ADV))
 		__hci_req_disable_advertising(&req);
@@ -1697,7 +1697,7 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	enabled = lmp_host_le_capable(hdev);
 
 	if (!val)
-		hci_req_clear_adv_instance(hdev, NULL, 0x00, true);
+		hci_req_clear_adv_instance(hdev, NULL, NULL, 0x00, true);
 
 	if (!hdev_is_powered(hdev) || val == enabled) {
 		bool changed = false;
@@ -6182,7 +6182,7 @@ static int remove_advertising(struct sock *sk, struct hci_dev *hdev,
 
 	hci_req_init(&req, hdev);
 
-	hci_req_clear_adv_instance(hdev, &req, cp->instance, true);
+	hci_req_clear_adv_instance(hdev, sk, &req, cp->instance, true);
 
 	if (list_empty(&hdev->adv_instances))
 		__hci_req_disable_advertising(&req);
-- 
2.7.4

