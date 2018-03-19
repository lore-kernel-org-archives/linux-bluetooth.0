Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 2/2] shared/shell: Fix memory leak by generator for
 submenu
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <645f8de1-77a5-71d9-ca31-637fcf30c6fa@jp.fujitsu.com>
Message-ID: <9c4f3d0d-6f90-7138-a415-5c001b2b6384@jp.fujitsu.com>
Date: Mon, 19 Mar 2018 13:46:47 +0900
MIME-Version: 1.0
In-Reply-To: <645f8de1-77a5-71d9-ca31-637fcf30c6fa@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since asprintf() allocates new memory when a submenu command is
complemented, the memory leak occurs as below:

   8 bytes in 1 blocks are definitely lost in loss record 18 of 179
      at 0x4C2FB0F: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
      by 0x5679C99: strdup (strdup.c:42)
      by 0x13B1E7: find_cmd.constprop.2 (shell.c:597)
      by 0x13B2D1: cmd_generator (shell.c:646)
      by 0x53B976D: rl_completion_matches (in /lib/x86_64-linux-gnu/libreadline.so.7.0)
      by 0x13BA91: shell_completion (shell.c:777)
      by 0x53B98B6: ??? (in /lib/x86_64-linux-gnu/libreadline.so.7.0)
      by 0x53B9A99: rl_complete_internal (in /lib/x86_64-linux-gnu/libreadline.so.7.0)
      by 0x53B02EE: _rl_dispatch_subseq (in /lib/x86_64-linux-gnu/libreadline.so.7.0)
      by 0x53B07B5: readline_internal_char (in /lib/x86_64-linux-gnu/libreadline.so.7.0)
      by 0x53C8F84: rl_callback_read_char (in /lib/x86_64-linux-gnu/libreadline.so.7.0)
      by 0x13AD80: input_read (shell.c:1065)
---
 src/shared/shell.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 7417e7ab4..9cd8d2567 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -645,10 +645,16 @@ static char *cmd_generator(const char *text, int state)
 	cmd = find_cmd(text + strlen(menu->name) + 1, menu->entries, &index);
 	if (cmd) {
 		int err;
+		char *tmp;
+
+		err = asprintf(&tmp, "%s.%s", menu->name, cmd);
+
+		free(cmd);
 
-		err = asprintf(&cmd, "%s.%s", menu->name, cmd);
 		if (err < 0)
 			return NULL;
+
+		cmd = tmp;
 	}
 
 	return cmd;
-- 
2.14.1

