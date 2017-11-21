Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/shell: Detect if the arguments are properly set
Date: Tue, 21 Nov 2017 12:53:22 +0200
Message-Id: <20171121105322.30008-2-luiz.dentz@gmail.com>
In-Reply-To: <20171121105322.30008-1-luiz.dentz@gmail.com>
References: <20171121105322.30008-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Parse arguments to detect if user has passed a valid number of
arguments.
---
 src/shared/shell.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 90 insertions(+), 6 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 378c0c029..fde94ef29 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -207,6 +207,93 @@ static void shell_print_menu(void)
 	}
 }
 
+static int cmd_exec(const struct bt_shell_menu_entry *entry,
+					int argc, char *argv[])
+{
+	wordexp_t w;
+	size_t len;
+	char *man, *opt;
+	int flags = WRDE_NOCMD;
+
+	if (!entry->arg || entry->arg[0] == '\0') {
+		if (argc) {
+			print_text(COLOR_HIGHLIGHT, "Too many arguments");
+			return -EINVAL;
+		}
+		goto exec;
+	}
+
+	/* Find last mandatory arguments */
+	man = strrchr(entry->arg, '>');
+	if (!man) {
+		opt = strdup(entry->arg);
+		goto optional;
+	}
+
+	len = man - entry->arg;
+	man = strndup(entry->arg, len + 1);
+
+	/* wordexp manpage:
+	 * |, &, ;, <, >, (, ), {, } characters outside a command substitution
+	 * or parameter substitution context.
+	 */
+	man = g_strdelimit(man, "|&;<>(){}", '"');
+
+	if (wordexp(man, &w, flags)) {
+		free(man);
+		print_text(COLOR_HIGHLIGHT,
+				"Unable to parse mandatory command arguments");
+		return -EINVAL;
+	}
+
+	free(man);
+
+	/* Check if there are enough arguments */
+	if ((unsigned) argc < w.we_wordc) {
+		print_text(COLOR_HIGHLIGHT, "Missing %s argument",
+						w.we_wordv[argc]);
+		goto fail;
+	}
+
+
+	flags |= WRDE_APPEND;
+	opt = strdup(entry->arg + len + 1);
+
+optional:
+	/* wordexp manpage:
+	 * |, &, ;, <, >, (, ), {, } characters outside a command substitution
+	 * or parameter substitution context.
+	 */
+	opt = g_strdelimit(opt, "|&;<>(){}[]", '"');
+
+	if (wordexp(opt, &w, flags)) {
+		free(opt);
+		print_text(COLOR_HIGHLIGHT,
+				"Unable to parse optional command arguments");
+		goto fail;
+	}
+
+	free(opt);
+
+	/* Check if there are too many arguments */
+	if ((unsigned) argc > w.we_wordc) {
+		print_text(COLOR_HIGHLIGHT, "Too many arguments");
+		goto fail;
+	}
+
+	wordfree(&w);
+
+exec:
+	if (entry->func)
+		entry->func(argc, argv);
+
+	return 0;
+
+fail:
+	wordfree(&w);
+	return -EINVAL;
+}
+
 static int menu_exec(const struct bt_shell_menu_entry *entry,
 					int argc, char *argv[])
 {
@@ -222,10 +309,7 @@ static int menu_exec(const struct bt_shell_menu_entry *entry,
 		if (data.menu == data.main && !strcmp(entry->cmd, "back"))
 			continue;
 
-		if (entry->func) {
-			entry->func(argc - 1, ++argv);
-			return 0;
-		}
+		return cmd_exec(entry, --argc, ++argv);
 	}
 
 	return -ENOENT;
@@ -236,8 +320,8 @@ static void shell_exec(int argc, char *argv[])
 	if (!data.menu || !argv[0])
 		return;
 
-	if (menu_exec(default_menu, argc, argv) < 0) {
-		if (menu_exec(data.menu->entries, argc, argv) < 0)
+	if (menu_exec(default_menu, argc, argv) == -ENOENT) {
+		if (menu_exec(data.menu->entries, argc, argv) == -ENOENT)
 			print_text(COLOR_HIGHLIGHT, "Invalid command");
 	}
 }
-- 
2.13.6

