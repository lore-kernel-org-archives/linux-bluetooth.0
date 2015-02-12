Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH] tools/btmgmt: Fix end of array checks
Date: Thu, 12 Feb 2015 22:05:15 +0100
Message-Id: <1423775115-16386-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

all_cmd arrays is not terminated by zeroed element.
---
 tools/btmgmt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 15425fb..75f64c2 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -3406,9 +3406,9 @@ static char **cmd_completion(const char *text, int start, int end)
 	char **matches = NULL;
 
 	if (start > 0) {
-		int i;
+		unsigned int i;
 
-		for (i = 0; all_cmd[i].cmd; i++) {
+		for (i = 0; i < NELEM(all_cmd); i++) {
 			struct cmd_info *c = &all_cmd[i];
 
 			if (strncmp(c->cmd, rl_line_buffer, start - 1))
@@ -3519,7 +3519,7 @@ done:
 
 static void usage(void)
 {
-	int i;
+	unsigned int i;
 
 	printf("btmgmt ver %s\n", VERSION);
 	printf("Usage:\n"
@@ -3531,7 +3531,7 @@ static void usage(void)
 		"\t--help\tDisplay help\n");
 
 	printf("Commands:\n");
-	for (i = 0; all_cmd[i].cmd; i++)
+	for (i = 0; i < NELEM(all_cmd); i++)
 		printf("\t%-15s\t%s\n", all_cmd[i].cmd, all_cmd[i].doc);
 
 	printf("\n"
-- 
2.1.4

