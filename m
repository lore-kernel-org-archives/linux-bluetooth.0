Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [RFC 2/9] Bluetooth: Impmlement extended adv enable
Date: Mon,  4 Dec 2017 13:37:46 +0530
Message-Id: <1512374873-1956-3-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1512374873-1956-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1512374873-1956-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements ext adv set parameter and enable functions.
Introduced __hci_req_start_ext_adv() which can activate a single
instance or all instances based on the parameter passed.
If atleast one instance is enabled then HCI_LE_ADV flag is set in
hdev. State is added for each instance to check whether the instance
is newly created (which means that it should be programmed to the
controller), enabled or disabled state.

Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
---
 include/net/bluetooth/hci.h      |  37 ++++++
 include/net/bluetooth/hci_core.h |   7 ++
 net/bluetooth/hci_event.c        |  87 +++++++++++++++
 net/bluetooth/hci_request.c      | 235 ++++++++++++++++++++++++++++++++++-----
 net/bluetooth/hci_request.h      |   5 +
 net/bluetooth/mgmt.c             |  96 ++++++++++------
 6 files changed, 407 insertions(+), 60 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 59df823..dd6b9cb 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1550,6 +1550,43 @@ struct hci_rp_le_read_num_supported_adv_sets {
 	__u8  num_of_sets;
 } __packed;
 
+#define HCI_OP_LE_SET_EXT_ADV_PARAMS			0x2036
+struct hci_cp_le_set_ext_adv_params {
+	__u8  handle;
+	__le16 evt_properties;
+	__u8  min_interval[3];
+	__u8  max_interval[3];
+	__u8  channel_map;
+	__u8  own_addr_type;
+	__u8  peer_addr_type;
+	bdaddr_t  peer_addr;
+	__u8  filter_policy;
+	__u8  tx_power;
+	__u8  primary_phy;
+	__u8  secondary_max_skip;
+	__u8  secondary_phy;
+	__u8  sid;
+	__u8  notif_enable;
+} __packed;
+
+struct hci_rp_le_set_ext_adv_params {
+	__u8  status;
+	__u8  tx_power;
+} __attribute__ ((packed));
+
+#define HCI_OP_LE_SET_EXT_ADV_ENABLE			0x2039
+struct hci_cp_le_set_ext_adv_enable {
+	__u8  enable;
+	__u8  num_of_sets;
+	__u8  data[0];
+} __packed;
+
+struct hci_cp_ext_adv_set {
+	__u8  handle;
+	__le16 duration;
+	__u8  max_events;
+} __packed;
+
 /* ---- HCI Events ---- */
 #define HCI_EV_INQUIRY_COMPLETE		0x01
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4a7a4ae..2abeabb 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -169,6 +169,13 @@ struct adv_info {
 	__u8	adv_data[HCI_MAX_AD_LENGTH];
 	__u16	scan_rsp_len;
 	__u8	scan_rsp_data[HCI_MAX_AD_LENGTH];
+	__u8	addr_type;
+	unsigned long state;
+};
+
+/* Adv instance states */
+enum {
+	ADV_INST_ENABLED,
 };
 
 #define HCI_MAX_ADV_INSTANCES		5
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 06d8c1b..724c668 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1076,6 +1076,56 @@ static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_unlock(hdev);
 }
 
