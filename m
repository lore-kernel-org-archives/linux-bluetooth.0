Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Adjust header for proc socket information
Date: Mon, 14 Oct 2013 02:05:25 -0700
Message-Id: <1381741525-22607-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The exposed socket information do not contain source or destination
addresses. So adjust the header accordingly.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/af_bluetooth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 61501c9..1f1a111 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -611,7 +611,7 @@ static int bt_seq_show(struct seq_file *seq, void *v)
 	struct bt_sock_list *l = s->l;
 
 	if (v == SEQ_START_TOKEN) {
-		seq_puts(seq ,"sk               RefCnt Rmem   Wmem   User   Inode  Src Dst Parent");
+		seq_puts(seq ,"sk               RefCnt Rmem   Wmem   User   Inode  Parent");
 
 		if (l->custom_seq_show) {
 			seq_putc(seq, ' ');
-- 
1.8.3.1

