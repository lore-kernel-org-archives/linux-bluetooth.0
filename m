Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] client: Use bt_shell_completion
Date: Thu, 21 Sep 2017 13:40:21 -0400
Message-Id: <20170921174021.20154-5-marcin.kraglak@tieto.com>
In-Reply-To: <20170921174021.20154-1-marcin.kraglak@tieto.com>
References: <20170921174021.20154-1-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/main.c | 49 +------------------------------------------------
 1 file changed, 1 insertion(+), 48 deletions(-)

diff --git a/client/main.c b/client/main.c
index 9113be95b..e0ea530bc 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2564,61 +2564,14 @@ static const struct bt_shell_menu_entry cmd_table[] = {
 	{ }
 };
 
-static char *cmd_generator(const char *text, int state)
-{
-	static int index, len;
-	const char *cmd;
-
-	if (!state) {
-		index = 0;
-		len = strlen(text);
-	}
-
-	while ((cmd = cmd_table[index].cmd)) {
-		index++;
-
-		if (!strncmp(cmd, text, len))
-			return strdup(cmd);
-	}
-
-	return NULL;
-}
-
 static char **cmd_completion(const char *text, int start, int end)
 {
-	char **matches = NULL;
-
 	if (agent_completion() == TRUE) {
 		rl_attempted_completion_over = 1;
 		return NULL;
 	}
 
-	if (start > 0) {
-		int i;
-		char *input_cmd;
-
-		input_cmd = g_strndup(rl_line_buffer, start -1);
-		for (i = 0; cmd_table[i].cmd; i++) {
-			if (strcmp(cmd_table[i].cmd, input_cmd))
-				continue;
-
-			if (!cmd_table[i].gen)
-				continue;
-
-			rl_completion_display_matches_hook = cmd_table[i].disp;
-			matches = rl_completion_matches(text, cmd_table[i].gen);
-			break;
-		}
-		g_free(input_cmd);
-	} else {
-		rl_completion_display_matches_hook = NULL;
-		matches = rl_completion_matches(text, cmd_generator);
-	}
-
-	if (!matches)
-		rl_attempted_completion_over = 1;
-
-	return matches;
+	return bt_shell_completion(text, start, end);
 }
 
 static void rl_handler(char *input)
-- 
2.13.5

