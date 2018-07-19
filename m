Return-Path: <jaganath.k.os@gmail.com>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH v5 11/16] Bluetooth: Use Set ext adv/scan rsp data if controller supports
Date: Thu, 19 Jul 2018 17:09:42 +0530
Message-Id: <1532000387-3649-12-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1532000387-3649-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1532000387-3649-1-git-send-email-jaganathx.kanakkassery@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements Set Ext Adv data and Set Ext Scan rsp data
if controller support extended advertising.

Currently the operation is set as Complete data and fragment
preference is set as no fragment

< HCI Command: LE Set Extended Advertising Data (0x08|0x0037) plen 35
        Handle: 0x00
        Operation: Complete extended advertising data (0x03)
        Fragment preference: Minimize fragmentation (0x01)
        Data length: 0x15
        16-bit Service UUIDs (complete): 2 entries
          Heart Rate (0x180d)
          Battery Service (0x180f)
        Name (complete): Test LE
        Company: Google (224)
          Data: 0102
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Extended Advertising Data (0x08|0x0037) ncmd 1
        Status: Success (0x00)

Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
---
 include/net/bluetooth/hci.h |  22 ++++++++
 net/bluetooth/hci_event.c   |   2 +
 net/bluetooth/hci_request.c | 126 +++++++++++++++++++++++++++++++++-----------
 net/bluetooth/hci_request.h |   1 +
 net/bluetooth/mgmt.c        |  13 +++--
 5 files changed, 130 insertions(+), 34 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index b447b12..aace970 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1625,6 +1625,28 @@ struct hci_cp_ext_adv_set {
 	__u8  max_events;
 } __packed;
 
+#define HCI_OP_LE_SET_EXT_ADV_DATA		0x2037
+struct hci_cp_le_set_ext_adv_data {
+	__u8  handle;
+	__u8  operation;
+	__u8  frag_pref;
+	__u8  length;
+	__u8  data[HCI_MAX_AD_LENGTH];
+} __packed;
+
+#define HCI_OP_LE_SET_EXT_SCAN_RSP_DATA		0x2038
+struct hci_cp_le_set_ext_scan_rsp_data {
+	__u8  handle;
+	__u8  operation;
+	__u8  frag_pref;
+	__u8  length;
+	__u8  data[HCI_MAX_AD_LENGTH];
+} __packed;
+
+#define LE_SET_ADV_DATA_OP_COMPLETE	0x03
+
+#define LE_SET_ADV_DATA_NO_FRAG		0x01
+
 /* ---- HCI Events ---- */
 #define HCI_EV_INQUIRY_COMPLETE		0x01
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0418a55..0a92bf7 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1547,6 +1547,8 @@ static void hci_cc_set_ext_adv_param(struct hci_dev *hdev, struct sk_buff *skb)
 		if (adv_instance)
 			adv_instance->tx_power = rp->tx_power;
 	}
