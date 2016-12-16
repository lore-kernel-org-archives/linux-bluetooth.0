Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: L2CAP: Rework code around Connect Response
Date: Fri, 16 Dec 2016 14:19:29 +0200
Message-Id: <20161216121929.26476-4-luiz.dentz@gmail.com>
In-Reply-To: <20161216121929.26476-1-luiz.dentz@gmail.com>
References: <20161216121929.26476-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempt to reuse the code dealing with L2CAP connect response
which were spread all over.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 270 +++++++++++++++++----------------------------
 1 file changed, 100 insertions(+), 170 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 99783d7..91ed4a0 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1405,6 +1405,74 @@ static void l2cap_send_disconn_req(struct l2cap_chan *chan, int err)
 	l2cap_state_change_and_error(chan, BT_DISCONN, err);
 }
 
+static void l2cap_send_connect_rsp(struct l2cap_conn *conn, u8 ident, u8 cmd,
+				   u16 scid, u16 dcid, u16 result, u16 status)
+{
+	struct l2cap_conn_rsp rsp;
+
+	rsp.scid   = cpu_to_le16(scid);
+	rsp.dcid   = cpu_to_le16(dcid);
+	rsp.result = cpu_to_le16(result);
+	rsp.status = cpu_to_le16(status);
+	l2cap_send_cmd(conn, ident, cmd, sizeof(rsp), &rsp);
+}
+
+static void __l2cap_connect_rsp(struct l2cap_chan *chan, u16 result, u16 status)
+{
+	struct l2cap_conn *conn = chan->conn;
+	u8 buf[128];
+	u8 rsp_code;
+
+	if (chan->hs_hcon)
+		rsp_code = L2CAP_CREATE_CHAN_RSP;
+	else
+		rsp_code = L2CAP_CONN_RSP;
+
+	BT_DBG("chan %p rsp_code %u", chan, rsp_code);
+
+	l2cap_send_connect_rsp(conn, chan->ident, rsp_code, chan->dcid,
+			       chan->scid, result, status);
+
+	if (test_and_set_bit(CONF_REQ_SENT, &chan->conf_state))
+		return;
+
+	l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
+		       l2cap_build_conf_req(chan, buf), buf);
+	chan->num_conf_req++;
+}
+
+static void __l2cap_connect_chan(struct l2cap_chan *chan)
+{
+	u16 result, status;
+
+	BT_DBG("chan %p", chan);
+
+	result = L2CAP_CR_SUCCESS;
+	status = L2CAP_CS_NO_INFO;
+
+	if (l2cap_chan_check_security(chan, false)) {
+		if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
+			result = L2CAP_CR_PEND;
+			status = L2CAP_CS_AUTHOR_PEND;
+			chan->ops->defer(chan);
+		} else {
+			/* Force pending result for AMP controllers.
+			 * The connection will succeed after the
+			 * physical link is up.
+			 */
+			if (chan->local_amp_id != AMP_ID_BREDR)
+				result = L2CAP_CR_PEND;
+			else
+				l2cap_state_change(chan, BT_CONFIG);
+		}
+	} else {
+		result = L2CAP_CR_PEND;
+		status = L2CAP_CS_AUTHEN_PEND;
+	}
+
+	__l2cap_connect_rsp(chan, result, status);
+}
+
 /* ---- L2CAP connections ---- */
 static void l2cap_conn_start(struct l2cap_conn *conn)
 {
@@ -1441,40 +1509,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 			l2cap_start_connection(chan);
 
 		} else if (chan->state == BT_CONNECT2) {
-			struct l2cap_conn_rsp rsp;
-			char buf[128];
-			rsp.scid = cpu_to_le16(chan->dcid);
-			rsp.dcid = cpu_to_le16(chan->scid);
-
-			if (l2cap_chan_check_security(chan, false)) {
-				if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
-					rsp.result = cpu_to_le16(L2CAP_CR_PEND);
-					rsp.status = cpu_to_le16(L2CAP_CS_AUTHOR_PEND);
-					chan->ops->defer(chan);
-
-				} else {
-					l2cap_state_change(chan, BT_CONFIG);
-					rsp.result = cpu_to_le16(L2CAP_CR_SUCCESS);
-					rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);
-				}
-			} else {
-				rsp.result = cpu_to_le16(L2CAP_CR_PEND);
-				rsp.status = cpu_to_le16(L2CAP_CS_AUTHEN_PEND);
-			}
-
-			l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_RSP,
-				       sizeof(rsp), &rsp);
-
-			if (test_bit(CONF_REQ_SENT, &chan->conf_state) ||
-			    rsp.result != L2CAP_CR_SUCCESS) {
-				l2cap_chan_unlock(chan);
-				continue;
-			}
-
-			set_bit(CONF_REQ_SENT, &chan->conf_state);
-			l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
-				       l2cap_build_conf_req(chan, buf), buf);
-			chan->num_conf_req++;
+			__l2cap_connect_chan(chan);
 		}
 
 		l2cap_chan_unlock(chan);
