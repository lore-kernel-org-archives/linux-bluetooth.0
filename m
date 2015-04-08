Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Read LE remote features during connection establishment
Date: Wed,  8 Apr 2015 01:25:20 -0700
Message-Id: <1428481520-29567-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When establishing a Bluetooth LE connection, read the remote used
features mask to determine which features are supported. This was
not really needed with Bluetooth 4.0, but since Bluetooth 4.1 and
also 4.2 have introduced new optional features, this becomes more
important.

This works the same as with BR/EDR where the connection enters the
BT_CONFIG stage and hci_connect_cfm call is delayed until the remote
features have been retrieved. Only after successfully receiving the
remote features, the connection enters the BT_CONNECTED state.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 12 ++++++++
 net/bluetooth/hci_event.c   | 75 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 2f8c830e600c..cb568ecc43a5 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1376,6 +1376,11 @@ struct hci_cp_le_conn_update {
 	__le16   max_ce_len;
 } __packed;
 
+#define HCI_OP_LE_READ_REMOTE_FEATURES	0x2016
+struct hci_cp_le_read_remote_features {
+	__le16	 handle;
+} __packed;
+
 #define HCI_OP_LE_START_ENC		0x2019
 struct hci_cp_le_start_enc {
 	__le16	handle;
@@ -1868,6 +1873,13 @@ struct hci_ev_le_conn_update_complete {
 	__le16   supervision_timeout;
 } __packed;
 
+#define HCI_EV_LE_REMOTE_FEAT_COMPLETE	0x04
+struct hci_ev_le_remote_feat_complete {
+	__u8     status;
+	__le16   handle;
+	__u8     features[8];
+} __packed;
+
 #define HCI_EV_LE_LTK_REQ		0x05
 struct hci_ev_le_ltk_req {
 	__le16	handle;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 01031038eb0e..123a6400a9d7 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2036,6 +2036,33 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
+static void hci_cs_le_read_remote_features(struct hci_dev *hdev, u8 status)
+{
+	struct hci_cp_le_read_remote_features *cp;
+	struct hci_conn *conn;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	if (!status)
+		return;
+
+	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_READ_REMOTE_FEATURES);
+	if (!cp)
+		return;
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(cp->handle));
+	if (conn) {
+		if (conn->state == BT_CONFIG) {
+			hci_connect_cfm(conn, status);
+			hci_conn_drop(conn);
+		}
+	}
+
+	hci_dev_unlock(hdev);
+}
+
 static void hci_cs_le_start_enc(struct hci_dev *hdev, u8 status)
 {
 	struct hci_cp_le_start_enc *cp;
@@ -3104,6 +3131,10 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cs_le_create_conn(hdev, ev->status);
 		break;
 
+	case HCI_OP_LE_READ_REMOTE_FEATURES:
+		hci_cs_le_read_remote_features(hdev, ev->status);
+		break;
+
 	case HCI_OP_LE_START_ENC:
 		hci_cs_le_start_enc(hdev, ev->status);
 		break;
@@ -4515,7 +4546,7 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	conn->sec_level = BT_SECURITY_LOW;
 	conn->handle = __le16_to_cpu(ev->handle);
-	conn->state = BT_CONNECTED;
+	conn->state = BT_CONFIG;
 
 	conn->le_conn_interval = le16_to_cpu(ev->interval);
 	conn->le_conn_latency = le16_to_cpu(ev->latency);
@@ -4524,7 +4555,18 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_debugfs_create_conn(conn);
 	hci_conn_add_sysfs(conn);
 
-	hci_connect_cfm(conn, ev->status);
+	if (!ev->status) {
+		struct hci_cp_le_read_remote_features cp;
+
+		cp.handle = __cpu_to_le16(conn->handle);
+
+		hci_send_cmd(hdev, HCI_OP_LE_READ_REMOTE_FEATURES,
+			     sizeof(cp), &cp);
+
+		hci_conn_hold(conn);
+	} else {
+		hci_connect_cfm(conn, ev->status);
+	}
 
 	params = hci_pend_le_action_lookup(&hdev->pend_le_conns, &conn->dst,
 					   conn->dst_type);
@@ -4826,6 +4868,31 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_unlock(hdev);
 }
 
+static void hci_le_remote_feat_complete_evt(struct hci_dev *hdev,
+					    struct sk_buff *skb)
+{
+	struct hci_ev_le_remote_feat_complete *ev = (void *)skb->data;
+	struct hci_conn *conn;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
+	if (conn) {
+		if (!ev->status)
+			memcpy(conn->features[0], ev->features, 8);
+
+		if (conn->state == BT_CONFIG) {
+			conn->state = BT_CONNECTED;
+			hci_connect_cfm(conn, ev->status);
+			hci_conn_drop(conn);
+		}
+	}
+
+	hci_dev_unlock(hdev);
+}
+
 static void hci_le_ltk_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_le_ltk_req *ev = (void *) skb->data;
@@ -4999,6 +5066,10 @@ static void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_le_adv_report_evt(hdev, skb);
 		break;
 
+	case HCI_EV_LE_REMOTE_FEAT_COMPLETE:
+		hci_le_remote_feat_complete_evt(hdev, skb);
+		break;
+
 	case HCI_EV_LE_LTK_REQ:
 		hci_le_ltk_request_evt(hdev, skb);
 		break;
-- 
2.1.0

