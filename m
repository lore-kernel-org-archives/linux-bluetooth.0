Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: A2MP: Manage incoming connections
Date: Thu, 22 Dec 2011 13:06:06 +0200
Message-Id: <1324551986-29431-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1324551986-29431-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1324551986-29431-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Handle incoming A2MP connection by creating AMP manager and
processing A2MP messages.
---
 include/net/bluetooth/a2mp.h  |    5 +++++
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/a2mp.c          |   13 +++++++++++++
 net/bluetooth/l2cap_core.c    |   13 ++++++++-----
 4 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
index d204802..903a3e7 100644
--- a/include/net/bluetooth/a2mp.h
+++ b/include/net/bluetooth/a2mp.h
@@ -15,8 +15,13 @@
 #ifndef __A2MP_H
 #define __A2MP_H
 
+#include <net/bluetooth/l2cap.h>
+
 #define A2MP_FEAT_EXT	0x8000
 
+
+int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb);
+
 void a2mp_incoming(struct l2cap_conn *conn, struct sk_buff *skb);
 
 struct amp_mgr {
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index c5dabf0..8bc6fb4 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -832,5 +832,6 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
 int l2cap_chan_check_security(struct l2cap_chan *chan);
 void l2cap_ertm_init(struct l2cap_chan *chan);
+int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb);
 
 #endif /* __L2CAP_H */
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index da3873b..63e6aaf 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -568,6 +568,19 @@ finished:
 	return mgr;
 }
 
+void a2mp_incoming(struct l2cap_conn *conn, struct sk_buff *skb)
+{
+	struct amp_mgr *mgr;
+	struct sock *sk;
+
+	mgr = amp_mgr_create(conn);
+	sk = mgr->a2mp_sock->sk;
+
+	BT_DBG("mgr %p sk %p", mgr, sk);
+
+	l2cap_ertm_data_rcv(sk, skb);
+}
+
 int a2mp_init(void)
 {
 #if 0
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 6fbe7ba..ba0f132 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -74,8 +74,6 @@ static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data);
 static void l2cap_send_disconn_req(struct l2cap_conn *conn,
 				struct l2cap_chan *chan, int err);
 
-static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb);
-
 /* ---- L2CAP channels ---- */
 
 static inline void chan_hold(struct l2cap_chan *c)
@@ -4167,7 +4165,7 @@ static inline int l2cap_data_channel_sframe(struct l2cap_chan *chan, u32 rx_cont
 	return 0;
 }
 
-static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb)
+int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb)
 {
 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 	u32 control;
@@ -4244,8 +4242,13 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 
 	chan = l2cap_get_chan_by_scid(conn, cid);
 	if (!chan) {
-		BT_DBG("unknown cid 0x%4.4x", cid);
-		goto drop;
+		if (cid == L2CAP_CID_A2MP) {
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

