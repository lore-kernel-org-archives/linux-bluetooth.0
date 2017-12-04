Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [RFC 3/9] Bluetooth: Use Set ext adv/scan rsp data if controller supports
Date: Mon,  4 Dec 2017 13:37:47 +0530
Message-Id: <1512374873-1956-4-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1512374873-1956-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1512374873-1956-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements Set Ext Adv data and Set Ext Scan rsp data
if controller support extended advertising.

Currently the operation is set as Complete data and fragment
preference is set as no fragment

Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
---
 include/net/bluetooth/hci.h      |  29 +++++++
 include/net/bluetooth/hci_core.h |   6 +-
 net/bluetooth/hci_core.c         |   8 +-
 net/bluetooth/hci_request.c      | 177 ++++++++++++++++++++++++++++++++-------
 net/bluetooth/mgmt.c             |  18 +++-
 5 files changed, 201 insertions(+), 37 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index dd6b9cb..997995d 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1587,6 +1587,30 @@ struct hci_cp_ext_adv_set {
 	__u8  max_events;
 } __packed;
 
+#define HCI_MAX_EXT_AD_LENGTH		251
+
+#define HCI_OP_LE_SET_EXT_ADV_DATA		0x2037
+struct hci_cp_le_set_ext_adv_data {
+	__u8  handle;
+	__u8  operation;
+	__u8  fragment_preference;
+	__u8  length;
+	__u8  data[HCI_MAX_EXT_AD_LENGTH];
+} __packed;
+
+#define HCI_OP_LE_SET_EXT_SCAN_RSP_DATA		0x2038
+struct hci_cp_le_set_ext_scan_rsp_data {
+	__u8  handle;
+	__u8  operation;
+	__u8  fragment_preference;
+	__u8  length;
+	__u8  data[HCI_MAX_EXT_AD_LENGTH];
+} __packed;
+
+#define LE_SET_ADV_DATA_OP_COMPLETE	0x03
+
+#define LE_SET_ADV_DATA_NO_FRAG		0x01
+
 /* ---- HCI Events ---- */
 #define HCI_EV_INQUIRY_COMPLETE		0x01
 
