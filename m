Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org,
	marcel@holtmann.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH] Bluetooth: Remove 'sport' field from l2cap_pinfo
Date: Fri,  9 Jul 2010 15:55:53 -0300
Message-Id: <1278701753-25682-1-git-send-email-gustavo@padovan.org>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo F. Padovan <padovan@profusion.mobi>

'sport' is pointless, is always has the value of l2cap_pinfo.psm, so we
can just use the psm field instead of this one.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    2 --
 net/bluetooth/l2cap.c         |    8 +++-----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 7df70e4..6e4a3a6 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -356,8 +356,6 @@ struct l2cap_pinfo {
 	__u16		remote_mps;
 	__u16		mps;
 
-	__le16		sport;
-
 	struct timer_list	retrans_timer;
 	struct timer_list	monitor_timer;
 	struct timer_list	ack_timer;
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index e366be0..9ca3042 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -727,7 +727,7 @@ static struct sock *__l2cap_get_sock_by_addr(__le16 psm, bdaddr_t *src)
 	struct sock *sk;
 	struct hlist_node *node;
 	sk_for_each(sk, node, &l2cap_sk_list.head)
-		if (l2cap_pi(sk)->sport == psm && !bacmp(&bt_sk(sk)->src, src))
+		if (l2cap_pi(sk)->psm == psm && !bacmp(&bt_sk(sk)->src, src))
 			goto found;
 	sk = NULL;
 found:
@@ -1016,7 +1016,6 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 		/* Save source address */
 		bacpy(&bt_sk(sk)->src, &la.l2_bdaddr);
 		l2cap_pi(sk)->psm   = la.l2_psm;
-		l2cap_pi(sk)->sport = la.l2_psm;
 		sk->sk_state = BT_BOUND;
 
 		if (__le16_to_cpu(la.l2_psm) == 0x0001 ||
@@ -1239,7 +1238,6 @@ static int l2cap_sock_listen(struct socket *sock, int backlog)
 		for (psm = 0x1001; psm < 0x1100; psm += 2)
 			if (!__l2cap_get_sock_by_addr(cpu_to_le16(psm), src)) {
 				l2cap_pi(sk)->psm   = cpu_to_le16(psm);
-				l2cap_pi(sk)->sport = cpu_to_le16(psm);
 				err = 0;
 				break;
 			}
@@ -1325,12 +1323,12 @@ static int l2cap_sock_getname(struct socket *sock, struct sockaddr *addr, int *l
 	addr->sa_family = AF_BLUETOOTH;
 	*len = sizeof(struct sockaddr_l2);
 
+	la->l2_psm = l2cap_pi(sk)->psm;
+
 	if (peer) {
-		la->l2_psm = l2cap_pi(sk)->psm;
 		bacpy(&la->l2_bdaddr, &bt_sk(sk)->dst);
 		la->l2_cid = cpu_to_le16(l2cap_pi(sk)->dcid);
 	} else {
-		la->l2_psm = l2cap_pi(sk)->sport;
 		bacpy(&la->l2_bdaddr, &bt_sk(sk)->src);
 		la->l2_cid = cpu_to_le16(l2cap_pi(sk)->scid);
 	}
-- 
1.7.1
