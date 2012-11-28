Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 2/5] Bluetooth: Refactor l2cap_send_disconn_req
Date: Wed, 28 Nov 2012 17:59:39 +0200
Message-Id: <1354118382-25571-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1354118382-25571-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1354118382-25571-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

l2cap_send_disconn_req takes 3 parameters of which conn might be
derived from chan. Make this conversion inside l2cap_send_disconn_req.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   56 ++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 30 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 39e144f..d8cffdb 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -53,8 +53,7 @@ static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn,
 static void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len,
 			   void *data);
 static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data);
-static void l2cap_send_disconn_req(struct l2cap_conn *conn,
-				   struct l2cap_chan *chan, int err);
+static void l2cap_send_disconn_req(struct l2cap_chan *chan, int err);
 
 static void l2cap_tx(struct l2cap_chan *chan, struct l2cap_ctrl *control,
 		     struct sk_buff_head *skbs, u8 event);
@@ -632,7 +631,7 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 		if (chan->chan_type == L2CAP_CHAN_CONN_ORIENTED &&
 		    conn->hcon->type == ACL_LINK) {
 			__set_chan_timer(chan, sk->sk_sndtimeo);
-			l2cap_send_disconn_req(conn, chan, reason);
+			l2cap_send_disconn_req(chan, reason);
 		} else
 			l2cap_chan_del(chan, reason);
 		break;
@@ -1181,10 +1180,10 @@ static inline int l2cap_mode_supported(__u8 mode, __u32 feat_mask)
 	}
 }
 
-static void l2cap_send_disconn_req(struct l2cap_conn *conn,
-				   struct l2cap_chan *chan, int err)
+static void l2cap_send_disconn_req(struct l2cap_chan *chan, int err)
 {
 	struct sock *sk = chan->sk;
+	struct l2cap_conn *conn = chan->conn;
 	struct l2cap_disconn_req req;
 
 	if (!conn)
@@ -1961,7 +1960,7 @@ static void l2cap_ertm_resend(struct l2cap_chan *chan)
 		if (chan->max_tx != 0 &&
 		    bt_cb(skb)->control.retries > chan->max_tx) {
 			BT_DBG("Retry limit exceeded (%d)", chan->max_tx);
-			l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
+			l2cap_send_disconn_req(chan, ECONNRESET);
 			l2cap_seq_list_clear(&chan->retrans_list);
 			break;
 		}
@@ -2667,7 +2666,7 @@ static void l2cap_tx_state_wait_f(struct l2cap_chan *chan,
 			__set_monitor_timer(chan);
 			chan->retry_count++;
 		} else {
-			l2cap_send_disconn_req(chan->conn, chan, ECONNABORTED);
+			l2cap_send_disconn_req(chan, ECONNABORTED);
 		}
 		break;
 	default:
@@ -3878,7 +3877,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
 	/* Complete config. */
 	len = l2cap_parse_conf_req(chan, rsp);
 	if (len < 0) {
-		l2cap_send_disconn_req(conn, chan, ECONNRESET);
+		l2cap_send_disconn_req(chan, ECONNRESET);
 		goto unlock;
 	}
 
@@ -3900,7 +3899,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
 			err = l2cap_ertm_init(chan);
 
 		if (err < 0)
-			l2cap_send_disconn_req(chan->conn, chan, -err);
+			l2cap_send_disconn_req(chan, -err);
 		else
 			l2cap_chan_ready(chan);
 
@@ -3968,7 +3967,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 			len = l2cap_parse_conf_rsp(chan, rsp->data, len,
 						   buf, &result);
 			if (len < 0) {
-				l2cap_send_disconn_req(conn, chan, ECONNRESET);
+				l2cap_send_disconn_req(chan, ECONNRESET);
 				goto done;
 			}
 
@@ -3989,7 +3988,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 			char req[64];
 
 			if (len > sizeof(req) - sizeof(struct l2cap_conf_req)) {
-				l2cap_send_disconn_req(conn, chan, ECONNRESET);
+				l2cap_send_disconn_req(chan, ECONNRESET);
 				goto done;
 			}
 
@@ -3998,7 +3997,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 			len = l2cap_parse_conf_rsp(chan, rsp->data, len,
 						   req, &result);
 			if (len < 0) {
-				l2cap_send_disconn_req(conn, chan, ECONNRESET);
+				l2cap_send_disconn_req(chan, ECONNRESET);
 				goto done;
 			}
 
@@ -4014,7 +4013,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 		l2cap_chan_set_err(chan, ECONNRESET);
 
 		__set_chan_timer(chan, L2CAP_DISC_REJ_TIMEOUT);
-		l2cap_send_disconn_req(conn, chan, ECONNRESET);
+		l2cap_send_disconn_req(chan, ECONNRESET);
 		goto done;
 	}
 
@@ -4031,7 +4030,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 			err = l2cap_ertm_init(chan);
 
 		if (err < 0)