@@ -1984,6 +2008,11 @@ struct hci_ev_le_conn_complete {
 #define LE_LEGACY_SCAN_RSP_ADV		0x001b
 #define LE_LEGACY_SCAN_RSP_ADV_SCAN	0x001a
 
+/* Extended Advertising event types */
+#define LE_EXT_ADV_NON_CONN_IND		0x0000
+#define LE_EXT_ADV_CONN_IND		0x0001
+#define LE_EXT_ADV_SCAN_IND		0x0002
+
 #define ADDR_LE_DEV_PUBLIC	0x00
 #define ADDR_LE_DEV_RANDOM	0x01
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2abeabb..610172a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -166,9 +166,9 @@ struct adv_info {
 	__u16	remaining_time;
 	__u16	duration;
 	__u16	adv_data_len;
-	__u8	adv_data[HCI_MAX_AD_LENGTH];
+	__u8	adv_data[HCI_MAX_EXT_AD_LENGTH];
 	__u16	scan_rsp_len;
-	__u8	scan_rsp_data[HCI_MAX_AD_LENGTH];
+	__u8	scan_rsp_data[HCI_MAX_EXT_AD_LENGTH];
 	__u8	addr_type;
 	unsigned long state;
 };
@@ -176,6 +176,8 @@ struct adv_info {
 /* Adv instance states */
 enum {
 	ADV_INST_ENABLED,
+	ADV_INST_ADV_DATA_CHANGED,
+	ADV_INST_SCAN_DATA_CHANGED,
 };
 
 #define HCI_MAX_ADV_INSTANCES		5
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3472572..6c22ed6 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2700,12 +2700,16 @@ int hci_add_adv_instance(struct hci_dev *hdev, u8 instance, u32 flags,
 	adv_instance->adv_data_len = adv_data_len;
 	adv_instance->scan_rsp_len = scan_rsp_len;
 
-	if (adv_data_len)
+	if (adv_data_len) {
 		memcpy(adv_instance->adv_data, adv_data, adv_data_len);
+		set_bit(ADV_INST_ADV_DATA_CHANGED, &adv_instance->state);
+	}
 
-	if (scan_rsp_len)
+	if (scan_rsp_len) {
 		memcpy(adv_instance->scan_rsp_data,
 		       scan_rsp_data, scan_rsp_len);
+		set_bit(ADV_INST_SCAN_DATA_CHANGED, &adv_instance->state);
+	}
 
 	adv_instance->timeout = timeout;
 	adv_instance->remaining_time = timeout;
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 05f1388..9c45cbf 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1132,29 +1132,81 @@ static u8 create_instance_scan_rsp_data(struct hci_dev *hdev, u8 instance,
 void __hci_req_update_scan_rsp_data(struct hci_request *req, u8 instance)
 {
 	struct hci_dev *hdev = req->hdev;
-	struct hci_cp_le_set_scan_rsp_data cp;
 	u8 len;
+	struct adv_info *adv_inst;
 
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
 
-	memcpy(hdev->scan_rsp_data, cp.data, sizeof(cp.data));
-	hdev->scan_rsp_data_len = len;
+		if (!instance) {
+			/* There's nothing to do if the data hasn't changed */
+			if (hdev->scan_rsp_data_len == len &&
+			    memcmp(cp.data, hdev->scan_rsp_data, len) == 0)
+				return;
 
-	cp.length = len;
+			memcpy(hdev->scan_rsp_data, cp.data, sizeof(cp.data));
+			memcpy(hdev->scan_rsp_data, cp.data,
+			       sizeof(hdev->scan_rsp_data));
+			hdev->scan_rsp_data_len = len;
+		} else {
+			adv_inst = hci_find_adv_instance(hdev, instance);
+			if (!adv_inst)
+				return;
 
-	hci_req_add(req, HCI_OP_LE_SET_SCAN_RSP_DATA, sizeof(cp), &cp);
+			/* There's nothing to do if the data hasn't changed and
+			 * scan rsp data is not changed by user
+			 */
+			if (!test_and_clear_bit(ADV_INST_SCAN_DATA_CHANGED,
+                                               &adv_inst->state) &&
+			    adv_inst->scan_rsp_len == len &&
+			    memcmp(cp.data, adv_inst->scan_rsp_data, len) == 0)
+				return;
+
+			memcpy(adv_inst->scan_rsp_data, cp.data,
+			       sizeof(cp.data));
+                        adv_inst->scan_rsp_len = len;
+		}
+
+		cp.handle = instance;
+		cp.length = len;
+		cp.operation = LE_SET_ADV_DATA_OP_COMPLETE;
+		cp.fragment_preference = LE_SET_ADV_DATA_NO_FRAG;
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
+
+		memcpy(hdev->scan_rsp_data, cp.data, sizeof(cp.data));
+		hdev->scan_rsp_data_len = len;
+
+		cp.length = len;
+
+		hci_req_add(req, HCI_OP_LE_SET_SCAN_RSP_DATA, sizeof(cp), &cp);
+	}
 }
 
 static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
@@ -1228,27 +1280,70 @@ static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 void __hci_req_update_adv_data(struct hci_request *req, u8 instance)
 {
 	struct hci_dev *hdev = req->hdev;
-	struct hci_cp_le_set_adv_data cp;
 	u8 len;
+	struct adv_info *adv_instance;
 
 	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
 		return;
 
-	memset(&cp, 0, sizeof(cp));
+	if (ext_adv_capable(hdev)) {
+		struct hci_cp_le_set_ext_adv_data cp;
+
+		memset(&cp, 0, sizeof(cp));
 
-	len = create_instance_adv_data(hdev, instance, cp.data);
+		len = create_instance_adv_data(hdev, instance, cp.data);
 
-	/* There's nothing to do if the data hasn't changed */
-	if (hdev->adv_data_len == len &&
-	    memcmp(cp.data, hdev->adv_data, len) == 0)
-		return;
+		if (!instance) {
+			/* There's nothing to do if the data hasn't changed */
+			if (hdev->adv_data_len == len &&
+			    memcmp(cp.data, hdev->adv_data, len) == 0)
+				return;
 
-	memcpy(hdev->adv_data, cp.data, sizeof(cp.data));
-	hdev->adv_data_len = len;
+			memcpy(hdev->adv_data, cp.data, sizeof(hdev->adv_data));
+			hdev->adv_data_len = len;
+		} else {
+			adv_instance = hci_find_adv_instance(hdev, instance);
+			if (!adv_instance)
+				return;
 
-	cp.length = len;
+			/* There's nothing to do if the data hasn't changed and
+			 * adv data is not changed by user
+			 */
+			if (!test_and_clear_bit(ADV_INST_ADV_DATA_CHANGED,
+					       &adv_instance->state) &&
+			    adv_instance->adv_data_len == len &&
+			    memcmp(cp.data, adv_instance->adv_data, len) == 0)
+				return;
+
+			memcpy(adv_instance->adv_data, cp.data, sizeof(cp.data));
+                        adv_instance->adv_data_len = len;
+		}
+
+		cp.length = len;
+		cp.handle = instance;
+		cp.operation = LE_SET_ADV_DATA_OP_COMPLETE;
+		cp.fragment_preference = LE_SET_ADV_DATA_NO_FRAG;
+
+		hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_DATA, sizeof(cp), &cp);
+	} else {
+		struct hci_cp_le_set_adv_data cp;
+
+		memset(&cp, 0, sizeof(cp));
+
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
@@ -1337,6 +1432,8 @@ static void __hci_req_setup_ext_adv_instance(struct hci_request *req,
 	u32 flags;
 	/* In ext adv set param interval is 3 octets */
 	const u8 adv_interval[3] = { 0x00, 0x08, 0x00 };
+	struct adv_info *adv_inst;
+	bool secondary_adv;
 
 	flags = get_adv_instance_flags(hdev, instance);
 
@@ -1351,12 +1448,29 @@ static void __hci_req_setup_ext_adv_instance(struct hci_request *req,
 	memcpy(cp.min_interval, adv_interval, sizeof(cp.min_interval));
 	memcpy(cp.max_interval, adv_interval, sizeof(cp.max_interval));
 
-	if (connectable)
-		cp.evt_properties = cpu_to_le16(LE_LEGACY_ADV_IND);
-	else if (get_adv_instance_scan_rsp_len(hdev, instance))
-		cp.evt_properties = cpu_to_le16(LE_LEGACY_ADV_SCAN_IND);
-	else
-		cp.evt_properties = cpu_to_le16(LE_LEGACY_NONCONN_IND);
+	adv_inst = hci_find_adv_instance(hdev, instance);
+	if (!adv_inst)
+		return;
+
+	secondary_adv = (adv_inst->adv_data_len > HCI_MAX_AD_LENGTH ||
+			 adv_inst->scan_rsp_len > HCI_MAX_AD_LENGTH);
+
+	if (connectable) {
+		if (secondary_adv)
+			cp.evt_properties = cpu_to_le16(LE_EXT_ADV_CONN_IND);
+		else
+			cp.evt_properties = cpu_to_le16(LE_LEGACY_ADV_IND);
+	} else if (get_adv_instance_scan_rsp_len(hdev, instance)) {
+		if (secondary_adv)
+			cp.evt_properties = cpu_to_le16(LE_EXT_ADV_SCAN_IND);
+		else
+			cp.evt_properties = cpu_to_le16(LE_LEGACY_ADV_SCAN_IND);
+	} else {
+		if (secondary_adv)
+			cp.evt_properties = cpu_to_le16(LE_EXT_ADV_NON_CONN_IND);
+		else
+			cp.evt_properties = cpu_to_le16(LE_LEGACY_NONCONN_IND);
+	}
 
 	cp.own_addr_type = BDADDR_LE_PUBLIC;
 	cp.channel_map = hdev->le_adv_channel_map;
@@ -1366,6 +1480,9 @@ static void __hci_req_setup_ext_adv_instance(struct hci_request *req,
 	cp.handle = instance;
 
 	hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_PARAMS, sizeof(cp), &cp);
+
+	__hci_req_update_adv_data(req, instance);
+	__hci_req_update_scan_rsp_data(req, instance);
 }
 
 void __hci_req_enable_ext_advertising(struct hci_request *req, u8 instance,
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 2575aff..65e5131 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6021,8 +6021,15 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 	supported_flags = get_supported_adv_flags(hdev);
 
 	rp->supported_flags = cpu_to_le32(supported_flags);
-	rp->max_adv_data_len = HCI_MAX_AD_LENGTH;
-	rp->max_scan_rsp_len = HCI_MAX_AD_LENGTH;
+
+	if (ext_adv_capable(hdev)) {
+		rp->max_adv_data_len = HCI_MAX_EXT_AD_LENGTH;
+		rp->max_scan_rsp_len = HCI_MAX_EXT_AD_LENGTH;
+	} else {
+		rp->max_adv_data_len = HCI_MAX_AD_LENGTH;
+		rp->max_scan_rsp_len = HCI_MAX_AD_LENGTH;
+	}
+
 	rp->max_instances = hdev->le_no_of_adv_sets;
 	rp->num_instances = hdev->adv_instance_cnt;
 
@@ -6052,7 +6059,12 @@ static u8 calculate_name_len(struct hci_dev *hdev)
 static u8 tlv_data_max_len(struct hci_dev *hdev, u32 adv_flags,
 			   bool is_adv_data)
 {
-	u8 max_len = HCI_MAX_AD_LENGTH;
+	u8 max_len;
+
+	if (ext_adv_capable(hdev))
+		max_len  = HCI_MAX_EXT_AD_LENGTH;
+	else
+		max_len = HCI_MAX_AD_LENGTH;
 
 	if (is_adv_data) {
 		if (adv_flags & (MGMT_ADV_FLAG_DISCOV |
-- 
2.7.4

