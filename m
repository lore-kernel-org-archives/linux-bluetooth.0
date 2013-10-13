Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: Access RFCOMM session addresses through L2CAP channel
Date: Sun, 13 Oct 2013 09:49:54 -0700
Message-Id: <1381682997-26437-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The L2CAP socket structure does not contain the address information
anymore. They need to be accessed through the L2CAP channel.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/rfcomm/core.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index ca957d3..27e936a 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -641,13 +641,13 @@ static struct rfcomm_session *rfcomm_session_get(bdaddr_t *src, bdaddr_t *dst)
 {
 	struct rfcomm_session *s;
 	struct list_head *p, *n;
-	struct bt_sock *sk;
+	struct l2cap_chan *chan;
 	list_for_each_safe(p, n, &session_list) {
 		s = list_entry(p, struct rfcomm_session, list);
-		sk = bt_sk(s->sock->sk);
+		chan = l2cap_pi(s->sock->sk)->chan;
 
-		if ((!bacmp(src, BDADDR_ANY) || !bacmp(&sk->src, src)) &&
-				!bacmp(&sk->dst, dst))
+		if ((!bacmp(src, BDADDR_ANY) || !bacmp(&chan->src, src)) &&
+		    !bacmp(&chan->dst, dst))
 			return s;
 	}
 	return NULL;
@@ -732,11 +732,11 @@ failed:
 
 void rfcomm_session_getaddr(struct rfcomm_session *s, bdaddr_t *src, bdaddr_t *dst)
 {
-	struct sock *sk = s->sock->sk;
+	struct l2cap_chan *chan = l2cap_pi(s->sock->sk)->chan;
 	if (src)
-		bacpy(src, &bt_sk(sk)->src);
+		bacpy(src, &chan->src);
 	if (dst)
-		bacpy(dst, &bt_sk(sk)->dst);
+		bacpy(dst, &chan->dst);
 }
 
 /* ---- RFCOMM frame sending ---- */
@@ -2112,12 +2112,11 @@ static int rfcomm_dlc_debugfs_show(struct seq_file *f, void *x)
 	rfcomm_lock();
 
 	list_for_each_entry(s, &session_list, list) {
+		struct l2cap_chan *chan = l2cap_pi(s->sock->sk)->chan;
 		struct rfcomm_dlc *d;
 		list_for_each_entry(d, &s->dlcs, list) {
-			struct sock *sk = s->sock->sk;
-
 			seq_printf(f, "%pMR %pMR %ld %d %d %d %d\n",
-				   &bt_sk(sk)->src, &bt_sk(sk)->dst,
+				   &chan->src, &chan->dst,
 				   d->state, d->dlci, d->mtu,
 				   d->rx_credits, d->tx_credits);
 		}
-- 
1.8.3.1

