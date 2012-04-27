Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0] Bluetooth: Change locking logic in sock send
Date: Fri, 27 Apr 2012 16:40:06 +0300
Message-Id: <1335534006-1216-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <alpine.DEB.2.02.1204261647490.13179@mathewm-linux>
References: <alpine.DEB.2.02.1204261647490.13179@mathewm-linux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use chan_lock instead of lock_sock when sending L2CAP pkts.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/bluetooth.h |    2 --
 net/bluetooth/l2cap_sock.c        |    8 ++++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 2fb268f..90678a9 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -256,12 +256,10 @@ static inline struct sk_buff *bt_skb_send_alloc(struct sock *sk,
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
index 0f30785..e622072 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -716,16 +716,16 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 	if (msg->msg_flags & MSG_OOB)
 		return -EOPNOTSUPP;
 
-	lock_sock(sk);
-
 	if (sk->sk_state != BT_CONNECTED) {
-		release_sock(sk);
 		return -ENOTCONN;
 	}
 
+	l2cap_chan_lock(chan);
+
 	err = l2cap_chan_send(chan, msg, len, sk->sk_priority);
 
-	release_sock(sk);
+	l2cap_chan_unlock(chan);
+
 	return err;
 }
 
-- 
1.7.9.5

