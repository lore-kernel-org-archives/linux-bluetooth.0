Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 2/3] Bluetooth: Move index to common header in management interface
Date: Fri, 25 Feb 2011 19:05:48 +0100
Message-ID: <1298657149-3091-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1298657149-3091-1-git-send-email-szymon.janc@tieto.com>
References: <1298657149-3091-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Most mgmt commands and event are related to hci adapter. Moving index to
common header allow to easily use it in command status while reporting errors.
For those not related to adapter use MGMT_INDEX_NONE (0xFFFF) as index.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 include/net/bluetooth/mgmt.h |   43 +----
 net/bluetooth/mgmt.c         |  407 +++++++++++++++++++-----------------------
 2 files changed, 183 insertions(+), 267 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 1e63c31..5fabfa8 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -21,11 +21,13 @@
    SOFTWARE IS DISCLAIMED.
 */
 
+#define MGMT_INDEX_NONE			0xFFFF
+
 struct mgmt_hdr {
 	__le16 opcode;
+	__le16 index;
 	__le16 len;
 } __packed;
-#define MGMT_HDR_SIZE			4
 
 #define MGMT_OP_READ_VERSION		0x0001
 struct mgmt_rp_read_version {
@@ -40,11 +42,7 @@ struct mgmt_rp_read_index_list {
 } __packed;
 
 #define MGMT_OP_READ_INFO		0x0004
-struct mgmt_cp_read_info {
-	__le16 index;
-} __packed;
 struct mgmt_rp_read_info {
-	__le16 index;
 	__u8 type;
 	__u8 powered;
 	__u8 connectable;
@@ -60,7 +58,6 @@ struct mgmt_rp_read_info {
 } __packed;
 
 struct mgmt_mode {
-	__le16 index;
 	__u8 val;
 } __packed;
 
@@ -74,27 +71,23 @@ struct mgmt_mode {
 
 #define MGMT_OP_ADD_UUID		0x0009
 struct mgmt_cp_add_uuid {
-	__le16 index;
 	__u8 uuid[16];
 	__u8 svc_hint;
 } __packed;
 
 #define MGMT_OP_REMOVE_UUID		0x000A
 struct mgmt_cp_remove_uuid {
-	__le16 index;
 	__u8 uuid[16];
 } __packed;
 
 #define MGMT_OP_SET_DEV_CLASS		0x000B
 struct mgmt_cp_set_dev_class {
-	__le16 index;
 	__u8 major;
 	__u8 minor;
 } __packed;
 
 #define MGMT_OP_SET_SERVICE_CACHE	0x000C
 struct mgmt_cp_set_service_cache {
-	__le16 index;
 	__u8 enable;
 } __packed;
 
@@ -107,7 +100,6 @@ struct mgmt_key_info {
 
 #define MGMT_OP_LOAD_KEYS		0x000D
 struct mgmt_cp_load_keys {
-	__le16 index;
 	__u8 debug_keys;
 	__le16 key_count;
 	struct mgmt_key_info keys[0];
@@ -115,75 +107,60 @@ struct mgmt_cp_load_keys {
 
 #define MGMT_OP_REMOVE_KEY		0x000E
 struct mgmt_cp_remove_key {
-	__le16 index;
 	bdaddr_t bdaddr;
 	__u8 disconnect;
 } __packed;
 
 #define MGMT_OP_DISCONNECT		0x000F
 struct mgmt_cp_disconnect {
-	__le16 index;
 	bdaddr_t bdaddr;
 } __packed;
 struct mgmt_rp_disconnect {
-	__le16 index;
 	bdaddr_t bdaddr;
 } __packed;
 
 #define MGMT_OP_GET_CONNECTIONS		0x0010
-struct mgmt_cp_get_connections {
-	__le16 index;
-} __packed;
 struct mgmt_rp_get_connections {
-	__le16 index;
 	__le16 conn_count;
 	bdaddr_t conn[0];
 } __packed;
 
 #define MGMT_OP_PIN_CODE_REPLY		0x0011
 struct mgmt_cp_pin_code_reply {
-	__le16 index;
 	bdaddr_t bdaddr;
 	__u8 pin_len;
 	__u8 pin_code[16];
 } __packed;
 struct mgmt_rp_pin_code_reply {
-	__le16 index;
 	bdaddr_t bdaddr;
 	uint8_t status;
 } __packed;
 
 #define MGMT_OP_PIN_CODE_NEG_REPLY	0x0012
 struct mgmt_cp_pin_code_neg_reply {
-	__le16 index;
 	bdaddr_t bdaddr;
 } __packed;
 
 #define MGMT_OP_SET_IO_CAPABILITY	0x0013
 struct mgmt_cp_set_io_capability {
-	__le16 index;
 	__u8 io_capability;
 } __packed;
 
 #define MGMT_OP_PAIR_DEVICE		0x0014
 struct mgmt_cp_pair_device {
-	__le16 index;
 	bdaddr_t bdaddr;
 	__u8 io_cap;
 } __packed;
 struct mgmt_rp_pair_device {
-	__le16 index;
 	bdaddr_t bdaddr;
 	__u8 status;
 } __packed;
 
 #define MGMT_OP_USER_CONFIRM_REPLY	0x0015
 struct mgmt_cp_user_confirm_reply {
-	__le16 index;
 	bdaddr_t bdaddr;
 } __packed;
 struct mgmt_rp_user_confirm_reply {
-	__le16 index;
 	bdaddr_t bdaddr;
 	__u8 status;
 } __packed;
@@ -204,19 +181,12 @@ struct mgmt_ev_cmd_status {
 
 #define MGMT_EV_CONTROLLER_ERROR	0x0003
 struct mgmt_ev_controller_error {
-	__le16 index;
 	__u8 error_code;
 } __packed;
 
 #define MGMT_EV_INDEX_ADDED		0x0004
-struct mgmt_ev_index_added {
-	__le16 index;
-} __packed;
 
 #define MGMT_EV_INDEX_REMOVED		0x0005
-struct mgmt_ev_index_removed {
-	__le16 index;
-} __packed;
 
 #define MGMT_EV_POWERED			0x0006
 
@@ -228,46 +198,39 @@ struct mgmt_ev_index_removed {
 
 #define MGMT_EV_NEW_KEY			0x000A
 struct mgmt_ev_new_key {
-	__le16 index;
 	struct mgmt_key_info key;
 	__u8 old_key_type;
 } __packed;
 
 #define MGMT_EV_CONNECTED		0x000B
 struct mgmt_ev_connected {
-	__le16 index;
 	bdaddr_t bdaddr;
 } __packed;
 
 #define MGMT_EV_DISCONNECTED		0x000C
 struct mgmt_ev_disconnected {
-	__le16 index;
 	bdaddr_t bdaddr;
 } __packed;
 
 #define MGMT_EV_CONNECT_FAILED		0x000D
 struct mgmt_ev_connect_failed {
-	__le16 index;
 	bdaddr_t bdaddr;
 	__u8 status;
 } __packed;
 
 #define MGMT_EV_PIN_CODE_REQUEST	0x000E
 struct mgmt_ev_pin_code_request {
-	__le16 index;
 	bdaddr_t bdaddr;
 } __packed;
 
 #define MGMT_EV_USER_CONFIRM_REQUEST	0x000F
 struct mgmt_ev_user_confirm_request {
-	__le16 index;
 	bdaddr_t bdaddr;
 	__le32 value;
 } __packed;
 
 #define MGMT_EV_AUTH_FAILED		0x0010
 struct mgmt_ev_auth_failed {
-	__le16 index;
 	bdaddr_t bdaddr;
 	__u8 status;
 } __packed;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4543ede..98c92ae 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -43,7 +43,7 @@ struct pending_cmd {
 
 LIST_HEAD(cmd_list);
 
-static int cmd_status(struct sock *sk, u16 cmd, u8 status)
+static int cmd_status(struct sock *sk, u16 index, u16 cmd, u8 status)
 {
 	struct sk_buff *skb;
 	struct mgmt_hdr *hdr;
@@ -58,6 +58,7 @@ static int cmd_status(struct sock *sk, u16 cmd, u8 status)
 	hdr = (void *) skb_put(skb, sizeof(*hdr));
 
 	hdr->opcode = cpu_to_le16(MGMT_EV_CMD_STATUS);
+	hdr->index = cpu_to_le16(index);
 	hdr->len = cpu_to_le16(sizeof(*ev));
 
 	ev = (void *) skb_put(skb, sizeof(*ev));
@@ -70,7 +71,8 @@ static int cmd_status(struct sock *sk, u16 cmd, u8 status)
 	return 0;
 }
 
-static int cmd_complete(struct sock *sk, u16 cmd, void *rp, size_t rp_len)
+static int cmd_complete(struct sock *sk, u16 index, u16 cmd, void *rp,
+								size_t rp_len)
 {
 	struct sk_buff *skb;
 	struct mgmt_hdr *hdr;
@@ -85,6 +87,7 @@ static int cmd_complete(struct sock *sk, u16 cmd, void *rp, size_t rp_len)
 	hdr = (void *) skb_put(skb, sizeof(*hdr));
 
 	hdr->opcode = cpu_to_le16(MGMT_EV_CMD_COMPLETE);
+	hdr->index = cpu_to_le16(index);
 	hdr->len = cpu_to_le16(sizeof(*ev) + rp_len);
 
 	ev = (void *) skb_put(skb, sizeof(*ev) + rp_len);
@@ -106,7 +109,8 @@ static int read_version(struct sock *sk)
 	rp.version = MGMT_VERSION;
 	put_unaligned_le16(MGMT_REVISION, &rp.revision);
 
-	return cmd_complete(sk, MGMT_OP_READ_VERSION, &rp, sizeof(rp));
+	return cmd_complete(sk, MGMT_INDEX_NONE, MGMT_OP_READ_VERSION, &rp,
+								sizeof(rp));
 }
 
 static int read_index_list(struct sock *sk)
@@ -152,32 +156,24 @@ static int read_index_list(struct sock *sk)
 
 	read_unlock(&hci_dev_list_lock);
 
-	err = cmd_complete(sk, MGMT_OP_READ_INDEX_LIST, rp, rp_len);
+	err = cmd_complete(sk, MGMT_INDEX_NONE, MGMT_OP_READ_INDEX_LIST, rp,
+									rp_len);
 
 	kfree(rp);
 
 	return err;
 }
 
-static int read_controller_info(struct sock *sk, unsigned char *data, u16 len)
+static int read_controller_info(struct sock *sk, u16 index)
 {
 	struct mgmt_rp_read_info rp;
-	struct mgmt_cp_read_info *cp = (void *) data;
 	struct hci_dev *hdev;
-	u16 dev_id;
 
-	BT_DBG("sock %p", sk);
-
-	if (len != 2)
-		return cmd_status(sk, MGMT_OP_READ_INFO, EINVAL);
-
-	dev_id = get_unaligned_le16(&cp->index);
+	BT_DBG("sock %p hci%u", sk, index);
 
-	BT_DBG("request for hci%u", dev_id);
-
-	hdev = hci_dev_get(dev_id);
+	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, MGMT_OP_READ_INFO, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_READ_INFO, ENODEV);
 
 	hci_del_off_timer(hdev);
 
@@ -185,7 +181,6 @@ static int read_controller_info(struct sock *sk, unsigned char *data, u16 len)
 
 	set_bit(HCI_MGMT, &hdev->flags);
 
-	put_unaligned_le16(hdev->id, &rp.index);
 	rp.type = hdev->dev_type;
 
 	rp.powered = test_bit(HCI_UP, &hdev->flags);
@@ -210,7 +205,7 @@ static int read_controller_info(struct sock *sk, unsigned char *data, u16 len)
 	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
 
-	return cmd_complete(sk, MGMT_OP_READ_INFO, &rp, sizeof(rp));
+	return cmd_complete(sk, index, MGMT_OP_READ_INFO, &rp, sizeof(rp));
 }
 
 static void mgmt_pending_free(struct pending_cmd *cmd)
@@ -296,37 +291,35 @@ static void mgmt_pending_remove(struct pending_cmd *cmd)
 	mgmt_pending_free(cmd);
 }
 
-static int set_powered(struct sock *sk, unsigned char *data, u16 len)
+static int set_powered(struct sock *sk, u16 index, unsigned char *data, u16 len)
 {
 	struct mgmt_mode *cp;
 	struct hci_dev *hdev;
 	struct pending_cmd *cmd;
-	u16 dev_id;
 	int err, up;
 
 	cp = (void *) data;
-	dev_id = get_unaligned_le16(&cp->index);
 
-	BT_DBG("request for hci%u", dev_id);
+	BT_DBG("request for hci%u", index);
 
-	hdev = hci_dev_get(dev_id);
+	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, MGMT_OP_SET_POWERED, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_SET_POWERED, ENODEV);
 
 	hci_dev_lock_bh(hdev);
 
 	up = test_bit(HCI_UP, &hdev->flags);
 	if ((cp->val && up) || (!cp->val && !up)) {
-		err = cmd_status(sk, MGMT_OP_SET_POWERED, EALREADY);
+		err = cmd_status(sk, index, MGMT_OP_SET_POWERED, EALREADY);
 		goto failed;
 	}
 
-	if (mgmt_pending_find(MGMT_OP_SET_POWERED, dev_id)) {
-		err = cmd_status(sk, MGMT_OP_SET_POWERED, EBUSY);
+	if (mgmt_pending_find(MGMT_OP_SET_POWERED, index)) {
+		err = cmd_status(sk, index, MGMT_OP_SET_POWERED, EBUSY);
 		goto failed;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_SET_POWERED, dev_id, data, len);
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_POWERED, index, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
@@ -345,44 +338,43 @@ failed:
 	return err;
 }
 
-static int set_discoverable(struct sock *sk, unsigned char *data, u16 len)
+static int set_discoverable(struct sock *sk, u16 index, unsigned char *data,
+									u16 len)
 {
 	struct mgmt_mode *cp;
 	struct hci_dev *hdev;
 	struct pending_cmd *cmd;
-	u16 dev_id;
 	u8 scan;
 	int err;
 
 	cp = (void *) data;
-	dev_id = get_unaligned_le16(&cp->index);
 
-	BT_DBG("request for hci%u", dev_id);
+	BT_DBG("request for hci%u", index);
 
-	hdev = hci_dev_get(dev_id);
+	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, MGMT_OP_SET_DISCOVERABLE, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_SET_DISCOVERABLE, ENODEV);
 
 	hci_dev_lock_bh(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
-		err = cmd_status(sk, MGMT_OP_SET_DISCOVERABLE, ENETDOWN);
+		err = cmd_status(sk, index, MGMT_OP_SET_DISCOVERABLE, ENETDOWN);
 		goto failed;
 	}
 
-	if (mgmt_pending_find(MGMT_OP_SET_DISCOVERABLE, dev_id) ||
-			mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, dev_id)) {
-		err = cmd_status(sk, MGMT_OP_SET_DISCOVERABLE, EBUSY);
+	if (mgmt_pending_find(MGMT_OP_SET_DISCOVERABLE, index) ||
+			mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, index)) {
+		err = cmd_status(sk, index, MGMT_OP_SET_DISCOVERABLE, EBUSY);
 		goto failed;
 	}
 
 	if (cp->val == test_bit(HCI_ISCAN, &hdev->flags) &&
 					test_bit(HCI_PSCAN, &hdev->flags)) {
-		err = cmd_status(sk, MGMT_OP_SET_DISCOVERABLE, EALREADY);
+		err = cmd_status(sk, index, MGMT_OP_SET_DISCOVERABLE, EALREADY);
 		goto failed;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_SET_DISCOVERABLE, dev_id, data, len);
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_DISCOVERABLE, index, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
@@ -404,43 +396,42 @@ failed:
 	return err;
 }
 
-static int set_connectable(struct sock *sk, unsigned char *data, u16 len)
+static int set_connectable(struct sock *sk, u16 index, unsigned char *data,
+									u16 len)
 {
 	struct mgmt_mode *cp;
 	struct hci_dev *hdev;
 	struct pending_cmd *cmd;
-	u16 dev_id;
 	u8 scan;
 	int err;
 
 	cp = (void *) data;
-	dev_id = get_unaligned_le16(&cp->index);
 
-	BT_DBG("request for hci%u", dev_id);
+	BT_DBG("request for hci%u", index);
 
-	hdev = hci_dev_get(dev_id);
+	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, MGMT_OP_SET_CONNECTABLE, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_SET_CONNECTABLE, ENODEV);
 
 	hci_dev_lock_bh(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
-		err = cmd_status(sk, MGMT_OP_SET_CONNECTABLE, ENETDOWN);
+		err = cmd_status(sk, index, MGMT_OP_SET_CONNECTABLE, ENETDOWN);
 		goto failed;
 	}
 
-	if (mgmt_pending_find(MGMT_OP_SET_DISCOVERABLE, dev_id) ||
-			mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, dev_id)) {
-		err = cmd_status(sk, MGMT_OP_SET_CONNECTABLE, EBUSY);
+	if (mgmt_pending_find(MGMT_OP_SET_DISCOVERABLE, index) ||
+			mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, index)) {
+		err = cmd_status(sk, index, MGMT_OP_SET_CONNECTABLE, EBUSY);
 		goto failed;
 	}
 
 	if (cp->val == test_bit(HCI_PSCAN, &hdev->flags)) {
-		err = cmd_status(sk, MGMT_OP_SET_CONNECTABLE, EALREADY);
+		err = cmd_status(sk, index, MGMT_OP_SET_CONNECTABLE, EALREADY);
 		goto failed;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_SET_CONNECTABLE, dev_id, data, len);
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_CONNECTABLE, index, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
@@ -462,7 +453,8 @@ failed:
 	return err;
 }
 
-static int mgmt_event(u16 event, void *data, u16 data_len, struct sock *skip_sk)
+static int mgmt_event(u16 event, u16 index, void *data, u16 data_len,
+							struct sock *skip_sk)
 {
 	struct sk_buff *skb;
 	struct mgmt_hdr *hdr;
@@ -475,9 +467,11 @@ static int mgmt_event(u16 event, void *data, u16 data_len, struct sock *skip_sk)
 
 	hdr = (void *) skb_put(skb, sizeof(*hdr));
 	hdr->opcode = cpu_to_le16(event);
+	hdr->index = cpu_to_le16(index);
 	hdr->len = cpu_to_le16(data_len);
 
-	memcpy(skb_put(skb, data_len), data, data_len);
+	if (data)
+		memcpy(skb_put(skb, data_len), data, data_len);
 
 	hci_send_to_sock(NULL, skb, skip_sk);
 	kfree_skb(skb);
@@ -489,27 +483,25 @@ static int send_mode_rsp(struct sock *sk, u16 opcode, u16 index, u8 val)
 {
 	struct mgmt_mode rp;
 
-	put_unaligned_le16(index, &rp.index);
 	rp.val = val;
 
-	return cmd_complete(sk, opcode, &rp, sizeof(rp));
+	return cmd_complete(sk, index, opcode, &rp, sizeof(rp));
 }
 
-static int set_pairable(struct sock *sk, unsigned char *data, u16 len)
+static int set_pairable(struct sock *sk, u16 index, unsigned char *data,
+									u16 len)
 {
 	struct mgmt_mode *cp, ev;
 	struct hci_dev *hdev;
-	u16 dev_id;
 	int err;
 
 	cp = (void *) data;
-	dev_id = get_unaligned_le16(&cp->index);
 
-	BT_DBG("request for hci%u", dev_id);
+	BT_DBG("request for hci%u", index);
 
-	hdev = hci_dev_get(dev_id);
+	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, MGMT_OP_SET_PAIRABLE, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_SET_PAIRABLE, ENODEV);
 
 	hci_dev_lock_bh(hdev);
 
@@ -518,14 +510,13 @@ static int set_pairable(struct sock *sk, unsigned char *data, u16 len)
 	else
 		clear_bit(HCI_PAIRABLE, &hdev->flags);
 
-	err = send_mode_rsp(sk, MGMT_OP_SET_PAIRABLE, dev_id, cp->val);
+	err = send_mode_rsp(sk, MGMT_OP_SET_PAIRABLE, index, cp->val);
 	if (err < 0)
 		goto failed;
 
-	put_unaligned_le16(dev_id, &ev.index);
 	ev.val = cp->val;
 
-	err = mgmt_event(MGMT_EV_PAIRABLE, &ev, sizeof(ev), sk);
+	err = mgmt_event(MGMT_EV_PAIRABLE, index, &ev, sizeof(ev), sk);
 
 failed:
 	hci_dev_unlock_bh(hdev);
@@ -567,22 +558,20 @@ static int update_class(struct hci_dev *hdev)
 	return hci_send_cmd(hdev, HCI_OP_WRITE_CLASS_OF_DEV, sizeof(cod), cod);
 }
 
-static int add_uuid(struct sock *sk, unsigned char *data, u16 len)
+static int add_uuid(struct sock *sk, u16 index, unsigned char *data, u16 len)
 {
 	struct mgmt_cp_add_uuid *cp;
 	struct hci_dev *hdev;
 	struct bt_uuid *uuid;
-	u16 dev_id;
 	int err;
 
 	cp = (void *) data;
-	dev_id = get_unaligned_le16(&cp->index);
 
-	BT_DBG("request for hci%u", dev_id);
+	BT_DBG("request for hci%u", index);
 
-	hdev = hci_dev_get(dev_id);
+	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, MGMT_OP_ADD_UUID, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_ADD_UUID, ENODEV);
 
 	hci_dev_lock_bh(hdev);
 
@@ -601,7 +590,7 @@ static int add_uuid(struct sock *sk, unsigned char *data, u16 len)
 	if (err < 0)
 		goto failed;
 
-	err = cmd_complete(sk, MGMT_OP_ADD_UUID, &dev_id, sizeof(dev_id));
+	err = cmd_complete(sk, index, MGMT_OP_ADD_UUID, NULL, 0);
 
 failed:
 	hci_dev_unlock_bh(hdev);
@@ -610,23 +599,21 @@ failed:
 	return err;
 }
 
-static int remove_uuid(struct sock *sk, unsigned char *data, u16 len)
+static int remove_uuid(struct sock *sk, u16 index, unsigned char *data, u16 len)
 {
 	struct list_head *p, *n;
 	struct mgmt_cp_remove_uuid *cp;
 	struct hci_dev *hdev;
 	u8 bt_uuid_any[] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
-	u16 dev_id;
 	int err, found;
 
 	cp = (void *) data;
-	dev_id = get_unaligned_le16(&cp->index);
 
-	BT_DBG("request for hci%u", dev_id);
+	BT_DBG("request for hci%u", index);
 
-	hdev = hci_dev_get(dev_id);
+	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, MGMT_OP_REMOVE_UUID, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_REMOVE_UUID, ENODEV);
 
 	hci_dev_lock_bh(hdev);
 
@@ -648,7 +635,7 @@ static int remove_uuid(struct sock *sk, unsigned char *data, u16 len)
 	}
 
 	if (found == 0) {
-		err = cmd_status(sk, MGMT_OP_REMOVE_UUID, ENOENT);
+		err = cmd_status(sk, index, MGMT_OP_REMOVE_UUID, ENOENT);
 		goto unlock;
 	}
 
