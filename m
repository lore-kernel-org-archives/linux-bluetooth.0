Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: jprvita@profusion.mobi, gustavo@padovan.org, marcel@holtmann.org
Subject: [PATCH 09/13] Bluetooth: Fix ERTM channel shutdown
Date: Mon, 31 May 2010 14:02:48 -0300
Message-Id: <1275325372-5671-9-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1275325372-5671-8-git-send-email-padovan@profusion.mobi>
References: <1275325372-5671-1-git-send-email-padovan@profusion.mobi>
 <1275325372-5671-2-git-send-email-padovan@profusion.mobi>
 <1275325372-5671-3-git-send-email-padovan@profusion.mobi>
 <1275325372-5671-4-git-send-email-padovan@profusion.mobi>
 <1275325372-5671-5-git-send-email-padovan@profusion.mobi>
 <1275325372-5671-6-git-send-email-padovan@profusion.mobi>
 <1275325372-5671-7-git-send-email-padovan@profusion.mobi>
 <1275325372-5671-8-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

After send a Disconnection Request we shall no send and receive frames
anymore. So we set it to BT_DISCONN when a Disconnection Request is
sent then L2CAP will not be able to send or receive any new packet, as
specified by L2CAP spec.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |   50 +++++++++++++++++++++++++++++++++---------------
 1 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 35b7791..3db0078 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -428,14 +428,41 @@ static void l2cap_do_start(struct sock *sk)
 	}
 }
 
+static inline void l2cap_ertm_shutdown(struct sock *sk)
+{
+	struct srej_list *l, *tmp;
+
+	del_timer(&l2cap_pi(sk)->retrans_timer);
+	del_timer(&l2cap_pi(sk)->monitor_timer);
+	del_timer(&l2cap_pi(sk)->ack_timer);
+
+	skb_queue_purge(SREJ_QUEUE(sk));
+	skb_queue_purge(BUSY_QUEUE(sk));
+
+	list_for_each_entry_safe(l, tmp, SREJ_LIST(sk), list) {
+		list_del(&l->list);
+		kfree(l);
+	}
+}
+
 static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct sock *sk)
 {
 	struct l2cap_disconn_req req;
 
+	skb_queue_purge(TX_QUEUE(sk));
+
+	if (l2cap_pi(sk)->mode == L2CAP_MODE_ERTM) {
+		del_timer(&l2cap_pi(sk)->retrans_timer);
+		del_timer(&l2cap_pi(sk)->monitor_timer);
+		del_timer(&l2cap_pi(sk)->ack_timer);
+	}
+
 	req.dcid = cpu_to_le16(l2cap_pi(sk)->dcid);
 	req.scid = cpu_to_le16(l2cap_pi(sk)->scid);
 	l2cap_send_cmd(conn, l2cap_get_ident(conn),
 			L2CAP_DISCONN_REQ, sizeof(req), &req);
+
+	sk->sk_state = BT_DISCONN;
 }
 
 /* ---- L2CAP connections ---- */
@@ -726,7 +753,6 @@ static void __l2cap_sock_close(struct sock *sk, int reason)
 				sk->sk_type == SOCK_STREAM) {
 			struct l2cap_conn *conn = l2cap_pi(sk)->conn;
 
-			sk->sk_state = BT_DISCONN;
 			l2cap_sock_set_timer(sk, sk->sk_sndtimeo);
 			l2cap_send_disconn_req(conn, sk);
 		} else
@@ -1409,6 +1435,9 @@ static int l2cap_ertm_send(struct sock *sk)
 	u16 control, fcs;
 	int nsent = 0;
 
+	if (sk->sk_state != BT_CONNECTED)
+		return -ENOTCONN;
+
 	if (pi->conn_state & L2CAP_CONN_WAIT_F)
 		return 0;
 
@@ -3068,7 +3097,6 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 
 	default:
 		sk->sk_state = BT_DISCONN;
-		sk->sk_err = ECONNRESET;
 		l2cap_sock_set_timer(sk, HZ * 5);
 		l2cap_send_disconn_req(conn, sk);
 		goto done;
@@ -3123,13 +3151,8 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
 
 	skb_queue_purge(TX_QUEUE(sk));
 
-	if (l2cap_pi(sk)->mode == L2CAP_MODE_ERTM) {
-		skb_queue_purge(SREJ_QUEUE(sk));
-		skb_queue_purge(BUSY_QUEUE(sk));
-		del_timer(&l2cap_pi(sk)->retrans_timer);
-		del_timer(&l2cap_pi(sk)->monitor_timer);
-		del_timer(&l2cap_pi(sk)->ack_timer);
-	}
+	if (l2cap_pi(sk)->mode == L2CAP_MODE_ERTM)
+		l2cap_ertm_shutdown(sk);
 
 	l2cap_chan_del(sk, ECONNRESET);
 	bh_unlock_sock(sk);
@@ -3155,13 +3178,8 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn, struct l2cap_cmd
 
 	skb_queue_purge(TX_QUEUE(sk));
 
-	if (l2cap_pi(sk)->mode == L2CAP_MODE_ERTM) {
-		skb_queue_purge(SREJ_QUEUE(sk));
-		skb_queue_purge(BUSY_QUEUE(sk));
-		del_timer(&l2cap_pi(sk)->retrans_timer);
-		del_timer(&l2cap_pi(sk)->monitor_timer);
-		del_timer(&l2cap_pi(sk)->ack_timer);
-	}
+	if (l2cap_pi(sk)->mode == L2CAP_MODE_ERTM)
+		l2cap_ertm_shutdown(sk);
 
 	l2cap_chan_del(sk, 0);
 	bh_unlock_sock(sk);
-- 
1.6.4.4
