Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 1/5] Bluetooth: Fix context in rfcomm_sock_lock
Date: Tue, 27 Dec 2011 15:28:44 -0200
Message-Id: <1325006928-3338-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

Code now run in process context, does not need to disable interrupt
anymore.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/rfcomm/sock.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index aea2bdd..f066678 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -370,7 +370,7 @@ static int rfcomm_sock_bind(struct socket *sock, struct sockaddr *addr, int addr
 		goto done;
 	}
 
-	write_lock_bh(&rfcomm_sk_list.lock);
+	write_lock(&rfcomm_sk_list.lock);
 
 	if (sa->rc_channel && __rfcomm_get_sock_by_addr(sa->rc_channel, &sa->rc_bdaddr)) {
 		err = -EADDRINUSE;
@@ -381,7 +381,7 @@ static int rfcomm_sock_bind(struct socket *sock, struct sockaddr *addr, int addr
 		sk->sk_state = BT_BOUND;
 	}
 
-	write_unlock_bh(&rfcomm_sk_list.lock);
+	write_unlock(&rfcomm_sk_list.lock);
 
 done:
 	release_sock(sk);
@@ -455,7 +455,7 @@ static int rfcomm_sock_listen(struct socket *sock, int backlog)
 
 		err = -EINVAL;
 
-		write_lock_bh(&rfcomm_sk_list.lock);
+		write_lock(&rfcomm_sk_list.lock);
 
 		for (channel = 1; channel < 31; channel++)
 			if (!__rfcomm_get_sock_by_addr(channel, src)) {
@@ -464,7 +464,7 @@ static int rfcomm_sock_listen(struct socket *sock, int backlog)
 				break;
 			}
 
-		write_unlock_bh(&rfcomm_sk_list.lock);
+		write_unlock(&rfcomm_sk_list.lock);
 
 		if (err < 0)
 			goto done;
@@ -982,7 +982,7 @@ static int rfcomm_sock_debugfs_show(struct seq_file *f, void *p)
 	struct sock *sk;
 	struct hlist_node *node;
 
-	read_lock_bh(&rfcomm_sk_list.lock);
+	read_lock(&rfcomm_sk_list.lock);
 
 	sk_for_each(sk, node, &rfcomm_sk_list.head) {
 		seq_printf(f, "%s %s %d %d\n",
@@ -991,7 +991,7 @@ static int rfcomm_sock_debugfs_show(struct seq_file *f, void *p)
 				sk->sk_state, rfcomm_pi(sk)->channel);
 	}
 
-	read_unlock_bh(&rfcomm_sk_list.lock);
+	read_unlock(&rfcomm_sk_list.lock);
 
 	return 0;
 }
-- 
1.7.7.5

