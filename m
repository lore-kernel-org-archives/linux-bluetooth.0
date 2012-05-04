Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Cc: pkrystad@codeaurora.org
Subject: [PATCHv2 2/2] Bluetooth: Lock the L2CAP channel when sending
Date: Fri,  4 May 2012 14:20:31 -0700
Message-Id: <1336166431-4926-3-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1336166431-4926-1-git-send-email-mathewm@codeaurora.org>
References: <1336166431-4926-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The ERTM and streaming mode transmit queue must only be accessed while
the L2CAP channel lock is held.  Locking the channel before calling
l2cap_chan_send ensures that multiple threads cannot simultaneously
manipulate the queue when sending and receiving concurrently.

L2CAP channel locking had previously moved to the l2cap_chan struct
instead of the associated socket, so some of the old socket locking
can also be removed in this patch.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 include/net/bluetooth/bluetooth.h |    2 --
 net/bluetooth/l2cap_sock.c        |   19 +++++++++++--------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 262ebd1..b286f0a 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -242,12 +242,10 @@ static inline struct sk_buff *bt_skb_send_alloc(struct sock *sk,
 {
 	struct sk_buff *skb;
 
-	release_sock(sk);
 	if ((skb = sock_alloc_send_skb(sk, len + BT_SKB_RESERVE, nb, err))) {
 		skb_reserve(skb, BT_SKB_RESERVE);
 		bt_cb(skb)->incoming  = 0;
 	}
-	lock_sock(sk);
 
 	if (!skb && *err)
 		return NULL;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 29122ed..757ddb3 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -712,16 +712,13 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 	if (msg->msg_flags & MSG_OOB)
 		return -EOPNOTSUPP;
 
-	lock_sock(sk);
-
-	if (sk->sk_state != BT_CONNECTED) {
-		release_sock(sk);
+	if (sk->sk_state != BT_CONNECTED)
 		return -ENOTCONN;
-	}
 
+	l2cap_chan_lock(chan);
 	err = l2cap_chan_send(chan, msg, len, sk->sk_priority);
+	l2cap_chan_unlock(chan);
 
-	release_sock(sk);
 	return err;
 }
 
@@ -930,9 +927,15 @@ static struct sk_buff *l2cap_sock_alloc_skb_cb(struct l2cap_chan *chan,
 					       unsigned long len, int nb,
 					       int *err)
 {
-	struct sock *sk = chan->sk;
+	struct sk_buff *skb;
 
-	return bt_skb_send_alloc(sk, len, nb, err);
+	l2cap_chan_unlock(chan);
+
+	skb = bt_skb_send_alloc(chan->sk, len, nb, err);
+
+	l2cap_chan_lock(chan);
+
+	return skb;
 }
 
 static struct l2cap_ops l2cap_chan_ops = {
-- 
1.7.10

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