@@ -656,7 +643,7 @@ static int remove_uuid(struct sock *sk, unsigned char *data, u16 len)
 	if (err < 0)
 		goto unlock;
 
-	err = cmd_complete(sk, MGMT_OP_REMOVE_UUID, &dev_id, sizeof(dev_id));
+	err = cmd_complete(sk, index, MGMT_OP_REMOVE_UUID, NULL, 0);
 
 unlock:
 	hci_dev_unlock_bh(hdev);
@@ -665,21 +652,20 @@ unlock:
 	return err;
 }
 
-static int set_dev_class(struct sock *sk, unsigned char *data, u16 len)
+static int set_dev_class(struct sock *sk, u16 index, unsigned char *data,
+									u16 len)
 {
 	struct hci_dev *hdev;
 	struct mgmt_cp_set_dev_class *cp;
-	u16 dev_id;
 	int err;
 
 	cp = (void *) data;
-	dev_id = get_unaligned_le16(&cp->index);
 
-	BT_DBG("request for hci%u", dev_id);
+	BT_DBG("request for hci%u", index);
 
-	hdev = hci_dev_get(dev_id);
+	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, MGMT_OP_SET_DEV_CLASS, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_SET_DEV_CLASS, ENODEV);
 
 	hci_dev_lock_bh(hdev);
 
