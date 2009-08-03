Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 1/7] Bluetooth: Create l2cap_send_disconn_req()
Date: Mon,  3 Aug 2009 02:41:27 -0300
Message-Id: <1249278093-725-1-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The code for sending a disconnect request was repetead several times on
L2CAP.

Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
---
 net/bluetooth/l2cap.c |   47 +++++++++++++++++------------------------------
 1 files changed, 17 insertions(+), 30 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index af0fbf9..18b3c62 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -366,6 +366,17 @@ static void l2cap_do_start(struct sock *sk)
 	}
 }
 
+static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct sock *sk)
+{
+	struct l2cap_disconn_req req;
+
+	req.dcid = cpu_to_le16(l2cap_pi(sk)->dcid);
+	req.scid = cpu_to_le16(l2cap_pi(sk)->scid);
+	l2cap_send_cmd(conn, l2cap_get_ident(conn),
+			L2CAP_DISCONN_REQ, sizeof(req), &req);
+	return;
+}
+
 /* ---- L2CAP connections ---- */
 static void l2cap_conn_start(struct l2cap_conn *conn)
 {
@@ -650,15 +661,10 @@ static void __l2cap_sock_close(struct sock *sk, int reason)
 	case BT_CONFIG:
 		if (sk->sk_type == SOCK_SEQPACKET) {
 			struct l2cap_conn *conn = l2cap_pi(sk)->conn;
-			struct l2cap_disconn_req req;
 
 			sk->sk_state = BT_DISCONN;
 			l2cap_sock_set_timer(sk, sk->sk_sndtimeo);
-
-			req.dcid = cpu_to_le16(l2cap_pi(sk)->dcid);
-			req.scid = cpu_to_le16(l2cap_pi(sk)->scid);
-			l2cap_send_cmd(conn, l2cap_get_ident(conn),
-					L2CAP_DISCONN_REQ, sizeof(req), &req);
+			l2cap_send_disconn_req(conn, sk);
 		} else
 			l2cap_chan_del(sk, reason);
 		break;
@@ -1786,13 +1792,8 @@ static int l2cap_build_conf_req(struct sock *sk, void *data)
 	case L2CAP_MODE_STREAMING:
 	case L2CAP_MODE_ERTM:
 		pi->conf_state |= L2CAP_CONF_STATE2_DEVICE;
-		if (!l2cap_mode_supported(pi->mode, pi->conn->feat_mask)) {
-			struct l2cap_disconn_req req;
-			req.dcid = cpu_to_le16(pi->dcid);
-			req.scid = cpu_to_le16(pi->scid);
-			l2cap_send_cmd(pi->conn, l2cap_get_ident(pi->conn),
-					L2CAP_DISCONN_REQ, sizeof(req), &req);
-		}
+		if (!l2cap_mode_supported(pi->mode, pi->conn->feat_mask))
+			l2cap_send_disconn_req(pi->conn, sk);
 		break;
 	default:
 		pi->mode = l2cap_select_mode(rfc.mode, pi->conn->feat_mask);
@@ -2286,11 +2287,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	/* Complete config. */
 	len = l2cap_parse_conf_req(sk, rsp);
 	if (len < 0) {
-		struct l2cap_disconn_req req;
-		req.dcid = cpu_to_le16(l2cap_pi(sk)->dcid);
-		req.scid = cpu_to_le16(l2cap_pi(sk)->scid);
-		l2cap_send_cmd(conn, l2cap_get_ident(conn),
-					L2CAP_DISCONN_REQ, sizeof(req), &req);
+		l2cap_send_disconn_req(conn, sk);
 		goto unlock;
 	}
 
@@ -2352,11 +2349,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 			len = l2cap_parse_conf_rsp(sk, rsp->data,
 							len, req, &result);
 			if (len < 0) {
-				struct l2cap_disconn_req req;
-				req.dcid = cpu_to_le16(l2cap_pi(sk)->dcid);
-				req.scid = cpu_to_le16(l2cap_pi(sk)->scid);
-				l2cap_send_cmd(conn, l2cap_get_ident(conn),
-					L2CAP_DISCONN_REQ, sizeof(req), &req);
+				l2cap_send_disconn_req(conn, sk);
 				goto done;
 			}
 
@@ -2372,13 +2365,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 		sk->sk_state = BT_DISCONN;
 		sk->sk_err = ECONNRESET;
 		l2cap_sock_set_timer(sk, HZ * 5);
-		{
-			struct l2cap_disconn_req req;
-			req.dcid = cpu_to_le16(l2cap_pi(sk)->dcid);
-			req.scid = cpu_to_le16(l2cap_pi(sk)->scid);
-			l2cap_send_cmd(conn, l2cap_get_ident(conn),
-					L2CAP_DISCONN_REQ, sizeof(req), &req);
-		}
+		l2cap_send_disconn_req(conn, sk);
 		goto done;
 	}
 
-- 
1.6.3.3