+static void hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev,
+					 struct sk_buff *skb)
+{
+	struct hci_cp_le_set_ext_adv_enable *cp;
+	struct hci_cp_ext_adv_set *adv_set;
+	__u8 status = *((__u8 *) skb->data);
+	struct adv_info *adv_instance;
+	int i;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	if (status)
+		return;
+
+	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_EXT_ADV_ENABLE);
+	if (!cp)
+		return;
+
+	adv_set = (void *) cp->data;
+
+	hci_dev_lock(hdev);
+
+	if (cp->enable) {
+		struct hci_conn *conn;
+
+		/* Set HCI_LE_ADV if atleast one instance is enabled */
+		hci_dev_set_flag(hdev, HCI_LE_ADV);
+
+		/* If we're doing connection initiation as peripheral. Set a
+		 * timeout in case something goes wrong.
+		 */
+		conn = hci_lookup_le_connect(hdev);
+		if (conn)
+			queue_delayed_work(hdev->workqueue,
+					   &conn->le_conn_timeout,
+					   conn->conn_timeout);
+
+		for (i = 0; i < cp->num_of_sets; i++) {
+			adv_instance = hci_find_adv_instance(hdev,
+							     adv_set->handle);
+			if (adv_instance)
+				set_bit(ADV_INST_ENABLED, &adv_instance->state);
+
+			adv_set++;
+		}
+	}
+
+	hci_dev_unlock(hdev);
+}
+
 static void hci_cc_le_set_scan_param(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_cp_le_set_scan_param *cp;
@@ -1438,6 +1488,35 @@ static void hci_cc_set_adv_param(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_unlock(hdev);
 }
 
+static void hci_cc_set_ext_adv_param(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_rp_le_set_ext_adv_params *rp = (void *) skb->data;
+	struct hci_cp_le_set_ext_adv_params *cp;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
+		return;
+
+	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_EXT_ADV_PARAMS);
+	if (!cp)
+		return;
+
+	hci_dev_lock(hdev);
+
+	if (!cp->handle) {
+		hdev->adv_addr_type = cp->own_addr_type;
+	} else {
+		struct adv_info *adv_instance;
+
+		adv_instance = hci_find_adv_instance(hdev, cp->handle);
+		if (adv_instance)
+			adv_instance->addr_type = cp->own_addr_type;
+	}
+
+	hci_dev_unlock(hdev);
+}
+
 static void hci_cc_read_rssi(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_rp_read_rssi *rp = (void *) skb->data;
@@ -3148,6 +3227,14 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cc_le_read_num_adv_sets(hdev, skb);
 		break;
 
+	case HCI_OP_LE_SET_EXT_ADV_PARAMS:
+		hci_cc_set_ext_adv_param(hdev, skb);
+		break;
+
+	case HCI_OP_LE_SET_EXT_ADV_ENABLE:
+		hci_cc_le_set_ext_adv_enable(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%4.4x", hdev->name, *opcode);
 		break;
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 62a7b94..05f1388 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -890,6 +890,24 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 			   hdev->le_scan_window, own_addr_type, filter_policy);
 }
 
