Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: [PATCH BlueZ 1/2] client: Fix completion for list/pair command
Message-ID: <611fb226-d99a-166d-a211-521872866d5d@jp.fujitsu.com>
Date: Tue, 5 Sep 2017 13:50:42 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The unexpected generator is used if the input string forward matches
with the unexpected command string which a generator for completion
is registered on. Thus,
  - since 496b6abf743440e937222c62768e0a3b31f47f02, list command
    generates the unneeded argument, which is device id like that
    list-attributes command generates.
  - since b0fe6045b7d9cfdd02a5e419fc9658a0ffa84619, pair command
    generates the invalid argument, which is on/off like that
    pairable command generates.
This patch use the exact matching command.
---
 client/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/client/main.c b/client/main.c
index 87eb131..d487eaf 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2578,10 +2578,11 @@ static char **cmd_completion(const char *text, int start, int end)
 
 	if (start > 0) {
 		int i;
+		char *input_cmd;
 
+		input_cmd = g_strndup(rl_line_buffer, start -1);
 		for (i = 0; cmd_table[i].cmd; i++) {
-			if (strncmp(cmd_table[i].cmd,
-					rl_line_buffer, start - 1))
+			if (strcmp(cmd_table[i].cmd, input_cmd))
 				continue;
 
 			if (!cmd_table[i].gen)
@@ -2591,6 +2592,7 @@ static char **cmd_completion(const char *text, int start, int end)
 			matches = rl_completion_matches(text, cmd_table[i].gen);
 			break;
 		}
+		g_free(input_cmd);
 	} else {
 		rl_completion_display_matches_hook = NULL;
 		matches = rl_completion_matches(text, cmd_generator);
-- 
2.7.4