-			l2cap_send_disconn_req(chan->conn, chan, -err);
+			l2cap_send_disconn_req(chan, -err);
 		else
 			l2cap_chan_ready(chan);
 	}
@@ -4393,7 +4392,7 @@ static void l2cap_logical_fail(struct l2cap_chan *chan)
 	/* Logical link setup failed */
 	if (chan->state != BT_CONNECTED) {
 		/* Create channel failure, disconnect */
-		l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
+		l2cap_send_disconn_req(chan, ECONNRESET);
 		return;
 	}
 
@@ -4436,7 +4435,7 @@ static void l2cap_logical_finish_create(struct l2cap_chan *chan,
 
 		err = l2cap_ertm_init(chan);
 		if (err < 0)
-			l2cap_send_disconn_req(chan->conn, chan, -err);
+			l2cap_send_disconn_req(chan, -err);
 		else
 			l2cap_chan_ready(chan);
 	}
@@ -5401,7 +5400,7 @@ static void l2cap_handle_srej(struct l2cap_chan *chan,
 
 	if (control->reqseq == chan->next_tx_seq) {
 		BT_DBG("Invalid reqseq %d, disconnecting", control->reqseq);
-		l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
+		l2cap_send_disconn_req(chan, ECONNRESET);
 		return;
 	}
 
@@ -5415,7 +5414,7 @@ static void l2cap_handle_srej(struct l2cap_chan *chan,
 
 	if (chan->max_tx != 0 && bt_cb(skb)->control.retries >= chan->max_tx) {
 		BT_DBG("Retry limit exceeded (%d)", chan->max_tx);
-		l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
+		l2cap_send_disconn_req(chan, ECONNRESET);
 		return;
 	}
 
@@ -5459,7 +5458,7 @@ static void l2cap_handle_rej(struct l2cap_chan *chan,
 
 	if (control->reqseq == chan->next_tx_seq) {
 		BT_DBG("Invalid reqseq %d, disconnecting", control->reqseq);
-		l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
+		l2cap_send_disconn_req(chan, ECONNRESET);
 		return;
 	}
 
@@ -5468,7 +5467,7 @@ static void l2cap_handle_rej(struct l2cap_chan *chan,
 	if (chan->max_tx && skb &&
 	    bt_cb(skb)->control.retries >= chan->max_tx) {
 		BT_DBG("Retry limit exceeded (%d)", chan->max_tx);
-		l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
+		l2cap_send_disconn_req(chan, ECONNRESET);
 		return;
 	}
 
@@ -5652,8 +5651,7 @@ static int l2cap_rx_state_recv(struct l2cap_chan *chan,
 			break;
 		case L2CAP_TXSEQ_INVALID:
 		default:
-			l2cap_send_disconn_req(chan->conn, chan,
-					       ECONNRESET);
+			l2cap_send_disconn_req(chan, ECONNRESET);
 			break;
 		}
 		break;
@@ -5786,8 +5784,7 @@ static int l2cap_rx_state_srej_sent(struct l2cap_chan *chan,
 			break;
 		case L2CAP_TXSEQ_INVALID:
 		default:
-			l2cap_send_disconn_req(chan->conn, chan,
-					       ECONNRESET);
+			l2cap_send_disconn_req(chan, ECONNRESET);
 			break;
 		}
 		break;
@@ -5982,7 +5979,7 @@ static int l2cap_rx(struct l2cap_chan *chan, struct l2cap_ctrl *control,
 		BT_DBG("Invalid reqseq %d (next_tx_seq %d, expected_ack_seq %d",
 		       control->reqseq, chan->next_tx_seq,
 		       chan->expected_ack_seq);
-		l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
+		l2cap_send_disconn_req(chan, ECONNRESET);
 	}
 
 	return err;
@@ -6051,7 +6048,7 @@ static int l2cap_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 		len -= L2CAP_FCS_SIZE;
 
 	if (len > chan->mps) {
-		l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
+		l2cap_send_disconn_req(chan, ECONNRESET);
 		goto drop;
 	}
 
@@ -6076,8 +6073,7 @@ static int l2cap_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 		}
 
 		if (err)
-			l2cap_send_disconn_req(chan->conn, chan,
-					       ECONNRESET);
+			l2cap_send_disconn_req(chan, ECONNRESET);
 	} else {
 		const u8 rx_func_to_event[4] = {
 			L2CAP_EV_RECV_RR, L2CAP_EV_RECV_REJ,
@@ -6094,7 +6090,7 @@ static int l2cap_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 
 		if (len != 0) {
 			BT_ERR("Trailing bytes: %d in sframe", len);
-			l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
+			l2cap_send_disconn_req(chan, ECONNRESET);
 			goto drop;
 		}
 
@@ -6105,7 +6101,7 @@ static int l2cap_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 
 		event = rx_func_to_event[control->super];
 		if (l2cap_rx(chan, control, skb, event))
-			l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
+			l2cap_send_disconn_req(chan, ECONNRESET);
 	}
 
 	return 0;
-- 
1.7.10.4

