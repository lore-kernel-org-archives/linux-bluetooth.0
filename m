Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [RFC 16/16] Bluetooth: Remove sk member from struct l2cap_chan
Date: Wed, 12 Dec 2012 02:13:44 -0200
Message-Id: <1355285624-25811-17-git-send-email-gustavo@padovan.org>
In-Reply-To: <1355285624-25811-1-git-send-email-gustavo@padovan.org>
References: <1355285624-25811-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Now that the removal of socket usage from l2cap_core.c is done we can
remove sk from struct l2cap_chan since we do not use it anywhere anymore.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 include/net/bluetooth/l2cap.h | 2 --
 net/bluetooth/l2cap_sock.c    | 5 ++---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index b6bfbbd..2d18bcb 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -433,8 +433,6 @@ struct l2cap_seq_list {
 #define L2CAP_SEQ_LIST_TAIL	0x8000
 
 struct l2cap_chan {
-	struct sock *sk;
-
 	bdaddr_t	src;
 	bdaddr_t	dst;
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 1f80b9b..82b7d0a 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1100,11 +1100,12 @@ static void l2cap_sock_state_change_cb(struct l2cap_chan *chan, int state, int e
 static struct sk_buff *l2cap_sock_alloc_skb_cb(struct l2cap_chan *chan,
 					       unsigned long len, int nb)
 {
+	struct sock *sk = chan->data;
 	struct sk_buff *skb;
 	int err;
 
 	l2cap_chan_unlock(chan);
-	skb = bt_skb_send_alloc(chan->sk, len, nb, &err);
+	skb = bt_skb_send_alloc(sk, len, nb, &err);
 	l2cap_chan_lock(chan);
 
 	if (!skb)
@@ -1292,8 +1293,6 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 
 	l2cap_chan_hold(chan);
 
-	chan->sk = sk;
-
 	l2cap_pi(sk)->chan = chan;
 
 	return sk;
-- 
1.7.11.7