@@ -3659,31 +3694,7 @@ void __l2cap_le_connect_rsp_defer(struct l2cap_chan *chan)
 
 void __l2cap_connect_rsp_defer(struct l2cap_chan *chan)
 {
-	struct l2cap_conn_rsp rsp;
-	struct l2cap_conn *conn = chan->conn;
-	u8 buf[128];
-	u8 rsp_code;
-
-	rsp.scid   = cpu_to_le16(chan->dcid);
-	rsp.dcid   = cpu_to_le16(chan->scid);
-	rsp.result = cpu_to_le16(L2CAP_CR_SUCCESS);
-	rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);
-
-	if (chan->hs_hcon)
-		rsp_code = L2CAP_CREATE_CHAN_RSP;
-	else
-		rsp_code = L2CAP_CONN_RSP;
-
-	BT_DBG("chan %p rsp_code %u", chan, rsp_code);
-
-	l2cap_send_cmd(conn, chan->ident, rsp_code, sizeof(rsp), &rsp);
-
-	if (test_and_set_bit(CONF_REQ_SENT, &chan->conf_state))
-		return;
-
-	l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
-		       l2cap_build_conf_req(chan, buf), buf);
-	chan->num_conf_req++;
+	__l2cap_connect_rsp(chan, L2CAP_CR_SUCCESS, L2CAP_CS_NO_INFO);
 }
 
 static void l2cap_conf_rfc_get(struct l2cap_chan *chan, void *rsp, int len)
