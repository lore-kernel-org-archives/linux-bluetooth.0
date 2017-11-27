Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/4] shared/shell: Detect if the arguments are properly set
Date: Mon, 27 Nov 2017 18:17:01 +0200
Message-Id: <20171127161704.14073-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Parse arguments to detect if user has passed a valid number of
arguments.
---
v2: Just print the usage of the commands without auto-complete generator so it
does add the arguments into the input.

 src/shared/shell.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 92 insertions(+), 6 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index c271a53ee..73aedaf79 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -207,6 +207,95 @@ static void shell_print_menu(void)
 	}
 }
 
+static int parse_args(char *arg, wordexp_t *w, char *del, int flags)
+{
+	char *str;
+
+	str = g_strdelimit(arg, del, '"');
+
+	if (wordexp(str, w, flags)) {
+		g_free(str);
+		return -EINVAL;
+	}
+
+	/* If argument ends with ,,, set we_offs bypass strict checks */
+	if (w->we_wordc && g_str_has_suffix(w->we_wordv[w->we_wordc -1], "..."))
+		w->we_offs = 1;
+
+	g_free(str);
+
+	return 0;
+}
+
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
+	if (parse_args(man, &w, "<>", flags) < 0) {
+		print_text(COLOR_HIGHLIGHT,
+				"Unable to parse mandatory command arguments");
+		return -EINVAL;
+	}
+
+	/* Check if there are enough arguments */
+	if ((unsigned) argc < w.we_wordc && !w.we_offs) {
+		print_text(COLOR_HIGHLIGHT, "Missing %s argument",
+						w.we_wordv[argc]);
+		goto fail;
+	}
+
+	flags |= WRDE_APPEND;
+	opt = strdup(entry->arg + len + 1);
+
+optional:
+	if (parse_args(opt, &w, "<>", flags) < 0) {
+		print_text(COLOR_HIGHLIGHT,
+				"Unable to parse mandatory command arguments");
+		return -EINVAL;
+	}
+
+	/* Check if there are too many arguments */
+	if ((unsigned) argc > w.we_wordc && !w.we_offs) {
+		print_text(COLOR_HIGHLIGHT, "Too many arguments: %d > %zu",
+					argc, w.we_wordc);
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
@@ -222,10 +311,7 @@ static int menu_exec(const struct bt_shell_menu_entry *entry,
 		if (data.menu == data.main && !strcmp(entry->cmd, "back"))
 			continue;
 
-		if (entry->func) {
-			entry->func(argc - 1, ++argv);
-			return 0;
-		}
+		return cmd_exec(entry, --argc, ++argv);
 	}
 
 	return -ENOENT;
@@ -236,8 +322,8 @@ static void shell_exec(int argc, char *argv[])
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

