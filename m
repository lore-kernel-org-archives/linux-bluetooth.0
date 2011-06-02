Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/6] Bluetooth: Add refcnt to struct l2cap_chan
Date: Thu,  2 Jun 2011 13:15:27 -0300
Message-Id: <1307031329-8001-4-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1307031329-8001-3-git-send-email-padovan@profusion.mobi>
References: <1307031329-8001-1-git-send-email-padovan@profusion.mobi>
 <1307031329-8001-2-git-send-email-padovan@profusion.mobi>
 <1307031329-8001-3-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

struct l2cap_chan has now its own refcnt that is compatible with the
socket refcnt, i.e., we won't see sk_refcnt = 0 and chan->refcnt > 0.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    2 ++
 net/bluetooth/l2cap_core.c    |   29 ++++++++++++++++++++---------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index af2f171..c620a92 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -287,6 +287,8 @@ struct l2cap_chan {
 
 	struct l2cap_conn	*conn;
 
+	atomic_t	refcnt;
+
 	__le16		psm;
 	__u16		dcid;
 	__u16		scid;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c645e03..dd8da43 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -78,6 +78,18 @@ static void l2cap_send_disconn_req(struct l2cap_conn *conn,
 static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb);
 
 /* ---- L2CAP channels ---- */
+
+static inline void chan_hold(struct l2cap_chan *c)
+{
+	atomic_inc(&c->refcnt);
+}
+
+static inline void chan_put(struct l2cap_chan *c)
+{
+	if (atomic_dec_and_test(&c->refcnt))
+		kfree(c);
+}
+
 static struct l2cap_chan *__l2cap_get_chan_by_dcid(struct l2cap_conn *conn, u16 cid)
 {
 	struct l2cap_chan *c;
@@ -213,7 +225,7 @@ static void l2cap_chan_set_timer(struct l2cap_chan *chan, long timeout)
        BT_DBG("chan %p state %d timeout %ld", chan->sk, chan->sk->sk_state,
 								 timeout);
        if (!mod_timer(&chan->chan_timer, jiffies + timeout))
-	       sock_hold(chan->sk);
+	       chan_hold(chan);
 }
 
 static void l2cap_chan_clear_timer(struct l2cap_chan *chan)
@@ -221,7 +233,7 @@ static void l2cap_chan_clear_timer(struct l2cap_chan *chan)
        BT_DBG("chan %p state %d", chan, chan->sk->sk_state);
 
        if (timer_pending(&chan->chan_timer) && del_timer(&chan->chan_timer))
-	       __sock_put(chan->sk);
+	       chan_put(chan);
 }
 
 static void l2cap_chan_timeout(unsigned long arg)
@@ -238,7 +250,7 @@ static void l2cap_chan_timeout(unsigned long arg)
 		/* sk is owned by user. Try again later */
 		l2cap_chan_set_timer(chan, HZ / 5);
 		bh_unlock_sock(sk);
-		sock_put(sk);
+		chan_put(chan);
 		return;
 	}
 
@@ -255,7 +267,7 @@ static void l2cap_chan_timeout(unsigned long arg)
 	bh_unlock_sock(sk);
 
 	chan->ops->close(chan->ops->data);
-	sock_put(sk);
+	chan_put(chan);
 }
 
 struct l2cap_chan *l2cap_chan_create(struct sock *sk)
@@ -274,6 +286,8 @@ struct l2cap_chan *l2cap_chan_create(struct sock *sk)
 
 	setup_timer(&chan->chan_timer, l2cap_chan_timeout, (unsigned long) chan);
 
+	atomic_set(&chan->refcnt, 1);
+
 	return chan;
 }
 
@@ -283,13 +297,11 @@ void l2cap_chan_destroy(struct l2cap_chan *chan)
 	list_del(&chan->global_l);
 	write_unlock_bh(&chan_list_lock);
 
-	kfree(chan);
+	chan_put(chan);
 }
 
 static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 {
-	struct sock *sk = chan->sk;
-
 	BT_DBG("conn %p, psm 0x%2.2x, dcid 0x%4.4x", conn,
 			chan->psm, chan->dcid);
 
@@ -320,7 +332,7 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 		chan->omtu = L2CAP_DEFAULT_MTU;
 	}
 
-	sock_hold(sk);
+	chan_hold(chan);
 
 	list_add(&chan->list, &conn->chan_l);
 }
@@ -342,7 +354,6 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 		write_lock_bh(&conn->chan_lock);
 		list_del(&chan->list);
 		write_unlock_bh(&conn->chan_lock);
-		__sock_put(sk);
 
 		chan->conn = NULL;
 		hci_conn_put(conn->hcon);
-- 
1.7.5.1

