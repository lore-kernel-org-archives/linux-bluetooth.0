Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 4/7] Bluetooth: Add chan->ops->set_shutdown()
Date: Tue, 15 Oct 2013 19:24:48 -0300
Message-Id: <1381875891-27953-4-git-send-email-gustavo@padovan.org>
In-Reply-To: <1381875891-27953-1-git-send-email-gustavo@padovan.org>
References: <1381875891-27953-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

We need to remove all direct access of struct sock from L2CAP core.
This change is pretty simple and just add a new L2CAP channel callback to
do the work in the L2CAP socket side.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 include/net/bluetooth/l2cap.h |  5 +++++
 net/bluetooth/a2mp.c          |  1 +
 net/bluetooth/l2cap_core.c    |  7 +------
 net/bluetooth/l2cap_sock.c    | 10 ++++++++++
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 9c6be72..ae3a99b 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -555,6 +555,7 @@ struct l2cap_ops {
 	void			(*ready) (struct l2cap_chan *chan);
 	void			(*defer) (struct l2cap_chan *chan);
 	void			(*resume) (struct l2cap_chan *chan);
+	void			(*set_shutdown) (struct l2cap_chan *chan);
 	long			(*get_sndtimeo) (struct l2cap_chan *chan);
 	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
 					       unsigned long len, int nb);
@@ -796,6 +797,10 @@ static inline void l2cap_chan_no_defer(struct l2cap_chan *chan)
 {
 }
 
+static inline void l2cap_chan_no_set_shutdown(struct l2cap_chan *chan)
+{
+}
+
 static inline long l2cap_chan_no_get_sndtimeo(struct l2cap_chan *chan)
 {
 	return 0;
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 1e99210..74c1477 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -710,6 +710,7 @@ static struct l2cap_ops a2mp_chan_ops = {
 	.teardown = l2cap_chan_no_teardown,
 	.ready = l2cap_chan_no_ready,
 	.defer = l2cap_chan_no_defer,
+	.set_shutdown = l2cap_chan_no_set_shutdown,
 	.get_sndtimeo = l2cap_chan_no_get_sndtimeo,
 };
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c6334fc..634781a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4241,7 +4241,6 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn,
 	struct l2cap_disconn_rsp rsp;
 	u16 dcid, scid;
 	struct l2cap_chan *chan;
-	struct sock *sk;
 
 	if (cmd_len != sizeof(*req))
 		return -EPROTO;
@@ -4261,15 +4260,11 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn,
 
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
index ffa78d3..301f25b 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1136,6 +1136,15 @@ static void l2cap_sock_resume_cb(struct l2cap_chan *chan)
 	sk->sk_state_change(sk);
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
 static long l2cap_sock_get_sndtimeo_cb(struct l2cap_chan *chan)
 {
 	struct sock *sk = chan->data;
@@ -1153,6 +1162,7 @@ static struct l2cap_ops l2cap_chan_ops = {
 	.ready		= l2cap_sock_ready_cb,
 	.defer		= l2cap_sock_defer_cb,
 	.resume		= l2cap_sock_resume_cb,
+	.set_shutdown	= l2cap_sock_set_shutdown_cb,
 	.get_sndtimeo	= l2cap_sock_get_sndtimeo_cb,
 	.alloc_skb	= l2cap_sock_alloc_skb_cb,
 };
-- 
1.8.3.1

