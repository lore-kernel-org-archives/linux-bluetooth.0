Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH 02/11] Bluetooth: Use extended scanning if controller supports
Date: Fri, 23 Feb 2018 16:38:38 +0530
Message-Id: <1519384128-2016-4-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1519384128-2016-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1519384128-2016-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This implements Set extended scan param and set extended scan enable
commands and use it for start LE scan based on controller support.

The new features added in these commands are setting of new PHY for
scanning and setting of scan duration. Both features are disabled
for now, meaning only 1M PHY is set and scan duration is set to 0
which means that scanning will be done untill scan disable is called.

< HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 8
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
        PHYs: 0x01
        Entry 0: LE 1M
          Type: Active (0x01)
          Interval: 11.250 msec (0x0012)
          Window: 11.250 msec (0x0012)
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Extended Scan Parameters (0x08|0x0041) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6
        Extended scan: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)

Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
---
 include/net/bluetooth/hci.h      |  24 +++++++++
 include/net/bluetooth/hci_core.h |   4 ++
 net/bluetooth/hci_event.c        |  51 ++++++++++++++++++
 net/bluetooth/hci_request.c      | 110 ++++++++++++++++++++++++++++++---------
 4 files changed, 164 insertions(+), 25 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 1668211..0e73acd 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1506,6 +1506,30 @@ struct hci_cp_le_set_default_phy {
 	__u8    rx_phys;
 } __packed;
 
+#define HCI_OP_LE_SET_EXT_SCAN_PARAMS   0x2041
+struct hci_cp_le_set_ext_scan_params {
+	__u8    own_addr_type;
+	__u8    filter_policy;
+	__u8    scanning_phys;
+	__u8    data[0];
+} __packed;
+
+#define LE_SCAN_PHY_1M 0x01
+
+struct hci_cp_le_scan_phy_params {
+	__u8    type;
+	__le16  interval;
+	__le16  window;
+} __packed;
+
+#define HCI_OP_LE_SET_EXT_SCAN_ENABLE   0x2042
+struct hci_cp_le_set_ext_scan_enable {
+	__u8    enable;
+	__u8    filter_dup;
+	__le16  duration;
+	__le16  period;
+} __packed;
+
 /* ---- HCI Events ---- */
 #define HCI_EV_INQUIRY_COMPLETE		0x01
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 95ccc1e..4b32601 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1156,6 +1156,10 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define bredr_sc_enabled(dev)  (lmp_sc_capable(dev) && \
 				hci_dev_test_flag(dev, HCI_SC_ENABLED))
 
+/* Use ext scanning if set ext scan param and ext scan enable is supported */
+#define use_ext_scan(dev) (((dev)->commands[37] & 0x20) && \
+			   ((dev)->commands[37] & 0x40))
+
 /* ----- HCI protocols ----- */
 #define HCI_PROTO_DEFER             0x01
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index e034ced..e88bf51 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1097,6 +1097,31 @@ static void hci_cc_le_set_scan_param(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_unlock(hdev);
 }
 
+static void hci_cc_le_set_ext_scan_param(struct hci_dev *hdev,
+					 struct sk_buff *skb)
+{
+	struct hci_cp_le_set_ext_scan_params *cp;
+	__u8 status = *((__u8 *) skb->data);
+	struct hci_cp_le_scan_phy_params *phy_param;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	if (status)
+		return;
+
+	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_EXT_SCAN_PARAMS);
+	if (!cp)
+		return;
+
+	phy_param = (void *)cp->data;
+
+	hci_dev_lock(hdev);
+
+	hdev->le_scan_type = phy_param->type;
+
+	hci_dev_unlock(hdev);
+}
+
 static bool has_pending_adv_report(struct hci_dev *hdev)
 {
 	struct discovery_state *d = &hdev->discovery;
@@ -1201,6 +1226,24 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 	le_set_scan_enable_complete(hdev, cp->enable);
 }
 
