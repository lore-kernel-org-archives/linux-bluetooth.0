Return-Path: <jaganath.k.os@gmail.com>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH v5 09/16] Bluetooth: Read no of adv sets during init
Date: Thu, 19 Jul 2018 17:09:40 +0530
Message-Id: <1532000387-3649-10-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1532000387-3649-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1532000387-3649-1-git-send-email-jaganathx.kanakkassery@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch reads the number of advertising sets in the controller
during init and save it in hdev.

Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
---
 include/net/bluetooth/hci.h      |  7 +++++++
 include/net/bluetooth/hci_core.h |  4 ++++
 net/bluetooth/hci_core.c         | 16 ++++++++++++++--
 net/bluetooth/hci_event.c        | 18 ++++++++++++++++++
 4 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 83a1593..3f93ae9 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -410,6 +410,7 @@ enum {
 #define HCI_LE_SLAVE_FEATURES		0x08
 #define HCI_LE_PING			0x10
 #define HCI_LE_DATA_LEN_EXT		0x20
+#define HCI_LE_EXT_ADV			0x10
 #define HCI_LE_EXT_SCAN_POLICY		0x80
 #define HCI_LE_PHY_2M			0x01
 #define HCI_LE_PHY_CODED		0x08
@@ -1579,6 +1580,12 @@ struct hci_cp_le_ext_conn_param {
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
index 113c9bb..2aad4a8 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -222,6 +222,7 @@ struct hci_dev {
 	__u8		le_features[8];
 	__u8		le_white_list_size;
 	__u8		le_resolv_list_size;
+	__u8		le_num_of_adv_sets;
 	__u8		le_states[8];
 	__u8		commands[64];
 	__u8		hci_ver;
@@ -1180,6 +1181,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 /* Use ext create connection if command is supported */
 #define use_ext_conn(dev) ((dev)->commands[37] & 0x80)
 
+/* Extended advertising support */
+#define ext_adv_capable(dev) (((dev)->le_features[1] & HCI_LE_EXT_ADV))
+
 /* ----- HCI protocols ----- */
 #define HCI_PROTO_DEFER             0x01
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 523e91a..7b08b7f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -715,8 +715,14 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
 		hci_req_add(req, HCI_OP_LE_SET_EVENT_MASK, sizeof(events),
 			    events);
 
-		if (hdev->commands[25] & 0x40) {
-			/* Read LE Advertising Channel TX Power */
+		/* Read LE Advertising Channel TX Power */
+		if ((hdev->commands[25] & 0x40) && !ext_adv_capable(hdev)) {
+			/* HCI TS spec forbids mixing of legacy and extended
+			 * advertising commands wherein READ_ADV_TX_POWER is
+			 * also included. So do not call it if extended adv
+			 * is supported otherwise controller will return
+			 * COMMAND_DISALLOWED for extended commands.
+			 */
 			hci_req_add(req, HCI_OP_LE_READ_ADV_TX_POWER, 0, NULL);
 		}
 
@@ -750,6 +756,12 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
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
index 5fa00f4..0ceb52e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1267,6 +1267,20 @@ static void hci_cc_le_set_ext_scan_enable(struct hci_dev *hdev,
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
+	hdev->le_num_of_adv_sets = rp->num_of_sets;
+}
+
 static void hci_cc_le_read_white_list_size(struct hci_dev *hdev,
 					   struct sk_buff *skb)
 {
@@ -3189,6 +3203,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
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
