Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 3/7] Bluetooth: Access sk_sndtimeo indirectly in l2cap_core.c
Date: Tue, 15 Oct 2013 19:24:47 -0300
Message-Id: <1381875891-27953-3-git-send-email-gustavo@padovan.org>
In-Reply-To: <1381875891-27953-1-git-send-email-gustavo@padovan.org>
References: <1381875891-27953-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

As part of the work to remove struct sock from l2cap_core.c and make it
more generic we remove in this commit the direct access to sk->sk_sndtimeo
member. This objective of this change is purely remove sk usage from
l2cap_core.c

Now we have a new l2cap ops to get the current value of sk->sndtimeo. A
l2cap_chan_no_get_sndtimeo was added for users of L2CAP that doesn't need
to set a timeout.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 include/net/bluetooth/l2cap.h | 6 ++++++
 net/bluetooth/a2mp.c          | 1 +
 net/bluetooth/l2cap_core.c    | 8 +++-----
 net/bluetooth/l2cap_sock.c    | 8 ++++++++
 4 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 4ec86ce..9c6be72 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -555,6 +555,7 @@ struct l2cap_ops {
 	void			(*ready) (struct l2cap_chan *chan);
 	void			(*defer) (struct l2cap_chan *chan);
 	void			(*resume) (struct l2cap_chan *chan);
+	long			(*get_sndtimeo) (struct l2cap_chan *chan);
 	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
 					       unsigned long len, int nb);
 };
@@ -795,6 +796,11 @@ static inline void l2cap_chan_no_defer(struct l2cap_chan *chan)
 {
 }
 
+static inline long l2cap_chan_no_get_sndtimeo(struct l2cap_chan *chan)
+{
+	return 0;
+}
+
 extern bool disable_ertm;
 
 int l2cap_init_sockets(void);
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 6b8cc23..1e99210 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -710,6 +710,7 @@ static struct l2cap_ops a2mp_chan_ops = {
 	.teardown = l2cap_chan_no_teardown,
 	.ready = l2cap_chan_no_ready,
 	.defer = l2cap_chan_no_defer,
+	.get_sndtimeo = l2cap_chan_no_get_sndtimeo,
 };
 
 static struct l2cap_chan *a2mp_chan_open(struct l2cap_conn *conn, bool locked)
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f4e02b4..c6334fc 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -649,8 +649,7 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 	case BT_CONFIG:
 		if (chan->chan_type == L2CAP_CHAN_CONN_ORIENTED &&
 		    conn->hcon->type == ACL_LINK) {
-			struct sock *sk = chan->sk;
-			__set_chan_timer(chan, sk->sk_sndtimeo);
+			__set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
 			l2cap_send_disconn_req(chan, reason);
 		} else
 			l2cap_chan_del(chan, reason);
@@ -1764,7 +1763,6 @@ static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm,
 int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		       bdaddr_t *dst, u8 dst_type)
 {
-	struct sock *sk = chan->sk;
 	struct l2cap_conn *conn;
 	struct hci_conn *hcon;
 	struct hci_dev *hdev;
@@ -1876,7 +1874,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 	hci_conn_drop(hcon);
 
 	l2cap_state_change(chan, BT_CONNECT);
-	__set_chan_timer(chan, sk->sk_sndtimeo);
+	__set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
 
 	if (hcon->state == BT_CONNECTED) {
 		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
@@ -3817,7 +3815,7 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 
 	dcid = chan->scid;
 
-	__set_chan_timer(chan, sk->sk_sndtimeo);
+	__set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
 
 	chan->ident = cmd->ident;
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 0de8a30..ffa78d3 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1136,6 +1136,13 @@ static void l2cap_sock_resume_cb(struct l2cap_chan *chan)
 	sk->sk_state_change(sk);
 }
 
+static long l2cap_sock_get_sndtimeo_cb(struct l2cap_chan *chan)
+{
+	struct sock *sk = chan->data;
+
+	return sk->sk_sndtimeo;
+}
+
 static struct l2cap_ops l2cap_chan_ops = {
 	.name		= "L2CAP Socket Interface",
 	.new_connection	= l2cap_sock_new_connection_cb,
@@ -1146,6 +1153,7 @@ static struct l2cap_ops l2cap_chan_ops = {
 	.ready		= l2cap_sock_ready_cb,
 	.defer		= l2cap_sock_defer_cb,
 	.resume		= l2cap_sock_resume_cb,
+	.get_sndtimeo	= l2cap_sock_get_sndtimeo_cb,
 	.alloc_skb	= l2cap_sock_alloc_skb_cb,
 };
 
-- 
1.8.3.1