+static void hci_cc_le_set_ext_scan_enable(struct hci_dev *hdev,
+				      struct sk_buff *skb)
+{
+	struct hci_cp_le_set_ext_scan_enable *cp;
+	__u8 status = *((__u8 *) skb->data);
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	if (status)
+		return;
+
+	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_EXT_SCAN_ENABLE);
+	if (!cp)
+		return;
+
+	le_set_scan_enable_complete(hdev, cp->enable);
+}
+
 static void hci_cc_le_read_white_list_size(struct hci_dev *hdev,
 					   struct sk_buff *skb)
 {
@@ -3044,6 +3087,14 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cc_write_ssp_debug_mode(hdev, skb);
 		break;
 
+	case HCI_OP_LE_SET_EXT_SCAN_PARAMS:
+		hci_cc_le_set_ext_scan_param(hdev, skb);
+		break;
+
+	case HCI_OP_LE_SET_EXT_SCAN_ENABLE:
+		hci_cc_le_set_ext_scan_enable(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%4.4x", hdev->name, *opcode);
 		break;
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index d9d07c4..f3def2e 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -663,11 +663,22 @@ void __hci_req_update_eir(struct hci_request *req)
 
 void hci_req_add_le_scan_disable(struct hci_request *req)
 {
-	struct hci_cp_le_set_scan_enable cp;
+	struct hci_dev *hdev = req->hdev;
 
-	memset(&cp, 0, sizeof(cp));
-	cp.enable = LE_SCAN_DISABLE;
-	hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
+	if (use_ext_scan(hdev)) {
+		struct hci_cp_le_set_ext_scan_enable cp;
+
+		memset(&cp, 0, sizeof(cp));
+		cp.enable = LE_SCAN_DISABLE;
+		hci_req_add(req, HCI_OP_LE_SET_EXT_SCAN_ENABLE, sizeof(cp),
+			    &cp);
+	} else {
+		struct hci_cp_le_set_scan_enable cp;
+
+		memset(&cp, 0, sizeof(cp));
+		cp.enable = LE_SCAN_DISABLE;
+		hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
+	}
 }
 
 static void add_to_white_list(struct hci_request *req,
@@ -786,23 +797,60 @@ static bool scan_use_rpa(struct hci_dev *hdev)
 static void hci_req_start_scan(struct hci_request *req, u8 type, u16 interval,
 			       u16 window, u8 own_addr_type, u8 filter_policy)
 {
-	struct hci_cp_le_set_scan_param param_cp;
-	struct hci_cp_le_set_scan_enable enable_cp;
-
-	memset(&param_cp, 0, sizeof(param_cp));
-	param_cp.type = type;
-	param_cp.interval = cpu_to_le16(interval);
-	param_cp.window = cpu_to_le16(window);
-	param_cp.own_address_type = own_addr_type;
-	param_cp.filter_policy = filter_policy;
-	hci_req_add(req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(param_cp),
-		    &param_cp);
+	struct hci_dev *hdev = req->hdev;
 
-	memset(&enable_cp, 0, sizeof(enable_cp));
-	enable_cp.enable = LE_SCAN_ENABLE;
-	enable_cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
-	hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
-		    &enable_cp);
+	/* Use ext scanning if set ext scan param and ext scan enable is
+	 * supported
+	 */
+	if (use_ext_scan(hdev)) {
+		struct hci_cp_le_set_ext_scan_params *ext_param_cp;
+		struct hci_cp_le_set_ext_scan_enable ext_enable_cp;
+		struct hci_cp_le_scan_phy_params *phy_params;
+		/* Ony single PHY (1M) is supported as of now */
+		u8 data[sizeof(*ext_param_cp) + sizeof(*phy_params) * 1];
+
+		ext_param_cp = (void *)data;
+		phy_params = (void *)ext_param_cp->data;
+
+		memset(ext_param_cp, 0, sizeof(*ext_param_cp));
+		ext_param_cp->own_addr_type = own_addr_type;
+		ext_param_cp->filter_policy = filter_policy;
+		ext_param_cp->scanning_phys = LE_SCAN_PHY_1M;
+
+		memset(phy_params, 0, sizeof(*phy_params));
+		phy_params->type = type;
+		phy_params->interval = cpu_to_le16(interval);
+		phy_params->window = cpu_to_le16(window);
+
+		hci_req_add(req, HCI_OP_LE_SET_EXT_SCAN_PARAMS,
+			    sizeof(*ext_param_cp) + sizeof(*phy_params),
+			    ext_param_cp);
+
+		memset(&ext_enable_cp, 0, sizeof(ext_enable_cp));
+		ext_enable_cp.enable = LE_SCAN_ENABLE;
+		ext_enable_cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
+
+		hci_req_add(req, HCI_OP_LE_SET_EXT_SCAN_ENABLE,
+			    sizeof(ext_enable_cp), &ext_enable_cp);
+	} else {
+		struct hci_cp_le_set_scan_param param_cp;
+		struct hci_cp_le_set_scan_enable enable_cp;
+
+		memset(&param_cp, 0, sizeof(param_cp));
+		param_cp.type = type;
+		param_cp.interval = cpu_to_le16(interval);
+		param_cp.window = cpu_to_le16(window);
+		param_cp.own_address_type = own_addr_type;
+		param_cp.filter_policy = filter_policy;
+		hci_req_add(req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(param_cp),
+			    &param_cp);
+
+		memset(&enable_cp, 0, sizeof(enable_cp));
+		enable_cp.enable = LE_SCAN_ENABLE;
+		enable_cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
+		hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
+			    &enable_cp);
+	}
 }
 
 void hci_req_add_le_passive_scan(struct hci_request *req)
@@ -1964,7 +2012,6 @@ static void le_scan_disable_work(struct work_struct *work)
 static int le_scan_restart(struct hci_request *req, unsigned long opt)
 {
 	struct hci_dev *hdev = req->hdev;
-	struct hci_cp_le_set_scan_enable cp;
 
 	/* If controller is not scanning we are done. */
 	if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
@@ -1972,10 +2019,23 @@ static int le_scan_restart(struct hci_request *req, unsigned long opt)
 
 	hci_req_add_le_scan_disable(req);
 
-	memset(&cp, 0, sizeof(cp));
-	cp.enable = LE_SCAN_ENABLE;
-	cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
-	hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
+	if (use_ext_scan(hdev)) {
+		struct hci_cp_le_set_ext_scan_enable ext_enable_cp;
+
+		memset(&ext_enable_cp, 0, sizeof(ext_enable_cp));
+		ext_enable_cp.enable = LE_SCAN_ENABLE;
+		ext_enable_cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
+
+		hci_req_add(req, HCI_OP_LE_SET_EXT_SCAN_ENABLE,
+			    sizeof(ext_enable_cp), &ext_enable_cp);
+	} else {
+		struct hci_cp_le_set_scan_enable cp;
+
+		memset(&cp, 0, sizeof(cp));
+		cp.enable = LE_SCAN_ENABLE;
+		cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
+		hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
+	}
 
 	return 0;
 }
-- 
2.7.4

