Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Use l2cap_pi(sk) directly where possible
Date: Sun, 13 Oct 2013 11:36:07 -0700
Message-Id: <1381689367-7104-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There are few places where it makes sense to use l2cap_pi(sk) directly
instead of assigning it to temporary structure.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_sock.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 6262e23..8fe9f49 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -976,13 +976,12 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 
 static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 {
-	int err;
 	struct sock *sk = chan->data;
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	int err;
 
 	lock_sock(sk);
 
-	if (pi->rx_busy_skb) {
+	if (l2cap_pi(sk)->rx_busy_skb) {
 		err = -ENOMEM;
 		goto done;
 	}
@@ -998,9 +997,9 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 	 * acked and reassembled until there is buffer space
 	 * available.
 	 */
-	if (err < 0 && pi->chan->mode == L2CAP_MODE_ERTM) {
-		pi->rx_busy_skb = skb;
-		l2cap_chan_busy(pi->chan, 1);
+	if (err < 0 && chan->mode == L2CAP_MODE_ERTM) {
+		l2cap_pi(sk)->rx_busy_skb = skb;
+		l2cap_chan_busy(chan, 1);
 		err = 0;
 	}
 
@@ -1128,6 +1127,7 @@ static void l2cap_sock_destruct(struct sock *sk)
 
 	if (l2cap_pi(sk)->chan)
 		l2cap_chan_put(l2cap_pi(sk)->chan);
+
 	if (l2cap_pi(sk)->rx_busy_skb) {
 		kfree_skb(l2cap_pi(sk)->rx_busy_skb);
 		l2cap_pi(sk)->rx_busy_skb = NULL;
@@ -1139,8 +1139,7 @@ static void l2cap_sock_destruct(struct sock *sk)
 
 static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 {
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
-	struct l2cap_chan *chan = pi->chan;
+	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 
 	BT_DBG("sk %p", sk);
 
-- 
1.8.3.1

