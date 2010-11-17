Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Get ride of __l2cap_get_sock_by_psm()
Date: Wed, 17 Nov 2010 21:22:55 -0200
Message-Id: <1290036176-4022-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

l2cap_get_sock_by_psm() was the only user of this function, so I merged
both into l2cap_get_sock_by_psm(). The socket lock now should be hold
outside of l2cap_get_sock_by_psm() once we hold and release it inside the
same function now.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap.c |   22 +++++++++-------------
 1 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 18a802c..12b4aa2 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -751,11 +751,13 @@ found:
 /* Find socket with psm and source bdaddr.
  * Returns closest match.
  */
-static struct sock *__l2cap_get_sock_by_psm(int state, __le16 psm, bdaddr_t *src)
+static struct sock *l2cap_get_sock_by_psm(int state, __le16 psm, bdaddr_t *src)
 {
 	struct sock *sk = NULL, *sk1 = NULL;
 	struct hlist_node *node;
 
+	read_lock(&l2cap_sk_list.lock);
+
 	sk_for_each(sk, node, &l2cap_sk_list.head) {
 		if (state && sk->sk_state != state)
 			continue;
@@ -770,20 +772,10 @@ static struct sock *__l2cap_get_sock_by_psm(int state, __le16 psm, bdaddr_t *src
 				sk1 = sk;
 		}
 	}
-	return node ? sk : sk1;
-}
 
-/* Find socket with given address (psm, src).
- * Returns locked socket */
-static inline struct sock *l2cap_get_sock_by_psm(int state, __le16 psm, bdaddr_t *src)
-{
-	struct sock *s;
-	read_lock(&l2cap_sk_list.lock);
-	s = __l2cap_get_sock_by_psm(state, psm, src);
-	if (s)
-		bh_lock_sock(s);
 	read_unlock(&l2cap_sk_list.lock);
-	return s;
+
+	return node ? sk : sk1;
 }
 
 static void l2cap_sock_destruct(struct sock *sk)
@@ -2934,6 +2926,8 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 		goto sendresp;
 	}
 
+	bh_lock_sock(parent);
+
 	/* Check if the ACL is secure enough (if not SDP) */
 	if (psm != cpu_to_le16(0x0001) &&
 				!hci_conn_check_link_mode(conn->hcon)) {
@@ -4464,6 +4458,8 @@ static inline int l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm, str
 	if (!sk)
 		goto drop;
 
+	bh_lock_sock(sk);
+
 	BT_DBG("sk %p, len %d", sk, skb->len);
 
 	if (sk->sk_state != BT_BOUND && sk->sk_state != BT_CONNECTED)
-- 
1.7.3.1

