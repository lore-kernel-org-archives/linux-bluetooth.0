Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Remove src and dst fields from bt_sock structure
Date: Sun, 13 Oct 2013 10:34:03 -0700
Message-Id: <1381685643-57066-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Every socket protocol now stores its own address information. So
just remove the generic src and dst fields since they are no longer
needed.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/bluetooth.h | 2 --
 net/bluetooth/af_bluetooth.c      | 4 +---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 5fd5106..1d6e484 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -218,8 +218,6 @@ void baswap(bdaddr_t *dst, bdaddr_t *src);
 
 struct bt_sock {
 	struct sock sk;
-	bdaddr_t    src;
-	bdaddr_t    dst;
 	struct list_head accept_q;
 	struct sock *parent;
 	unsigned long flags;
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index e6e1278..9c7e4ed 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -617,15 +617,13 @@ static int bt_seq_show(struct seq_file *seq, void *v)
 		struct bt_sock *bt = bt_sk(sk);
 
 		seq_printf(seq,
-			   "%pK %-6d %-6u %-6u %-6u %-6lu %pMR %pMR %-6lu",
+			   "%pK %-6d %-6u %-6u %-6u %-6lu %-6lu",
 			   sk,
 			   atomic_read(&sk->sk_refcnt),
 			   sk_rmem_alloc_get(sk),
 			   sk_wmem_alloc_get(sk),
 			   from_kuid(seq_user_ns(seq), sock_i_uid(sk)),
 			   sock_i_ino(sk),
-			   &bt->src,
-			   &bt->dst,
 			   bt->parent? sock_i_ino(bt->parent): 0LU);
 
 		if (l->custom_seq_show) {
-- 
1.8.3.1

