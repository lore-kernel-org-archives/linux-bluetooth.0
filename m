Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2] emulator/bthost: Fix command queue
Date: Wed, 19 Feb 2014 14:39:38 +0100
Message-Id: <1392817178-15022-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now new commands will be pushed to tail. Queue will be consumed
from head, firstly added commands will be sent. It repairs this
warning from android-tester:
==20561== 1,904 bytes in 7 blocks are definitely
lost in loss record 30 of 31
==20561==    at 0x4006AB1: malloc (in /usr/lib/valgrind/
vgpreload_memcheck-x86-linux.so)
==20561==    by 0x8050293: send_command (bthost.c:389)
==20561==    by 0x80543E1: start_stack (hciemu.c:299)
==20561==    by 0x41043D00: ??? (in /usr/lib/libglib-2.0.so.0.3600.4)
==20561==    by 0x410470E5: g_main_context_dispatch (in
/usr/lib/libglib-2.0.so.0.3600.4)
==20561==    by 0x41047497: ??? (in
/usr/lib/libglib-2.0.so.0.3600.4)
==20561==    by 0x41047912: g_main_loop_run (in
/usr/lib/libglib-2.0.so.0.3600.4)
==20561==    by 0x8055870: tester_run (tester.c:798)
==20561==    by 0x804B980: main (android-tester.c:3984)
---
 emulator/bthost.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index fe78ec5..2f338f7 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -395,7 +395,7 @@ void bthost_destroy(struct bthost *bthost)
 	while (bthost->cmd_q.tail) {
 		struct cmd *cmd = bthost->cmd_q.tail;
 
-		bthost->cmd_q.tail = cmd->next;
+		bthost->cmd_q.tail = cmd->prev;
 		free(cmd);
 	}
 
@@ -461,6 +461,8 @@ static void queue_command(struct bthost *bthost, const void *data,
 
 	if (cmd_q->tail)
 		cmd_q->tail->next = cmd;
+	else
+		cmd_q->head = cmd;
 
 	cmd->prev = cmd_q->tail;
 	cmd_q->tail = cmd;
@@ -662,7 +664,7 @@ static void send_command(struct bthost *bthost, uint16_t opcode,
 static void next_cmd(struct bthost *bthost)
 {
 	struct cmd_queue *cmd_q = &bthost->cmd_q;
-	struct cmd *cmd = cmd_q->tail;
+	struct cmd *cmd = cmd_q->head;
 	struct cmd *next;
 
 	if (!cmd)
@@ -678,8 +680,10 @@ static void next_cmd(struct bthost *bthost)
 
 	if (next)
 		next->prev = NULL;
+	else
+		cmd_q->tail = NULL;
 
-	cmd_q->tail = next;
+	cmd_q->head = next;
 
 	free(cmd);
 }
-- 
1.8.3.1