@@ -689,8 +675,7 @@ static int set_dev_class(struct sock *sk, unsigned char *data, u16 len)
 	err = update_class(hdev);
 
 	if (err == 0)
-		err = cmd_complete(sk, MGMT_OP_SET_DEV_CLASS, &dev_id,
-							sizeof(dev_id));
+		err = cmd_complete(sk, index, MGMT_OP_SET_DEV_CLASS, NULL, 0);
 
 	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
@@ -698,23 +683,22 @@ static int set_dev_class(struct sock *sk, unsigned char *data, u16 len)
 	return err;
 }
 
-static int set_service_cache(struct sock *sk, unsigned char *data, u16 len)
+static int set_service_cache(struct sock *sk, u16 index,  unsigned char *data,
+									u16 len)
 {
 	struct hci_dev *hdev;
 	struct mgmt_cp_set_service_cache *cp;
-	u16 dev_id;
 	int err;
 
 	cp = (void *) data;
-	dev_id = get_unaligned_le16(&cp->index);
 
-	hdev = hci_dev_get(dev_id);
+	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, MGMT_OP_SET_SERVICE_CACHE, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_SET_SERVICE_CACHE, ENODEV);
 
 	hci_dev_lock_bh(hdev);
 
-	BT_DBG("hci%u enable %d", dev_id, cp->enable);
+	BT_DBG("hci%u enable %d", index, cp->enable);
 
 	if (cp->enable) {
 		set_bit(HCI_SERVICE_CACHE, &hdev->flags);
@@ -725,8 +709,8 @@ static int set_service_cache(struct sock *sk, unsigned char *data, u16 len)
 	}
 
 	if (err == 0)
