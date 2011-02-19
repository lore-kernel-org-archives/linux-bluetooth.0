Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/8] Bluetooth: Add mgmt_pair_device command
Date: Sat, 19 Feb 2011 12:05:56 -0300
Message-Id: <1298127962-18576-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1298127962-18576-1-git-send-email-johan.hedberg@gmail.com>
References: <1298127962-18576-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

This patch adds a new mgmt_pair_device which can be used to initiate a
dedicated bonding procedure. Some extra callbacks are added to the
hci_conn struct so that the pairing code can get notified of the
completion of the procedure.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 include/net/bluetooth/hci_core.h |   16 +++++
 include/net/bluetooth/mgmt.h     |   12 ++++
 net/bluetooth/mgmt.c             |  133 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 161 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d5d8454..506f250 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -248,6 +248,10 @@ struct hci_conn {
 	void		*priv;
 
 	struct hci_conn	*link;
+
+	void (*connect_cfm_cb)	(struct hci_conn *conn, u8 status);
+	void (*security_cfm_cb)	(struct hci_conn *conn, u8 status);
+	void (*disconn_cfm_cb)	(struct hci_conn *conn, u8 reason);
 };
 
 extern struct hci_proto *hci_proto[];
@@ -571,6 +575,9 @@ static inline void hci_proto_connect_cfm(struct hci_conn *conn, __u8 status)
 	hp = hci_proto[HCI_PROTO_SCO];
 	if (hp && hp->connect_cfm)
 		hp->connect_cfm(conn, status);
+
+	if (conn->connect_cfm_cb)
+		conn->connect_cfm_cb(conn, status);
 }
 
 static inline int hci_proto_disconn_ind(struct hci_conn *conn)
@@ -600,6 +607,9 @@ static inline void hci_proto_disconn_cfm(struct hci_conn *conn, __u8 reason)
 	hp = hci_proto[HCI_PROTO_SCO];
 	if (hp && hp->disconn_cfm)
 		hp->disconn_cfm(conn, reason);
+
+	if (conn->disconn_cfm_cb)
+		conn->disconn_cfm_cb(conn, reason);
 }
 
 static inline void hci_proto_auth_cfm(struct hci_conn *conn, __u8 status)
@@ -619,6 +629,9 @@ static inline void hci_proto_auth_cfm(struct hci_conn *conn, __u8 status)
 	hp = hci_proto[HCI_PROTO_SCO];
 	if (hp && hp->security_cfm)
 		hp->security_cfm(conn, status, encrypt);
+
+	if (conn->security_cfm_cb)
+		conn->security_cfm_cb(conn, status);
 }
 
 static inline void hci_proto_encrypt_cfm(struct hci_conn *conn, __u8 status, __u8 encrypt)
@@ -632,6 +645,9 @@ static inline void hci_proto_encrypt_cfm(struct hci_conn *conn, __u8 status, __u
 	hp = hci_proto[HCI_PROTO_SCO];
 	if (hp && hp->security_cfm)
 		hp->security_cfm(conn, status, encrypt);
+
+	if (conn->security_cfm_cb)
+		conn->security_cfm_cb(conn, status);
 }
 
 int hci_register_proto(struct hci_proto *hproto);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 44ac55c..1d25c59 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -160,6 +160,18 @@ struct mgmt_cp_set_io_capability {
 	__u8 io_capability;
 } __packed;
 
+#define MGMT_OP_PAIR_DEVICE		0x0014
+struct mgmt_cp_pair_device {
+	__le16 index;
+	bdaddr_t bdaddr;
+	__u8 io_cap;
+} __packed;
+struct mgmt_rp_pair_device {
+	__le16 index;
+	bdaddr_t bdaddr;
+	__u8 status;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16 opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 52e5f88..d7fc54d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -38,6 +38,7 @@ struct pending_cmd {
 	int index;
 	void *cmd;
 	struct sock *sk;
+	void *user_data;
 };
 
 LIST_HEAD(cmd_list);
@@ -1063,6 +1064,135 @@ static int set_io_capability(struct sock *sk, unsigned char *data, u16 len)
 						&dev_id, sizeof(dev_id));
 }
 
