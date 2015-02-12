Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] tools/btmgmt: Fix crash in completion in interactive mode
Date: Thu, 12 Feb 2015 17:30:43 +0100
Message-Id: <1423758644-3122-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use separate indexes while iterating over all_cmd and interactive_cmd.
Fix following crash:

[mgmt]# ==2224== Invalid read of size 1
==2224==    at 0x4A092F2: strlen (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
==2224==    by 0x323C8860AD: strdup (in /usr/lib64/libc-2.18.so)
==2224==    by 0x323EC1D550: rl_completion_matches (in /usr/lib64/libreadline.so.6.2)
==2224==    by 0x402BBC: cmd_completion (btmgmt.c:3427)
==2224==    by 0x323EC1D608: ??? (in /usr/lib64/libreadline.so.6.2)
==2224==    by 0x323EC1D783: rl_complete_internal (in /usr/lib64/libreadline.so.6.2)
==2224==    by 0x323EC156DD: _rl_dispatch_subseq (in /usr/lib64/libreadline.so.6.2)
==2224==    by 0x323EC159FF: readline_internal_char (in /usr/lib64/libreadline.so.6.2)
==2224==    by 0x323EC2AB6C: rl_callback_read_char (in /usr/lib64/libreadline.so.6.2)
==2224==    by 0x4032E8: prompt_read (btmgmt.c:3551)
==2224==    by 0x419048: io_callback (io-mainloop.c:123)
==2224==    by 0x419842: mainloop_run (mainloop.c:157)
==2224==  Address 0x68 is not stack'd, malloc'd or (recently) free'd
---
 tools/btmgmt.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index e262350..0686ed6 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -3375,23 +3375,24 @@ static struct cmd_info interactive_cmd[] = {
 
 static char *cmd_generator(const char *text, int state)
 {
-	static int index, len;
+	static int i, j, len;
 	const char *cmd;
 
 	if (!state) {
-		index = 0;
+		i = 0;
+		j = 0;
 		len = strlen(text);
 	}
 
-	while ((cmd = all_cmd[index].cmd)) {
-		index++;
+	while ((cmd = all_cmd[i].cmd)) {
+		i++;
 
 		if (!strncmp(cmd, text, len))
 			return strdup(cmd);
 	}
 
-	while ((cmd = interactive_cmd[index].cmd)) {
-		index++;
+	while ((cmd = interactive_cmd[j].cmd)) {
+		j++;
 
 		if (!strncmp(cmd, text, len))
 			return strdup(cmd);
-- 
1.9.3

