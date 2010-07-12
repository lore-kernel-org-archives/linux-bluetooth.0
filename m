Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtman.org, "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 1/2] Bluetooth: Add Fixed Channels support to bind syscall.
Date: Mon, 12 Jul 2010 18:19:04 -0300
Message-Id: <1278969545-26864-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo F. Padovan <padovan@profusion.mobi>

L2CAP nows support bind to a fixed channel, this is needed for Low Energy
and AMP.
bind returns error if you pass both PSM and CID values.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap.c |   48 +++++++++++++++++++++++++++++++++++-------------
 1 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 449cbdd..39f047b 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -726,7 +726,7 @@ static inline void l2cap_chan_add(struct l2cap_conn *conn, struct sock *sk, stru
 }
 
 /* ---- Socket interface ---- */
-static struct sock *__l2cap_get_sock_by_addr(__le16 psm, bdaddr_t *src)
+static struct sock *__l2cap_sock_by_psm_addr(__le16 psm, bdaddr_t *src)
 {
 	struct sock *sk;
 	struct hlist_node *node;
@@ -738,6 +738,16 @@ found:
 	return sk;
 }
 
+static struct sock *__l2cap_sock_by_cid_addr(__le16 cid, bdaddr_t *src)
+{
+	struct sock *sk;
+	struct hlist_node *node;
+	sk_for_each(sk, node, &l2cap_sk_list.head)
+		if (l2cap_pi(sk)->scid == cid && !bacmp(&bt_sk(sk)->src, src))
+			return sk;
+	return NULL;
+}
+
 /* Find socket with psm and source bdaddr.
  * Returns closest match.
  */
@@ -996,7 +1006,7 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 	len = min_t(unsigned int, sizeof(la), alen);
 	memcpy(&la, addr, len);
 
-	if (la.l2_cid)
+	if (la.l2_cid && la.l2_psm)
 		return -EINVAL;
 
 	lock_sock(sk);
@@ -1014,18 +1024,30 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 
 	write_lock_bh(&l2cap_sk_list.lock);
 
-	if (la.l2_psm && __l2cap_get_sock_by_addr(la.l2_psm, &la.l2_bdaddr)) {
-		err = -EADDRINUSE;
-	} else {
-		/* Save source address */
-		bacpy(&bt_sk(sk)->src, &la.l2_bdaddr);
-		l2cap_pi(sk)->psm   = la.l2_psm;
-		l2cap_pi(sk)->sport = la.l2_psm;
-		sk->sk_state = BT_BOUND;
+	if (la.l2_psm) {
+		if (__l2cap_sock_by_psm_addr(la.l2_psm, &la.l2_bdaddr)) {
+			err = -EADDRINUSE;
+		} else {
+			/* Save source address */
+			bacpy(&bt_sk(sk)->src, &la.l2_bdaddr);
+			l2cap_pi(sk)->psm   = la.l2_psm;
+			l2cap_pi(sk)->sport = la.l2_psm;
+			sk->sk_state = BT_BOUND;
 
-		if (__le16_to_cpu(la.l2_psm) == 0x0001 ||
+			if (__le16_to_cpu(la.l2_psm) == 0x0001 ||
 					__le16_to_cpu(la.l2_psm) == 0x0003)
-			l2cap_pi(sk)->sec_level = BT_SECURITY_SDP;
+				l2cap_pi(sk)->sec_level = BT_SECURITY_SDP;
+		}
+	} else if (la.l2_cid) {
+		/* Save source address */
+		if (__l2cap_sock_by_cid_addr(la.l2_cid, &la.l2_bdaddr)) {
+			err = -EADDRINUSE;
+		} else {
+			bacpy(&bt_sk(sk)->src, &la.l2_bdaddr);
+			l2cap_pi(sk)->scid  = la.l2_cid;
+			l2cap_pi(sk)->sport = la.l2_cid;
+			sk->sk_state = BT_BOUND;
+		}
 	}
 
 	write_unlock_bh(&l2cap_sk_list.lock);
@@ -1241,7 +1263,7 @@ static int l2cap_sock_listen(struct socket *sock, int backlog)
 		write_lock_bh(&l2cap_sk_list.lock);
 
 		for (psm = 0x1001; psm < 0x1100; psm += 2)
-			if (!__l2cap_get_sock_by_addr(cpu_to_le16(psm), src)) {
+			if (!__l2cap_sock_by_psm_addr(cpu_to_le16(psm), src)) {
 				l2cap_pi(sk)->psm   = cpu_to_le16(psm);
 				l2cap_pi(sk)->sport = cpu_to_le16(psm);
 				err = 0;
-- 
1.7.1

