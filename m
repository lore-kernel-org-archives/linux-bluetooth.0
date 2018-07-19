Return-Path: <jaganath.k.os@gmail.com>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH v5 10/16] Bluetooth: Impmlement extended adv enable
Date: Thu, 19 Jul 2018 17:09:41 +0530
Message-Id: <1532000387-3649-11-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1532000387-3649-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1532000387-3649-1-git-send-email-jaganathx.kanakkassery@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch basically replaces legacy adv with extended adv
based on the controller support. Currently there is no
design change. ie only one adv set will be enabled at a time.

This also adds tx_power in instance and store whatever returns
from Set_ext_parameter, use the same in adv data as well.
For instance 0 tx_power is stored in hdev only.

< HCI Command: LE Set Extended Advertising Parameters (0x08|0x0036) plen 25
        Handle: 0x00
        Properties: 0x0010
          Use legacy advertising PDUs: ADV_NONCONN_IND
        Min advertising interval: 1280.000 msec (0x0800)
        Max advertising interval: 1280.000 msec (0x0800)
        Channel map: 37, 38, 39 (0x07)
        Own address type: Random (0x01)
        Peer address type: Public (0x00)
        Peer address: 00:00:00:00:00:00 (OUI 00-00-00)
        Filter policy: Allow Scan Request from Any, Allow Connect Request from Any (0x00)
        TX power: 127 dbm (0x7f)
        Primary PHY: LE 1M (0x01)
        Secondary max skip: 0x00
        Secondary PHY: LE 1M (0x01)
        SID: 0x00
        Scan request notifications: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 5
      LE Set Extended Advertising Parameters (0x08|0x0036) ncmd 1
        Status: Success (0x00)
        TX power (selected): 7 dbm (0x07)
< HCI Command: LE Set Extended Advertising Enable (0x08|0x0039) plen 6
        Extended advertising: Enabled (0x01)
        Number of sets: 1 (0x01)
        Entry 0
          Handle: 0x00
          Duration: 0 ms (0x00)
          Max ext adv events: 0
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Extended Advertising Enable (0x08|0x0039) ncmd 2
        Status: Success (0x00)

Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
---
 include/net/bluetooth/hci.h      |  39 +++++++++
 include/net/bluetooth/hci_core.h |   1 +
 net/bluetooth/hci_core.c         |   2 +
 net/bluetooth/hci_event.c        |  72 +++++++++++++++++
 net/bluetooth/hci_request.c      | 171 ++++++++++++++++++++++++++++++++++-----
 net/bluetooth/hci_request.h      |   3 +
 net/bluetooth/mgmt.c             |  22 +++--
 7 files changed, 285 insertions(+), 25 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 3f93ae9..b447b12 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1586,6 +1586,45 @@ struct hci_rp_le_read_num_supported_adv_sets {
 	__u8  num_of_sets;
 } __packed;
 
+#define HCI_OP_LE_SET_EXT_ADV_PARAMS		0x2036
+struct hci_cp_le_set_ext_adv_params {
+	__u8      handle;
+	__le16    evt_properties;
+	__u8      min_interval[3];
+	__u8      max_interval[3];
+	__u8      channel_map;
+	__u8      own_addr_type;
+	__u8      peer_addr_type;
+	bdaddr_t  peer_addr;
+	__u8      filter_policy;
+	__u8      tx_power;
+	__u8      primary_phy;
+	__u8      secondary_max_skip;
+	__u8      secondary_phy;
+	__u8      sid;
+	__u8      notif_enable;
+} __packed;
+
+#define HCI_ADV_PHY_1M		0X01
+
+struct hci_rp_le_set_ext_adv_params {
+	__u8  status;
+	__u8  tx_power;
+} __packed;
+
+#define HCI_OP_LE_SET_EXT_ADV_ENABLE		0x2039
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
index 2aad4a8..ad35183 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -171,6 +171,7 @@ struct adv_info {
 	__u8	adv_data[HCI_MAX_AD_LENGTH];
 	__u16	scan_rsp_len;
 	__u8	scan_rsp_data[HCI_MAX_AD_LENGTH];
+	__s8	tx_power;
 };
 
 #define HCI_MAX_ADV_INSTANCES		5
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7b08b7f..944d4fe 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2779,6 +2779,8 @@ int hci_add_adv_instance(struct hci_dev *hdev, u8 instance, u32 flags,
 	else
 		adv_instance->duration = duration;
 
+	adv_instance->tx_power = HCI_TX_POWER_INVALID;
+
 	BT_DBG("%s for %dMR", hdev->name, instance);
 
 	return 0;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0ceb52e..0418a55 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1099,6 +1099,41 @@ static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_unlock(hdev);
 }
 
