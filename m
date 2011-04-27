Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Add l2cap_add_psm() and l2cap_add_scid()
Date: Wed, 27 Apr 2011 18:49:15 -0300
Message-Id: <1303940957-22694-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The intention is to get rid of the l2cap_sk_list usage inside
l2cap_core.c. l2cap_sk_list will soon be replaced by a list that does not
depend on socket usage.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    4 +++
 net/bluetooth/l2cap_core.c    |   44 +++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/l2cap_sock.c    |   44 ++++++++++------------------------------
 3 files changed, 59 insertions(+), 33 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index c34b1c1..f5f3c2c 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -458,6 +458,10 @@ void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb);
 void l2cap_streaming_send(struct l2cap_chan *chan);
 int l2cap_ertm_send(struct l2cap_chan *chan);
 
+struct sock *__l2cap_get_sock_by_addr(__le16 psm, bdaddr_t *src);
+int l2cap_add_psm(struct l2cap_chan *chan, bdaddr_t *src, __le16 psm);
+int l2cap_add_scid(struct l2cap_chan *chan,  __u16 scid);
+
 void l2cap_sock_set_timer(struct sock *sk, long timeout);
 void l2cap_sock_clear_timer(struct sock *sk);
 void __l2cap_sock_close(struct sock *sk, int reason);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 338d8c3..98ddd86 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -135,6 +135,50 @@ static inline struct l2cap_chan *l2cap_get_chan_by_ident(struct l2cap_conn *conn
 	return c;
 }
 
+struct sock *__l2cap_get_sock_by_addr(__le16 psm, bdaddr_t *src)
+{
+	struct sock *sk;
+	struct hlist_node *node;
+	sk_for_each(sk, node, &l2cap_sk_list.head) {
+		struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+
+		if (chan->sport == psm && !bacmp(&bt_sk(sk)->src, src))
+			goto found;
+	}
+
+	sk = NULL;
+found:
+	return sk;
+}
+
+int l2cap_add_psm(struct l2cap_chan *chan, bdaddr_t *src, __le16 psm)
+{
+	write_lock_bh(&l2cap_sk_list.lock);
+
+	if (__l2cap_get_sock_by_addr(psm, src)) {
+		write_unlock_bh(&l2cap_sk_list.lock);
+		return -EADDRINUSE;
+	}
+
+	chan->psm = psm;
+	chan->sport = psm;
+
+	write_unlock_bh(&l2cap_sk_list.lock);
+
+	return 0;
+}
+
+int l2cap_add_scid(struct l2cap_chan *chan,  __u16 scid)
+{
+	write_lock_bh(&l2cap_sk_list.lock);
+
+	chan->scid = scid;
+
+	write_unlock_bh(&l2cap_sk_list.lock);
+
+	return 0;
+}
+
 static u16 l2cap_alloc_cid(struct l2cap_conn *conn)
 {
 	u16 cid = L2CAP_CID_DYN_START;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 09cc7a0..2156dce 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -78,22 +78,6 @@ void l2cap_sock_clear_timer(struct sock *sk)
 	sk_stop_timer(sk, &sk->sk_timer);
 }
 
-static struct sock *__l2cap_get_sock_by_addr(__le16 psm, bdaddr_t *src)
-{
-	struct sock *sk;
-	struct hlist_node *node;
-	sk_for_each(sk, node, &l2cap_sk_list.head) {
-		struct l2cap_chan *chan = l2cap_pi(sk)->chan;
-
-		if (chan->sport == psm && !bacmp(&bt_sk(sk)->src, src))
-			goto found;
-	}
-
-	sk = NULL;
-found:
-	return sk;
-}
-
 static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 {
 	struct sock *sk = sock->sk;
@@ -136,26 +120,20 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 		}
 	}
 
-	write_lock_bh(&l2cap_sk_list.lock);
+	if (la.l2_cid)
+		err = l2cap_add_scid(chan, la.l2_cid);
+	else
+		err = l2cap_add_psm(chan, &la.l2_bdaddr, la.l2_psm);
 
-	if (la.l2_psm && __l2cap_get_sock_by_addr(la.l2_psm, &la.l2_bdaddr)) {
-		err = -EADDRINUSE;
-	} else {
-		/* Save source address */
-		bacpy(&bt_sk(sk)->src, &la.l2_bdaddr);
-		chan->psm   = la.l2_psm;
-		chan->sport = la.l2_psm;
-		sk->sk_state = BT_BOUND;
-
-		if (__le16_to_cpu(la.l2_psm) == 0x0001 ||
-					__le16_to_cpu(la.l2_psm) == 0x0003)
-			chan->sec_level = BT_SECURITY_SDP;
-	}
+	if (err < 0)
+		goto done;
 
-	if (la.l2_cid)
-		chan->scid = la.l2_cid;
+	if (__le16_to_cpu(la.l2_psm) == 0x0001 ||
+				__le16_to_cpu(la.l2_psm) == 0x0003)
+		chan->sec_level = BT_SECURITY_SDP;
 
-	write_unlock_bh(&l2cap_sk_list.lock);
+	bacpy(&bt_sk(sk)->src, &la.l2_bdaddr);
+	sk->sk_state = BT_BOUND;
 
 done:
 	release_sock(sk);
-- 
1.7.5.rc1