-		err = cmd_complete(sk, MGMT_OP_SET_SERVICE_CACHE, &dev_id,
-							sizeof(dev_id));
+		err = cmd_complete(sk, index, MGMT_OP_SET_SERVICE_CACHE, NULL,
+									0);
 
 	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
@@ -734,15 +718,14 @@ static int set_service_cache(struct sock *sk, unsigned char *data, u16 len)
 	return err;
 }
 
-static int load_keys(struct sock *sk, unsigned char *data, u16 len)
+static int load_keys(struct sock *sk, u16 index, unsigned char *data, u16 len)
 {
 	struct hci_dev *hdev;
 	struct mgmt_cp_load_keys *cp;
-	u16 dev_id, key_count, expected_len;
+	u16 key_count, expected_len;
 	int i;
 
 	cp = (void *) data;
-	dev_id = get_unaligned_le16(&cp->index);
 	key_count = get_unaligned_le16(&cp->key_count);
 
 	expected_len = sizeof(*cp) + key_count * sizeof(struct mgmt_key_info);
@@ -752,11 +735,11 @@ static int load_keys(struct sock *sk, unsigned char *data, u16 len)
 		return -EINVAL;
 	}
 
-	hdev = hci_dev_get(dev_id);
+	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, MGMT_OP_LOAD_KEYS, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_LOAD_KEYS, ENODEV);
 
