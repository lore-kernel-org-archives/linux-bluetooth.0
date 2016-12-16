Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Don't force MGMT device connected on L2CAP connection request
Date: Fri, 16 Dec 2016 14:19:28 +0200
Message-Id: <20161216121929.26476-3-luiz.dentz@gmail.com>
In-Reply-To: <20161216121929.26476-1-luiz.dentz@gmail.com>
References: <20161216121929.26476-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Forcing the device to be connected may cause the userspace to not have
any name for the device since the command to fetch can be pending, so
instead this set the socket as pending with BT_CONNECT2 state and then
wait until it becomes ready after all necessary commands completes.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h | 13 ++++++
 include/net/bluetooth/l2cap.h    |  1 +
 net/bluetooth/hci_event.c        | 16 +++++--
 net/bluetooth/l2cap_core.c       | 95 ++++++++++++++++++++++++++++++++++++----
 4 files changed, 112 insertions(+), 13 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 554671c..5b4d643 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1188,6 +1188,7 @@ struct hci_cb {
 
 	char *name;
 
+	void (*connect2_ready)	(struct hci_conn *conn);
 	void (*connect_cfm)	(struct hci_conn *conn, __u8 status);
 	void (*disconn_cfm)	(struct hci_conn *conn, __u8 status);
 	void (*security_cfm)	(struct hci_conn *conn, __u8 status,
@@ -1196,6 +1197,18 @@ struct hci_cb {
 	void (*role_switch_cfm)	(struct hci_conn *conn, __u8 status, __u8 role);
 };
 
+static inline void hci_connect2_ready(struct hci_conn *conn)
+{
+	struct hci_cb *cb;
+
+	mutex_lock(&hci_cb_list_lock);
+	list_for_each_entry(cb, &hci_cb_list, list) {
+		if (cb->connect2_ready)
+			cb->connect2_ready(conn);
+	}
+	mutex_unlock(&hci_cb_list_lock);
+}
+
 static inline void hci_connect_cfm(struct hci_conn *conn, __u8 status)
 {
 	struct hci_cb *cb;
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 5ee3c68..88f4f6c 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -722,6 +722,7 @@ enum {
 	FLAG_LE_CONN_REQ_SENT,
 	FLAG_PENDING_SECURITY,
 	FLAG_HOLD_HCI_CONN,
+	FLAG_PENDING_CONNECT_RSP,
 };
 
 /* Lock nesting levels for L2CAP channels. We need these because lockdep
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index e17aacb..d414302 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1651,8 +1651,10 @@ static void hci_check_pending_name(struct hci_dev *hdev, struct hci_conn *conn,
 	 */
 	if (conn &&
 	    (conn->state == BT_CONFIG || conn->state == BT_CONNECTED) &&
-	    !test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
+	    !test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags)) {
 		mgmt_device_connected(hdev, conn, 0, name, name_len);
+		hci_connect2_ready(conn);
+	}
 
 	if (discov->state == DISCOVERY_STOPPED)
 		return;
@@ -2745,8 +2747,10 @@ static void hci_remote_features_evt(struct hci_dev *hdev,
 		bacpy(&cp.bdaddr, &conn->dst);
 		cp.pscan_rep_mode = 0x02;
 		hci_send_cmd(hdev, HCI_OP_REMOTE_NAME_REQ, sizeof(cp), &cp);
-	} else if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
+	} else if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags)) {
 		mgmt_device_connected(hdev, conn, 0, NULL, 0);
+		hci_connect2_ready(conn);
+	}
 
 	if (!hci_outgoing_auth_needed(hdev, conn)) {
 		conn->state = BT_CONNECTED;
@@ -3718,8 +3722,10 @@ static void hci_remote_ext_features_evt(struct hci_dev *hdev,
 		bacpy(&cp.bdaddr, &conn->dst);
 		cp.pscan_rep_mode = 0x02;
 		hci_send_cmd(hdev, HCI_OP_REMOTE_NAME_REQ, sizeof(cp), &cp);
-	} else if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
+	} else if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags)) {
 		mgmt_device_connected(hdev, conn, 0, NULL, 0);
+		hci_connect2_ready(conn);
+	}
 
 	if (!hci_outgoing_auth_needed(hdev, conn)) {
 		conn->state = BT_CONNECTED;
@@ -4562,8 +4568,10 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		goto unlock;
 	}
 
-	if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
+	if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags)) {
 		mgmt_device_connected(hdev, conn, 0, NULL, 0);
+		hci_connect2_ready(conn);
+	}
 
 	conn->sec_level = BT_SECURITY_LOW;
 	conn->handle = __le16_to_cpu(ev->handle);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7718e4a..99783d7 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3828,6 +3828,21 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 
 	chan->ident = cmd->ident;
 
