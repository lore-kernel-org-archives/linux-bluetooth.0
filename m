Return-Path: <cyrus@holtmann.org>
From: Arron Wang <arron.wang@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arron Wang <arron.wang@intel.com>
Subject: [PATCH 2/3] Bluetooth: Classify HCI cmd status event under corresponding config option
Date: Thu, 20 Aug 2015 17:09:04 +0800
Message-Id: <1440061745-24356-2-git-send-email-arron.wang@intel.com>
In-Reply-To: <1440061745-24356-1-git-send-email-arron.wang@intel.com>
References: <1440061745-24356-1-git-send-email-arron.wang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Arron Wang <arron.wang@intel.com>
---
 net/bluetooth/hci_event.c |   74 +++++++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 33 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4d7dfd3..a4df0fb 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1445,6 +1445,29 @@ static void hci_cc_set_adv_param(struct hci_dev *hdev, struct sk_buff *skb)
 }
 #endif
 
+static void hci_cs_disconnect(struct hci_dev *hdev, u8 status)
+{
+	struct hci_cp_disconnect *cp;
+	struct hci_conn *conn;
+
+	if (!status)
+		return;
+
+	cp = hci_sent_cmd_data(hdev, HCI_OP_DISCONNECT);
+	if (!cp)
+		return;
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(cp->handle));
+	if (conn)
+		mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
+				       conn->dst_type, status);
+
+	hci_dev_unlock(hdev);
+}
+
+#if IS_ENABLED(CONFIG_BT_BREDR)
 static void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 {
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
@@ -1876,28 +1899,31 @@ static void hci_cs_exit_sniff_mode(struct hci_dev *hdev, __u8 status)
 	hci_dev_unlock(hdev);
 }
 
-static void hci_cs_disconnect(struct hci_dev *hdev, u8 status)
+static void hci_cs_switch_role(struct hci_dev *hdev, u8 status)
 {
-	struct hci_cp_disconnect *cp;
+	struct hci_cp_switch_role *cp;
 	struct hci_conn *conn;
 
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
 	if (!status)
 		return;
 
-	cp = hci_sent_cmd_data(hdev, HCI_OP_DISCONNECT);
+	cp = hci_sent_cmd_data(hdev, HCI_OP_SWITCH_ROLE);
 	if (!cp)
 		return;
 
 	hci_dev_lock(hdev);
 
-	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(cp->handle));
+	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->bdaddr);
 	if (conn)
-		mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
-				       conn->dst_type, status);
+		clear_bit(HCI_CONN_RSWITCH_PEND, &conn->flags);
 
 	hci_dev_unlock(hdev);
 }
+#endif
 
+#if IS_ENABLED(CONFIG_BT_LE)
 static void hci_cs_le_create_conn(struct hci_dev *hdev, u8 status)
 {
 	struct hci_cp_le_create_conn *cp;
@@ -2005,29 +2031,7 @@ static void hci_cs_le_start_enc(struct hci_dev *hdev, u8 status)
 unlock:
 	hci_dev_unlock(hdev);
 }
-
-static void hci_cs_switch_role(struct hci_dev *hdev, u8 status)
-{
-	struct hci_cp_switch_role *cp;
-	struct hci_conn *conn;
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
-
-	if (!status)
-		return;
-
-	cp = hci_sent_cmd_data(hdev, HCI_OP_SWITCH_ROLE);
-	if (!cp)
-		return;
-
-	hci_dev_lock(hdev);
-
-	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->bdaddr);
-	if (conn)
-		clear_bit(HCI_CONN_RSWITCH_PEND, &conn->flags);
-
-	hci_dev_unlock(hdev);
-}
+#endif
 
 static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
@@ -3064,6 +3068,11 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb,
 	*status = ev->status;
 
 	switch (*opcode) {
+	case HCI_OP_DISCONNECT:
+		hci_cs_disconnect(hdev, ev->status);
+		break;
+
+#if IS_ENABLED(CONFIG_BT_BREDR)
 	case HCI_OP_INQUIRY:
 		hci_cs_inquiry(hdev, ev->status);
 		break;
@@ -3072,10 +3081,6 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cs_create_conn(hdev, ev->status);
 		break;
 
-	case HCI_OP_DISCONNECT:
-		hci_cs_disconnect(hdev, ev->status);
-		break;
-
 	case HCI_OP_ADD_SCO:
 		hci_cs_add_sco(hdev, ev->status);
 		break;
@@ -3115,7 +3120,9 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb,
 	case HCI_OP_SWITCH_ROLE:
 		hci_cs_switch_role(hdev, ev->status);
 		break;
+#endif
 
+#if IS_ENABLED(CONFIG_BT_LE)
 	case HCI_OP_LE_CREATE_CONN:
 		hci_cs_le_create_conn(hdev, ev->status);
 		break;
@@ -3127,6 +3134,7 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb,
 	case HCI_OP_LE_START_ENC:
 		hci_cs_le_start_enc(hdev, ev->status);
 		break;
+#endif
 
 	default:
 		BT_DBG("%s opcode 0x%4.4x", hdev->name, *opcode);
-- 
1.7.9.5