+static u8 get_adv_instance_scan_rsp_len(struct hci_dev *hdev, u8 instance)
+{
+	struct adv_info *adv_instance;
+
+	/* Ignore instance 0 */
+	if (instance == 0x00)
+		return 0;
+
+	adv_instance = hci_find_adv_instance(hdev, instance);
+	if (!adv_instance)
+		return 0;
+
+	/* TODO: Take into account the "appearance" and "local-name" flags here.
+	 * These are currently being ignored as they are not supported.
+	 */
+	return adv_instance->scan_rsp_len;
+}
+
 static u8 get_cur_adv_instance_scan_rsp_len(struct hci_dev *hdev)
 {
 	u8 instance = hdev->cur_adv_instance;
@@ -1258,13 +1276,22 @@ void hci_req_reenable_advertising(struct hci_dev *hdev)
 
 	hci_req_init(&req, hdev);
 
-	if (hdev->cur_adv_instance) {
-		__hci_req_schedule_adv_instance(&req, hdev->cur_adv_instance,
-						true);
+	if (ext_adv_capable(hdev)) {
+		if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
+			__hci_req_start_ext_adv(&req, 0, false, false, 0);
+		else
+			__hci_req_start_ext_adv(&req, 0, true, false, 0);
 	} else {
-		__hci_req_update_adv_data(&req, 0x00);
-		__hci_req_update_scan_rsp_data(&req, 0x00);
-		__hci_req_enable_advertising(&req);
+
+		if (hdev->cur_adv_instance) {
+			__hci_req_schedule_adv_instance(&req,
+							hdev->cur_adv_instance,
+							true);
+		} else {
+			__hci_req_update_adv_data(&req, 0x00);
+			__hci_req_update_scan_rsp_data(&req, 0x00);
+			__hci_req_enable_advertising(&req);
+		}
 	}
 
 	hci_req_run(&req, adv_enable_complete);
@@ -1301,6 +1328,133 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
+static void __hci_req_setup_ext_adv_instance(struct hci_request *req,
+					     u8 instance)
+{
+	struct hci_cp_le_set_ext_adv_params cp;
+	struct hci_dev *hdev = req->hdev;
+	bool connectable;
+	u32 flags;
+	/* In ext adv set param interval is 3 octets */
+	const u8 adv_interval[3] = { 0x00, 0x08, 0x00 };
+
+	flags = get_adv_instance_flags(hdev, instance);
+
+	/* If the "connectable" instance flag was not set, then choose between
+	 * ADV_IND and ADV_NONCONN_IND based on the global connectable setting.
+	 */
+	connectable = (flags & MGMT_ADV_FLAG_CONNECTABLE) ||
+		      mgmt_get_connectable(hdev);
+
+	memset(&cp, 0, sizeof(cp));
+
+	memcpy(cp.min_interval, adv_interval, sizeof(cp.min_interval));
+	memcpy(cp.max_interval, adv_interval, sizeof(cp.max_interval));
+
+	if (connectable)
+		cp.evt_properties = cpu_to_le16(LE_LEGACY_ADV_IND);
+	else if (get_adv_instance_scan_rsp_len(hdev, instance))
+		cp.evt_properties = cpu_to_le16(LE_LEGACY_ADV_SCAN_IND);
+	else
+		cp.evt_properties = cpu_to_le16(LE_LEGACY_NONCONN_IND);
+
+	cp.own_addr_type = BDADDR_LE_PUBLIC;
+	cp.channel_map = hdev->le_adv_channel_map;
+	cp.tx_power = 127;
+	cp.primary_phy = LE_PHY_1M;
+	cp.secondary_phy = LE_PHY_1M;
+	cp.handle = instance;
+
+	hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_PARAMS, sizeof(cp), &cp);
+}
+
+void __hci_req_enable_ext_advertising(struct hci_request *req, u8 instance,
+				      bool all_instances)
+{
+	struct hci_cp_le_set_ext_adv_enable *cp;
+	struct hci_cp_ext_adv_set *adv_set;
+	struct hci_dev *hdev = req->hdev;
+	u8 data[sizeof(*cp) + sizeof(*adv_set) * HCI_MAX_ADV_INSTANCES];
+	struct adv_info *adv_instance;
+	u16 duration;
+
+	cp = (void *) data;
+	adv_set = (void *) cp->data;
+
+	memset(cp, 0, sizeof(*cp));
+
+	cp->enable = 0x01;
+
+	if (all_instances) {
+		cp->num_of_sets = 0;
+
+		list_for_each_entry(adv_instance, &hdev->adv_instances, list) {
+			/* duration = timeout_in_ms / 10 */
+			duration = adv_instance->timeout * 100;
+
+			memset(adv_set, 0, sizeof(*adv_set));
+
+			adv_set->handle = adv_instance->instance;
+			adv_set->duration = cpu_to_le16(duration);
+
+			adv_set++;
+
+			cp->num_of_sets++;
+		}
+	} else {
+		cp->num_of_sets = 0x01;
+
+		memset(adv_set, 0, sizeof(*adv_set));
+
+		adv_set->handle = instance;
+
+		if (instance > 0) {
+			adv_instance = hci_find_adv_instance(hdev, instance);
+			if (!adv_instance)
+				return;
+
+			/* duration = timeout_in_ms / 10 */
+			duration = adv_instance->timeout * 100;
+			adv_set->duration = cpu_to_le16(duration);
+		}
+	}
+
+	hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_ENABLE,
+		    sizeof(*cp) + sizeof(*adv_set) * cp->num_of_sets,
+		    data);
+}
+
+int __hci_req_start_ext_adv(struct hci_request *req, u8 instance,
+			    bool all_instances, bool check_flag, u32 flags)
+{
+	struct hci_dev *hdev = req->hdev;
+	struct adv_info *adv_instance;
+
+	if (hci_conn_num(hdev, LE_LINK) > 0)
+		return -EPERM;
+
+	if (all_instances) {
+		if (list_empty(&hdev->adv_instances))
+			return -EPERM;
+
+		list_for_each_entry(adv_instance, &hdev->adv_instances, list) {
+			/* If current instance doesn't need to be changed */
+			if (check_flag && !(adv_instance->flags & flags))
+				continue;
+
+			__hci_req_setup_ext_adv_instance(req,
+							 adv_instance->instance);
+		}
+
+		__hci_req_enable_ext_advertising(req, 0, true);
+	} else {
+		__hci_req_setup_ext_adv_instance(req, instance);
+		__hci_req_enable_ext_advertising(req, instance, false);
+	}
+
+	return 0;
+}
+
 int __hci_req_schedule_adv_instance(struct hci_request *req, u8 instance,
 				    bool force)
 {
@@ -1618,17 +1772,26 @@ static int connectable_update(struct hci_request *req, unsigned long opt)
 
 	__hci_req_update_scan(req);
 
-	/* If BR/EDR is not enabled and we disable advertising as a
-	 * by-product of disabling connectable, we need to update the
-	 * advertising flags.
-	 */
-	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
-		__hci_req_update_adv_data(req, hdev->cur_adv_instance);
 
-	/* Update the advertising parameters if necessary */
-	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
-	    !list_empty(&hdev->adv_instances))
-		__hci_req_enable_advertising(req);
+	if (ext_adv_capable(hdev)) {
+		/* Update adv flags and adv params */
+		if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
+			__hci_req_start_ext_adv(req, 0, false, false, 0);
+		else
+			__hci_req_start_ext_adv(req, 0, true, false, 0);
+	} else {
+		/* If BR/EDR is not enabled and we disable advertising as a
+		 * by-product of disabling connectable, we need to update the
+		 * advertising flags.
+		 */
+		if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
+			__hci_req_update_adv_data(req, hdev->cur_adv_instance);
+
+		/* Update the advertising parameters if necessary */
+		if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
+		    !list_empty(&hdev->adv_instances))
+			__hci_req_enable_advertising(req);
+	}
 
 	__hci_update_background_scan(req);
 
