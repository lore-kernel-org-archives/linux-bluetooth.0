Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 8/8] shared/shell: Use mainloop wrappers instead of GLIB directly
Date: Wed, 21 Feb 2018 16:14:56 +0200
Message-Id: <20180221141456.6656-8-luiz.dentz@gmail.com>
In-Reply-To: <20180221141456.6656-1-luiz.dentz@gmail.com>
References: <20180221141456.6656-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This will allow the shell to be used by the likes of btmgmt.
---
 src/shared/shell.c | 49 ++++++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 85657c250..6cc797cdb 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -29,6 +29,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include <stdlib.h>
+#include <stdarg.h>
 #include <stdbool.h>
 #include <signal.h>
 #include <sys/signalfd.h>
@@ -37,8 +38,9 @@
 
 #include <readline/readline.h>
 #include <readline/history.h>
-#include <glib.h>
 
+#include "src/shared/mainloop.h"
+#include "src/shared/timeout.h"
 #include "src/shared/io.h"
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
@@ -54,14 +56,13 @@
 		printf(COLOR_BLUE "%s %-*s " COLOR_OFF "%s\n", \
 			cmd, (int)(CMD_LENGTH - strlen(cmd)), "", desc)
 
-static GMainLoop *main_loop;
-
 struct bt_shell_env {
 	char *name;
 	void *value;
 };
 
 static struct {
+	bool init;
 	int argc;
 	char **argv;
 	bool mode;
@@ -88,7 +89,7 @@ static void cmd_version(int argc, char *argv[])
 
 static void cmd_quit(int argc, char *argv[])
 {
-	g_main_loop_quit(main_loop);
+	mainloop_quit();
 }
 
 static void cmd_help(int argc, char *argv[])
@@ -249,18 +250,18 @@ static int parse_args(char *arg, wordexp_t *w, char *del, int flags)
 {
 	char *str;
 
-	str = g_strdelimit(arg, del, '"');
+	str = strdelimit(arg, del, '"');
 
 	if (wordexp(str, w, flags)) {
-		g_free(str);
+		free(str);
 		return -EINVAL;
 	}
 
 	/* If argument ends with ,,, set we_offs bypass strict checks */
-	if (w->we_wordc && g_str_has_suffix(w->we_wordv[w->we_wordc -1], "..."))
+	if (w->we_wordc && strsuffix(w->we_wordv[w->we_wordc -1], "..."))
 		w->we_offs = 1;
 
-	g_free(str);
+	free(str);
 
 	return 0;
 }
@@ -460,7 +461,7 @@ static void rl_handler(char *input)
 		rl_insert_text("quit");
 		rl_redisplay();
 		rl_crlf();
-		g_main_loop_quit(main_loop);
+		mainloop_quit();
 		return;
 	}
 
@@ -586,7 +587,7 @@ static char **args_completion(const struct bt_shell_menu_entry *entry, int argc,
 		goto done;
 
 	/* Split values separated by / */
-	str = g_strdelimit(args.we_wordv[index], "/", ' ');
+	str = strdelimit(args.we_wordv[index], "/", ' ');
 
 	if (wordexp(str, &args, WRDE_NOCMD))
 		goto done;
@@ -659,7 +660,7 @@ static char **shell_completion(const char *text, int start, int end)
 
 static bool io_hup(struct io *io, void *user_data)
 {
-	g_main_loop_quit(main_loop);
+	mainloop_quit();
 
 	return false;
 }
@@ -699,7 +700,7 @@ static bool signal_read(struct io *io, void *user_data)
 		if (!terminated) {
 			rl_replace_line("", 0);
 			rl_crlf();
-			g_main_loop_quit(main_loop);
+			mainloop_quit();
 		}
 
 		terminated = true;
@@ -821,9 +822,11 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
 	if (data.mode)
 		bt_shell_set_env("NON_INTERACTIVE", &data.mode);
 
-	main_loop = g_main_loop_new(NULL, FALSE);
+	mainloop_init();
 
 	rl_init();
+
+	data.init = true;
 }
 
 static void rl_cleanup(void)
@@ -846,22 +849,21 @@ void bt_shell_run(void)
 
 	signal = setup_signalfd();
 
-	g_main_loop_run(main_loop);
+	mainloop_run();
 
 	bt_shell_release_prompt("");
 	bt_shell_detach();
 
 	io_destroy(signal);
 
-	g_main_loop_unref(main_loop);
-	main_loop = NULL;
-
 	if (data.envs) {
 		queue_destroy(data.envs, env_destroy);
 		data.envs = NULL;
 	}
 
 	rl_cleanup();
+
+	data.init = false;
 }
 
 bool bt_shell_set_menu(const struct bt_shell_menu *menu)
@@ -892,7 +894,7 @@ bool bt_shell_add_submenu(const struct bt_shell_menu *menu)
 
 void bt_shell_set_prompt(const char *string)
 {
-	if (!main_loop || data.mode)
+	if (!data.init || data.mode)
 		return;
 
 	rl_set_prompt(string);
@@ -907,11 +909,11 @@ static bool input_read(struct io *io, void *user_data)
 	return true;
 }
 
-static gboolean shell_quit(void *data)
+static bool shell_quit(void *data)
 {
-	g_main_loop_quit(main_loop);
+	mainloop_quit();
 
-	return FALSE;
+	return false;
 }
 
 bool bt_shell_attach(int fd)
@@ -934,9 +936,10 @@ bool bt_shell_attach(int fd)
 
 		if (!data.timeout) {
 			bt_shell_detach();
-			g_main_loop_quit(main_loop);
+			mainloop_quit();
 		} else
-			g_timeout_add_seconds(data.timeout, shell_quit, NULL);
+			timeout_add(data.timeout * 1000, shell_quit, NULL,
+								NULL);
 	}
 
 	return true;
-- 
2.14.3

