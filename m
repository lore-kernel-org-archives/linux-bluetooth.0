Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [RFC -v2 15/16] Bluetooth: Create l2cap->ops->set_shutdown()
Date: Fri, 21 Dec 2012 16:10:58 -0200
Message-Id: <1356113459-7932-16-git-send-email-gustavo@padovan.org>
In-Reply-To: <1356113459-7932-1-git-send-email-gustavo@padovan.org>
References: <1356113459-7932-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Isolates the code that sets the socket shutdown mask. This is the last
commit to remove the socket usage from l2cap_core.c

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 include/net/bluetooth/l2cap.h |  5 +++++
 net/bluetooth/a2mp.c          |  1 +
 net/bluetooth/l2cap_core.c    |  7 +------
 net/bluetooth/l2cap_sock.c    | 10 ++++++++++
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index cab7773..d3c8f57 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -556,6 +556,7 @@ struct l2cap_ops {
 	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
 					       unsigned long len, int nb);
 	void			(*resume) (struct l2cap_chan *chan);
+	void			(*set_shutdown) (struct l2cap_chan *chan);
 };
 
 struct l2cap_conn {
@@ -794,6 +795,10 @@ static inline void l2cap_chan_no_resume(struct l2cap_chan *chan)
 {
 }
 
+static inline void l2cap_chan_no_set_shutdown(struct l2cap_chan *chan)
+{
+}
+
 extern bool disable_ertm;
 
 int l2cap_init_sockets(void);
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 4a542b3..0a2ec84 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -709,6 +709,7 @@ static struct l2cap_ops a2mp_chan_ops = {
 	.ready = l2cap_chan_no_ready,
 	.defer = l2cap_chan_no_defer,
 	.resume = l2cap_chan_no_resume,
+	.set_shutdown = l2cap_chan_no_set_shutdown,
 };
 
 static struct l2cap_chan *a2mp_chan_open(struct l2cap_conn *conn, bool locked)
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 72dd394..5104a88 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3973,7 +3973,6 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn,
 	struct l2cap_disconn_rsp rsp;
 	u16 dcid, scid;
 	struct l2cap_chan *chan;
-	struct sock *sk;
 
 	scid = __le16_to_cpu(req->scid);
 	dcid = __le16_to_cpu(req->dcid);
@@ -3990,15 +3989,11 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn,
 
 	l2cap_chan_lock(chan);
 
-	sk = chan->sk;
-
 	rsp.dcid = cpu_to_le16(chan->scid);
 	rsp.scid = cpu_to_le16(chan->dcid);
 	l2cap_send_cmd(conn, cmd->ident, L2CAP_DISCONN_RSP, sizeof(rsp), &rsp);
 
-	lock_sock(sk);
-	sk->sk_shutdown = SHUTDOWN_MASK;
-	release_sock(sk);
+	chan->ops->set_shutdown(chan);
 
 	l2cap_chan_hold(chan);
 	l2cap_chan_del(chan, ECONNRESET);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index e7b3291..07ef90c 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1159,6 +1159,15 @@ static void l2cap_sock_resume_cb(struct l2cap_chan *chan)
 	release_sock(sk);
 }
 
+static void l2cap_sock_set_shutdown_cb(struct l2cap_chan *chan)
+{
+	struct sock *sk = chan->data;
+
+	lock_sock(sk);
+	sk->sk_shutdown = SHUTDOWN_MASK;
+	release_sock(sk);
+}
+
 static struct l2cap_ops l2cap_chan_ops = {
 	.name		= "L2CAP Socket Interface",
 	.new_connection	= l2cap_sock_new_connection_cb,
@@ -1170,6 +1179,7 @@ static struct l2cap_ops l2cap_chan_ops = {
 	.defer		= l2cap_sock_defer_cb,
 	.alloc_skb	= l2cap_sock_alloc_skb_cb,
 	.resume		= l2cap_sock_resume_cb,
+	.set_shutdown	= l2cap_sock_set_shutdown_cb,
 };
 
 static void l2cap_sock_destruct(struct sock *sk)
-- 
1.8.0.2

