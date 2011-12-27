Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 5/5] Bluetooth: Remove *_bh from socket list lock.
Date: Tue, 27 Dec 2011 15:28:48 -0200
Message-Id: <1325006928-3338-5-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1325006928-3338-4-git-send-email-padovan@profusion.mobi>
References: <1325006928-3338-1-git-send-email-padovan@profusion.mobi>
 <1325006928-3338-2-git-send-email-padovan@profusion.mobi>
 <1325006928-3338-3-git-send-email-padovan@profusion.mobi>
 <1325006928-3338-4-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

We don't need it anymore.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/af_bluetooth.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index cdcfcab..ef92864 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -156,17 +156,17 @@ static int bt_sock_create(struct net *net, struct socket *sock, int proto,
 
 void bt_sock_link(struct bt_sock_list *l, struct sock *sk)
 {
-	write_lock_bh(&l->lock);
+	write_lock(&l->lock);
 	sk_add_node(sk, &l->head);
-	write_unlock_bh(&l->lock);
+	write_unlock(&l->lock);
 }
 EXPORT_SYMBOL(bt_sock_link);
 
 void bt_sock_unlink(struct bt_sock_list *l, struct sock *sk)
 {
-	write_lock_bh(&l->lock);
+	write_lock(&l->lock);
 	sk_del_node_init(sk);
-	write_unlock_bh(&l->lock);
+	write_unlock(&l->lock);
 }
 EXPORT_SYMBOL(bt_sock_unlink);
 
-- 
1.7.7.5

