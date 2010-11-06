Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/6] Bluetooth: Hold the lock inside rfcomm_get_sock_by_addr()
Date: Sat,  6 Nov 2010 17:44:48 -0400
Message-Id: <1289079891-4795-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1289079891-4795-2-git-send-email-padovan@profusion.mobi>
References: <1289079891-4795-1-git-send-email-padovan@profusion.mobi>
 <1289079891-4795-2-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It also have to change the name of the function to
rfcomm_get_sock_by_addr() because we do hold the lock inside it now.
rfcomm_get_sock_by_addr() just read data, so the lock now is
read_lock_bh().

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/rfcomm/sock.c |   16 +++++-----------
 1 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index aec505f..5a061d3 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -123,16 +123,18 @@ static void rfcomm_sk_state_change(struct rfcomm_dlc *d, int err)
 }
 
 /* ---- Socket functions ---- */
-static struct sock *__rfcomm_get_sock_by_addr(u8 channel, bdaddr_t *src)
+static struct sock *rfcomm_get_sock_by_addr(u8 channel, bdaddr_t *src)
 {
 	struct sock *sk = NULL;
 	struct hlist_node *node;
 
+	read_lock_bh(&rfcomm_sk_list.lock);
 	sk_for_each(sk, node, &rfcomm_sk_list.head) {
 		if (rfcomm_pi(sk)->channel == channel &&
 				!bacmp(&bt_sk(sk)->src, src))
 			break;
 	}
+	read_unlock_bh(&rfcomm_sk_list.lock);
 
 	return node ? sk : NULL;
 }
@@ -374,9 +376,7 @@ static int rfcomm_sock_bind(struct socket *sock, struct sockaddr *addr, int addr
 		goto done;
 	}
 
-	write_lock_bh(&rfcomm_sk_list.lock);
-
-	if (sa->rc_channel && __rfcomm_get_sock_by_addr(sa->rc_channel, &sa->rc_bdaddr)) {
+	if (sa->rc_channel && rfcomm_get_sock_by_addr(sa->rc_channel, &sa->rc_bdaddr)) {
 		err = -EADDRINUSE;
 	} else {
 		/* Save source address */
@@ -385,8 +385,6 @@ static int rfcomm_sock_bind(struct socket *sock, struct sockaddr *addr, int addr
 		sk->sk_state = BT_BOUND;
 	}
 
-	write_unlock_bh(&rfcomm_sk_list.lock);
-
 done:
 	release_sock(sk);
 	return err;
@@ -459,17 +457,13 @@ static int rfcomm_sock_listen(struct socket *sock, int backlog)
 
 		err = -EINVAL;
 
-		write_lock_bh(&rfcomm_sk_list.lock);
-
 		for (channel = 1; channel < 31; channel++)
-			if (!__rfcomm_get_sock_by_addr(channel, src)) {
+			if (!rfcomm_get_sock_by_addr(channel, src)) {
 				rfcomm_pi(sk)->channel = channel;
 				err = 0;
 				break;
 			}
 
-		write_unlock_bh(&rfcomm_sk_list.lock);
-
 		if (err < 0)
 			goto done;
 	}
-- 
1.7.3.1