+	hci_dev_lock(conn->hcon->hdev);
+	if (hci_dev_test_flag(conn->hcon->hdev, HCI_MGMT) &&
+	    !test_bit(HCI_CONN_MGMT_CONNECTED, &conn->hcon->flags)) {
+		/* Wait for MGMT Device Connected event to complete the
+		 * connection.
+		 */
+		set_bit(FLAG_PENDING_CONNECT_RSP, &chan->flags);
+		l2cap_state_change(chan, BT_CONNECT2);
+		result = L2CAP_CR_PEND;
+		status = L2CAP_CS_NO_INFO;
+		hci_dev_unlock(conn->hcon->hdev);
+		goto response;
+	}
+	hci_dev_unlock(conn->hcon->hdev);
+
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE) {
 		if (l2cap_chan_check_security(chan, false)) {
 			if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
@@ -3890,18 +3905,9 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 static int l2cap_connect_req(struct l2cap_conn *conn,
 			     struct l2cap_cmd_hdr *cmd, u16 cmd_len, u8 *data)
 {
-	struct hci_dev *hdev = conn->hcon->hdev;
-	struct hci_conn *hcon = conn->hcon;
-
 	if (cmd_len < sizeof(struct l2cap_conn_req))
 		return -EPROTO;
 
-	hci_dev_lock(hdev);
-	if (hci_dev_test_flag(hdev, HCI_MGMT) &&
-	    !test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &hcon->flags))
-		mgmt_device_connected(hdev, hcon, 0, NULL, 0);
-	hci_dev_unlock(hdev);
-
 	l2cap_connect(conn, cmd, data, L2CAP_CONN_RSP, 0);
 	return 0;
 }
@@ -7269,6 +7275,76 @@ static struct l2cap_chan *l2cap_global_fixed_chan(struct l2cap_chan *c,
 	return NULL;
 }
 
+static void l2cap_connect2_ready(struct hci_conn *hcon)
+{
+	struct l2cap_conn *conn = hcon->l2cap_data;
+	struct l2cap_chan *chan;
+
+	if (!conn)
+		return;
+
+	BT_DBG("conn %p bdaddr %pMR", conn, &hcon->dst);
+
+	mutex_lock(&conn->chan_lock);
+
+	list_for_each_entry(chan, &conn->chan_l, list) {
+		struct l2cap_conn_rsp rsp;
+
+		l2cap_chan_lock(chan);
+
+		BT_DBG("chan %p scid 0x%4.4x state %s", chan, chan->scid,
+		       state_to_string(chan->state));
+
+		if (chan->state != BT_CONNECT2 ||
+		    !test_and_clear_bit(FLAG_PENDING_CONNECT_RSP, &chan->flags))
+			goto next;
+
+		rsp.result = cpu_to_le16(L2CAP_CR_SUCCESS);
+		rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);
+
+		if (l2cap_chan_check_security(chan, false)) {
+			if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
+				rsp.result = cpu_to_le16(L2CAP_CR_PEND);
+				rsp.status = cpu_to_le16(L2CAP_CS_AUTHOR_PEND);
+				chan->ops->defer(chan);
+			} else {
+				/* Force pending result for AMP controllers.
+				 * The connection will succeed after the
+				 * physical link is up.
+				 */
+				if (chan->local_amp_id != AMP_ID_BREDR)
+					rsp.result = cpu_to_le16(L2CAP_CR_PEND);
+				else
+					l2cap_state_change(chan, BT_CONFIG);
+			}
+		} else {
+			rsp.result = cpu_to_le16(L2CAP_CR_PEND);
+			rsp.status = cpu_to_le16(L2CAP_CS_AUTHEN_PEND);
+		}
+
+		rsp.scid = cpu_to_le16(chan->dcid);
+		rsp.dcid = cpu_to_le16(chan->scid);
+		l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_RSP,
+			       sizeof(rsp), &rsp);
+
+		if (!test_bit(CONF_REQ_SENT, &chan->conf_state) &&
+		    chan->state == BT_CONFIG) {
+			u8 buf[128];
+			set_bit(CONF_REQ_SENT, &chan->conf_state);
+			l2cap_send_cmd(conn, l2cap_get_ident(conn),
+				       L2CAP_CONF_REQ,
+				       l2cap_build_conf_req(chan, buf),
+				       buf);
+			chan->num_conf_req++;
+		}
+
+next:
+		l2cap_chan_unlock(chan);
+	}
+
+	mutex_unlock(&conn->chan_lock);
+}
+
 static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 {
 	struct hci_dev *hdev = hcon->hdev;
@@ -7565,6 +7641,7 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 
 static struct hci_cb l2cap_cb = {
 	.name		= "L2CAP",
+	.connect2_ready	= l2cap_connect2_ready,
 	.connect_cfm	= l2cap_connect_cfm,
 	.disconn_cfm	= l2cap_disconn_cfm,
 	.security_cfm	= l2cap_security_cfm,
-- 
2.9.3

