Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	gustavo@padovan.org
Cc: sunnyk@codeaurora.org,
	marcel@holtmann.org
Subject: [PATCH 12/19] Bluetooth: Handle physical link completion
Date: Mon, 15 Oct 2012 08:34:01 -0700
Message-Id: <1350315248-7690-13-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1350315248-7690-1-git-send-email-mathewm@codeaurora.org>
References: <1350315248-7690-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Several different actions may be taken when an AMP physical link
becomes available.  A channel being created on an AMP controller must
continue the connection process.  A channel being moved needs to
either send a move request or a move response.  A failed physical link
will revert to using a BR/EDR controller if possible.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c | 166 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 166 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ac9d34a..592699f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -995,6 +995,19 @@ void l2cap_send_conn_req(struct l2cap_chan *chan)
 	l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_REQ, sizeof(req), &req);
 }
 
+static void l2cap_send_create_chan_req(struct l2cap_chan *chan, u8 amp_id)
+{
+	struct l2cap_create_chan_req req;
+	req.scid = cpu_to_le16(chan->scid);
+	req.psm  = chan->psm;
+	req.amp_id = amp_id;
+
+	chan->ident = l2cap_get_ident(chan->conn);
+
+	l2cap_send_cmd(chan->conn, chan->ident, L2CAP_CREATE_CHAN_REQ,
+		       sizeof(req), &req);
+}
+
 static void l2cap_move_setup(struct l2cap_chan *chan)
 {
 	struct sk_buff *skb;
@@ -4179,6 +4192,23 @@ static int l2cap_create_channel_req(struct l2cap_conn *conn,
 	return 0;
 }
 
+static void l2cap_send_move_chan_req(struct l2cap_chan *chan, u8 dest_amp_id)
+{
+	struct l2cap_move_chan_req req;
+	u8 ident;
+
+	BT_DBG("chan %p, dest_amp_id %d", chan, dest_amp_id);
+
+	ident = l2cap_get_ident(chan->conn);
+	chan->ident = ident;
+
+	req.icid = cpu_to_le16(chan->scid);
+	req.dest_amp_id = dest_amp_id;
+
+	l2cap_send_cmd(chan->conn, ident, L2CAP_MOVE_CHAN_REQ, sizeof(req),
+		       &req);
+}
+
 static void l2cap_send_move_chan_rsp(struct l2cap_conn *conn, u8 ident,
 				     u16 icid, u16 result)
 {
@@ -4341,6 +4371,142 @@ static void l2cap_logical_cfm(struct l2cap_chan *chan, struct hci_chan *hchan,
 	}
 }
 
+static void l2cap_do_create(struct l2cap_chan *chan, int result,
+			    u8 local_amp_id, u8 remote_amp_id)
+{
+	if (!test_bit(CONF_CONNECT_PEND, &chan->conf_state)) {
+		struct l2cap_conn_rsp rsp;
+		char buf[128];
+		rsp.scid = cpu_to_le16(chan->dcid);
+		rsp.dcid = cpu_to_le16(chan->scid);
+
+		/* Incoming channel on AMP */
+		if (result == L2CAP_CR_SUCCESS) {
+			/* Send successful response */
+			rsp.result = cpu_to_le16(L2CAP_CR_SUCCESS);
+			rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);
+		} else {
+			/* Send negative response */
+			rsp.result = cpu_to_le16(L2CAP_CR_NO_MEM);
+			rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);
+		}
+
+		l2cap_send_cmd(chan->conn, chan->ident, L2CAP_CREATE_CHAN_RSP,
+			       sizeof(rsp), &rsp);
+
+		if (result == L2CAP_CR_SUCCESS) {
+			__l2cap_state_change(chan, BT_CONFIG);
+			set_bit(CONF_REQ_SENT, &chan->conf_state);
+			l2cap_send_cmd(chan->conn, l2cap_get_ident(chan->conn),
+				       L2CAP_CONF_REQ,
+				       l2cap_build_conf_req(chan, buf), buf);
+			chan->num_conf_req++;
+		}
+	} else {
+		/* Outgoing channel on AMP */
+		if (result == L2CAP_CR_SUCCESS) {
+			chan->local_amp_id = local_amp_id;
+			l2cap_send_create_chan_req(chan, remote_amp_id);
+		} else {
+			/* Revert to BR/EDR connect */
+			l2cap_send_conn_req(chan);
+		}
+	}
+}
+
+static void l2cap_do_move_initiate(struct l2cap_chan *chan, u8 local_amp_id,
+				   u8 remote_amp_id)
+{
+	l2cap_move_setup(chan);
+	chan->move_id = local_amp_id;
+	chan->move_state = L2CAP_MOVE_WAIT_RSP;
+
+	l2cap_send_move_chan_req(chan, remote_amp_id);
+	__set_chan_timer(chan, L2CAP_MOVE_TIMEOUT);
+}
+
+static void l2cap_do_move_respond(struct l2cap_chan *chan, int result)
+{
+	struct hci_chan *hchan = NULL;
+
+	/* Placeholder - get hci_chan for logical link */
+
+	if (hchan) {
+		if (hchan->state == BT_CONNECTED) {
+			/* Logical link is ready to go */
+			chan->hs_hcon = hchan->conn;
+			chan->hs_hcon->l2cap_data = chan->conn;
+			chan->move_state = L2CAP_MOVE_WAIT_CONFIRM;
+			l2cap_send_move_chan_rsp(chan->conn, chan->ident,
+						 chan->dcid, L2CAP_MR_SUCCESS);
+
+			l2cap_logical_cfm(chan, hchan, L2CAP_MR_SUCCESS);
+		} else {
+			/* Wait for logical link to be ready */
+			chan->move_state = L2CAP_MOVE_WAIT_LOGICAL_CFM;
+		}
+	} else {
+		/* Logical link not available */
+		l2cap_send_move_chan_rsp(chan->conn, chan->ident, chan->dcid,
+					 L2CAP_MR_NOT_ALLOWED);
+	}
+}
+
+static void l2cap_do_move_cancel(struct l2cap_chan *chan, int result)
+{
+	if (chan->move_role == L2CAP_MOVE_ROLE_RESPONDER) {
+		u8 rsp_result;
+		if (result == -EINVAL)
+			rsp_result = L2CAP_MR_BAD_ID;
+		else
+			rsp_result = L2CAP_MR_NOT_ALLOWED;
+
+		l2cap_send_move_chan_rsp(chan->conn, chan->ident, chan->dcid,
+					 rsp_result);
+	}
+
+	chan->move_role = L2CAP_MOVE_ROLE_NONE;
+	chan->move_state = L2CAP_MOVE_STABLE;
+
+	/* Restart data transmission */
+	l2cap_ertm_send(chan);
+}
+
+void l2cap_physical_cfm(struct l2cap_chan *chan, int result, u8 local_amp_id,
+			u8 remote_amp_id)
+{
+	BT_DBG("chan %p, result %d, local_amp_id %d, remote_amp_id %d",
+	       chan, result, local_amp_id, remote_amp_id);
+
+	l2cap_chan_lock(chan);
+
+	if (chan->state == BT_DISCONN || chan->state == BT_CLOSED) {
+		l2cap_chan_unlock(chan);
+		return;
+	}
+
+	if (chan->state != BT_CONNECTED) {
+		l2cap_do_create(chan, result, local_amp_id, remote_amp_id);
+	} else if (result != L2CAP_MR_SUCCESS) {
+		l2cap_do_move_cancel(chan, result);
+	} else {
+		switch (chan->move_role) {
+		case L2CAP_MOVE_ROLE_INITIATOR:
+			l2cap_do_move_initiate(chan, local_amp_id,
+					       remote_amp_id);
+			break;
+		case L2CAP_MOVE_ROLE_RESPONDER:
+			l2cap_do_move_respond(chan, result);
+			break;
+		default:
+			l2cap_do_move_cancel(chan, result);
+			break;
+		}
+	}
+
+	l2cap_chan_unlock(chan);
+}
+
 static inline int l2cap_move_channel_req(struct l2cap_conn *conn,
 					 struct l2cap_cmd_hdr *cmd,
 					 u16 cmd_len, void *data)
-- 
1.7.12.3

--
Mat Martineau

Employee of Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
