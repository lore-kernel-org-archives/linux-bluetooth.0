Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 2/4] Bluetooth: trivial: Shorten variable scope
Date: Tue,  7 Aug 2012 18:05:04 +0300
Message-Id: <1344351906-27563-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1344351906-27563-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1344351906-27563-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Make code more clear by moving sk and bt vars to the place where
they are actually used.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/af_bluetooth.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 58f9762..1b88fe4 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -567,8 +567,6 @@ static void bt_seq_stop(struct seq_file *seq, void *v)
 
 static int bt_seq_show(struct seq_file *seq, void *v)
 {
-	struct sock *sk;
-	struct bt_sock *bt;
 	struct bt_seq_state *s = seq->private;
 	struct bt_sock_list *l = s->l;
 	bdaddr_t src_baswapped, dst_baswapped;
@@ -583,8 +581,8 @@ static int bt_seq_show(struct seq_file *seq, void *v)
 
 		seq_putc(seq, '\n');
 	} else {
-		sk = sk_entry(v);
-		bt = bt_sk(sk);
+		struct sock *sk = sk_entry(v);
+		struct bt_sock *bt = bt_sk(sk);
 		baswap(&src_baswapped, &bt->src);
 		baswap(&dst_baswapped, &bt->dst);
 
-- 
1.7.9.5

