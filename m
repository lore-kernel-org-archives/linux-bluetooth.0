Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	marcel@holtmann.org
Cc: pkrystad@codeaurora.org, andrei.emeltchenko.news@gmail.com
Subject: [RFCv2 3/8] Bluetooth: Make better use of l2cap_chan reference counting
Date: Fri, 27 Apr 2012 16:50:50 -0700
Message-Id: <1335570655-30878-4-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1335570655-30878-1-git-send-email-mathewm@codeaurora.org>
References: <1335570655-30878-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

L2CAP sockets contain a pointer to l2cap_chan that needs to be
reference counted in order to prevent a possible dangling pointer when
the channel is freed.

There were a few other cases where an l2cap_chan pointer on the stack
was dereferenced after a call to l2cap_chan_del. Those pointers are
also now reference counted.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |    6 ++++++
 net/bluetooth/l2cap_sock.c |    3 +++
 2 files changed, 9 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c3d3cfc..5963cd2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1257,6 +1257,7 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 
 	/* Kill channels */
 	list_for_each_entry_safe(chan, l, &conn->chan_l, list) {
+		l2cap_chan_hold(chan);
 		l2cap_chan_lock(chan);
 
 		l2cap_chan_del(chan, err);
@@ -1264,6 +1265,7 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 		l2cap_chan_unlock(chan);
 
 		chan->ops->close(chan->data);
+		l2cap_chan_put(chan);
 	}
 
 	mutex_unlock(&conn->chan_lock);
@@ -3376,11 +3378,13 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
 	sk->sk_shutdown = SHUTDOWN_MASK;
 	release_sock(sk);
 
+	l2cap_chan_hold(chan);
 	l2cap_chan_del(chan, ECONNRESET);
 
 	l2cap_chan_unlock(chan);
 
 	chan->ops->close(chan->data);
+	l2cap_chan_put(chan);
 
 	mutex_unlock(&conn->chan_lock);
 
@@ -3408,11 +3412,13 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn, struct l2cap_cmd
 
 	l2cap_chan_lock(chan);
 
+	l2cap_chan_hold(chan);
 	l2cap_chan_del(chan, 0);
 
 	l2cap_chan_unlock(chan);
 
 	chan->ops->close(chan->data);
+	l2cap_chan_put(chan);
 
 	mutex_unlock(&conn->chan_lock);
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 0f30785..82b6368 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -956,6 +956,7 @@ static void l2cap_sock_destruct(struct sock *sk)
 {
 	BT_DBG("sk %p", sk);
 
+	l2cap_chan_put(l2cap_pi(sk)->chan);
 	if (l2cap_pi(sk)->rx_busy_skb) {
 		kfree_skb(l2cap_pi(sk)->rx_busy_skb);
 		l2cap_pi(sk)->rx_busy_skb = NULL;
@@ -1057,6 +1058,8 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock, int p
 		return NULL;
 	}
 
+	l2cap_chan_hold(chan);
+
 	chan->sk = sk;
 
 	l2cap_pi(sk)->chan = chan;
-- 
1.7.10

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
