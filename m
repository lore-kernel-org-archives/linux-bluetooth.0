Return-Path: <cyrus@holtmann.org>
From: Abhinav Kumar <abhinav.ku91@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Abhinav Kumar <abhinav.ku91@samsung.com>
Subject: [PATCH ] [BT][LE Data Length Extension]
Date: Wed, 04 Mar 2015 10:39:09 +0530
Message-id: <1425445750-3723-1-git-send-email-abhinav.ku91@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

1> Added kernel code for for all commands and events which are part of the feature.

Signed-off-by: Abhinav Kumar <abhinav.ku91@samsung.com>
---
 include/net/bluetooth/hci_core.h |   13 ++-
 include/net/bluetooth/mgmt.h     |   40 +++++++++
 net/bluetooth/hci_conn.c         |   27 ++++++
 net/bluetooth/hci_event.c        |   35 +++++++-
 net/bluetooth/mgmt.c             |  169 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 280 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index acec914..14c2c7e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1314,6 +1314,13 @@ void mgmt_pin_code_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				  u8 status);
 void mgmt_pin_code_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				      u8 status);
+void mgmt_le_set_data_length_complete(struct hci_dev * hdev,
+								u8 status, u16 handle);
+void mgmt_le_write_suggested_default_data_length_complete(
+		struct hci_dev *hdev, u8 status);
+void mgmt_le_data_length_changed(
+		struct hci_dev *hdev, u16 handle, u16 txOctets,
+		u16 txTime, u16 rxOctets, u16 rxTime);
 int mgmt_user_confirm_request(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			      u8 link_type, u8 addr_type, u32 value,
 			      u8 confirm_hint);
@@ -1360,7 +1367,11 @@ u8 hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
 		      u16 to_multiplier);
 void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
 							__u8 ltk[16]);
-
+void hci_le_set_data_length(
+	struct hci_dev *hdev, u16 handle,
+	u16 txOctets, u16 txTime);
+void hci_le_write_suggested_default_data_length(
+	struct hci_dev *hdev, u16 txOctets, u16 txTime);
 void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			       u8 *bdaddr_type);
 
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index fe8eef0..e4ad168 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -503,6 +503,37 @@ struct mgmt_cp_start_service_discovery {
 } __packed;
 #define MGMT_START_SERVICE_DISCOVERY_SIZE 4
 
