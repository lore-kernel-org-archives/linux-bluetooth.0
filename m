Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: jprvita@profusion.mobi, gustavo@padovan.org, marcel@holtmann.org
Subject: [PATCH 11/13] Bluetooth: Fix ERTM error reporting to the userspace
Date: Mon, 31 May 2010 14:02:50 -0300
Message-Id: <1275325372-5671-11-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1275325372-5671-10-git-send-email-padovan@profusion.mobi>
References: <1275325372-5671-1-git-send-email-padovan@profusion.mobi>
 <1275325372-5671-2-git-send-email-padovan@profusion.mobi>
 <1275325372-5671-3-git-send-email-padovan@profusion.mobi>
 <1275325372-5671-4-git-send-email-padovan@profusion.mobi>
 <1275325372-5671-5-git-send-email-padovan@profusion.mobi>
 <1275325372-5671-6-git-send-email-padovan@profusion.mobi>
 <1275325372-5671-7-git-send-email-padovan@profusion.mobi>
 <1275325372-5671-8-git-send-email-padovan@profusion.mobi>
 <1275325372-5671-9-git-send-email-padovan@profusion.mobi>
 <1275325372-5671-10-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

If any error occurs during transfers we have to tell userspace that
something wrong happened.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |   39 ++++++++++++++++++++++-----------------
 1 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index e5b766d..775204a 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -449,7 +449,7 @@ static inline void l2cap_ertm_shutdown(struct sock *sk)
 	}
 }
 
-static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct sock *sk)
+static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct sock *sk, int err)
 {
 	struct l2cap_disconn_req req;
 
@@ -467,6 +467,7 @@ static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct sock *sk)
 			L2CAP_DISCONN_REQ, sizeof(req), &req);
 
 	sk->sk_state = BT_DISCONN;
+	sk->sk_err = err;
 }
 
 /* ---- L2CAP connections ---- */
@@ -758,7 +759,7 @@ static void __l2cap_sock_close(struct sock *sk, int reason)
 			struct l2cap_conn *conn = l2cap_pi(sk)->conn;
 
 			l2cap_sock_set_timer(sk, sk->sk_sndtimeo);
-			l2cap_send_disconn_req(conn, sk);
+			l2cap_send_disconn_req(conn, sk, reason);
 		} else
 			l2cap_chan_del(sk, reason);
 		break;
@@ -1303,7 +1304,7 @@ static void l2cap_monitor_timeout(unsigned long arg)
 
 	bh_lock_sock(sk);
 	if (l2cap_pi(sk)->retry_count >= l2cap_pi(sk)->remote_max_tx) {
-		l2cap_send_disconn_req(l2cap_pi(sk)->conn, sk);
+		l2cap_send_disconn_req(l2cap_pi(sk)->conn, sk, ECONNABORTED);
 		bh_unlock_sock(sk);
 		return;
 	}
@@ -1413,7 +1414,7 @@ static void l2cap_retransmit_one_frame(struct sock *sk, u8 tx_seq)
 
 	if (pi->remote_max_tx &&
 			bt_cb(skb)->retries == pi->remote_max_tx) {
-		l2cap_send_disconn_req(pi->conn, sk);
+		l2cap_send_disconn_req(pi->conn, sk, ECONNABORTED);
 		return;
 	}
 
@@ -1450,7 +1451,7 @@ static int l2cap_ertm_send(struct sock *sk)
 
 		if (pi->remote_max_tx &&
 				bt_cb(skb)->retries == pi->remote_max_tx) {
-			l2cap_send_disconn_req(pi->conn, sk);
+			l2cap_send_disconn_req(pi->conn, sk, ECONNABORTED);
 			break;
 		}
 
@@ -2168,6 +2169,10 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 			err = bt_sock_wait_state(sk, BT_CLOSED,
 							sk->sk_lingertime);
 	}
+
+	if (!err && sk->sk_err)
+		err = -sk->sk_err;
+
 	release_sock(sk);
 	return err;
 }
