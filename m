Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Cc: sunnyk@codeaurora.org
Subject: [RFCv1 18/20] Bluetooth: Send create channel request instead of connect for AMP
Date: Tue, 11 Sep 2012 11:21:29 -0700
Message-Id: <1347387691-5285-19-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1347387691-5285-1-git-send-email-mathewm@codeaurora.org>
References: <1347387691-5285-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the channel policy is set to prefer AMP, then an L2CAP channel is
set up using the "create channel" command rather than the "connect"
command.  A physical link is also set up before sending "create
channel".

Behavior is unchanged if enable_hs is false.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c | 84 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 78 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 3fd2eac..bde1303 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -56,7 +56,10 @@ static void l2cap_send_disconn_req(struct l2cap_conn *conn,
 				   struct l2cap_chan *chan, int err);
 
 static void l2cap_tx(struct l2cap_chan *chan, struct l2cap_ctrl *control,
-		    struct sk_buff_head *skbs, u8 event);
+		     struct sk_buff_head *skbs, u8 event);
+
+static void l2cap_logical_cfm(struct l2cap_chan *chan, struct hci_chan *hchan,
+			      u8 status);
 
 /* ---- L2CAP channels ---- */
 
@@ -554,6 +557,13 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 			hci_conn_put(conn->hcon);
 	}
 
+	if (chan->hs_hchan) {
+		chan->hs_hchan = NULL;
+		chan->hs_hcon = NULL;
+
+		/* Placeholder - free logical link */
+	}
+
 	if (chan->ops->teardown)
 		chan->ops->teardown(chan, err);
 
@@ -1100,8 +1110,19 @@ static void l2cap_do_start(struct l2cap_chan *chan)
 			return;
 
 		if (l2cap_chan_check_security(chan) &&
-				__l2cap_no_conn_pending(chan))
-			l2cap_send_conn_req(chan);
+		    __l2cap_no_conn_pending(chan)) {
+			if (enable_hs &&
+			    (conn->fixed_chan_mask & L2CAP_FC_A2MP) &&
+			    chan->chan_policy == BT_CHANNEL_POLICY_AMP_PREFERRED) {
+				set_bit(CONF_CONNECT_PEND, &chan->conf_state);
+
+				/* Placeholder
+				amp_create_phylink();
+				*/
+			} else {
+				l2cap_send_conn_req(chan);
+			}
+		}
 	} else {
 		struct l2cap_info_req req;
 		req.type = __constant_cpu_to_le16(L2CAP_IT_FEAT_MASK);
@@ -1196,8 +1217,17 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 				continue;
 			}
 
-			l2cap_send_conn_req(chan);
+			if (enable_hs &&
+			    (conn->fixed_chan_mask & L2CAP_FC_A2MP) &&
+			    chan->chan_policy == BT_CHANNEL_POLICY_AMP_PREFERRED) {
+				set_bit(CONF_CONNECT_PEND, &chan->conf_state);
 
+				/* Placeholder
+				amp_create_phylink();
+				*/
+			} else {
+				l2cap_send_conn_req(chan);
+			}
 		} else if (chan->state == BT_CONNECT2) {
 			struct l2cap_conn_rsp rsp;
 			char buf[128];
@@ -1225,8 +1255,18 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 				rsp.status = __constant_cpu_to_le16(L2CAP_CS_AUTHEN_PEND);
 			}
 
+			if (rsp.result == __constant_cpu_to_le16(L2CAP_CR_SUCCESS) &&
+			    chan->local_amp_id) {
+				/* Placeholder - uncomment when amp functions
+				 * are available
+				amp_accept_physical(chan, chan->local_amp_id);
+				 */
+				l2cap_chan_unlock(chan);
+				continue;
+			}
+
 			l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_RSP,
-							sizeof(rsp), &rsp);
+				       sizeof(rsp), &rsp);
 
 			if (test_bit(CONF_REQ_SENT, &chan->conf_state) ||
 					rsp.result != L2CAP_CR_SUCCESS) {
@@ -3308,6 +3348,18 @@ done:
 			rfc.mode = chan->mode;
 		}
 
+		if (test_bit(CONF_LOC_CONF_PEND, &chan->conf_state) &&
+		    chan->local_amp_id) {
+			struct hci_chan *hchan = NULL;
+
+			/* Placeholder - get hci_chan for logical link */
+
+			if (hchan && hchan->state == BT_CONNECTED) {
+				l2cap_logical_cfm(chan, hchan,
+						  L2CAP_MR_SUCCESS);
+			}
+		}
+
 		if (result == L2CAP_CONF_SUCCESS)
 			set_bit(CONF_OUTPUT_DONE, &chan->conf_state);
 	}
@@ -6282,7 +6334,18 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 
 		if (chan->state == BT_CONNECT) {
 			if (!status) {
-				l2cap_send_conn_req(chan);
+				if (enable_hs &&
+				    (conn->fixed_chan_mask & L2CAP_FC_A2MP) &&
+				    chan->chan_policy == BT_CHANNEL_POLICY_AMP_PREFERRED) {
+					set_bit(CONF_CONNECT_PEND,
+						&chan->conf_state);
+
+					/* Placeholder
+					amp_create_phylink();
+					*/
+				} else {
+					l2cap_send_conn_req(chan);
+				}
 			} else {
 				__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
 			}
@@ -6302,6 +6365,15 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 					if (parent)
 						parent->sk_data_ready(parent, 0);
 				} else {
+					if (chan->local_amp_id) {
+						/* Placeholder - accept physical
+						 * link
+						amp_accept_physical(chan,
+							chan->local_amp_id);
+						*/
+						continue;
+					}
+
 					__l2cap_state_change(chan, BT_CONFIG);
 					res = L2CAP_CR_SUCCESS;
 					stat = L2CAP_CS_NO_INFO;
-- 
1.7.12

--
Mat Martineau

The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
