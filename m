Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] shared/shell/bt_shell: Add bt_shell_completion
Date: Thu, 21 Sep 2017 13:40:20 -0400
Message-Id: <20170921174021.20154-4-marcin.kraglak@tieto.com>
In-Reply-To: <20170921174021.20154-1-marcin.kraglak@tieto.com>
References: <20170921174021.20154-1-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function may be used as rl_attempted_completion_function
in applications using readline.
---
 src/shared/shell/bt_shell.c | 60 +++++++++++++++++++++++++++++++++++++++++++++
 src/shared/shell/bt_shell.h |  1 +
 2 files changed, 61 insertions(+)

diff --git a/src/shared/shell/bt_shell.c b/src/shared/shell/bt_shell.c
index 1f3a57e02..f9e9ff6bd 100644
--- a/src/shared/shell/bt_shell.c
+++ b/src/shared/shell/bt_shell.c
@@ -26,6 +26,7 @@
 #endif
 
 #include <stdio.h>
+#include <readline/readline.h>
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
 #include "src/shared/shell/bt_shell.h"
@@ -90,3 +91,62 @@ void bt_shell_print_menu(void)
 					entry->arg ? : "", entry->desc ? : "");
 	}
 }
+
+static char *cmd_generator(const char *text, int state)
+{
+	const struct bt_shell_menu_entry *entry;
+	static int index, len;
+	const char *cmd;
+
+	entry = bt_shell_data.current;
+
+	if (!state) {
+		index = 0;
+		len = strlen(text);
+	}
+
+	while ((cmd = entry[index].cmd)) {
+		index++;
+
+		if (!strncmp(cmd, text, len))
+			return strdup(cmd);
+	}
+
+	return NULL;
+}
+
+char **bt_shell_completion(const char *text, int start, int end)
+{
+	char **matches = NULL;
+
+	if (!bt_shell_data.current)
+		return NULL;
+
+	if (start > 0) {
+		const struct bt_shell_menu_entry *entry;
+		char *input_cmd;
+
+		input_cmd = strndup(rl_line_buffer, start - 1);
+		for (entry = bt_shell_data.current; entry->cmd; entry++) {
+			if (strcmp(entry->cmd, input_cmd))
+				continue;
+
+			if (!entry->gen)
+				continue;
+
+			rl_completion_display_matches_hook = entry->disp;
+			matches = rl_completion_matches(text, entry->gen);
+			break;
+		}
+
+		free(input_cmd);
+	} else {
+		rl_completion_display_matches_hook = NULL;
+		matches = rl_completion_matches(text, cmd_generator);
+	}
+
+	if (!matches)
+		rl_attempted_completion_over = 1;
+
+	return matches;
+}
diff --git a/src/shared/shell/bt_shell.h b/src/shared/shell/bt_shell.h
index 93d7ed771..c30a3dcbd 100644
--- a/src/shared/shell/bt_shell.h
+++ b/src/shared/shell/bt_shell.h
@@ -39,4 +39,5 @@ bool bt_shell_init(const struct bt_shell_menu_entry *menu);
 void bt_shell_cleanup(void);
 
 void bt_shell_process(const char *cmd, const char *arg);
+char **bt_shell_completion(const char *text, int start, int end);
 void bt_shell_print_menu(void);
-- 
2.13.5