-	BT_DBG("hci%u debug_keys %u key_count %u", dev_id, cp->debug_keys,
+	BT_DBG("hci%u debug_keys %u key_count %u", index, cp->debug_keys,
 								key_count);
 
 	hci_dev_lock_bh(hdev);
@@ -783,26 +766,24 @@ static int load_keys(struct sock *sk, unsigned char *data, u16 len)
 	return 0;
 }
 
-static int remove_key(struct sock *sk, unsigned char *data, u16 len)
+static int remove_key(struct sock *sk, u16 index, unsigned char *data, u16 len)
 {
 	struct hci_dev *hdev;
 	struct mgmt_cp_remove_key *cp;
 	struct hci_conn *conn;
-	u16 dev_id;
 	int err;
 
 	cp = (void *) data;
-	dev_id = get_unaligned_le16(&cp->index);
 
-	hdev = hci_dev_get(dev_id);
+	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, MGMT_OP_REMOVE_KEY, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_REMOVE_KEY, ENODEV);
 
 	hci_dev_lock_bh(hdev);
 
 	err = hci_remove_link_key(hdev, &cp->bdaddr);
 	if (err < 0) {
-		err = cmd_status(sk, MGMT_OP_REMOVE_KEY, -err);
+		err = cmd_status(sk, index, MGMT_OP_REMOVE_KEY, -err);
 		goto unlock;
 	}
 
@@ -827,44 +808,42 @@ unlock:
 	return err;
 }
 
-static int disconnect(struct sock *sk, unsigned char *data, u16 len)
+static int disconnect(struct sock *sk, u16 index, unsigned char *data, u16 len)
 {
 	struct hci_dev *hdev;
 	struct mgmt_cp_disconnect *cp;
 	struct hci_cp_disconnect dc;
 	struct pending_cmd *cmd;
 	struct hci_conn *conn;
-	u16 dev_id;
 	int err;
 
 	BT_DBG("");
 
 	cp = (void *) data;
-	dev_id = get_unaligned_le16(&cp->index);
 
-	hdev = hci_dev_get(dev_id);
+	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, MGMT_OP_DISCONNECT, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_DISCONNECT, ENODEV);
 
 	hci_dev_lock_bh(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
-		err = cmd_status(sk, MGMT_OP_DISCONNECT, ENETDOWN);
+		err = cmd_status(sk, index, MGMT_OP_DISCONNECT, ENETDOWN);
 		goto failed;
 	}
 
-	if (mgmt_pending_find(MGMT_OP_DISCONNECT, dev_id)) {
-		err = cmd_status(sk, MGMT_OP_DISCONNECT, EBUSY);
+	if (mgmt_pending_find(MGMT_OP_DISCONNECT, index)) {
+		err = cmd_status(sk, index, MGMT_OP_DISCONNECT, EBUSY);
 		goto failed;
 	}
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->bdaddr);
 	if (!conn) {
-		err = cmd_status(sk, MGMT_OP_DISCONNECT, ENOTCONN);
+		err = cmd_status(sk, index, MGMT_OP_DISCONNECT, ENOTCONN);
 		goto failed;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_DISCONNECT, dev_id, data, len);
+	cmd = mgmt_pending_add(sk, MGMT_OP_DISCONNECT, index, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
@@ -884,24 +863,24 @@ failed:
 	return err;
 }
 
-static int get_connections(struct sock *sk, unsigned char *data, u16 len)
+static int get_connections(struct sock *sk, u16 index, unsigned char *data,
+									u16 len)
 {
 	struct mgmt_cp_get_connections *cp;
 	struct mgmt_rp_get_connections *rp;
 	struct hci_dev *hdev;
 	struct list_head *p;
 	size_t rp_len;
-	u16 dev_id, count;
+	u16 count;
 	int i, err;
 
 	BT_DBG("");
 
 	cp = (void *) data;
-	dev_id = get_unaligned_le16(&cp->index);
 
-	hdev = hci_dev_get(dev_id);
+	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, MGMT_OP_GET_CONNECTIONS, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_GET_CONNECTIONS, ENODEV);
 
 	hci_dev_lock_bh(hdev);
 
@@ -917,7 +896,6 @@ static int get_connections(struct sock *sk, unsigned char *data, u16 len)
 		goto unlock;
 	}
 
-	put_unaligned_le16(dev_id, &rp->index);
 	put_unaligned_le16(count, &rp->conn_count);
 
 	read_lock(&hci_dev_list_lock);
@@ -931,7 +909,7 @@ static int get_connections(struct sock *sk, unsigned char *data, u16 len)
 
 	read_unlock(&hci_dev_list_lock);
 
-	err = cmd_complete(sk, MGMT_OP_GET_CONNECTIONS, rp, rp_len);
+	err = cmd_complete(sk, index, MGMT_OP_GET_CONNECTIONS, rp, rp_len);
 
 unlock:
 	kfree(rp);
@@ -940,32 +918,31 @@ unlock:
 	return err;
 }
 
-static int pin_code_reply(struct sock *sk, unsigned char *data, u16 len)
+static int pin_code_reply(struct sock *sk, u16 index, unsigned char *data,
+									u16 len)
 {
 	struct hci_dev *hdev;
 	struct mgmt_cp_pin_code_reply *cp;
 	struct hci_cp_pin_code_reply reply;
 	struct pending_cmd *cmd;
-	u16 dev_id;
 	int err;
 
 	BT_DBG("");
 
 	cp = (void *) data;
-	dev_id = get_unaligned_le16(&cp->index);
 
-	hdev = hci_dev_get(dev_id);
+	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, MGMT_OP_PIN_CODE_REPLY, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_PIN_CODE_REPLY, ENODEV);
 
 	hci_dev_lock_bh(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
-		err = cmd_status(sk, MGMT_OP_PIN_CODE_REPLY, ENETDOWN);
+		err = cmd_status(sk, index, MGMT_OP_PIN_CODE_REPLY, ENETDOWN);
 		goto failed;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_PIN_CODE_REPLY, dev_id, data, len);
+	cmd = mgmt_pending_add(sk, MGMT_OP_PIN_CODE_REPLY, index, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
@@ -986,31 +963,32 @@ failed:
 	return err;
 }
 