@@ -1737,8 +1900,13 @@ static int discoverable_update(struct hci_request *req, unsigned long opt)
 		/* Discoverable mode affects the local advertising
 		 * address in limited privacy mode.
 		 */
-		if (hci_dev_test_flag(hdev, HCI_LIMITED_PRIVACY))
-			__hci_req_enable_advertising(req);
+		if (hci_dev_test_flag(hdev, HCI_LIMITED_PRIVACY)) {
+			if (ext_adv_capable(hdev))
+				__hci_req_start_ext_adv(req, 0, false,
+							false,0);
+			else
+				__hci_req_enable_advertising(req);
+		}
 	}
 
 	hci_dev_unlock(hdev);
@@ -2327,16 +2495,29 @@ static int powered_update_hci(struct hci_request *req, unsigned long opt)
 			__hci_req_update_adv_data(req, 0x00);
 			__hci_req_update_scan_rsp_data(req, 0x00);
 
-			if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
-				__hci_req_enable_advertising(req);
+			if (hci_dev_test_flag(hdev, HCI_ADVERTISING)) {
+				if (ext_adv_capable(hdev))
+					__hci_req_start_ext_adv(req, 0, false,
+								false, 0);
+				else
+					__hci_req_enable_advertising(req);
+			}
 		} else if (!list_empty(&hdev->adv_instances)) {
-			struct adv_info *adv_instance;
-
-			adv_instance = list_first_entry(&hdev->adv_instances,
-							struct adv_info, list);
-			__hci_req_schedule_adv_instance(req,
-							adv_instance->instance,
-							true);
+			if (ext_adv_capable(hdev)) {
+				__hci_req_start_ext_adv(req, 0, true, false, 0);
+			} else {
+				struct adv_info *adv_instance;
+				struct list_head *head = &hdev->adv_instances;
+				u8 instance;
+
+				adv_instance = list_first_entry(head,
+								struct adv_info,
+								list);
+				instance = adv_instance->instance;
+				__hci_req_schedule_adv_instance(req,
+								instance,
+								true);
+			}
 		}
 	}
 
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 702beb1..2f2dfad 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -80,6 +80,11 @@ void hci_req_clear_adv_instance(struct hci_dev *hdev, struct sock *sk,
 				struct hci_request *req, u8 instance,
 				bool force);
 
+int __hci_req_start_ext_adv(struct hci_request *req, u8 instance,
+                            bool all_instances, bool check_flag, u32 flags);
+void __hci_req_enable_ext_advertising(struct hci_request *req, u8 instance,
+				      bool all_instances);
+
 void __hci_req_update_class(struct hci_request *req);
 
 /* Returns true if HCI commands were queued */
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ffd5f7b..2575aff 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -817,7 +817,10 @@ static void rpa_expired(struct work_struct *work)
 	 * function.
 	 */
 	hci_req_init(&req, hdev);
-	__hci_req_enable_advertising(&req);
+	if (ext_adv_capable(hdev))
+		__hci_req_start_ext_adv(&req, 0, false, false, 0);
+	else
+		__hci_req_enable_advertising(&req);
 	hci_req_run(&req, NULL);
 }
 
@@ -3025,27 +3028,39 @@ static void adv_expire(struct hci_dev *hdev, u32 flags)
 	struct hci_request req;
 	int err;
 
