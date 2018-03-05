Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: [PATCH BlueZ 1/2] shared/shell: Fix memory leak when parsing args
Message-ID: <23d54c9a-2fe2-33cb-8516-323aaa7185ba@jp.fujitsu.com>
Date: Mon, 5 Mar 2018 17:41:11 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When running the command having mandatory arguments, memory leak occurs
as below:

  1 bytes in 1 blocks are definitely lost in loss record 2 of 184
     at 0x4C2FB0F: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
     by 0x5679C99: strdup (strdup.c:42)
     by 0x13A976: cmd_exec (shell.c:327)
     by 0x13A976: menu_exec (shell.c:375)
     by 0x13AEA4: shell_exec (shell.c:418)
     by 0x13BBF1: rl_handler (shell.c:563)
     by 0x53C8D72: rl_callback_read_char (in /lib/x86_64-linux-gnu/libreadline.so.7.0)
     by 0x13ACE0: input_read (shell.c:1018)
     by 0x13C90A: watch_callback (io-glib.c:170)
     by 0x4E86E24: g_main_context_dispatch (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.5400.1)
     by 0x4E871EF: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.5400.1)
     by 0x4E87501: g_main_loop_run (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.5400.1)
     by 0x13D244: mainloop_run (mainloop-glib.c:73)

  7 bytes in 1 blocks are definitely lost in loss record 12 of 184
     at 0x4C2FB0F: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
     by 0x5679C99: strdup (strdup.c:42)
     by 0x139EEA: strdelimit (util.c:991)
     by 0x13B66A: args_completion (shell.c:668)
     by 0x13B66A: menu_completion (shell.c:695)
     by 0x13B836: shell_completion (shell.c:723)
     by 0x53B98B6: ??? (in /lib/x86_64-linux-gnu/libreadline.so.7.0)
     by 0x53B9A99: rl_complete_internal (in /lib/x86_64-linux-gnu/libreadline.so.7.0)
     by 0x53B02EE: _rl_dispatch_subseq (in /lib/x86_64-linux-gnu/libreadline.so.7.0)
     by 0x53B07B5: readline_internal_char (in /lib/x86_64-linux-gnu/libreadline.so.7.0)
     by 0x53C8F84: rl_callback_read_char (in /lib/x86_64-linux-gnu/libreadline.so.7.0)
     by 0x13ACE0: input_read (shell.c:1018)
     by 0x13C90A: watch_callback (io-glib.c:170)

  9 bytes in 1 blocks are definitely lost in loss record 21 of 184
     at 0x4C2FB0F: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
     by 0x5679C99: strdup (strdup.c:42)
     by 0x13B53F: args_completion (shell.c:654)
     by 0x13B53F: menu_completion (shell.c:695)
     by 0x13B836: shell_completion (shell.c:723)
     by 0x53B98B6: ??? (in /lib/x86_64-linux-gnu/libreadline.so.7.0)
     by 0x53B9A99: rl_complete_internal (in /lib/x86_64-linux-gnu/libreadline.so.7.0)
     by 0x53B02EE: _rl_dispatch_subseq (in /lib/x86_64-linux-gnu/libreadline.so.7.0)
     by 0x53B07B5: readline_internal_char (in /lib/x86_64-linux-gnu/libreadline.so.7.0)
     by 0x53C8F84: rl_callback_read_char (in /lib/x86_64-linux-gnu/libreadline.so.7.0)
     by 0x13ACE0: input_read (shell.c:1018)
     by 0x13C90A: watch_callback (io-glib.c:170)
     by 0x4E86E24: g_main_context_dispatch (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.5400.1)

  9 bytes in 1 blocks are definitely lost in loss record 22 of 184
     at 0x4C2FB0F: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
     by 0x5679CE9: strndup (strndup.c:43)
     by 0x13A9EB: cmd_exec (shell.c:301)
     by 0x13A9EB: menu_exec (shell.c:375)
     by 0x13AEA4: shell_exec (shell.c:418)
     by 0x13BBF1: rl_handler (shell.c:563)
     by 0x53C8D72: rl_callback_read_char (in /lib/x86_64-linux-gnu/libreadline.so.7.0)
     by 0x13ACE0: input_read (shell.c:1018)
     by 0x13C90A: watch_callback (io-glib.c:170)
     by 0x4E86E24: g_main_context_dispatch (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.5400.1)
     by 0x4E871EF: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.5400.1)
     by 0x4E87501: g_main_loop_run (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.5400.1)
     by 0x13D244: mainloop_run (mainloop-glib.c:73)
---
 src/shared/shell.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index fc4c9b5a5..f962f21e8 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -313,9 +313,12 @@ static int cmd_exec(const struct bt_shell_menu_entry *entry,
 	if (parse_args(man, &w, "<>", flags) < 0) {
 		print_text(COLOR_HIGHLIGHT,
 			"Unable to parse mandatory command arguments: %s", man );
+		free(man);
 		return -EINVAL;
 	}
 
+	free(man);
+
 	/* Check if there are enough arguments */
 	if ((unsigned) argc - 1 < w.we_wordc) {
 		print_text(COLOR_HIGHLIGHT, "Missing %s argument",
@@ -330,9 +333,12 @@ optional:
 	if (parse_args(opt, &w, "[]", flags) < 0) {
 		print_text(COLOR_HIGHLIGHT,
 			"Unable to parse optional command arguments: %s", opt);
+		free(opt);
 		return -EINVAL;
 	}
 
+	free(opt);
+
 	/* Check if there are too many arguments */
 	if ((unsigned) argc - 1 > w.we_wordc && !w.we_offs) {
 		print_text(COLOR_HIGHLIGHT, "Too many arguments: %d > %zu",
@@ -649,7 +655,7 @@ static char **args_completion(const struct bt_shell_menu_entry *entry, int argc,
 		return NULL;
 
 	if (!entry->arg)
-		goto done;
+		goto end;
 
 	str = strdup(entry->arg);
 
@@ -664,6 +670,8 @@ static char **args_completion(const struct bt_shell_menu_entry *entry, int argc,
 	if (!strrchr(entry->arg, '/'))
 		goto done;
 
+	free(str);
+
 	/* Split values separated by / */
 	str = strdelimit(args.we_wordv[index], "/", ' ');
 
@@ -674,6 +682,8 @@ static char **args_completion(const struct bt_shell_menu_entry *entry, int argc,
 	matches = rl_completion_matches(text, arg_generator);
 
 done:
+	free(str);
+end:
 	if (!matches && text[0] == '\0')
 		bt_shell_printf("Usage: %s %s\n", entry->cmd,
 					entry->arg ? entry->arg : "");
-- 
2.14.1

