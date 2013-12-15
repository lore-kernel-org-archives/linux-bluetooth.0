Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH] emulator/bthost: Fix use after free in bthost_destroy
Date: Sun, 15 Dec 2013 20:55:48 +0100
Message-Id: <1387137348-5377-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

cmd was dereferenced after free. Use temp pointer for freeing.
---
 emulator/bthost.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 10e7a05..b05072a 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -186,13 +186,15 @@ static struct l2conn *btconn_find_l2cap_conn_by_scid(struct btconn *conn,
 
 void bthost_destroy(struct bthost *bthost)
 {
-	struct cmd *cmd;
-
 	if (!bthost)
 		return;
 
-	for (cmd = bthost->cmd_q.tail; cmd != NULL; cmd = cmd->next)
+	while (bthost->cmd_q.tail) {
+		struct cmd *cmd = bthost->cmd_q.tail;
+
+		bthost->cmd_q.tail = cmd->next;
 		free(cmd);
+	}
 
 	while (bthost->conns) {
 		struct btconn *conn = bthost->conns;
-- 
1.8.5.1