@@ -3767,9 +3778,7 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 					u8 *data, u8 rsp_code, u8 amp_id)
 {
 	struct l2cap_conn_req *req = (struct l2cap_conn_req *) data;
-	struct l2cap_conn_rsp rsp;
 	struct l2cap_chan *chan = NULL, *pchan;
-	int result, status = L2CAP_CS_NO_INFO;
 
 	u16 dcid = 0, scid = __le16_to_cpu(req->scid);
 	__le16 psm = req->psm;
@@ -3780,8 +3789,9 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 	pchan = l2cap_global_chan_by_psm(BT_LISTEN, psm, &conn->hcon->src,
 					 &conn->hcon->dst, ACL_LINK);
 	if (!pchan) {
-		result = L2CAP_CR_BAD_PSM;
-		goto sendresp;
+		l2cap_send_connect_rsp(conn, cmd->ident, rsp_code, scid, dcid,
+				       L2CAP_CR_BAD_PSM, L2CAP_CS_NO_INFO);
+		return NULL;
 	}
 
 	mutex_lock(&conn->chan_lock);
@@ -3791,19 +3801,24 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 	if (psm != cpu_to_le16(L2CAP_PSM_SDP) &&
 	    !hci_conn_check_link_mode(conn->hcon)) {
 		conn->disc_reason = HCI_ERROR_AUTH_FAILURE;
-		result = L2CAP_CR_SEC_BLOCK;
-		goto response;
+		l2cap_send_connect_rsp(conn, cmd->ident, rsp_code, scid, dcid,
+				       L2CAP_CR_SEC_BLOCK, L2CAP_CS_NO_INFO);
+		goto unlock;
 	}
 
-	result = L2CAP_CR_NO_MEM;
-
 	/* Check if we already have channel with that dcid */
-	if (__l2cap_get_chan_by_dcid(conn, scid))
-		goto response;
+	if (__l2cap_get_chan_by_dcid(conn, scid)) {
+		l2cap_send_connect_rsp(conn, cmd->ident, rsp_code, scid, dcid,
+				       L2CAP_CR_NO_MEM, L2CAP_CS_NO_INFO);
+		goto unlock;
+	}
 
 	chan = pchan->ops->new_connection(pchan);
-	if (!chan)
-		goto response;
+	if (!chan) {
+		l2cap_send_connect_rsp(conn, cmd->ident, rsp_code, scid, dcid,
+				       L2CAP_CR_NO_MEM, L2CAP_CS_NO_INFO);
+		goto unlock;
+	}
 
 	/* For certain devices (ex: HID mouse), support for authentication,
 	 * pairing and bonding is optional. For such devices, inorder to avoid
@@ -3828,6 +3843,8 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 
 	chan->ident = cmd->ident;
 
+	l2cap_state_change(chan, BT_CONNECT2);
+
 	hci_dev_lock(conn->hcon->hdev);
 	if (hci_dev_test_flag(conn->hcon->hdev, HCI_MGMT) &&
 	    !test_bit(HCI_CONN_MGMT_CONNECTED, &conn->hcon->flags)) {
@@ -3835,70 +3852,26 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 		 * connection.
 		 */
 		set_bit(FLAG_PENDING_CONNECT_RSP, &chan->flags);
-		l2cap_state_change(chan, BT_CONNECT2);
-		result = L2CAP_CR_PEND;
-		status = L2CAP_CS_NO_INFO;
+		l2cap_send_connect_rsp(conn, cmd->ident, rsp_code, scid, dcid,
+				       L2CAP_CR_PEND, L2CAP_CS_NO_INFO);
 		hci_dev_unlock(conn->hcon->hdev);
-		goto response;
+		goto unlock;
 	}
 	hci_dev_unlock(conn->hcon->hdev);
 
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE) {
-		if (l2cap_chan_check_security(chan, false)) {
-			if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
-				l2cap_state_change(chan, BT_CONNECT2);
-				result = L2CAP_CR_PEND;
-				status = L2CAP_CS_AUTHOR_PEND;
-				chan->ops->defer(chan);
-			} else {
-				/* Force pending result for AMP controllers.
-				 * The connection will succeed after the
-				 * physical link is up.
-				 */
-				if (amp_id == AMP_ID_BREDR) {
-					l2cap_state_change(chan, BT_CONFIG);
-					result = L2CAP_CR_SUCCESS;
-				} else {
-					l2cap_state_change(chan, BT_CONNECT2);
-					result = L2CAP_CR_PEND;
-				}
-				status = L2CAP_CS_NO_INFO;
-			}
-		} else {
-			l2cap_state_change(chan, BT_CONNECT2);
-			result = L2CAP_CR_PEND;
-			status = L2CAP_CS_AUTHEN_PEND;
-		}
+		__l2cap_connect_chan(chan);
 	} else {
-		l2cap_state_change(chan, BT_CONNECT2);
-		result = L2CAP_CR_PEND;
-		status = L2CAP_CS_NO_INFO;
+		l2cap_send_connect_rsp(conn, cmd->ident, rsp_code, scid, dcid,
+				       L2CAP_CR_PEND, L2CAP_CS_NO_INFO);
+		l2cap_request_info(conn);
 	}
 
-response:
+unlock:
 	l2cap_chan_unlock(pchan);
 	mutex_unlock(&conn->chan_lock);
 	l2cap_chan_put(pchan);
 