+static void hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev,
+					 struct sk_buff *skb)
+{
+	struct hci_cp_le_set_ext_adv_enable *cp;
+	struct hci_cp_ext_adv_set *adv_set;
+	__u8 status = *((__u8 *) skb->data);
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
+		hci_dev_set_flag(hdev, HCI_LE_ADV);
+
+		conn = hci_lookup_le_connect(hdev);
+		if (conn)
+			queue_delayed_work(hdev->workqueue,
+					   &conn->le_conn_timeout,
+					   conn->conn_timeout);
+	}
+
+	hci_dev_unlock(hdev);
+}
+
 static void hci_cc_le_set_scan_param(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_cp_le_set_scan_param *cp;
@@ -1486,6 +1521,35 @@ static void hci_cc_set_adv_param(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_unlock(hdev);
 }
 
+static void hci_cc_set_ext_adv_param(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_rp_le_set_ext_adv_params *rp = (void *) skb->data;
+	struct hci_cp_le_set_ext_adv_params *cp;
+	struct adv_info *adv_instance;
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
+	hdev->adv_addr_type = cp->own_addr_type;
+	if (!hdev->cur_adv_instance) {
+		/* Store in hdev for instance 0 */
+		hdev->adv_tx_power = rp->tx_power;
+	} else {
+		adv_instance = hci_find_adv_instance(hdev,
+						     hdev->cur_adv_instance);
+		if (adv_instance)
+			adv_instance->tx_power = rp->tx_power;
+	}
+	hci_dev_unlock(hdev);
+}
+
 static void hci_cc_read_rssi(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_rp_read_rssi *rp = (void *) skb->data;
@@ -3207,6 +3271,14 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
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
index 215059a..2ac9fd6 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -895,6 +895,24 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
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
@@ -1235,15 +1253,27 @@ static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 		ptr += adv_instance->adv_data_len;
 	}
 
-	/* Provide Tx Power only if we can provide a valid value for it */
-	if (hdev->adv_tx_power != HCI_TX_POWER_INVALID &&
-	    (instance_flags & MGMT_ADV_FLAG_TX_POWER)) {
-		ptr[0] = 0x02;
-		ptr[1] = EIR_TX_POWER;
-		ptr[2] = (u8)hdev->adv_tx_power;
+	if (instance_flags & MGMT_ADV_FLAG_TX_POWER) {
+		s8 adv_tx_power;
 
-		ad_len += 3;
-		ptr += 3;
+		if (ext_adv_capable(hdev)) {
+			if (adv_instance)
+				adv_tx_power = adv_instance->tx_power;
+			else
+				adv_tx_power = hdev->adv_tx_power;
+		} else {
+			adv_tx_power = hdev->adv_tx_power;
+		}
+
+		/* Provide Tx Power only if we can provide a valid value for it */
+		if (adv_tx_power != HCI_TX_POWER_INVALID) {
+			ptr[0] = 0x02;
+			ptr[1] = EIR_TX_POWER;
+			ptr[2] = (u8)adv_tx_power;
+
+			ad_len += 3;
+			ptr += 3;
+		}
 	}
 
 	return ad_len;
@@ -1304,9 +1334,13 @@ void hci_req_reenable_advertising(struct hci_dev *hdev)
 		__hci_req_schedule_adv_instance(&req, hdev->cur_adv_instance,
 						true);
 	} else {
-		__hci_req_update_adv_data(&req, 0x00);
-		__hci_req_update_scan_rsp_data(&req, 0x00);
-		__hci_req_enable_advertising(&req);
+		if (ext_adv_capable(hdev)) {
+			__hci_req_start_ext_adv(&req, 0x00);
+		} else {
+			__hci_req_update_adv_data(&req, 0x00);
+			__hci_req_update_scan_rsp_data(&req, 0x00);
+			__hci_req_enable_advertising(&req);
+		}
 	}
 
 	hci_req_run(&req, adv_enable_complete);
@@ -1343,6 +1377,87 @@ static void adv_timeout_expire(struct work_struct *work)
 	hci_dev_unlock(hdev);
 }
 
