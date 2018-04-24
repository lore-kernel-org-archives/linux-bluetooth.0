Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH v2 12/18] Bluetooth: Read no of adv sets during init
Date: Tue, 24 Apr 2018 19:20:45 +0530
Message-Id: <1524577851-17238-13-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1524577851-17238-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1524577851-17238-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch reads the number of advertising sets in the controller
during init and save it in hdev.

This also checks ext adv support before send Read Adv TX Power
since legacy and extended Adv commands should not be mixed.

Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
---
 include/net/bluetooth/hci.h      |  7 +++++++
 include/net/bluetooth/hci_core.h |  4 ++++
 net/bluetooth/hci_core.c         | 12 ++++++++++--
 net/bluetooth/hci_event.c        | 18 ++++++++++++++++++
 4 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index ee58389..d8c0dbe 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -406,6 +406,7 @@ enum {
 #define HCI_LE_SLAVE_FEATURES		0x08
 #define HCI_LE_PING			0x10
 #define HCI_LE_DATA_LEN_EXT		0x20
+#define HCI_LE_EXT_ADV			0x10
 #define HCI_LE_EXT_SCAN_POLICY		0x80
 #define HCI_LE_PHY_2M			0x01
 #define HCI_LE_PHY_CODED		0x08
@@ -1567,6 +1568,12 @@ struct hci_cp_le_ext_conn_param {
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
index a386f40..9a74e24 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -221,6 +221,7 @@ struct hci_dev {
 	__u8		features[HCI_MAX_PAGES][8];
 	__u8		le_features[8];
 	__u8		le_white_list_size;
+	__u8		le_no_of_adv_sets;
 	__u8		le_states[8];
 	__u8		commands[64];
 	__u8		hci_ver;
@@ -1171,6 +1172,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 
 #define use_ext_conn(dev) ((dev)->commands[37] & 0x80)
 
+/* Extended advertising support */
+#define ext_adv_capable(dev) (((dev)->le_features[1] & HCI_LE_EXT_ADV))
+
 /* ----- HCI protocols ----- */
 #define HCI_PROTO_DEFER             0x01
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 45df3ad..3ac034e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -724,8 +724,10 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
 		hci_req_add(req, HCI_OP_LE_SET_EVENT_MASK, sizeof(events),
 			    events);
 
-		if (hdev->commands[25] & 0x40) {
-			/* Read LE Advertising Channel TX Power */
+		if ((hdev->commands[25] & 0x40) && !ext_adv_capable(hdev)) {
+			/* Read LE Advertising Channel TX Power only if
+			 * extended advertising is not supported
+			 */
 			hci_req_add(req, HCI_OP_LE_READ_ADV_TX_POWER, 0, NULL);
 		}
 
@@ -748,6 +750,12 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
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
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5663dfa..aa2f426 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1297,6 +1297,20 @@ static void hci_cc_le_set_ext_scan_enable(struct hci_dev *hdev,
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
+	hdev->le_no_of_adv_sets = rp->num_of_sets;
+}
+
 static void hci_cc_le_read_white_list_size(struct hci_dev *hdev,
 					   struct sk_buff *skb)
 {
@@ -3185,6 +3199,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cc_le_set_default_phy(hdev, skb);
 		break;
 
+	case HCI_OP_LE_READ_NUM_SUPPORTED_ADV_SETS:
+		hci_cc_le_read_num_adv_sets(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%4.4x", hdev->name, *opcode);
 		break;
-- 
2.7.4

