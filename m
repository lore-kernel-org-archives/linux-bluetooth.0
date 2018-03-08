Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH 4/7] Bluetooth: Implement disable and removal of adv instance
Date: Thu,  8 Mar 2018 17:09:33 +0530
Message-Id: <1520509176-17569-7-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1520509176-17569-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1520509176-17569-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If ext adv is enabled then use ext adv to disable as well.
Also remove the adv set during LE disable.

< HCI Command: LE Set Extended Advertising Enable (0x08|0x0039) plen 2
        Extended advertising: Disabled (0x00)
        Number of sets: Disable all sets (0x00)
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Extended Advertising Enable (0x08|0x0039) ncmd 2
        Status: Success (0x00)

Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
---
 include/net/bluetooth/hci.h |  7 +++++++
 net/bluetooth/hci_event.c   |  2 ++
 net/bluetooth/hci_request.c | 33 +++++++++++++++++++++++++++++++--
 net/bluetooth/hci_request.h |  1 +
 net/bluetooth/mgmt.c        |  2 ++
 5 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5e2a644..fd55abc 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1635,6 +1635,13 @@ struct hci_cp_le_set_ext_scan_rsp_data {
 
 #define LE_SET_ADV_DATA_NO_FRAG		0x01
 
+#define HCI_OP_LE_REMOVE_ADV_SET	0x203c
+struct hci_cp_le_remove_adv_set {
+	__u8  handle;
+} __packed;
+
+#define HCI_OP_LE_CLEAR_ADV_SETS	0x203d
+
 /* ---- HCI Events ---- */
 #define HCI_EV_INQUIRY_COMPLETE		0x01
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7d78170..4cc6161 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1159,6 +1159,8 @@ static void hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev,
 			queue_delayed_work(hdev->workqueue,
 					   &conn->le_conn_timeout,
 					   conn->conn_timeout);
+	} else {
+		hci_dev_clear_flag(hdev, HCI_LE_ADV);
 	}
 
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index ef8b816..137df28 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -949,9 +949,19 @@ static u8 get_cur_adv_instance_scan_rsp_len(struct hci_dev *hdev)
 
 void __hci_req_disable_advertising(struct hci_request *req)
 {
-	u8 enable = 0x00;
+	if (ext_adv_capable(req->hdev)) {
+		struct hci_cp_le_set_ext_adv_enable cp;
 
-	hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable), &enable);
+		cp.enable = 0x00;
+		/* Disable all adv sets */
+		cp.num_of_sets = 0x00;
+
+		hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_ENABLE, sizeof(cp), &cp);
+	} else {
+		u8 enable = 0x00;
+
+		hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable), &enable);
+	}
 }
 
 static u32 get_adv_instance_flags(struct hci_dev *hdev, u8 instance)
@@ -1433,6 +1443,22 @@ static void adv_timeout_expire(struct work_struct *work)
 	hci_dev_unlock(hdev);
 }
 
+void __hci_req_remove_ext_adv_set(struct hci_request *req, u8 instance)
+{
+	struct hci_cp_le_remove_adv_set cp;
+
+	memset(&cp, 0, sizeof(cp));
+
+	cp.handle = instance;
+
+	hci_req_add(req, HCI_OP_LE_REMOVE_ADV_SET, sizeof(cp), &cp);
+}
+
+void __hci_req_clear_ext_adv_sets(struct hci_request *req)
+{
+	hci_req_add(req, HCI_OP_LE_REMOVE_ADV_SET, 0, NULL);
+}
+
 void __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
 {
 	struct hci_cp_le_set_ext_adv_params cp;
@@ -1502,6 +1528,9 @@ int __hci_req_start_ext_adv(struct hci_request *req, u8 instance)
 	if (hci_conn_num(hdev, LE_LINK) > 0)
 		return -EPERM;
 
+	if (hci_dev_test_flag(hdev, HCI_LE_ADV))
+		__hci_req_disable_advertising(req);
+
 	__hci_req_setup_ext_adv_instance(req, instance);
 	__hci_req_update_adv_data(req, instance);
 	__hci_req_update_scan_rsp_data(req, instance);
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index caa970e..e9fd965 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -83,6 +83,7 @@ void hci_req_clear_adv_instance(struct hci_dev *hdev, struct sock *sk,
 void __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance);
 int __hci_req_start_ext_adv(struct hci_request *req, u8 instance);
 void __hci_req_enable_ext_advertising(struct hci_request *req);
+void __hci_req_clear_ext_adv_sets(struct hci_request *req);
 
 void __hci_req_update_class(struct hci_request *req);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 161197a..2639346 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1888,6 +1888,8 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	} else {
 		if (hci_dev_test_flag(hdev, HCI_LE_ADV))
 			__hci_req_disable_advertising(&req);
+
+		__hci_req_clear_ext_adv_sets(&req);
 	}
 
 	hci_req_add(&req, HCI_OP_WRITE_LE_HOST_SUPPORTED, sizeof(hci_cp),
-- 
2.7.4

