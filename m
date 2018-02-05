Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] shared/shell: Add tab completion for argument values
Date: Mon,  5 Feb 2018 10:48:17 -0200
Message-Id: <20180205124818.23566-3-luiz.dentz@gmail.com>
In-Reply-To: <20180205124818.23566-1-luiz.dentz@gmail.com>
References: <20180205124818.23566-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In case a command don't have a generator parse its argument string and
generate a list of possible values.
---
 src/shared/shell.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 73 insertions(+), 5 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 69f303b51..2958a66b5 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -518,8 +518,76 @@ static char *cmd_generator(const char *text, int state)
 	return find_cmd(text, data.menu->entries, &index);
 }
 
+static wordexp_t args;
+
+static char *arg_generator(const char *text, int state)
+{
+	static unsigned int index, len;
+	const char *arg;
+
+	if (!state) {
+		index = 0;
+		len = strlen(text);
+	}
+
+	while (index < args.we_wordc) {
+		arg = args.we_wordv[index];
+		index++;
+
+		if (!strncmp(arg, text, len))
+			return strdup(arg);
+	}
+
+	return NULL;
+}
+
+static char **args_completion(const struct bt_shell_menu_entry *entry, int argc,
+							const char *text)
+{
+	char **matches = NULL;
+	char *str;
+	int index;
+
+	index = text[0] == '\0' ? argc - 1 : argc - 2;
+	if (index < 0)
+		return NULL;
+
+	if (!entry->arg)
+		goto done;
+
+	str = strdup(entry->arg);
+
+	if (parse_args(str, &args, "<>[]", WRDE_NOCMD))
+		goto done;
+
+	/* Check if argument is valid */
+	if ((unsigned) index > args.we_wordc - 1)
+		goto done;
+
+	/* Check if there are multiple values */
+	if (!strrchr(entry->arg, '/'))
+		goto done;
+
+	/* Split values separated by / */
+	str = g_strdelimit(args.we_wordv[index], "/", ' ');
+
+	if (wordexp(str, &args, WRDE_NOCMD))
+		goto done;
+
+	rl_completion_display_matches_hook = NULL;
+	matches = rl_completion_matches(text, arg_generator);
+
+done:
+	if (!matches && text[0] == '\0')
+		bt_shell_printf("Usage: %s %s\n", entry->cmd,
+					entry->arg ? entry->arg : "");
+
+	wordfree(&args);
+	return matches;
+}
+
 static char **menu_completion(const struct bt_shell_menu_entry *entry,
-				const char *text, char *input_cmd)
+				const char *text, int argc, char *input_cmd)
 {
 	char **matches = NULL;
 
@@ -528,9 +596,7 @@ static char **menu_completion(const struct bt_shell_menu_entry *entry,
 			continue;
 
 		if (!entry->gen) {
-			if (text[0] == '\0')
-				bt_shell_printf("Usage: %s %s\n", entry->cmd,
-						entry->arg ? entry->arg : "");
+			matches = args_completion(entry, argc, text);
 			break;
 		}
 
@@ -555,9 +621,11 @@ static char **shell_completion(const char *text, int start, int end)
 		if (wordexp(rl_line_buffer, &w, WRDE_NOCMD))
 			return NULL;
 
-		matches = menu_completion(default_menu, text, w.we_wordv[0]);
+		matches = menu_completion(default_menu, text, w.we_wordc,
+							w.we_wordv[0]);
 		if (!matches)
 			matches = menu_completion(data.menu->entries, text,
+							w.we_wordc,
 							w.we_wordv[0]);
 
 		wordfree(&w);
-- 
2.14.3