+	/* Update adv data as tx power is known now */
+	hci_req_update_adv_data(hdev, hdev->cur_adv_instance);
 	hci_dev_unlock(hdev);
 }
 
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 2ac9fd6..c41e9bb 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1174,29 +1174,58 @@ static u8 create_instance_scan_rsp_data(struct hci_dev *hdev, u8 instance,
 void __hci_req_update_scan_rsp_data(struct hci_request *req, u8 instance)
 {
 	struct hci_dev *hdev = req->hdev;
-	struct hci_cp_le_set_scan_rsp_data cp;
 	u8 len;
 
 	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
 		return;
 
-	memset(&cp, 0, sizeof(cp));
+	if (ext_adv_capable(hdev)) {
+		struct hci_cp_le_set_ext_scan_rsp_data cp;
 
-	if (instance)
-		len = create_instance_scan_rsp_data(hdev, instance, cp.data);
-	else
-		len = create_default_scan_rsp_data(hdev, cp.data);
+		memset(&cp, 0, sizeof(cp));
 
-	if (hdev->scan_rsp_data_len == len &&
-	    !memcmp(cp.data, hdev->scan_rsp_data, len))
-		return;
+		if (instance)
+			len = create_instance_scan_rsp_data(hdev, instance,
+							    cp.data);
+		else
+			len = create_default_scan_rsp_data(hdev, cp.data);
+
+		if (hdev->scan_rsp_data_len == len &&
+		    !memcmp(cp.data, hdev->scan_rsp_data, len))
+			return;
+
+		memcpy(hdev->scan_rsp_data, cp.data, sizeof(cp.data));
+		hdev->scan_rsp_data_len = len;
+
+		cp.handle = 0;
+		cp.length = len;
+		cp.operation = LE_SET_ADV_DATA_OP_COMPLETE;
+		cp.frag_pref = LE_SET_ADV_DATA_NO_FRAG;
+
+		hci_req_add(req, HCI_OP_LE_SET_EXT_SCAN_RSP_DATA, sizeof(cp),
+			    &cp);
+	} else {
+		struct hci_cp_le_set_scan_rsp_data cp;
+
+		memset(&cp, 0, sizeof(cp));
+
+		if (instance)
+			len = create_instance_scan_rsp_data(hdev, instance,
+							    cp.data);
+		else
+			len = create_default_scan_rsp_data(hdev, cp.data);
+
+		if (hdev->scan_rsp_data_len == len &&
+		    !memcmp(cp.data, hdev->scan_rsp_data, len))
+			return;
 
-	memcpy(hdev->scan_rsp_data, cp.data, sizeof(cp.data));
-	hdev->scan_rsp_data_len = len;
+		memcpy(hdev->scan_rsp_data, cp.data, sizeof(cp.data));
+		hdev->scan_rsp_data_len = len;
 
-	cp.length = len;
+		cp.length = len;
 
-	hci_req_add(req, HCI_OP_LE_SET_SCAN_RSP_DATA, sizeof(cp), &cp);
+		hci_req_add(req, HCI_OP_LE_SET_SCAN_RSP_DATA, sizeof(cp), &cp);
+	}
 }
 
 static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
@@ -1282,27 +1311,51 @@ static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 void __hci_req_update_adv_data(struct hci_request *req, u8 instance)
 {
 	struct hci_dev *hdev = req->hdev;
-	struct hci_cp_le_set_adv_data cp;
 	u8 len;
 
 	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
 		return;
 
-	memset(&cp, 0, sizeof(cp));
+	if (ext_adv_capable(hdev)) {
+		struct hci_cp_le_set_ext_adv_data cp;
 
-	len = create_instance_adv_data(hdev, instance, cp.data);
+		memset(&cp, 0, sizeof(cp));
 
-	/* There's nothing to do if the data hasn't changed */
-	if (hdev->adv_data_len == len &&
-	    memcmp(cp.data, hdev->adv_data, len) == 0)
-		return;
+		len = create_instance_adv_data(hdev, instance, cp.data);
+
+		/* There's nothing to do if the data hasn't changed */
+		if (hdev->adv_data_len == len &&
+		    memcmp(cp.data, hdev->adv_data, len) == 0)
+			return;
+
+		memcpy(hdev->adv_data, cp.data, sizeof(cp.data));
+		hdev->adv_data_len = len;
+
+		cp.length = len;
+		cp.handle = 0;
+		cp.operation = LE_SET_ADV_DATA_OP_COMPLETE;
+		cp.frag_pref = LE_SET_ADV_DATA_NO_FRAG;
 
-	memcpy(hdev->adv_data, cp.data, sizeof(cp.data));
-	hdev->adv_data_len = len;
+		hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_DATA, sizeof(cp), &cp);
+	} else {
+		struct hci_cp_le_set_adv_data cp;
+
+		memset(&cp, 0, sizeof(cp));
 
-	cp.length = len;
+		len = create_instance_adv_data(hdev, instance, cp.data);
+
+		/* There's nothing to do if the data hasn't changed */
+		if (hdev->adv_data_len == len &&
+		    memcmp(cp.data, hdev->adv_data, len) == 0)
+			return;
 
-	hci_req_add(req, HCI_OP_LE_SET_ADV_DATA, sizeof(cp), &cp);
+		memcpy(hdev->adv_data, cp.data, sizeof(cp.data));
+		hdev->adv_data_len = len;
+
+		cp.length = len;
+
+		hci_req_add(req, HCI_OP_LE_SET_ADV_DATA, sizeof(cp), &cp);
+	}
 }
 
 int hci_req_update_adv_data(struct hci_dev *hdev, u8 instance)
