Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Get ride of __rfcomm_get_sock_by_channel()
Date: Wed, 17 Nov 2010 21:22:56 -0200
Message-Id: <1290036176-4022-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1290036176-4022-1-git-send-email-padovan@profusion.mobi>
References: <1290036176-4022-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

rfcomm_get_sock_by_channel() was the only user of this function, so I merged
both into rfcomm_get_sock_by_channel(). The socket lock now should be hold
outside of rfcomm_get_sock_by_channel() once we hold and release it inside the
same function now.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/rfcomm/sock.c |   19 +++++++------------
 1 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index aec505f..0207bd6 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -140,11 +140,13 @@ static struct sock *__rfcomm_get_sock_by_addr(u8 channel, bdaddr_t *src)
 /* Find socket with channel and source bdaddr.
  * Returns closest match.
  */
-static struct sock *__rfcomm_get_sock_by_channel(int state, u8 channel, bdaddr_t *src)
+static struct sock *rfcomm_get_sock_by_channel(int state, u8 channel, bdaddr_t *src)
 {
 	struct sock *sk = NULL, *sk1 = NULL;
 	struct hlist_node *node;
 
+	read_lock(&rfcomm_sk_list.lock);
+
 	sk_for_each(sk, node, &rfcomm_sk_list.head) {
 		if (state && sk->sk_state != state)
 			continue;
@@ -159,19 +161,10 @@ static struct sock *__rfcomm_get_sock_by_channel(int state, u8 channel, bdaddr_t
 				sk1 = sk;
 		}
 	}
-	return node ? sk : sk1;
-}
 
-/* Find socket with given address (channel, src).
- * Returns locked socket */
-static inline struct sock *rfcomm_get_sock_by_channel(int state, u8 channel, bdaddr_t *src)
-{
-	struct sock *s;
-	read_lock(&rfcomm_sk_list.lock);
-	s = __rfcomm_get_sock_by_channel(state, channel, src);
-	if (s) bh_lock_sock(s);
 	read_unlock(&rfcomm_sk_list.lock);
-	return s;
+
+	return node ? sk : sk1;
 }
 
 static void rfcomm_sock_destruct(struct sock *sk)
@@ -945,6 +938,8 @@ int rfcomm_connect_ind(struct rfcomm_session *s, u8 channel, struct rfcomm_dlc *
 	if (!parent)
 		return 0;
 
+	bh_lock_sock(parent);
+
 	/* Check for backlog size */
 	if (sk_acceptq_is_full(parent)) {
 		BT_DBG("backlog full %d", parent->sk_ack_backlog);
-- 
1.7.3.1

