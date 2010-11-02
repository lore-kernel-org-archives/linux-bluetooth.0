Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/7] Bluetooth: Get ride of __l2cap_get_sock_by_psm()
Date: Tue,  2 Nov 2010 15:03:15 +0000
Message-Id: <1288710198-6108-4-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1288710198-6108-3-git-send-email-padovan@profusion.mobi>
References: <1288710198-6108-1-git-send-email-padovan@profusion.mobi>
 <1288710198-6108-2-git-send-email-padovan@profusion.mobi>
 <1288710198-6108-3-git-send-email-padovan@profusion.mobi>
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
index 3d48867..27199bc 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -746,11 +746,13 @@ found:
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
@@ -765,20 +767,10 @@ static struct sock *__l2cap_get_sock_by_psm(int state, __le16 psm, bdaddr_t *src
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
@@ -2921,6 +2913,8 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 		goto sendresp;
 	}
 
+	bh_lock_sock(parent);
+
 	/* Check if the ACL is secure enough (if not SDP) */
 	if (psm != cpu_to_le16(0x0001) &&
 				!hci_conn_check_link_mode(conn->hcon)) {
@@ -4425,6 +4419,8 @@ static inline int l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm, str
 	if (!sk)
 		goto drop;
 
+	bh_lock_sock(sk);
+
 	BT_DBG("sk %p, len %d", sk, skb->len);
 
 	if (sk->sk_state != BT_BOUND && sk->sk_state != BT_CONNECTED)
-- 
1.7.3.1

