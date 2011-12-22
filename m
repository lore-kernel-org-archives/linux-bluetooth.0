Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 06/12] Bluetooth: Remove *_bh locks from SCO
Date: Thu, 22 Dec 2011 16:56:07 -0200
Message-Id: <1324580173-24957-6-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1324580173-24957-5-git-send-email-padovan@profusion.mobi>
References: <1324580173-24957-1-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-2-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-3-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-4-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-5-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

Those locks are not shared between interrupt and process context anymore,
so remove the part that disable interruption. We are stiff safe because
preeption is disabled.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/sco.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 90c72fa..c8afcdb 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -489,7 +489,7 @@ static int sco_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_le
 		goto done;
 	}
 
-	write_lock_bh(&sco_sk_list.lock);
+	write_lock(&sco_sk_list.lock);
 
 	if (bacmp(src, BDADDR_ANY) && __sco_get_sock_by_addr(src)) {
 		err = -EADDRINUSE;
@@ -499,7 +499,7 @@ static int sco_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_le
 		sk->sk_state = BT_BOUND;
 	}
 
-	write_unlock_bh(&sco_sk_list.lock);
+	write_unlock(&sco_sk_list.lock);
 
 done:
 	release_sock(sk);
@@ -972,14 +972,14 @@ static int sco_debugfs_show(struct seq_file *f, void *p)
 	struct sock *sk;
 	struct hlist_node *node;
 
-	read_lock_bh(&sco_sk_list.lock);
+	read_lock(&sco_sk_list.lock);
 
 	sk_for_each(sk, node, &sco_sk_list.head) {
 		seq_printf(f, "%s %s %d\n", batostr(&bt_sk(sk)->src),
 				batostr(&bt_sk(sk)->dst), sk->sk_state);
 	}
 
-	read_unlock_bh(&sco_sk_list.lock);
+	read_unlock(&sco_sk_list.lock);
 
 	return 0;
 }
-- 
1.7.6.4