@@ -1377,8 +1430,7 @@ static void adv_timeout_expire(struct work_struct *work)
 	hci_dev_unlock(hdev);
 }
 
-static int __hci_req_setup_ext_adv_instance(struct hci_request *req,
-					    u8 instance)
+int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
 {
 	struct hci_cp_le_set_ext_adv_params cp;
 	struct hci_dev *hdev = req->hdev;
@@ -1453,6 +1505,7 @@ int __hci_req_start_ext_adv(struct hci_request *req, u8 instance)
 	if (err < 0)
 		return err;
 
+	__hci_req_update_scan_rsp_data(req, instance);
 	__hci_req_enable_ext_advertising(req);
 
 	return 0;
@@ -2500,14 +2553,25 @@ static int powered_update_hci(struct hci_request *req, unsigned long opt)
 		 */
 		if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
 		    list_empty(&hdev->adv_instances)) {
-			__hci_req_update_adv_data(req, 0x00);
-			__hci_req_update_scan_rsp_data(req, 0x00);
+			int err;
+
+			if (ext_adv_capable(hdev)) {
+				err = __hci_req_setup_ext_adv_instance(req,
+								       0x00);
+				if (!err)
+					__hci_req_update_scan_rsp_data(req,
+								       0x00);
+			} else {
+				err = 0;
+				__hci_req_update_adv_data(req, 0x00);
+				__hci_req_update_scan_rsp_data(req, 0x00);
+			}
 
 			if (hci_dev_test_flag(hdev, HCI_ADVERTISING)) {
-				if (ext_adv_capable(hdev))
-					__hci_req_start_ext_adv(req, 0x00);
-				else
+				if (!ext_adv_capable(hdev))
 					__hci_req_enable_advertising(req);
+				else if (!err)
+					__hci_req_enable_ext_advertising(req);
 			}
 		} else if (!list_empty(&hdev->adv_instances)) {
 			struct adv_info *adv_instance;
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 9b8c74d..6afc624 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -80,6 +80,7 @@ void hci_req_clear_adv_instance(struct hci_dev *hdev, struct sock *sk,
 				struct hci_request *req, u8 instance,
 				bool force);
 
+int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance);
 int __hci_req_start_ext_adv(struct hci_request *req, u8 instance);
 void __hci_req_enable_ext_advertising(struct hci_request *req);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 761a9ae..142f7e7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1847,10 +1847,17 @@ static void le_enable_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 	 */
 	if (hci_dev_test_flag(hdev, HCI_LE_ENABLED)) {
 		struct hci_request req;
-
 		hci_req_init(&req, hdev);
-		__hci_req_update_adv_data(&req, 0x00);
-		__hci_req_update_scan_rsp_data(&req, 0x00);
+		if (ext_adv_capable(hdev)) {
+			int err;
+
+			err = __hci_req_setup_ext_adv_instance(&req, 0x00);
+			if (!err)
+				__hci_req_update_scan_rsp_data(&req, 0x00);
+		} else {
+			__hci_req_update_adv_data(&req, 0x00);
+			__hci_req_update_scan_rsp_data(&req, 0x00);
+		}
 		hci_req_run(&req, NULL);
 		hci_update_background_scan(hdev);
 	}
-- 
2.7.4