+static int __hci_req_setup_ext_adv_instance(struct hci_request *req,
+					    u8 instance)
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
+	 if (!is_advertising_allowed(hdev, connectable))
+		return -EPERM;
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
+	cp.primary_phy = HCI_ADV_PHY_1M;
+	cp.secondary_phy = HCI_ADV_PHY_1M;
+	cp.handle = 0;
+
+	hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_PARAMS, sizeof(cp), &cp);
+
+	return 0;
+}
+
+void __hci_req_enable_ext_advertising(struct hci_request *req)
+{
+	struct hci_cp_le_set_ext_adv_enable *cp;
+	struct hci_cp_ext_adv_set *adv_set;
+	u8 data[sizeof(*cp) + sizeof(*adv_set) * 1];
+
+	cp = (void *) data;
+	adv_set = (void *) cp->data;
+
+	memset(cp, 0, sizeof(*cp));
+
+	cp->enable = 0x01;
+	cp->num_of_sets = 0x01;
+
+	memset(adv_set, 0, sizeof(*adv_set));
+
+	adv_set->handle = 0;
+
+	hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_ENABLE,
+		    sizeof(*cp) + sizeof(*adv_set) * cp->num_of_sets,
+		    data);
+}
+
+int __hci_req_start_ext_adv(struct hci_request *req, u8 instance)
+{
+	int err;
+
+	err = __hci_req_setup_ext_adv_instance(req, instance);
+	if (err < 0)
+		return err;
+
+	__hci_req_enable_ext_advertising(req);
+
+	return 0;
+}
+
 int __hci_req_schedule_adv_instance(struct hci_request *req, u8 instance,
 				    bool force)
 {
@@ -1396,9 +1511,13 @@ int __hci_req_schedule_adv_instance(struct hci_request *req, u8 instance,
 		return 0;
 
 	hdev->cur_adv_instance = instance;
-	__hci_req_update_adv_data(req, instance);
-	__hci_req_update_scan_rsp_data(req, instance);
-	__hci_req_enable_advertising(req);
+	if (ext_adv_capable(hdev)) {
+		__hci_req_start_ext_adv(req, instance);
+	} else {
+		__hci_req_update_adv_data(req, instance);
+		__hci_req_update_scan_rsp_data(req, instance);
+		__hci_req_enable_advertising(req);
+	}
 
 	return 0;
 }
@@ -1669,8 +1788,12 @@ static int connectable_update(struct hci_request *req, unsigned long opt)
 
 	/* Update the advertising parameters if necessary */
 	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
-	    !list_empty(&hdev->adv_instances))
-		__hci_req_enable_advertising(req);
+	    !list_empty(&hdev->adv_instances)) {
+		if (ext_adv_capable(hdev))
+			__hci_req_start_ext_adv(req, hdev->cur_adv_instance);
+		else
+			__hci_req_enable_advertising(req);
+	}
 
 	__hci_update_background_scan(req);
 
