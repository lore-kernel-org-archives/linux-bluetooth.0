Return-Path: <jaganath.k.os@gmail.com>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH v5 12/16] Bluetooth: Implement disable and removal of adv instance
Date: Thu, 19 Jul 2018 17:09:43 +0530
Message-Id: <1532000387-3649-13-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1532000387-3649-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1532000387-3649-1-git-send-email-jaganathx.kanakkassery@intel.com>
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
 include/net/bluetooth/hci.h |  2 ++
 net/bluetooth/hci_event.c   |  2 ++
 net/bluetooth/hci_request.c | 23 +++++++++++++++++++++--
 net/bluetooth/hci_request.h |  1 +
 net/bluetooth/mgmt.c        |  3 +++
 5 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index aace970..faa2922 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1647,6 +1647,8 @@ struct hci_cp_le_set_ext_scan_rsp_data {
 
 #define LE_SET_ADV_DATA_NO_FRAG		0x01
 
+#define HCI_OP_LE_CLEAR_ADV_SETS	0x203d
+
 /* ---- HCI Events ---- */
 #define HCI_EV_INQUIRY_COMPLETE		0x01
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0a92bf7..a78d1dd 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1129,6 +1129,8 @@ static void hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev,
 			queue_delayed_work(hdev->workqueue,
 					   &conn->le_conn_timeout,
 					   conn->conn_timeout);
+	} else {
+		hci_dev_clear_flag(hdev, HCI_LE_ADV);
 	}
 
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index c41e9bb..96e1e05 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -934,9 +934,19 @@ static u8 get_cur_adv_instance_scan_rsp_len(struct hci_dev *hdev)
 
 void __hci_req_disable_advertising(struct hci_request *req)
 {
-	u8 enable = 0x00;
+	if (ext_adv_capable(req->hdev)) {
+		struct hci_cp_le_set_ext_adv_enable cp;
 
-	hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable), &enable);
+		cp.enable = 0x00;
+		/* Disable all sets since we only support one set at the moment */
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
@@ -1430,6 +1440,11 @@ static void adv_timeout_expire(struct work_struct *work)
 	hci_dev_unlock(hdev);
 }
 
+void __hci_req_clear_ext_adv_sets(struct hci_request *req)
+{
+	hci_req_add(req, HCI_OP_LE_CLEAR_ADV_SETS, 0, NULL);
+}
+
 int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
 {
 	struct hci_cp_le_set_ext_adv_params cp;
@@ -1499,8 +1514,12 @@ void __hci_req_enable_ext_advertising(struct hci_request *req)
 
 int __hci_req_start_ext_adv(struct hci_request *req, u8 instance)
 {
+	struct hci_dev *hdev = req->hdev;
 	int err;
 
+	if (hci_dev_test_flag(hdev, HCI_LE_ADV))
+		__hci_req_disable_advertising(req);
+
 	err = __hci_req_setup_ext_adv_instance(req, instance);
 	if (err < 0)
 		return err;
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 6afc624..2451861 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -83,6 +83,7 @@ void hci_req_clear_adv_instance(struct hci_dev *hdev, struct sock *sk,
 int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance);
 int __hci_req_start_ext_adv(struct hci_request *req, u8 instance);
 void __hci_req_enable_ext_advertising(struct hci_request *req);
+void __hci_req_clear_ext_adv_sets(struct hci_request *req);
 
 void __hci_req_update_class(struct hci_request *req);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 142f7e7..c283f03 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1956,6 +1956,9 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	} else {
 		if (hci_dev_test_flag(hdev, HCI_LE_ADV))
 			__hci_req_disable_advertising(&req);
+
+		if (ext_adv_capable(hdev))
+			__hci_req_clear_ext_adv_sets(&req);
 	}
 
 	hci_req_add(&req, HCI_OP_WRITE_LE_HOST_SUPPORTED, sizeof(hci_cp),
-- 
2.7.4