+#define MGMT_LE_READ_SUGGESTED_DEFAULT_DATA_LENGTH_SIZE	0
+#define MGMT_OP_LE_READ_SUGGESTED_DEFAULT_DATA_LENGTH	0x003B
+struct mgmt_rp_le_read_suggested_default_data_length {
+	__le16 txOctets;
+	__le16 txTime;
+} __packed;
+
+#define MGMT_LE_READ_MAXIMUM_DATA_LENGTH_SIZE 0
+#define MGMT_OP_LE_READ_MAXIMUM_DATA_LENGTH	0x003C
+struct mgmt_rp_le_read_maximum_data_length {
+	__le16 txOctets;
+	__le16 txTime;
+	__le16 rxOctets;
+	__le16 rxTime;
+} __packed;
+
+#define MGMT_LE_WRITE_SUGGESTED_DEFAULT_DATA_LENGTH_SIZE 4
+#define MGMT_OP_LE_WRITE_SUGGESTED_DEFAULT_DATA_LENGTH 0x003D
+struct mgmt_cp_le_write_suggested_default_data_length {
+	__le16 txOctets;
+	__le16 txTime;
+} __packed;
+
+#define MGMT_LE_SET_DATA_LENGTH_SIZE 10
+#define MGMT_OP_LE_SET_DATA_LENGTH 0x003E
+struct mgmt_cp_le_set_data_length {
+	bdaddr_t bdaddr;
+	__le16 txOctets;
+	__le16 txTime;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
@@ -690,3 +721,12 @@ struct mgmt_ev_new_conn_param {
 #define MGMT_EV_UNCONF_INDEX_REMOVED	0x001e
 
 #define MGMT_EV_NEW_CONFIG_OPTIONS	0x001f
+
+#define MGMT_EV_LE_DATA_LENGTH_CHANGE   0x0024
+struct mgmt_ev_le_data_length_change {
+	bdaddr_t bdaddr;
+	__le16 txOctets;
+	__le16 txTime;
+	__le16 rxOctets;
+	__le16 rxTime;
+} __packed;
\ No newline at end of file
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 91ebb9c..6fff13e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -275,6 +275,33 @@ u8 hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
 	return 0x00;
 }
 
+void hci_le_write_suggested_default_data_length(
+			struct hci_dev *hdev, u16 txOctets, u16 txTime) {
+
+	struct hci_cp_le_write_def_data_len cp;
+
+	memset(&cp, 0, sizeof(cp));
+
+	cp.tx_len = cpu_to_le16(txOctets);
+	cp.tx_time = cpu_to_le16(txTime);
+
+	hci_send_cmd(hdev,
+			HCI_OP_LE_WRITE_DEF_DATA_LEN, sizeof(cp), &cp);
+}
+
+void hci_le_set_data_length(
+	struct hci_dev *hdev, u16 handle, u16 txOctets, u16 txTime) {
+
+	struct hci_cp_le_set_data_len cp;
+	memset(&cp, 0, sizeof(cp));
+
+	cp.handle = cpu_to_le16(handle);
+	cp.tx_len = cpu_to_le16(txOctets);
+	cp.tx_time = cpu_to_le16(txTime);
+
+	hci_send_cmd(hdev, HCI_OP_LE_SET_DATA_LEN, sizeof(cp), &cp);
+}
+
 void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
 		      __u8 ltk[16])
 {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 39653d4..97af5c3 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1320,6 +1320,16 @@ static void hci_cc_le_read_supported_states(struct hci_dev *hdev,
 	memcpy(hdev->le_states, rp->le_states, 8);
 }
 
+static void hci_cc_le_set_data_len(struct hci_dev *hdev,
+					 struct sk_buff *skb)
+{
+	struct hci_rp_le_set_data_len *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	mgmt_le_set_data_length_complete(hdev, rp->status, rp->handle);
+}
+
 static void hci_cc_le_read_def_data_len(struct hci_dev *hdev,
 					struct sk_buff *skb)
 {
@@ -1342,15 +1352,14 @@ static void hci_cc_le_write_def_data_len(struct hci_dev *hdev,
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
 
-	if (status)
-		return;
-
 	sent = hci_sent_cmd_data(hdev, HCI_OP_LE_WRITE_DEF_DATA_LEN);
 	if (!sent)
 		return;
 
 	hdev->le_def_tx_len = le16_to_cpu(sent->tx_len);
 	hdev->le_def_tx_time = le16_to_cpu(sent->tx_time);
+
+    mgmt_le_write_suggested_default_data_length_complete(hdev, status);
 }
 
 static void hci_cc_le_read_max_data_len(struct hci_dev *hdev,
@@ -2978,6 +2987,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_le_read_max_data_len(hdev, skb);
 		break;
 
+	case HCI_OP_LE_SET_DATA_LEN:
+		hci_cc_le_set_data_len(hdev, skb);
+		break;
+
 	case HCI_OP_WRITE_LE_HOST_SUPPORTED:
 		hci_cc_write_le_host_supported(hdev, skb);
 		break;
@@ -4968,6 +4981,19 @@ static void hci_le_direct_adv_report_evt(struct hci_dev *hdev,
 	hci_dev_unlock(hdev);
 }
 
+static void hci_le_data_length_change_evt(
+	struct hci_dev *hdev, struct sk_buff *skb) {
+
+	struct hci_ev_le_data_len_change *ev = (void *) skb->data;
+	struct hci_conn *conn;
+
+	hci_dev_lock(hdev);
+
+	mgmt_le_data_length_changed(hdev, ev->handle, ev->tx_len,
+					ev->tx_time, ev->rx_len, ev->rx_time);
+	hci_dev_unlock(hdev);
+}
+
 static void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_le_meta *le_ev = (void *) skb->data;
@@ -4998,6 +5024,9 @@ static void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	case HCI_EV_LE_DIRECT_ADV_REPORT:
 		hci_le_direct_adv_report_evt(hdev, skb);
 		break;
+	case HCI_EV_LE_DATA_LEN_CHANGE:
+		hci_le_data_length_change_evt( hdev, skb );
+		break;
 
 	default:
 		break;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1e4635a..8b6079a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -96,6 +96,10 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_SET_EXTERNAL_CONFIG,
 	MGMT_OP_SET_PUBLIC_ADDRESS,
 	MGMT_OP_START_SERVICE_DISCOVERY,
+	MGMT_OP_LE_READ_SUGGESTED_DEFAULT_DATA_LENGTH,
+	MGMT_OP_LE_READ_MAXIMUM_DATA_LENGTH,
+	MGMT_OP_LE_WRITE_SUGGESTED_DEFAULT_DATA_LENGTH,
+	MGMT_OP_LE_SET_DATA_LENGTH,
 };
 
 static const u16 mgmt_events[] = {
@@ -4205,6 +4209,105 @@ unlock:
 	return err;
 }
 
+static int le_set_data_length( struct sock *sk, struct hci_dev *hdev, void *data, u16 len )
+{
+	struct mgmt_cp_le_set_data_length *cp = data;
+	struct pending_cmd *cmd;
+	struct hci_conn *conn = NULL;
+
+	u16 txOctets, txTime, handle;
+	int err = 0;
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->bdaddr);
+
+	if(!conn) {
+		err = -ENOMEM;
+		goto done;
+	}
+
+	handle = conn->handle;
+	txOctets = __le16_to_cpu( cp->txOctets );
+	txTime = __le16_to_cpu( cp->txTime );
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_LE_SET_DATA_LENGTH, hdev, data, len);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto done;
+	}
+
+	hci_le_set_data_length(hdev, handle, txOctets, txTime);
+done:
+	hci_dev_unlock(hdev);
+	return err;
+}
+
+static int le_write_suggested_default_data_length(
+	struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
+{
+	struct mgmt_cp_le_write_suggested_default_data_length *cp = data;
+	struct pending_cmd *cmd;
+	u16 txOctets, txTime;
+	int err = 0;
+
+	hci_dev_lock(hdev);
+
+	txOctets = __le16_to_cpu(cp->txOctets);
+	txTime = __le16_to_cpu(cp->txTime);
+
+	cmd = mgmt_pending_add(sk,
+			MGMT_OP_LE_WRITE_SUGGESTED_DEFAULT_DATA_LENGTH, hdev, data, len);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto done;
+	}
+
+	hci_le_write_suggested_default_data_length(hdev, txOctets, txTime);
+done:
+	hci_dev_unlock(hdev);
+	return err;
+}
+
+static int le_read_suggested_default_data_length(
+		struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
+{
+	int err = 0;
+	struct mgmt_rp_le_read_suggested_default_data_length rp;
+
+	hci_dev_lock(hdev);
+
+	rp.txOctets = hdev->le_def_tx_len;
+	rp.txTime = hdev->le_def_tx_time;
+
+	cmd_complete(sk, hdev->id,
+				MGMT_OP_LE_READ_SUGGESTED_DEFAULT_DATA_LENGTH,
+				mgmt_status(MGMT_STATUS_SUCCESS), &rp, sizeof(rp));
+
+	hci_dev_unlock(hdev);
+	return err;
+}
+
+static int le_read_maximum_data_length(
+	struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
+{
+	int err = 0;
+	struct mgmt_rp_le_read_maximum_data_length rp;
+
+	hci_dev_lock(hdev);
+
+	rp.txOctets = hdev->le_max_tx_len;
+	rp.txTime = hdev->le_max_tx_time;
+	rp.rxOctets = hdev->le_max_rx_len;
+	rp.rxTime = hdev->le_max_rx_time;
+
+	cmd_complete(sk, hdev->id,
+				MGMT_OP_LE_READ_MAXIMUM_DATA_LENGTH,
+				mgmt_status(0), &rp, sizeof(rp));
+	hci_dev_unlock(hdev);
+	return err;
+}
+
 static int confirm_name(struct sock *sk, struct hci_dev *hdev, void *data,
 			u16 len)
 {
@@ -6171,6 +6274,13 @@ static const struct mgmt_handler {
 	{ set_external_config,    false, MGMT_SET_EXTERNAL_CONFIG_SIZE },
 	{ set_public_address,     false, MGMT_SET_PUBLIC_ADDRESS_SIZE },
 	{ start_service_discovery,true,  MGMT_START_SERVICE_DISCOVERY_SIZE },
+	{ le_read_suggested_default_data_length, false,
+		MGMT_LE_READ_SUGGESTED_DEFAULT_DATA_LENGTH_SIZE },
+	{ le_read_maximum_data_length, false,
+		MGMT_LE_READ_MAXIMUM_DATA_LENGTH_SIZE },
+	{ le_write_suggested_default_data_length, false,
+		MGMT_LE_WRITE_SUGGESTED_DEFAULT_DATA_LENGTH_SIZE },
+	{ le_set_data_length, false, MGMT_LE_SET_DATA_LENGTH_SIZE },
 };
 
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
@@ -6871,6 +6981,65 @@ void mgmt_pin_code_request(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 secure)
 	mgmt_event(MGMT_EV_PIN_CODE_REQUEST, hdev, &ev, sizeof(ev), NULL);
 }
 
+void mgmt_le_data_length_changed(struct hci_dev *hdev, u16 handle,
+					u16 txOctets, u16 txTime, u16 rxOctets, u16 rxTime) {
+
+	struct mgmt_ev_le_data_length_change ev;
+	struct hci_conn *conn;
+
+	conn = hci_conn_hash_lookup_handle(hdev, handle);
+
+	ev.bdaddr = conn->dst;
+	ev.txOctets = cpu_to_le16(txOctets);
+	ev.txTime = cpu_to_le16(txTime);
+	ev.rxOctets = cpu_to_le16(rxOctets);
+	ev.rxTime = cpu_to_le16(rxTime);
+
+	return mgmt_event(MGMT_EV_LE_DATA_LENGTH_CHANGE,
+			hdev, &ev, sizeof(ev), NULL);
+}
+
+void mgmt_le_write_suggested_default_data_length_complete(
+		struct hci_dev *hdev, u8 status) {
+
+	struct pending_cmd *cmd;
+	cmd = mgmt_pending_find(
+			MGMT_OP_LE_WRITE_SUGGESTED_DEFAULT_DATA_LENGTH, hdev);
+	if (!cmd) {
+		BT_INFO( "could not find command" );
+		return;
+	}
+
+	cmd_complete(cmd->sk, hdev->id, MGMT_OP_LE_WRITE_SUGGESTED_DEFAULT_DATA_LENGTH,
+			 mgmt_status(status), NULL, 0);
+	mgmt_pending_remove(cmd);
+}
+
+void mgmt_le_set_data_length_complete(struct hci_dev *hdev, u8 status, u16 handle) {
+
+	struct pending_cmd *cmd;
+	struct hci_conn *conn;
+	void *rp = NULL;
+	int len = 0;
+
+	cmd = mgmt_pending_find(MGMT_OP_LE_SET_DATA_LENGTH, hdev);
+	if (!cmd) {
+		BT_INFO( "could not find command" );
+		return;
+	}
+
+	conn = hci_conn_hash_lookup_handle(hdev, handle);
+
+	if(conn) {
+		rp = (void *)&(conn->dst);
+		len = 6;
+	}
+
+	cmd_complete(cmd->sk, hdev->id, MGMT_OP_LE_SET_DATA_LENGTH,
+				 mgmt_status(status), rp, len);
+	mgmt_pending_remove(cmd);
+}
+
 void mgmt_pin_code_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				  u8 status)
 {
-- 
1.7.9.5