-	adv_instance = hci_find_adv_instance(hdev, hdev->cur_adv_instance);
-	if (!adv_instance)
-		return;
+	if (ext_adv_capable(hdev)) {
+		hci_req_init(&req, hdev);
 
-	/* stop if current instance doesn't need to be changed */
-	if (!(adv_instance->flags & flags))
-		return;
+		__hci_req_start_ext_adv(&req, 0, true, true, flags);
 
-	cancel_adv_timeout(hdev);
+		if (!skb_queue_empty(&req.cmd_q))
+			hci_req_run(&req, NULL);
+	} else {
+		adv_instance = hci_find_adv_instance(hdev,
+						     hdev->cur_adv_instance);
+		if (!adv_instance)
+			return;
 
-	adv_instance = hci_get_next_instance(hdev, adv_instance->instance);
-	if (!adv_instance)
-		return;
+		/* stop if current instance doesn't need to be changed */
+		if (!(adv_instance->flags & flags))
+			return;
 
-	hci_req_init(&req, hdev);
-	err = __hci_req_schedule_adv_instance(&req, adv_instance->instance,
-					      true);
-	if (err)
-		return;
+		cancel_adv_timeout(hdev);
 
-	hci_req_run(&req, NULL);
+		adv_instance = hci_get_next_instance(hdev,
+						     adv_instance->instance);
+		if (!adv_instance)
+			return;
+
+		hci_req_init(&req, hdev);
+		err = __hci_req_schedule_adv_instance(&req,
+						      adv_instance->instance,
+						      true);
+		if (err)
+			return;
+
+		hci_req_run(&req, NULL);
+	}
 }
 
 static void set_name_complete(struct hci_dev *hdev, u8 status, u16 opcode)
@@ -3925,19 +3940,25 @@ static void set_advertising_complete(struct hci_dev *hdev, u8 status,
 	    list_empty(&hdev->adv_instances))
 		goto unlock;
 
-	instance = hdev->cur_adv_instance;
-	if (!instance) {
-		adv_instance = list_first_entry_or_null(&hdev->adv_instances,
-							struct adv_info, list);
-		if (!adv_instance)
-			goto unlock;
+	hci_req_init(&req, hdev);
 
-		instance = adv_instance->instance;
-	}
+	if (ext_adv_capable(hdev)) {
+		err = __hci_req_start_ext_adv(&req, 0, true, false, 0);
+	} else {
+		struct list_head *instances = &hdev->adv_instances;
+		instance = hdev->cur_adv_instance;
+		if (!instance) {
+			adv_instance = list_first_entry_or_null(instances,
+								struct adv_info,
+								list);
+			if (!adv_instance)
+				goto unlock;
 
-	hci_req_init(&req, hdev);
+			instance = adv_instance->instance;
+		}
 
-	err = __hci_req_schedule_adv_instance(&req, instance, true);
+		err = __hci_req_schedule_adv_instance(&req, instance, true);
+	}
 
 	if (!err)
 		err = hci_req_run(&req, enable_advertising_instance);
@@ -4035,10 +4056,14 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 		 * We cannot use update_[adv|scan_rsp]_data() here as the
 		 * HCI_ADVERTISING flag is not yet set.
 		 */
-		hdev->cur_adv_instance = 0x00;
-		__hci_req_update_adv_data(&req, 0x00);
-		__hci_req_update_scan_rsp_data(&req, 0x00);
-		__hci_req_enable_advertising(&req);
+		if (ext_adv_capable(hdev)) {
+			__hci_req_start_ext_adv(&req, 0, false, false, 0);
+		} else {
+			hdev->cur_adv_instance = 0x00;
+			__hci_req_update_adv_data(&req, 0x00);
+			__hci_req_update_scan_rsp_data(&req, 0x00);
+			__hci_req_enable_advertising(&req);
+		}
 	} else {
 		__hci_req_disable_advertising(&req);
 	}
@@ -6248,7 +6273,7 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 	if (hdev->adv_instance_cnt > prev_instance_cnt)
 		mgmt_advertising_added(sk, hdev, cp->instance);
 
-	if (hdev->cur_adv_instance == cp->instance) {
+	if (hdev->cur_adv_instance == cp->instance && !ext_adv_capable(hdev)) {
 		/* If the currently advertised instance is being changed then
 		 * cancel the current advertising and schedule the next
 		 * instance. If there is only one instance then the overridden
@@ -6291,7 +6316,12 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 
 	hci_req_init(&req, hdev);
 
-	err = __hci_req_schedule_adv_instance(&req, schedule_instance, true);
+	if (ext_adv_capable(hdev))
+		err = __hci_req_start_ext_adv(&req, schedule_instance, false,
+					      false, 0);
+	else
+		err = __hci_req_schedule_adv_instance(&req, schedule_instance,
+						      true);
 
 	if (!err)
 		err = hci_req_run(&req, add_advertising_complete);
-- 
2.7.4