@@ -2439,7 +2444,7 @@ static int l2cap_build_conf_req(struct sock *sk, void *data)
 	case L2CAP_MODE_ERTM:
 		pi->conf_state |= L2CAP_CONF_STATE2_DEVICE;
 		if (!l2cap_mode_supported(pi->mode, pi->conn->feat_mask))
-			l2cap_send_disconn_req(pi->conn, sk);
+			l2cap_send_disconn_req(pi->conn, sk, ECONNRESET);
 		break;
 	default:
 		pi->mode = l2cap_select_mode(rfc.mode, pi->conn->feat_mask);
@@ -3008,7 +3013,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	/* Complete config. */
 	len = l2cap_parse_conf_req(sk, rsp);
 	if (len < 0) {
-		l2cap_send_disconn_req(conn, sk);
+		l2cap_send_disconn_req(conn, sk, ECONNRESET);
 		goto unlock;
 	}
 
@@ -3078,7 +3083,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 			char req[64];
 
 			if (len > sizeof(req) - sizeof(struct l2cap_conf_req)) {
-				l2cap_send_disconn_req(conn, sk);
+				l2cap_send_disconn_req(conn, sk, ECONNRESET);
 				goto done;
 			}
 
@@ -3087,7 +3092,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 			len = l2cap_parse_conf_rsp(sk, rsp->data,
 							len, req, &result);
 			if (len < 0) {
-				l2cap_send_disconn_req(conn, sk);
+				l2cap_send_disconn_req(conn, sk, ECONNRESET);
 				goto done;
 			}
 
@@ -3102,7 +3107,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	default:
 		sk->sk_state = BT_DISCONN;
 		l2cap_sock_set_timer(sk, HZ * 5);
-		l2cap_send_disconn_req(conn, sk);
+		l2cap_send_disconn_req(conn, sk, ECONNRESET);
 		goto done;
 	}
 
@@ -3545,7 +3550,7 @@ drop:
 	pi->sdu = NULL;
 
 disconnect:
-	l2cap_send_disconn_req(pi->conn, sk);
+	l2cap_send_disconn_req(pi->conn, sk, ECONNRESET);
 	kfree_skb(skb);
 	return 0;
 }
@@ -3568,7 +3573,7 @@ static void l2cap_busy_work(struct work_struct *work)
 
 		if (n_tries++ > L2CAP_LOCAL_BUSY_TRIES) {
 			err = -EBUSY;
-			l2cap_send_disconn_req(pi->conn, sk);
+			l2cap_send_disconn_req(pi->conn, sk, EBUSY);
 			goto done;
 		}
 
@@ -3844,7 +3849,7 @@ static inline int l2cap_data_channel_iframe(struct sock *sk, u16 rx_control, str
 
 	/* invalid tx_seq */
 	if (tx_seq_offset >= pi->tx_win) {
-		l2cap_send_disconn_req(pi->conn, sk);
+		l2cap_send_disconn_req(pi->conn, sk, ECONNRESET);
 		goto drop;
 	}
 
@@ -4155,7 +4160,7 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 			len -= 2;
 
 		if (len > pi->mps) {
-			l2cap_send_disconn_req(pi->conn, sk);
+			l2cap_send_disconn_req(pi->conn, sk, ECONNRESET);
 			goto drop;
 		}
 
@@ -4171,20 +4176,20 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 
 		/* check for invalid req-seq */
 		if (req_seq_offset > next_tx_seq_offset) {
-			l2cap_send_disconn_req(pi->conn, sk);
+			l2cap_send_disconn_req(pi->conn, sk, ECONNRESET);
 			goto drop;
 		}
 
 		if (__is_iframe(control)) {
 			if (len < 4) {
-				l2cap_send_disconn_req(pi->conn, sk);
+				l2cap_send_disconn_req(pi->conn, sk, ECONNRESET);
 				goto drop;
 			}
 
 			l2cap_data_channel_iframe(sk, control, skb);
 		} else {
 			if (len != 0) {
-				l2cap_send_disconn_req(pi->conn, sk);
+				l2cap_send_disconn_req(pi->conn, sk, ECONNRESET);
 				goto drop;
 			}
 
-- 
1.6.4.4
