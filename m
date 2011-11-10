Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 21/21] Bluetooth: A2MP: Manage incoming connections
Date: Thu, 10 Nov 2011 16:54:28 +0200
Message-Id: <1320936868-7978-22-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1320936868-7978-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1320936868-7978-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Handle incoming A2MP connection by creating AMP manager and
processing A2MP messages in a workqueue.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h |    8 ++++++++
 net/bluetooth/a2mp.c         |   34 ++++++++++++++++++++++++++++++++++
 net/bluetooth/l2cap_core.c   |   10 ++++++++--
 3 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
index 31d98a8..d1abddc 100644
--- a/include/net/bluetooth/a2mp.h
+++ b/include/net/bluetooth/a2mp.h
@@ -17,6 +17,8 @@
 
 #define A2MP_FEAT_EXT	0x8000
 
+void a2mp_incoming(struct l2cap_conn *conn, struct sk_buff *skb);
+
 struct amp_mgr {
 	struct list_head	list;
 	struct l2cap_conn	*l2cap_conn;
@@ -125,6 +127,12 @@ struct a2mp_work_state_change {
 	struct sock *sk;
 };
 
+struct a2mp_work_incoming {
+	struct work_struct work;
+	struct l2cap_conn *conn;
+	struct sk_buff *skb;
+};
+
 int a2mp_init(void);
 void a2mp_exit(void);
 
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 21e808d..2d9e975 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -615,6 +615,40 @@ finished:
 	return mgr;
 }
 
+static void incoming_worker(struct work_struct *w)
+{
+	struct a2mp_work_incoming *work = (struct a2mp_work_incoming *) w;
+	struct l2cap_conn *conn = work->conn;
+	struct amp_mgr *mgr;
+	struct sock *sk;
+
+	mgr = amp_mgr_create(conn);
+	sk = mgr->a2mp_sock->sk;
+
+	BT_DBG("mgr %p sk %p", mgr, sk);
+
+	lock_sock(sk);
+	sk->sk_backlog_rcv(sk, work->skb);
+	release_sock(sk);
+
+	kfree(work);
+}
+
+void a2mp_incoming(struct l2cap_conn *conn, struct sk_buff *skb)
+{
+	struct a2mp_work_incoming *work;
+
+	BT_DBG("conn %p", conn);
+	work = kmalloc(sizeof(*work), GFP_ATOMIC);
+	if (work) {
+		INIT_WORK((struct work_struct *) work, incoming_worker);
+		work->conn = conn;
+		work->skb = skb;
+		if (queue_work(a2mp_workqueue, (struct work_struct *) work) == 0)
+			kfree(work);
+	}
+}
+
 int a2mp_init(void)
 {
 	a2mp_workqueue = create_singlethread_workqueue("a2mp");
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index cf57ae0..1c312b2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4201,8 +4201,14 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 
 	chan = l2cap_get_chan_by_scid(conn, cid);
 	if (!chan) {
-		BT_DBG("unknown cid 0x%4.4x", cid);
-		goto drop;
+		if (cid == L2CAP_CID_A2MP) {
+			BT_DBG("A2MP");
+			a2mp_incoming(conn, skb);
+			goto done;
+		} else {
+			BT_DBG("unknown cid 0x%4.4x", cid);
+			goto drop;
+		}
 	}
 
 	sk = chan->sk;
-- 
1.7.4.1