+static inline struct pending_cmd *find_pairing(struct hci_conn *conn)
+{
+	struct hci_dev *hdev = conn->hdev;
+	struct list_head *p;
+
+	list_for_each(p, &cmd_list) {
+		struct pending_cmd *cmd;
+
+		cmd = list_entry(p, struct pending_cmd, list);
+
+		if (cmd->opcode != MGMT_OP_PAIR_DEVICE)
+			continue;
+
+		if (cmd->index != hdev->id)
+			continue;
+
+		if (cmd->user_data != conn)
+			continue;
+
+		return cmd;
+	}
+
+	return NULL;
+}
+
+static void pairing_complete(struct pending_cmd *cmd, u8 status)
+{
+	struct mgmt_rp_pair_device rp;
+	struct hci_conn *conn = cmd->user_data;
+
+	rp.index = cmd->index;
+	bacpy(&rp.bdaddr, &conn->dst);
+	rp.status = status;
+
+	cmd_complete(cmd->sk, MGMT_OP_PAIR_DEVICE, &rp, sizeof(rp));
+
+	/* So we don't get further callbacks for this connection */
+	conn->connect_cfm_cb = NULL;
+	conn->security_cfm_cb = NULL;
+	conn->disconn_cfm_cb = NULL;
+
+	hci_conn_put(conn);
+
+	list_del(&cmd->list);
+	mgmt_pending_free(cmd);
+}
+
+static void pairing_complete_cb(struct hci_conn *conn, u8 status)
+{
+	struct pending_cmd *cmd;
+
+	BT_DBG("status %u", status);
+
+	cmd = find_pairing(conn);
+	if (!cmd) {
+		BT_DBG("Unable to find a pending command");
+		return;
+	}
+
+	pairing_complete(cmd, status);
+}
+
+static int pair_device(struct sock *sk, unsigned char *data, u16 len)
+{
+	struct hci_dev *hdev;
+	struct mgmt_cp_pair_device *cp;
+	struct pending_cmd *cmd;
+	u8 sec_level, auth_type;
+	struct hci_conn *conn;
+	u16 dev_id;
+	int err;
+
+	BT_DBG("");
+
+	cp = (void *) data;
+	dev_id = get_unaligned_le16(&cp->index);
+
+	hdev = hci_dev_get(dev_id);
+	if (!hdev)
+		return cmd_status(sk, MGMT_OP_PAIR_DEVICE, ENODEV);
+
+	hci_dev_lock_bh(hdev);
+
+	if (cp->io_cap == 0x03) {
+		sec_level = BT_SECURITY_MEDIUM;
+		auth_type = HCI_AT_DEDICATED_BONDING;
+	} else {
+		sec_level = BT_SECURITY_HIGH;
+		auth_type = HCI_AT_DEDICATED_BONDING_MITM;
+	}
+
+	conn = hci_connect(hdev, ACL_LINK, &cp->bdaddr, sec_level, auth_type);
+	if (!conn) {
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	if (conn->connect_cfm_cb) {
+		hci_conn_put(conn);
+		err = cmd_status(sk, MGMT_OP_PAIR_DEVICE, EBUSY);
+		goto unlock;
+	}
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_PAIR_DEVICE, dev_id, data, len);
+	if (!cmd) {
+		err = -ENOMEM;
+		hci_conn_put(conn);
+		goto unlock;
+	}
+
+	conn->connect_cfm_cb = pairing_complete_cb;
+	conn->security_cfm_cb = pairing_complete_cb;
+	conn->disconn_cfm_cb = pairing_complete_cb;
+	conn->io_capability = cp->io_cap;
+	cmd->user_data = conn;
+
+	if (conn->state == BT_CONNECTED &&
+				hci_conn_security(conn, sec_level, auth_type))
+		pairing_complete(cmd, 0);
+
+	err = 0;
+
+unlock:
+	hci_dev_unlock_bh(hdev);
+	hci_dev_put(hdev);
+
+	return err;
+}
+
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 {
 	unsigned char *buf;
@@ -1148,6 +1278,9 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	case MGMT_OP_SET_IO_CAPABILITY:
 		err = set_io_capability(sk, buf + sizeof(*hdr), len);
 		break;
+	case MGMT_OP_PAIR_DEVICE:
+		err = pair_device(sk, buf + sizeof(*hdr), len);
+		break;
 	default:
 		BT_DBG("Unknown op %u", opcode);
 		err = cmd_status(sk, opcode, 0x01);
-- 
1.7.4.1

