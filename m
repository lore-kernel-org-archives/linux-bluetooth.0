Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [RFC 07/22] Bluetooth: Don't use spin_lock socket lock anymore
Date: Sat, 17 Dec 2011 19:29:27 -0200
Message-Id: <1324157382-1815-8-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1324157382-1815-7-git-send-email-padovan@profusion.mobi>
References: <1324157382-1815-1-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-2-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-3-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-4-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-5-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-6-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-7-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

We now run everything in process context, so the mutex lock is the best
option. But in some places we still need the bh_lock_sock()

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap_core.c |   66 +++++++++++++------------------------------
 1 files changed, 20 insertions(+), 46 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 89cda6d..ed67ac0 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -118,7 +118,7 @@ static struct l2cap_chan *l2cap_get_chan_by_scid(struct l2cap_conn *conn, u16 ci
 	read_lock(&conn->chan_lock);
 	c = __l2cap_get_chan_by_scid(conn, cid);
 	if (c)
-		bh_lock_sock(c->sk);
+		lock_sock(c->sk);
 	read_unlock(&conn->chan_lock);
 	return c;
 }
@@ -141,7 +141,7 @@ static inline struct l2cap_chan *l2cap_get_chan_by_ident(struct l2cap_conn *conn
 	read_lock(&conn->chan_lock);
 	c = __l2cap_get_chan_by_ident(conn, ident);
 	if (c)
-		bh_lock_sock(c->sk);
+		lock_sock(c->sk);
 	read_unlock(&conn->chan_lock);
 	return c;
 }
@@ -889,7 +889,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 
 	parent = pchan->sk;
 
-	bh_lock_sock(parent);
+	lock_sock(parent);
 
 	/* Check for backlog size */
 	if (sk_acceptq_is_full(parent)) {
@@ -922,7 +922,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 	write_unlock_bh(&conn->chan_lock);
 
 clean:
-	bh_unlock_sock(parent);
+	release_sock(parent);
 }
 
 static void l2cap_chan_ready(struct sock *sk)
@@ -1024,9 +1024,9 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 	/* Kill channels */
 	list_for_each_entry_safe(chan, l, &conn->chan_l, list) {
 		sk = chan->sk;
-		bh_lock_sock(sk);
+		lock_sock(sk);
 		l2cap_chan_del(chan, err);
-		bh_unlock_sock(sk);
+		release_sock(sk);
 		chan->ops->close(chan->data);
 	}
 
@@ -2568,7 +2568,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 	parent = pchan->sk;
 
-	bh_lock_sock(parent);
+	lock_sock(parent);
 
 	/* Check if the ACL is secure enough (if not SDP) */
 	if (psm != cpu_to_le16(0x0001) &&
@@ -2645,7 +2645,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	write_unlock_bh(&conn->chan_lock);
 
 response:
-	bh_unlock_sock(parent);
+	release_sock(parent);
 
 sendresp:
 	rsp.scid   = cpu_to_le16(scid);
@@ -2727,19 +2727,11 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 		break;
 
 	default:
-		/* don't delete l2cap channel if sk is owned by user */
-		if (sock_owned_by_user(sk)) {
-			l2cap_state_change(chan, BT_DISCONN);
-			__clear_chan_timer(chan);
-			__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
-			break;
-		}
-
 		l2cap_chan_del(chan, ECONNREFUSED);
 		break;
 	}
 
-	bh_unlock_sock(sk);
+	release_sock(sk);
 	return 0;
 }
 
@@ -2861,7 +2853,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	}
 
 unlock:
-	bh_unlock_sock(sk);
+	release_sock(sk);
 	return 0;
 }
 
@@ -2968,7 +2960,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	}
 
 done:
-	bh_unlock_sock(sk);
+	release_sock(sk);
 	return 0;
 }
 
@@ -2997,17 +2989,8 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
 
 	sk->sk_shutdown = SHUTDOWN_MASK;
 
-	/* don't delete l2cap channel if sk is owned by user */
-	if (sock_owned_by_user(sk)) {
-		l2cap_state_change(chan, BT_DISCONN);
-		__clear_chan_timer(chan);
-		__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
-		bh_unlock_sock(sk);
-		return 0;
-	}
-
 	l2cap_chan_del(chan, ECONNRESET);
-	bh_unlock_sock(sk);
+	release_sock(sk);
 
 	chan->ops->close(chan->data);
 	return 0;
@@ -3031,17 +3014,8 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn, struct l2cap_cmd
 
 	sk = chan->sk;
 
-	/* don't delete l2cap channel if sk is owned by user */
-	if (sock_owned_by_user(sk)) {
-		l2cap_state_change(chan, BT_DISCONN);
-		__clear_chan_timer(chan);
-		__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
-		bh_unlock_sock(sk);
-		return 0;
-	}
-
 	l2cap_chan_del(chan, 0);
-	bh_unlock_sock(sk);
+	release_sock(sk);
 
 	chan->ops->close(chan->data);
 	return 0;
@@ -4284,7 +4258,7 @@ drop:
 
 done:
 	if (sk)
-		bh_unlock_sock(sk);
+		release_sock(sk);
 
 	return 0;
 }
@@ -4300,7 +4274,7 @@ static inline int l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm, str
 
 	sk = chan->sk;
 
-	bh_lock_sock(sk);
+	lock_sock(sk);
 
 	BT_DBG("sk %p, len %d", sk, skb->len);
 
@@ -4318,7 +4292,7 @@ drop:
 
 done:
 	if (sk)
-		bh_unlock_sock(sk);
+		release_sock(sk);
 	return 0;
 }
 
@@ -4333,7 +4307,7 @@ static inline int l2cap_att_channel(struct l2cap_conn *conn, __le16 cid, struct
 
 	sk = chan->sk;
 
-	bh_lock_sock(sk);
+	lock_sock(sk);
 
 	BT_DBG("sk %p, len %d", sk, skb->len);
 
@@ -4351,7 +4325,7 @@ drop:
 
 done:
 	if (sk)
-		bh_unlock_sock(sk);
+		release_sock(sk);
 	return 0;
 }
 
@@ -4656,11 +4630,11 @@ static int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 fl
 				BT_ERR("Frame exceeding recv MTU (len %d, "
 							"MTU %d)", len,
 							chan->imtu);
-				bh_unlock_sock(sk);
+				release_sock(sk);
 				l2cap_conn_unreliable(conn, ECOMM);
 				goto drop;
 			}
-			bh_unlock_sock(sk);
+			release_sock(sk);
 		}
 
 		/* Allocate skb for the complete frame (with header) */
-- 
1.7.6.4

