Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [RFC 1/9] Bluetooth: Read no of adv sets during init
Date: Mon,  4 Dec 2017 13:37:45 +0530
Message-Id: <1512374873-1956-2-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1512374873-1956-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1512374873-1956-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch reads the number of advertising sets in the controller
during init and save it in hdev.

Currently host only supports upto HCI_MAX_ADV_INSTANCES (5).

Instance 0 is reserved for "Set Advertising" which means that
multi adv is supported only for total sets - 1.

Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
---
 include/net/bluetooth/hci.h      |  7 +++++++
 include/net/bluetooth/hci_core.h |  4 ++++
 net/bluetooth/hci_core.c         | 11 +++++++++--
 net/bluetooth/hci_event.c        | 20 ++++++++++++++++++++
 net/bluetooth/mgmt.c             |  6 +++---
 5 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index f0868df..59df823 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -398,6 +398,7 @@ enum {
 #define HCI_LE_SLAVE_FEATURES		0x08
 #define HCI_LE_PING			0x10
 #define HCI_LE_DATA_LEN_EXT		0x20
+#define HCI_LE_EXT_ADV			0x10
 #define HCI_LE_EXT_SCAN_POLICY		0x80
 
 /* Connection modes */
@@ -1543,6 +1544,12 @@ struct hci_cp_le_ext_conn_param {
         __le16 max_ce_len;
 } __packed;
 
+#define HCI_OP_LE_READ_NUM_SUPPORTED_ADV_SETS	0x203b
+struct hci_rp_le_read_num_supported_adv_sets {
+	__u8  status;
+	__u8  num_of_sets;
+} __packed;
+
 /* ---- HCI Events ---- */
 #define HCI_EV_INQUIRY_COMPLETE		0x01
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 554671c..4a7a4ae 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -219,6 +219,7 @@ struct hci_dev {
 	__u8		features[HCI_MAX_PAGES][8];
 	__u8		le_features[8];
 	__u8		le_white_list_size;
+	__u8		le_no_of_adv_sets;
 	__u8		le_states[8];
 	__u8		commands[64];
 	__u8		hci_ver;
@@ -1154,6 +1155,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define bredr_sc_enabled(dev)  (lmp_sc_capable(dev) && \
 				hci_dev_test_flag(dev, HCI_SC_ENABLED))
 
+/* Extended advertising support */
+#define ext_adv_capable(dev) ((dev)->le_features[1] & HCI_LE_EXT_ADV)
+
 /* ----- HCI protocols ----- */
 #define HCI_PROTO_DEFER             0x01
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a91a09a..3472572 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -716,6 +716,12 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
 			hci_req_add(req, HCI_OP_LE_READ_DEF_DATA_LEN, 0, NULL);
 		}
 
+		if (ext_adv_capable(hdev)) {
+			/* Read LE Number of Supported Advertising Sets */
+			hci_req_add(req, HCI_OP_LE_READ_NUM_SUPPORTED_ADV_SETS,
+				    0, NULL);
+		}
+
 		hci_set_le_support(req);
 	}
 
@@ -2676,8 +2682,8 @@ int hci_add_adv_instance(struct hci_dev *hdev, u8 instance, u32 flags,
 		memset(adv_instance->scan_rsp_data, 0,
 		       sizeof(adv_instance->scan_rsp_data));
 	} else {
-		if (hdev->adv_instance_cnt >= HCI_MAX_ADV_INSTANCES ||
-		    instance < 1 || instance > HCI_MAX_ADV_INSTANCES)
+		if (hdev->adv_instance_cnt >= hdev->le_no_of_adv_sets ||
+		    instance < 1 || instance > hdev->le_no_of_adv_sets)
 			return -EOVERFLOW;
 
 		adv_instance = kzalloc(sizeof(*adv_instance), GFP_KERNEL);
@@ -2972,6 +2978,7 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->le_max_tx_time = 0x0148;
 	hdev->le_max_rx_len = 0x001b;
 	hdev->le_max_rx_time = 0x0148;
+	hdev->le_no_of_adv_sets = HCI_MAX_ADV_INSTANCES;
 
 	hdev->rpa_timeout = HCI_DEFAULT_RPA_TIMEOUT;
 	hdev->discov_interleaved_timeout = DISCOV_INTERLEAVED_TIMEOUT;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a26ae80..06d8c1b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1243,6 +1243,22 @@ static void hci_cc_le_set_ext_scan_enable(struct hci_dev *hdev,
 	le_set_scan_enable_complete(hdev, cp->enable);
 }
 
+static void hci_cc_le_read_num_adv_sets(struct hci_dev *hdev,
+				      struct sk_buff *skb)
+{
+	struct hci_rp_le_read_num_supported_adv_sets *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%2.2x No of Adv sets %u", hdev->name, rp->status,
+	       rp->num_of_sets);
+
+	if (rp->status)
+		return;
+
+	/* Instance 0 is reserved for Set Advertising */
+	hdev->le_no_of_adv_sets = min_t(u8, rp->num_of_sets - 1,
+					HCI_MAX_ADV_INSTANCES);
+}
+
 static void hci_cc_le_read_white_list_size(struct hci_dev *hdev,
 					   struct sk_buff *skb)
 {
@@ -3128,6 +3144,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cc_le_set_ext_scan_enable(hdev, skb);
 		break;
 
+	case HCI_OP_LE_READ_NUM_SUPPORTED_ADV_SETS:
+		hci_cc_le_read_num_adv_sets(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%4.4x", hdev->name, *opcode);
 		break;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 07a3cc2..ffd5f7b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5998,7 +5998,7 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 	rp->supported_flags = cpu_to_le32(supported_flags);
 	rp->max_adv_data_len = HCI_MAX_AD_LENGTH;
 	rp->max_scan_rsp_len = HCI_MAX_AD_LENGTH;
-	rp->max_instances = HCI_MAX_ADV_INSTANCES;
+	rp->max_instances = hdev->le_no_of_adv_sets;
 	rp->num_instances = hdev->adv_instance_cnt;
 
 	instance = rp->instance;
@@ -6187,7 +6187,7 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
 				       status);
 
-	if (cp->instance < 1 || cp->instance > HCI_MAX_ADV_INSTANCES)
+	if (cp->instance < 1 || cp->instance > hdev->le_no_of_adv_sets)
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
 				       MGMT_STATUS_INVALID_PARAMS);
 
@@ -6422,7 +6422,7 @@ static int get_adv_size_info(struct sock *sk, struct hci_dev *hdev,
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_GET_ADV_SIZE_INFO,
 				       MGMT_STATUS_REJECTED);
 
-	if (cp->instance < 1 || cp->instance > HCI_MAX_ADV_INSTANCES)
+	if (cp->instance < 1 || cp->instance > hdev->le_no_of_adv_sets)
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_GET_ADV_SIZE_INFO,
 				       MGMT_STATUS_INVALID_PARAMS);
 
-- 
2.7.4

