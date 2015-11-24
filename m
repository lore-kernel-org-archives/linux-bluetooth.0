Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 24 Nov 2015 14:11:16 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/7] Bluetooth: Perform Class of Device changes through
 hdev->req_workqueue
Message-ID: <20151124121116.GA31276@t440s.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1448366527-29714-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The Class of Device needs to be changed e.g. for limited discoverable
mode. In preparation of moving the discoverable mode to hci_request.c
and hdev->req_workqueue, move the Class of Device helpers there first.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_request.c | 40 +++++++++++++++++++++++++++++++++
 net/bluetooth/hci_request.h |  2 ++
 net/bluetooth/mgmt.c        | 54 ++++++---------------------------------------
 3 files changed, 49 insertions(+), 47 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 167c90644b4b..e5e827b762b9 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1311,6 +1311,46 @@ static void connectable_update_work(struct work_struct *work)
 	mgmt_set_connectable_complete(hdev, status);
 }
 
+static u8 get_service_classes(struct hci_dev *hdev)
+{
+	struct bt_uuid *uuid;
+	u8 val = 0;
+
+	list_for_each_entry(uuid, &hdev->uuids, list)
+		val |= uuid->svc_hint;
+
+	return val;
+}
+
+void __hci_req_update_class(struct hci_request *req)
+{
+	struct hci_dev *hdev = req->hdev;
+	u8 cod[3];
+
+	BT_DBG("%s", hdev->name);
+
+	if (!hdev_is_powered(hdev))
+		return;
+
+	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
+		return;
+
+	if (hci_dev_test_flag(hdev, HCI_SERVICE_CACHE))
+		return;
+
+	cod[0] = hdev->minor_class;
+	cod[1] = hdev->major_class;
+	cod[2] = get_service_classes(hdev);
+
+	if (hci_dev_test_flag(hdev, HCI_LIMITED_DISCOVERABLE))
+		cod[1] |= 0x20;
+
+	if (memcmp(cod, hdev->dev_class, 3) == 0)
+		return;
+
+	hci_req_add(req, HCI_OP_WRITE_CLASS_OF_DEV, sizeof(cod), cod);
+}
+
 void __hci_abort_conn(struct hci_request *req, struct hci_conn *conn,
 		      u8 reason)
 {
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 5358b1b12ca0..41920348d68b 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -72,6 +72,8 @@ int __hci_req_schedule_adv_instance(struct hci_request *req, u8 instance,
 void hci_req_clear_adv_instance(struct hci_dev *hdev, struct hci_request *req,
 				u8 instance, bool force);
 
+void __hci_req_update_class(struct hci_request *req);
+
 /* Returns true if HCI commands were queued */
 bool hci_req_stop_discovery(struct hci_request *req);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d8b76ca5c820..f5a4ee92f2bf 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -959,46 +959,6 @@ static void update_eir(struct hci_request *req)
 	hci_req_add(req, HCI_OP_WRITE_EIR, sizeof(cp), &cp);
 }
 
-static u8 get_service_classes(struct hci_dev *hdev)
-{
-	struct bt_uuid *uuid;
-	u8 val = 0;
-
-	list_for_each_entry(uuid, &hdev->uuids, list)
-		val |= uuid->svc_hint;
-
-	return val;
-}
-
-static void update_class(struct hci_request *req)
-{
-	struct hci_dev *hdev = req->hdev;
-	u8 cod[3];
-
-	BT_DBG("%s", hdev->name);
-
-	if (!hdev_is_powered(hdev))
-		return;
-
-	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
-		return;
-
-	if (hci_dev_test_flag(hdev, HCI_SERVICE_CACHE))
-		return;
-
-	cod[0] = hdev->minor_class;
-	cod[1] = hdev->major_class;
-	cod[2] = get_service_classes(hdev);
-
-	if (hci_dev_test_flag(hdev, HCI_LIMITED_DISCOVERABLE))
-		cod[1] |= 0x20;
-
-	if (memcmp(cod, hdev->dev_class, 3) == 0)
-		return;
-
-	hci_req_add(req, HCI_OP_WRITE_CLASS_OF_DEV, sizeof(cod), cod);
-}
-
 static void service_cache_off(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
@@ -1013,7 +973,7 @@ static void service_cache_off(struct work_struct *work)
 	hci_dev_lock(hdev);
 
 	update_eir(&req);
-	update_class(&req);
+	__hci_req_update_class(&req);
 
 	hci_dev_unlock(hdev);
 
@@ -1370,7 +1330,7 @@ static void set_discoverable_complete(struct hci_dev *hdev, u8 status,
 	 */
 	hci_req_init(&req, hdev);
 	__hci_req_update_scan(&req);
-	update_class(&req);
+	__hci_req_update_class(&req);
 	hci_req_run(&req, NULL);
 
 remove_cmd:
@@ -2177,7 +2137,7 @@ static int add_uuid(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	hci_req_init(&req, hdev);
 
-	update_class(&req);
+	__hci_req_update_class(&req);
 	update_eir(&req);
 
 	err = hci_req_run(&req, add_uuid_complete);
@@ -2277,7 +2237,7 @@ static int remove_uuid(struct sock *sk, struct hci_dev *hdev, void *data,
 update_class:
 	hci_req_init(&req, hdev);
 
-	update_class(&req);
+	__hci_req_update_class(&req);
 	update_eir(&req);
 
 	err = hci_req_run(&req, remove_uuid_complete);
@@ -2356,7 +2316,7 @@ static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
 		update_eir(&req);
 	}
 
-	update_class(&req);
+	__hci_req_update_class(&req);
 
 	err = hci_req_run(&req, set_class_complete);
 	if (err < 0) {
@@ -6871,7 +6831,7 @@ static int powered_update_hci(struct hci_dev *hdev)
 		else
 			write_fast_connectable(&req, false);
 		__hci_req_update_scan(&req);
-		update_class(&req);
+		__hci_req_update_class(&req);
 		update_name(&req);
 		update_eir(&req);
 	}
@@ -6972,7 +6932,7 @@ void mgmt_discoverable_timeout(struct hci_dev *hdev)
 		hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE,
 			    sizeof(scan), &scan);
 	}
-	update_class(&req);
+	__hci_req_update_class(&req);
 
 	/* Advertising instances don't use the global discoverable setting, so
 	 * only update AD if advertising was enabled using Set Advertising.
-- 
2.5.0

