Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH 01/11] Bluetooth: Introduce helpers for LE set scan start and complete
Date: Fri, 23 Feb 2018 16:38:36 +0530
Message-Id: <1519384128-2016-2-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1519384128-2016-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1519384128-2016-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Introduce a helper hci_req_start_scan() which starts an LE
scan and call it from passive_Scan() and active_scan().
There is not functionality change in this patch.

This is basically done to enable extended scanning if the
controller supports which will be done in the subsequent
patch

Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
---
 net/bluetooth/hci_event.c   | 37 ++++++++++++++++-------------
 net/bluetooth/hci_request.c | 58 +++++++++++++++++++--------------------------
 2 files changed, 46 insertions(+), 49 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index cd3bbb7..e034ced 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1126,24 +1126,11 @@ static void store_pending_adv_report(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	d->last_adv_data_len = len;
 }
 
-static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
-				      struct sk_buff *skb)
+static void le_set_scan_enable_complete(struct hci_dev *hdev, u8 enable)
 {
-	struct hci_cp_le_set_scan_enable *cp;
-	__u8 status = *((__u8 *) skb->data);
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
-
-	if (status)
-		return;
-
-	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_SCAN_ENABLE);
-	if (!cp)
-		return;
-
 	hci_dev_lock(hdev);
 
-	switch (cp->enable) {
+	switch (enable) {
 	case LE_SCAN_ENABLE:
 		hci_dev_set_flag(hdev, HCI_LE_SCAN);
 		if (hdev->le_scan_type == LE_SCAN_ACTIVE)
@@ -1189,13 +1176,31 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 
 	default:
 		bt_dev_err(hdev, "use of reserved LE_Scan_Enable param %d",
-			   cp->enable);
+			   enable);
 		break;
 	}
 
 	hci_dev_unlock(hdev);
 }
 
+static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
+				      struct sk_buff *skb)
+{
+	struct hci_cp_le_set_scan_enable *cp;
+	__u8 status = *((__u8 *) skb->data);
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	if (status)
+		return;
+
+	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_SCAN_ENABLE);
+	if (!cp)
+		return;
+
+	le_set_scan_enable_complete(hdev, cp->enable);
+}
+
 static void hci_cc_le_read_white_list_size(struct hci_dev *hdev,
 					   struct sk_buff *skb)
 {
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 66c0781..d9d07c4 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -783,10 +783,30 @@ static bool scan_use_rpa(struct hci_dev *hdev)
 	return hci_dev_test_flag(hdev, HCI_PRIVACY);
 }
 
-void hci_req_add_le_passive_scan(struct hci_request *req)
+static void hci_req_start_scan(struct hci_request *req, u8 type, u16 interval,
+			       u16 window, u8 own_addr_type, u8 filter_policy)
 {
 	struct hci_cp_le_set_scan_param param_cp;
 	struct hci_cp_le_set_scan_enable enable_cp;
+
+	memset(&param_cp, 0, sizeof(param_cp));
+	param_cp.type = type;
+	param_cp.interval = cpu_to_le16(interval);
+	param_cp.window = cpu_to_le16(window);
+	param_cp.own_address_type = own_addr_type;
+	param_cp.filter_policy = filter_policy;
+	hci_req_add(req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(param_cp),
+		    &param_cp);
+
+	memset(&enable_cp, 0, sizeof(enable_cp));
+	enable_cp.enable = LE_SCAN_ENABLE;
+	enable_cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
+	hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
+		    &enable_cp);
+}
+
+void hci_req_add_le_passive_scan(struct hci_request *req)
+{
 	struct hci_dev *hdev = req->hdev;
 	u8 own_addr_type;
 	u8 filter_policy;
@@ -820,20 +840,8 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 	    (hdev->le_features[0] & HCI_LE_EXT_SCAN_POLICY))
 		filter_policy |= 0x02;
 
-	memset(&param_cp, 0, sizeof(param_cp));
-	param_cp.type = LE_SCAN_PASSIVE;
-	param_cp.interval = cpu_to_le16(hdev->le_scan_interval);
-	param_cp.window = cpu_to_le16(hdev->le_scan_window);
-	param_cp.own_address_type = own_addr_type;
-	param_cp.filter_policy = filter_policy;
-	hci_req_add(req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(param_cp),
-		    &param_cp);
-
-	memset(&enable_cp, 0, sizeof(enable_cp));
-	enable_cp.enable = LE_SCAN_ENABLE;
-	enable_cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
-	hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
-		    &enable_cp);
+	hci_req_start_scan(req, LE_SCAN_PASSIVE, hdev->le_scan_interval,
+			   hdev->le_scan_window, own_addr_type, filter_policy);
 }
 
 static u8 get_cur_adv_instance_scan_rsp_len(struct hci_dev *hdev)
@@ -2026,8 +2034,6 @@ static int active_scan(struct hci_request *req, unsigned long opt)
 {
 	uint16_t interval = opt;
 	struct hci_dev *hdev = req->hdev;
-	struct hci_cp_le_set_scan_param param_cp;
-	struct hci_cp_le_set_scan_enable enable_cp;
 	u8 own_addr_type;
 	int err;
 
@@ -2066,22 +2072,8 @@ static int active_scan(struct hci_request *req, unsigned long opt)
 	if (err < 0)
 		own_addr_type = ADDR_LE_DEV_PUBLIC;
 
-	memset(&param_cp, 0, sizeof(param_cp));
-	param_cp.type = LE_SCAN_ACTIVE;
-	param_cp.interval = cpu_to_le16(interval);
-	param_cp.window = cpu_to_le16(DISCOV_LE_SCAN_WIN);
-	param_cp.own_address_type = own_addr_type;
-
-	hci_req_add(req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(param_cp),
-		    &param_cp);
-
-	memset(&enable_cp, 0, sizeof(enable_cp));
-	enable_cp.enable = LE_SCAN_ENABLE;
-	enable_cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
-
-	hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
-		    &enable_cp);
-
+	hci_req_start_scan(req, LE_SCAN_ACTIVE, interval, DISCOV_LE_SCAN_WIN,
+			   own_addr_type, 0);
 	return 0;
 }
 
-- 
2.7.4

