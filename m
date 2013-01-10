Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 01/16] Bluetooth: Add src and dst info to struct l2cap_chan
Date: Thu, 10 Jan 2013 05:47:38 -0200
Message-Id: <1357804073-31582-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1357804073-31582-1-git-send-email-gustavo@padovan.org>
References: <1357804073-31582-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Adding these two info to l2cap_chan makes the l2cap_core.c a little more
independent of the struct sock.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 include/net/bluetooth/l2cap.h |  3 +++
 net/bluetooth/l2cap_core.c    | 46 ++++++++++++++++++-------------------------
 net/bluetooth/l2cap_sock.c    |  6 +++---
 net/bluetooth/rfcomm/core.c   | 15 +++++++-------
 4 files changed, 33 insertions(+), 37 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index cdd3302..6040743 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -435,6 +435,9 @@ struct l2cap_seq_list {
 struct l2cap_chan {
 	struct sock *sk;
 
+	bdaddr_t	src;
+	bdaddr_t	dst;
+
 	struct l2cap_conn	*conn;
 	struct hci_conn		*hs_hcon;
 	struct hci_chan		*hs_hchan;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 82a3bdc..ae51965 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -148,7 +148,7 @@ static struct l2cap_chan *__l2cap_global_chan_by_addr(__le16 psm, bdaddr_t *src)
 	struct l2cap_chan *c;
 
 	list_for_each_entry(c, &chan_list, global_l) {
-		if (c->sport == psm && !bacmp(&bt_sk(c->sk)->src, src))
+		if (c->sport == psm && !bacmp(&c->src, src))
 			return c;
 	}
 	return NULL;
@@ -1305,7 +1305,6 @@ static struct l2cap_chan *l2cap_global_chan_by_scid(int state, u16 cid,
 	read_lock(&chan_list_lock);
 
 	list_for_each_entry(c, &chan_list, global_l) {
-		struct sock *sk = c->sk;
 
 		if (state && c->state != state)
 			continue;
@@ -1315,16 +1314,16 @@ static struct l2cap_chan *l2cap_global_chan_by_scid(int state, u16 cid,
 			int src_any, dst_any;
 
 			/* Exact match. */
-			src_match = !bacmp(&bt_sk(sk)->src, src);
-			dst_match = !bacmp(&bt_sk(sk)->dst, dst);
+			src_match = !bacmp(&c->src, src);
+			dst_match = !bacmp(&c->dst, dst);
 			if (src_match && dst_match) {
 				read_unlock(&chan_list_lock);
 				return c;
 			}
 
 			/* Closest match */
-			src_any = !bacmp(&bt_sk(sk)->src, BDADDR_ANY);
-			dst_any = !bacmp(&bt_sk(sk)->dst, BDADDR_ANY);
+			src_any = !bacmp(&c->src, BDADDR_ANY);
+			dst_any = !bacmp(&c->dst, BDADDR_ANY);
 			if ((src_match && dst_any) || (src_any && dst_match) ||
 			    (src_any && dst_any))
 				c1 = c;
@@ -1338,7 +1337,7 @@ static struct l2cap_chan *l2cap_global_chan_by_scid(int state, u16 cid,
 
 static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 {
-	struct sock *parent, *sk;
+	struct sock *parent;
 	struct l2cap_chan *chan, *pchan;
 
 	BT_DBG("");
@@ -1357,13 +1356,11 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 	if (!chan)
 		goto clean;
 
-	sk = chan->sk;
-
 	hci_conn_hold(conn->hcon);
 	conn->hcon->disc_timeout = HCI_DISCONN_TIMEOUT;
 
-	bacpy(&bt_sk(sk)->src, conn->src);
-	bacpy(&bt_sk(sk)->dst, conn->dst);
+	bacpy(&chan->src, conn->src);
+	bacpy(&chan->dst, conn->dst);
 
 	l2cap_chan_add(conn, chan);
 
@@ -1572,7 +1569,6 @@ static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm,
 	read_lock(&chan_list_lock);
 
 	list_for_each_entry(c, &chan_list, global_l) {
-		struct sock *sk = c->sk;
 
 		if (state && c->state != state)
 			continue;
@@ -1582,16 +1578,16 @@ static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm,
 			int src_any, dst_any;
 
 			/* Exact match. */
-			src_match = !bacmp(&bt_sk(sk)->src, src);
-			dst_match = !bacmp(&bt_sk(sk)->dst, dst);
+			src_match = !bacmp(&c->src, src);
+			dst_match = !bacmp(&c->dst, dst);
 			if (src_match && dst_match) {
 				read_unlock(&chan_list_lock);
 				return c;
 			}
 
 			/* Closest match */
-			src_any = !bacmp(&bt_sk(sk)->src, BDADDR_ANY);
-			dst_any = !bacmp(&bt_sk(sk)->dst, BDADDR_ANY);
+			src_any = !bacmp(&c->src, BDADDR_ANY);
+			dst_any = !bacmp(&c->dst, BDADDR_ANY);
 			if ((src_match && dst_any) || (src_any && dst_match) ||
 			    (src_any && dst_any))
 				c1 = c;
@@ -1607,7 +1603,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		       bdaddr_t *dst, u8 dst_type)
 {
 	struct sock *sk = chan->sk;
-	bdaddr_t *src = &bt_sk(sk)->src;
+	bdaddr_t *src = &chan->src;
 	struct l2cap_conn *conn;
 	struct hci_conn *hcon;
 	struct hci_dev *hdev;
@@ -1674,9 +1670,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 	}
 
 	/* Set destination address and psm */
-	lock_sock(sk);
-	bacpy(&bt_sk(sk)->dst, dst);
-	release_sock(sk);
+	bacpy(&chan->dst, dst);
 
 	chan->psm = psm;
 	chan->dcid = cid;
@@ -3637,8 +3631,8 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 
 	hci_conn_hold(conn->hcon);
 
-	bacpy(&bt_sk(sk)->src, conn->src);
-	bacpy(&bt_sk(sk)->dst, conn->dst);
+	bacpy(&chan->src, conn->src);
+	bacpy(&chan->dst, conn->dst);
 	chan->psm  = psm;
 	chan->dcid = scid;
 	chan->local_amp_id = amp_id;
@@ -6274,17 +6268,16 @@ int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr)
 	/* Find listening sockets and check their link_mode */
 	read_lock(&chan_list_lock);
 	list_for_each_entry(c, &chan_list, global_l) {
-		struct sock *sk = c->sk;
 
 		if (c->state != BT_LISTEN)
 			continue;
 
-		if (!bacmp(&bt_sk(sk)->src, &hdev->bdaddr)) {
+		if (!bacmp(&c->src, &hdev->bdaddr)) {
 			lm1 |= HCI_LM_ACCEPT;
 			if (test_bit(FLAG_ROLE_SWITCH, &c->flags))
 				lm1 |= HCI_LM_MASTER;
 			exact++;
-		} else if (!bacmp(&bt_sk(sk)->src, BDADDR_ANY)) {
+		} else if (!bacmp(&c->src, BDADDR_ANY)) {
 			lm2 |= HCI_LM_ACCEPT;
 			if (test_bit(FLAG_ROLE_SWITCH, &c->flags))
 				lm2 |= HCI_LM_MASTER;
@@ -6568,10 +6561,9 @@ static int l2cap_debugfs_show(struct seq_file *f, void *p)
 	read_lock(&chan_list_lock);
 
 	list_for_each_entry(c, &chan_list, global_l) {
-		struct sock *sk = c->sk;
 
 		seq_printf(f, "%pMR %pMR %d %d 0x%4.4x 0x%4.4x %d %d %d %d\n",
-			   &bt_sk(sk)->src, &bt_sk(sk)->dst,
+			   &c->src, &c->dst,
 			   c->state, __le16_to_cpu(c->psm),
 			   c->scid, c->dcid, c->imtu, c->omtu,
 			   c->sec_level, c->mode);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 1bcfb84..0977966 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -97,7 +97,7 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 	    __le16_to_cpu(la.l2_psm) == L2CAP_PSM_RFCOMM)
 		chan->sec_level = BT_SECURITY_SDP;
 
-	bacpy(&bt_sk(sk)->src, &la.l2_bdaddr);
+	bacpy(&chan->src, &la.l2_bdaddr);
 
 	chan->state = BT_BOUND;
 	sk->sk_state = BT_BOUND;
@@ -259,11 +259,11 @@ static int l2cap_sock_getname(struct socket *sock, struct sockaddr *addr,
 
 	if (peer) {
 		la->l2_psm = chan->psm;
-		bacpy(&la->l2_bdaddr, &bt_sk(sk)->dst);
+		bacpy(&la->l2_bdaddr, &chan->dst);
 		la->l2_cid = cpu_to_le16(chan->dcid);
 	} else {
 		la->l2_psm = chan->sport;
-		bacpy(&la->l2_bdaddr, &bt_sk(sk)->src);
+		bacpy(&la->l2_bdaddr, &chan->src);
 		la->l2_cid = cpu_to_le16(chan->scid);
 	}
 
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 201fdf7..15dc078 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -632,13 +632,13 @@ static struct rfcomm_session *rfcomm_session_get(bdaddr_t *src, bdaddr_t *dst)
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
+				!bacmp(&chan->dst, dst))
 			return s;
 	}
 	return NULL;
@@ -727,9 +727,9 @@ void rfcomm_session_getaddr(struct rfcomm_session *s, bdaddr_t *src, bdaddr_t *d
 {
 	struct sock *sk = s->sock->sk;
 	if (src)
-		bacpy(src, &bt_sk(sk)->src);
+		bacpy(src, &l2cap_pi(sk)->chan->src);
 	if (dst)
-		bacpy(dst, &bt_sk(sk)->dst);
+		bacpy(dst, &l2cap_pi(sk)->chan->dst);
 }
 
 /* ---- RFCOMM frame sending ---- */
@@ -2126,7 +2126,8 @@ static int rfcomm_dlc_debugfs_show(struct seq_file *f, void *x)
 			struct sock *sk = s->sock->sk;
 
 			seq_printf(f, "%pMR %pMR %ld %d %d %d %d\n",
-				   &bt_sk(sk)->src, &bt_sk(sk)->dst,
+				   &l2cap_pi(sk)->chan->src,
+				   &l2cap_pi(sk)->chan->dst,
 				   d->state, d->dlci, d->mtu,
 				   d->rx_credits, d->tx_credits);
 		}
-- 
1.8.0.2