-sendresp:
-	rsp.scid   = cpu_to_le16(scid);
-	rsp.dcid   = cpu_to_le16(dcid);
-	rsp.result = cpu_to_le16(result);
-	rsp.status = cpu_to_le16(status);
-	l2cap_send_cmd(conn, cmd->ident, rsp_code, sizeof(rsp), &rsp);
-
-	if (result == L2CAP_CR_PEND && status == L2CAP_CS_NO_INFO)
-		l2cap_request_info(conn);
-
-	if (chan && !test_bit(CONF_REQ_SENT, &chan->conf_state) &&
-	    result == L2CAP_CR_SUCCESS) {
-		u8 buf[128];
-		set_bit(CONF_REQ_SENT, &chan->conf_state);
-		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
-			       l2cap_build_conf_req(chan, buf), buf);
-		chan->num_conf_req++;
-	}
-
 	return chan;
 }
 
@@ -7288,8 +7261,6 @@ static void l2cap_connect2_ready(struct hci_conn *hcon)
 	mutex_lock(&conn->chan_lock);
 
 	list_for_each_entry(chan, &conn->chan_l, list) {
-		struct l2cap_conn_rsp rsp;
-
 		l2cap_chan_lock(chan);
 
 		BT_DBG("chan %p scid 0x%4.4x state %s", chan, chan->scid,
@@ -7299,44 +7270,7 @@ static void l2cap_connect2_ready(struct hci_conn *hcon)
 		    !test_and_clear_bit(FLAG_PENDING_CONNECT_RSP, &chan->flags))
 			goto next;
 
-		rsp.result = cpu_to_le16(L2CAP_CR_SUCCESS);
-		rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);
-
-		if (l2cap_chan_check_security(chan, false)) {
-			if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
-				rsp.result = cpu_to_le16(L2CAP_CR_PEND);
-				rsp.status = cpu_to_le16(L2CAP_CS_AUTHOR_PEND);
-				chan->ops->defer(chan);
-			} else {
-				/* Force pending result for AMP controllers.
-				 * The connection will succeed after the
-				 * physical link is up.
-				 */
-				if (chan->local_amp_id != AMP_ID_BREDR)
-					rsp.result = cpu_to_le16(L2CAP_CR_PEND);
-				else
-					l2cap_state_change(chan, BT_CONFIG);
-			}
-		} else {
-			rsp.result = cpu_to_le16(L2CAP_CR_PEND);
-			rsp.status = cpu_to_le16(L2CAP_CS_AUTHEN_PEND);
-		}
-
-		rsp.scid = cpu_to_le16(chan->dcid);
-		rsp.dcid = cpu_to_le16(chan->scid);
-		l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_RSP,
-			       sizeof(rsp), &rsp);
-
-		if (!test_bit(CONF_REQ_SENT, &chan->conf_state) &&
-		    chan->state == BT_CONFIG) {
-			u8 buf[128];
-			set_bit(CONF_REQ_SENT, &chan->conf_state);
-			l2cap_send_cmd(conn, l2cap_get_ident(conn),
-				       L2CAP_CONF_REQ,
-				       l2cap_build_conf_req(chan, buf),
-				       buf);
-			chan->num_conf_req++;
-		}
+		__l2cap_connect_chan(chan);
 
 next:
 		l2cap_chan_unlock(chan);
@@ -7490,7 +7424,6 @@ static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 				__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
 		} else if (chan->state == BT_CONNECT2 &&
 			   chan->mode != L2CAP_MODE_LE_FLOWCTL) {
-			struct l2cap_conn_rsp rsp;
 			__u16 res, stat;
 
 			if (!status) {
@@ -7510,12 +7443,9 @@ static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 				stat = L2CAP_CS_NO_INFO;
 			}
 
-			rsp.scid   = cpu_to_le16(chan->dcid);
-			rsp.dcid   = cpu_to_le16(chan->scid);
-			rsp.result = cpu_to_le16(res);
-			rsp.status = cpu_to_le16(stat);
-			l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_RSP,
-				       sizeof(rsp), &rsp);
+			l2cap_send_connect_rsp(conn, chan->ident,
+					       L2CAP_CONN_RSP, chan->scid,
+					       chan->dcid, res, stat);
 
 			if (!test_bit(CONF_REQ_SENT, &chan->conf_state) &&
 			    res == L2CAP_CR_SUCCESS) {
-- 
2.9.3