-static int pin_code_neg_reply(struct sock *sk, unsigned char *data, u16 len)
+static int pin_code_neg_reply(struct sock *sk, u16 index, unsigned char *data,
+									u16 len)
 {
 	struct hci_dev *hdev;
 	struct mgmt_cp_pin_code_neg_reply *cp;
 	struct pending_cmd *cmd;
-	u16 dev_id;
 	int err;
 
 	BT_DBG("");
 
 	cp = (void *) data;
-	dev_id = get_unaligned_le16(&cp->index);
 
-	hdev = hci_dev_get(dev_id);
+	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, MGMT_OP_PIN_CODE_NEG_REPLY, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_PIN_CODE_NEG_REPLY,
+									ENODEV);
 
 	hci_dev_lock_bh(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
-		err = cmd_status(sk, MGMT_OP_PIN_CODE_NEG_REPLY, ENETDOWN);
+		err = cmd_status(sk, index, MGMT_OP_PIN_CODE_NEG_REPLY,
+								ENETDOWN);
 		goto failed;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_PIN_CODE_NEG_REPLY, dev_id,
+	cmd = mgmt_pending_add(sk, MGMT_OP_PIN_CODE_NEG_REPLY, index,
 								data, len);
 	if (!cmd) {
 		err = -ENOMEM;
@@ -1029,20 +1007,19 @@ failed:
 	return err;
 }
 
-static int set_io_capability(struct sock *sk, unsigned char *data, u16 len)
+static int set_io_capability(struct sock *sk, u16 index, unsigned char *data,
+									u16 len)
 {
 	struct hci_dev *hdev;
 	struct mgmt_cp_set_io_capability *cp;
-	u16 dev_id;
 
 	BT_DBG("");
 
 	cp = (void *) data;
-	dev_id = get_unaligned_le16(&cp->index);
 
-	hdev = hci_dev_get(dev_id);
+	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, MGMT_OP_SET_IO_CAPABILITY, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_SET_IO_CAPABILITY, ENODEV);
 
 	hci_dev_lock_bh(hdev);
 
@@ -1054,8 +1031,7 @@ static int set_io_capability(struct sock *sk, unsigned char *data, u16 len)
 	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
 
-	return cmd_complete(sk, MGMT_OP_SET_IO_CAPABILITY,
-						&dev_id, sizeof(dev_id));
+	return cmd_complete(sk, index, MGMT_OP_SET_IO_CAPABILITY, NULL, 0);
 }
 
 static inline struct pending_cmd *find_pairing(struct hci_conn *conn)
@@ -1088,11 +1064,10 @@ static void pairing_complete(struct pending_cmd *cmd, u8 status)
 	struct mgmt_rp_pair_device rp;
 	struct hci_conn *conn = cmd->user_data;
 
-	rp.index = cmd->index;
 	bacpy(&rp.bdaddr, &conn->dst);
 	rp.status = status;
 
-	cmd_complete(cmd->sk, MGMT_OP_PAIR_DEVICE, &rp, sizeof(rp));
+	cmd_complete(cmd->sk, cmd->index, MGMT_OP_PAIR_DEVICE, &rp, sizeof(rp));
 
 	/* So we don't get further callbacks for this connection */
 	conn->connect_cfm_cb = NULL;
@@ -1119,24 +1094,22 @@ static void pairing_complete_cb(struct hci_conn *conn, u8 status)
 	pairing_complete(cmd, status);
 }
 
-static int pair_device(struct sock *sk, unsigned char *data, u16 len)
+static int pair_device(struct sock *sk, u16 index, unsigned char *data, u16 len)
 {
 	struct hci_dev *hdev;
 	struct mgmt_cp_pair_device *cp;
 	struct pending_cmd *cmd;
 	u8 sec_level, auth_type;
 	struct hci_conn *conn;
-	u16 dev_id;
 	int err;
 
 	BT_DBG("");
 
 	cp = (void *) data;
-	dev_id = get_unaligned_le16(&cp->index);
 
-	hdev = hci_dev_get(dev_id);
+	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, MGMT_OP_PAIR_DEVICE, ENODEV);
+		return cmd_status(sk, index, MGMT_OP_PAIR_DEVICE, ENODEV);
 
 	hci_dev_lock_bh(hdev);
 
@@ -1156,11 +1129,11 @@ static int pair_device(struct sock *sk, unsigned char *data, u16 len)
 
 	if (conn->connect_cfm_cb) {
 		hci_conn_put(conn);
-		err = cmd_status(sk, MGMT_OP_PAIR_DEVICE, EBUSY);
+		err = cmd_status(sk, index, MGMT_OP_PAIR_DEVICE, EBUSY);
 		goto unlock;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_PAIR_DEVICE, dev_id, data, len);
+	cmd = mgmt_pending_add(sk, MGMT_OP_PAIR_DEVICE, index, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		hci_conn_put(conn);
@@ -1186,19 +1159,17 @@ unlock:
 	return err;
 }
 
-static int user_confirm_reply(struct sock *sk, unsigned char *data, u16 len,
-								int success)
+static int user_confirm_reply(struct sock *sk, u16 index, unsigned char *data,
+							u16 len, int success)
 {
 	struct mgmt_cp_user_confirm_reply *cp = (void *) data;
-	u16 dev_id, mgmt_op, hci_op;
+	u16 mgmt_op, hci_op;
 	struct pending_cmd *cmd;
 	struct hci_dev *hdev;
 	int err;
 
 	BT_DBG("");
 
-	dev_id = get_unaligned_le16(&cp->index);
-
 	if (success) {
 		mgmt_op = MGMT_OP_USER_CONFIRM_REPLY;
 		hci_op = HCI_OP_USER_CONFIRM_REPLY;
@@ -1207,16 +1178,16 @@ static int user_confirm_reply(struct sock *sk, unsigned char *data, u16 len,
 		hci_op = HCI_OP_USER_CONFIRM_NEG_REPLY;
 	}
 
-	hdev = hci_dev_get(dev_id);
+	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, mgmt_op, ENODEV);
+		return cmd_status(sk, index, mgmt_op, ENODEV);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
-		err = cmd_status(sk, mgmt_op, ENETDOWN);
+		err = cmd_status(sk, index, mgmt_op, ENETDOWN);
 		goto failed;
 	}
 
