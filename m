Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 3/4] Bluetooth: Use %pMR instead of baswap in seq_show
Date: Tue,  7 Aug 2012 18:05:05 +0300
Message-Id: <1344351906-27563-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1344351906-27563-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1344351906-27563-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use new bluetooth address print specifier %pMR for printing
bluetooth addresses instead of dedicated variable and baswap.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/af_bluetooth.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 1b88fe4..a724f6c 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -569,7 +569,6 @@ static int bt_seq_show(struct seq_file *seq, void *v)
 {
 	struct bt_seq_state *s = seq->private;
 	struct bt_sock_list *l = s->l;
-	bdaddr_t src_baswapped, dst_baswapped;
 
 	if (v == SEQ_START_TOKEN) {
 		seq_puts(seq ,"sk               RefCnt Rmem   Wmem   User   Inode  Src Dst Parent");
@@ -583,18 +582,17 @@ static int bt_seq_show(struct seq_file *seq, void *v)
 	} else {
 		struct sock *sk = sk_entry(v);
 		struct bt_sock *bt = bt_sk(sk);
-		baswap(&src_baswapped, &bt->src);
-		baswap(&dst_baswapped, &bt->dst);
 
-		seq_printf(seq, "%pK %-6d %-6u %-6u %-6u %-6lu %pM %pM %-6lu",
+		seq_printf(seq,
+			   "%pK %-6d %-6u %-6u %-6u %-6lu %pMR %pMR %-6lu",
 			   sk,
 			   atomic_read(&sk->sk_refcnt),
 			   sk_rmem_alloc_get(sk),
 			   sk_wmem_alloc_get(sk),
 			   sock_i_uid(sk),
 			   sock_i_ino(sk),
-			   &src_baswapped,
-			   &dst_baswapped,
+			   &bt->src,
+			   &bt->dst,
 			   bt->parent? sock_i_ino(bt->parent): 0LU);
 
 		if (l->custom_seq_show) {
-- 
1.7.9.5