@@ -1779,8 +1902,12 @@ static int discoverable_update(struct hci_request *req, unsigned long opt)
 		/* Discoverable mode affects the local advertising
 		 * address in limited privacy mode.
 		 */
-		if (hci_dev_test_flag(hdev, HCI_LIMITED_PRIVACY))
-			__hci_req_enable_advertising(req);
+		if (hci_dev_test_flag(hdev, HCI_LIMITED_PRIVACY)) {
+			if (ext_adv_capable(hdev))
+				__hci_req_start_ext_adv(req, 0x00);
+			else
+				__hci_req_enable_advertising(req);
+		}
 	}
 
 	hci_dev_unlock(hdev);
@@ -2376,8 +2503,12 @@ static int powered_update_hci(struct hci_request *req, unsigned long opt)
 			__hci_req_update_adv_data(req, 0x00);
 			__hci_req_update_scan_rsp_data(req, 0x00);
 
-			if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
-				__hci_req_enable_advertising(req);
+			if (hci_dev_test_flag(hdev, HCI_ADVERTISING)) {
+				if (ext_adv_capable(hdev))
+					__hci_req_start_ext_adv(req, 0x00);
+				else
+					__hci_req_enable_advertising(req);
+			}
 		} else if (!list_empty(&hdev->adv_instances)) {
 			struct adv_info *adv_instance;
 
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 702beb1..9b8c74d 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -80,6 +80,9 @@ void hci_req_clear_adv_instance(struct hci_dev *hdev, struct sock *sk,
 				struct hci_request *req, u8 instance,
 				bool force);
 
+int __hci_req_start_ext_adv(struct hci_request *req, u8 instance);
+void __hci_req_enable_ext_advertising(struct hci_request *req);
+
 void __hci_req_update_class(struct hci_request *req);
 
 /* Returns true if HCI commands were queued */
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1867aad..761a9ae 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -940,7 +940,10 @@ static void rpa_expired(struct work_struct *work)
 	 * function.
 	 */
 	hci_req_init(&req, hdev);
-	__hci_req_enable_advertising(&req);
+	if (ext_adv_capable(hdev))
+		__hci_req_start_ext_adv(&req, hdev->cur_adv_instance);
+	else
+		__hci_req_enable_advertising(&req);
 	hci_req_run(&req, NULL);
 }
 
@@ -4382,9 +4385,14 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 		 * HCI_ADVERTISING flag is not yet set.
 		 */
 		hdev->cur_adv_instance = 0x00;
-		__hci_req_update_adv_data(&req, 0x00);
-		__hci_req_update_scan_rsp_data(&req, 0x00);
-		__hci_req_enable_advertising(&req);
+
+		if (ext_adv_capable(hdev)) {
+			__hci_req_start_ext_adv(&req, 0x00);
+		} else {
+			__hci_req_update_adv_data(&req, 0x00);
+			__hci_req_update_scan_rsp_data(&req, 0x00);
+			__hci_req_enable_advertising(&req);
+		}
 	} else {
 		__hci_req_disable_advertising(&req);
 	}
@@ -6312,7 +6320,11 @@ static u32 get_supported_adv_flags(struct hci_dev *hdev)
 	flags |= MGMT_ADV_FLAG_APPEARANCE;
 	flags |= MGMT_ADV_FLAG_LOCAL_NAME;
 
-	if (hdev->adv_tx_power != HCI_TX_POWER_INVALID)
+	/* In extended adv TX_POWER returned from Set Adv Param
+	 * will be always valid.
+	 */
+	if ((hdev->adv_tx_power != HCI_TX_POWER_INVALID) ||
+	    ext_adv_capable(hdev))
 		flags |= MGMT_ADV_FLAG_TX_POWER;
 
 	return flags;
-- 
2.7.4