-	cmd = mgmt_pending_add(sk, mgmt_op, dev_id, data, len);
+	cmd = mgmt_pending_add(sk, mgmt_op, index, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
@@ -1237,7 +1208,7 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 {
 	unsigned char *buf;
 	struct mgmt_hdr *hdr;
-	u16 opcode, len;
+	u16 opcode, index, len;
 	int err;
 
 	BT_DBG("got %zu bytes", msglen);
@@ -1256,6 +1227,7 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 
 	hdr = (struct mgmt_hdr *) buf;
 	opcode = get_unaligned_le16(&hdr->opcode);
+	index = get_unaligned_le16(&hdr->index);
 	len = get_unaligned_le16(&hdr->len);
 
 	if (len != msglen - sizeof(*hdr)) {
@@ -1271,65 +1243,65 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 		err = read_index_list(sk);
 		break;
 	case MGMT_OP_READ_INFO:
-		err = read_controller_info(sk, buf + sizeof(*hdr), len);
+		err = read_controller_info(sk, index);
 		break;
 	case MGMT_OP_SET_POWERED:
-		err = set_powered(sk, buf + sizeof(*hdr), len);
+		err = set_powered(sk, index, buf + sizeof(*hdr), len);
 		break;
 	case MGMT_OP_SET_DISCOVERABLE:
-		err = set_discoverable(sk, buf + sizeof(*hdr), len);
+		err = set_discoverable(sk, index, buf + sizeof(*hdr), len);
 		break;
 	case MGMT_OP_SET_CONNECTABLE:
-		err = set_connectable(sk, buf + sizeof(*hdr), len);
+		err = set_connectable(sk, index, buf + sizeof(*hdr), len);
 		break;
 	case MGMT_OP_SET_PAIRABLE:
-		err = set_pairable(sk, buf + sizeof(*hdr), len);
+		err = set_pairable(sk, index, buf + sizeof(*hdr), len);
 		break;
 	case MGMT_OP_ADD_UUID:
-		err = add_uuid(sk, buf + sizeof(*hdr), len);
+		err = add_uuid(sk, index, buf + sizeof(*hdr), len);
 		break;
 	case MGMT_OP_REMOVE_UUID:
-		err = remove_uuid(sk, buf + sizeof(*hdr), len);
+		err = remove_uuid(sk, index, buf + sizeof(*hdr), len);
 		break;
 	case MGMT_OP_SET_DEV_CLASS:
-		err = set_dev_class(sk, buf + sizeof(*hdr), len);
+		err = set_dev_class(sk, index, buf + sizeof(*hdr), len);
 		break;
 	case MGMT_OP_SET_SERVICE_CACHE:
-		err = set_service_cache(sk, buf + sizeof(*hdr), len);
+		err = set_service_cache(sk, index, buf + sizeof(*hdr), len);
 		break;
 	case MGMT_OP_LOAD_KEYS:
-		err = load_keys(sk, buf + sizeof(*hdr), len);
+		err = load_keys(sk, index, buf + sizeof(*hdr), len);
 		break;
 	case MGMT_OP_REMOVE_KEY:
-		err = remove_key(sk, buf + sizeof(*hdr), len);
+		err = remove_key(sk, index, buf + sizeof(*hdr), len);
 		break;
 	case MGMT_OP_DISCONNECT:
-		err = disconnect(sk, buf + sizeof(*hdr), len);
+		err = disconnect(sk, index, buf + sizeof(*hdr), len);
 		break;
 	case MGMT_OP_GET_CONNECTIONS:
-		err = get_connections(sk, buf + sizeof(*hdr), len);
+		err = get_connections(sk, index, buf + sizeof(*hdr), len);
 		break;
 	case MGMT_OP_PIN_CODE_REPLY:
-		err = pin_code_reply(sk, buf + sizeof(*hdr), len);
+		err = pin_code_reply(sk, index, buf + sizeof(*hdr), len);
 		break;
 	case MGMT_OP_PIN_CODE_NEG_REPLY:
-		err = pin_code_neg_reply(sk, buf + sizeof(*hdr), len);
+		err = pin_code_neg_reply(sk, index, buf + sizeof(*hdr), len);
 		break;
 	case MGMT_OP_SET_IO_CAPABILITY:
-		err = set_io_capability(sk, buf + sizeof(*hdr), len);
+		err = set_io_capability(sk, index, buf + sizeof(*hdr), len);
 		break;
 	case MGMT_OP_PAIR_DEVICE:
-		err = pair_device(sk, buf + sizeof(*hdr), len);
+		err = pair_device(sk, index, buf + sizeof(*hdr), len);
 		break;
 	case MGMT_OP_USER_CONFIRM_REPLY:
-		err = user_confirm_reply(sk, buf + sizeof(*hdr), len, 1);
+		err = user_confirm_reply(sk, index, buf + sizeof(*hdr), len, 1);
 		break;
 	case MGMT_OP_USER_CONFIRM_NEG_REPLY:
-		err = user_confirm_reply(sk, buf + sizeof(*hdr), len, 0);
+		err = user_confirm_reply(sk, index, buf + sizeof(*hdr), len, 0);
 		break;
 	default:
 		BT_DBG("Unknown op %u", opcode);
-		err = cmd_status(sk, opcode, 0x01);
+		err = cmd_status(sk, index, opcode, 0x01);
 		break;
 	}
 
@@ -1345,20 +1317,12 @@ done:
 
 int mgmt_index_added(u16 index)
 {
-	struct mgmt_ev_index_added ev;
-
-	put_unaligned_le16(index, &ev.index);
-
-	return mgmt_event(MGMT_EV_INDEX_ADDED, &ev, sizeof(ev), NULL);
+	return mgmt_event(MGMT_EV_INDEX_ADDED, index, NULL, 0, NULL);
 }
 
 int mgmt_index_removed(u16 index)
 {
-	struct mgmt_ev_index_added ev;
-
-	put_unaligned_le16(index, &ev.index);
-
-	return mgmt_event(MGMT_EV_INDEX_REMOVED, &ev, sizeof(ev), NULL);
+	return mgmt_event(MGMT_EV_INDEX_REMOVED, index, NULL, 0, NULL);
 }
 
 struct cmd_lookup {
@@ -1394,10 +1358,9 @@ int mgmt_powered(u16 index, u8 powered)
 
 	mgmt_pending_foreach(MGMT_OP_SET_POWERED, index, mode_rsp, &match);
 
-	put_unaligned_le16(index, &ev.index);
 	ev.val = powered;
 
-	ret = mgmt_event(MGMT_EV_POWERED, &ev, sizeof(ev), match.sk);
+	ret = mgmt_event(MGMT_EV_POWERED, index, &ev, sizeof(ev), match.sk);
 
 	if (match.sk)
 		sock_put(match.sk);
@@ -1414,10 +1377,10 @@ int mgmt_discoverable(u16 index, u8 discoverable)
 	mgmt_pending_foreach(MGMT_OP_SET_DISCOVERABLE, index,
 							mode_rsp, &match);
 
-	put_unaligned_le16(index, &ev.index);
 	ev.val = discoverable;
 
-	ret = mgmt_event(MGMT_EV_DISCOVERABLE, &ev, sizeof(ev), match.sk);
+	ret = mgmt_event(MGMT_EV_DISCOVERABLE, index, &ev, sizeof(ev),
+								match.sk);
 
 	if (match.sk)
 		sock_put(match.sk);
@@ -1433,10 +1396,9 @@ int mgmt_connectable(u16 index, u8 connectable)
 
 	mgmt_pending_foreach(MGMT_OP_SET_CONNECTABLE, index, mode_rsp, &match);
 
-	put_unaligned_le16(index, &ev.index);
 	ev.val = connectable;
 
-	ret = mgmt_event(MGMT_EV_CONNECTABLE, &ev, sizeof(ev), match.sk);
+	ret = mgmt_event(MGMT_EV_CONNECTABLE, index, &ev, sizeof(ev), match.sk);
 
 	if (match.sk)
 		sock_put(match.sk);
@@ -1450,25 +1412,22 @@ int mgmt_new_key(u16 index, struct link_key *key, u8 old_key_type)
 
 	memset(&ev, 0, sizeof(ev));
 
-	put_unaligned_le16(index, &ev.index);
-
 	bacpy(&ev.key.bdaddr, &key->bdaddr);
 	ev.key.type = key->type;
 	memcpy(ev.key.val, key->val, 16);
 	ev.key.pin_len = key->pin_len;
 	ev.old_key_type = old_key_type;
 
-	return mgmt_event(MGMT_EV_NEW_KEY, &ev, sizeof(ev), NULL);
+	return mgmt_event(MGMT_EV_NEW_KEY, index, &ev, sizeof(ev), NULL);
 }
 
 int mgmt_connected(u16 index, bdaddr_t *bdaddr)
 {
 	struct mgmt_ev_connected ev;
 
-	put_unaligned_le16(index, &ev.index);
 	bacpy(&ev.bdaddr, bdaddr);
 
-	return mgmt_event(MGMT_EV_CONNECTED, &ev, sizeof(ev), NULL);
+	return mgmt_event(MGMT_EV_CONNECTED, index, &ev, sizeof(ev), NULL);
 }
 
 static void disconnect_rsp(struct pending_cmd *cmd, void *data)
@@ -1477,10 +1436,9 @@ static void disconnect_rsp(struct pending_cmd *cmd, void *data)
 	struct sock **sk = data;
 	struct mgmt_rp_disconnect rp;
 
-	put_unaligned_le16(cmd->index, &rp.index);
 	bacpy(&rp.bdaddr, &cp->bdaddr);
 
-	cmd_complete(cmd->sk, MGMT_OP_DISCONNECT, &rp, sizeof(rp));
+	cmd_complete(cmd->sk, cmd->index, MGMT_OP_DISCONNECT, &rp, sizeof(rp));
 
 	*sk = cmd->sk;
 	sock_hold(*sk);
@@ -1496,10 +1454,9 @@ int mgmt_disconnected(u16 index, bdaddr_t *bdaddr)
 
 	mgmt_pending_foreach(MGMT_OP_DISCONNECT, index, disconnect_rsp, &sk);
 
-	put_unaligned_le16(index, &ev.index);
 	bacpy(&ev.bdaddr, bdaddr);
 
-	err = mgmt_event(MGMT_EV_DISCONNECTED, &ev, sizeof(ev), sk);
+	err = mgmt_event(MGMT_EV_DISCONNECTED, index, &ev, sizeof(ev), sk);
 
 	if (sk)
 		sock_put(sk);
@@ -1516,7 +1473,7 @@ int mgmt_disconnect_failed(u16 index)
 	if (!cmd)
 		return -ENOENT;
 
-	err = cmd_status(cmd->sk, MGMT_OP_DISCONNECT, EIO);
+	err = cmd_status(cmd->sk, index, MGMT_OP_DISCONNECT, EIO);
 
 	mgmt_pending_remove(cmd);
 
@@ -1527,21 +1484,20 @@ int mgmt_connect_failed(u16 index, bdaddr_t *bdaddr, u8 status)
 {
 	struct mgmt_ev_connect_failed ev;
 
-	put_unaligned_le16(index, &ev.index);
 	bacpy(&ev.bdaddr, bdaddr);
 	ev.status = status;
 
-	return mgmt_event(MGMT_EV_CONNECT_FAILED, &ev, sizeof(ev), NULL);
+	return mgmt_event(MGMT_EV_CONNECT_FAILED, index, &ev, sizeof(ev), NULL);
 }
 
 int mgmt_pin_code_request(u16 index, bdaddr_t *bdaddr)
 {
 	struct mgmt_ev_pin_code_request ev;
 
-	put_unaligned_le16(index, &ev.index);
 	bacpy(&ev.bdaddr, bdaddr);
 
-	return mgmt_event(MGMT_EV_PIN_CODE_REQUEST, &ev, sizeof(ev), NULL);
+	return mgmt_event(MGMT_EV_PIN_CODE_REQUEST, index, &ev, sizeof(ev),
+									NULL);
 }
 
 int mgmt_pin_code_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status)
@@ -1554,11 +1510,11 @@ int mgmt_pin_code_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status)
 	if (!cmd)
 		return -ENOENT;
 
-	put_unaligned_le16(index, &rp.index);
 	bacpy(&rp.bdaddr, bdaddr);
 	rp.status = status;
 
-	err = cmd_complete(cmd->sk, MGMT_OP_PIN_CODE_REPLY, &rp, sizeof(rp));
+	err = cmd_complete(cmd->sk, index, MGMT_OP_PIN_CODE_REPLY, &rp,
+								sizeof(rp));
 
 	mgmt_pending_remove(cmd);
 
@@ -1575,12 +1531,11 @@ int mgmt_pin_code_neg_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status)
 	if (!cmd)
 		return -ENOENT;
 
-	put_unaligned_le16(index, &rp.index);
 	bacpy(&rp.bdaddr, bdaddr);
 	rp.status = status;
 
-	err = cmd_complete(cmd->sk, MGMT_OP_PIN_CODE_NEG_REPLY,
-							&rp, sizeof(rp));
+	err = cmd_complete(cmd->sk, index, MGMT_OP_PIN_CODE_NEG_REPLY, &rp,
+								sizeof(rp));
 
 	mgmt_pending_remove(cmd);
 
@@ -1593,11 +1548,11 @@ int mgmt_user_confirm_request(u16 index, bdaddr_t *bdaddr, __le32 value)
 
 	BT_DBG("hci%u", index);
 
-	put_unaligned_le16(index, &ev.index);
 	bacpy(&ev.bdaddr, bdaddr);
 	put_unaligned_le32(value, &ev.value);
 
-	return mgmt_event(MGMT_EV_USER_CONFIRM_REQUEST, &ev, sizeof(ev), NULL);
+	return mgmt_event(MGMT_EV_USER_CONFIRM_REQUEST, index, &ev, sizeof(ev),
+									NULL);
 }
 
 static int confirm_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status,
@@ -1611,10 +1566,9 @@ static int confirm_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status,
 	if (!cmd)
 		return -ENOENT;
 
-	put_unaligned_le16(index, &rp.index);
 	bacpy(&rp.bdaddr, bdaddr);
 	rp.status = status;
-	err = cmd_complete(cmd->sk, opcode, &rp, sizeof(rp));
+	err = cmd_complete(cmd->sk, index, opcode, &rp, sizeof(rp));
 
 	mgmt_pending_remove(cmd);
 
@@ -1638,9 +1592,8 @@ int mgmt_auth_failed(u16 index, bdaddr_t *bdaddr, u8 status)
 {
 	struct mgmt_ev_auth_failed ev;
 
-	put_unaligned_le16(index, &ev.index);
 	bacpy(&ev.bdaddr, bdaddr);
 	ev.status = status;
 
-	return mgmt_event(MGMT_EV_AUTH_FAILED, &ev, sizeof(ev), NULL);
+	return mgmt_event(MGMT_EV_AUTH_FAILED, index, &ev, sizeof(ev), NULL);
 }
-- 
1.7.0.4
on behalf of ST-Ericsson
