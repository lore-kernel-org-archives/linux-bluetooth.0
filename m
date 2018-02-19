Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/shell: Add non-interactive mode
Date: Mon, 19 Feb 2018 17:49:52 +0200
Message-Id: <20180219154952.24339-2-luiz.dentz@gmail.com>
In-Reply-To: <20180219154952.24339-1-luiz.dentz@gmail.com>
References: <20180219154952.24339-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This detects if any command was given as parameter, execute it and
exit disabling all other outputs:

bluetoothctl list
Controller 00:1B:DC:07:31:88 Vudentz's T460s #1 [default]
Controller B8:8A:60:D8:17:D7 BlueZ-1
---
 src/shared/shell.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 12330ff53..01a62074f 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -55,6 +55,9 @@
 			cmd, (int)(CMD_LENGTH - strlen(cmd)), "", desc)
 
 static GMainLoop *main_loop;
+static int exec_argc;
+static char **exec_argv;
+static bool interactive;
 
 struct bt_shell_env {
 	char *name;
@@ -373,6 +376,9 @@ void bt_shell_printf(const char *fmt, ...)
 	char *saved_line;
 	int saved_point;
 
+	if (!interactive)
+		return;
+
 	save_input = !RL_ISSTATE(RL_STATE_DONE);
 
 	if (save_input) {
@@ -784,6 +790,9 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
 	} else
 		snprintf(optstr, sizeof(optstr), "+hv");
 
+	exec_argc = --argc;
+	exec_argv = &argv[1];
+
 	while ((c = getopt_long(argc, argv, optstr, options, &index)) != -1) {
 		switch (c) {
 		case 'v':
@@ -876,7 +885,7 @@ bool bt_shell_add_submenu(const struct bt_shell_menu *menu)
 
 void bt_shell_set_prompt(const char *string)
 {
-	if (!main_loop)
+	if (!main_loop || !interactive)
 		return;
 
 	rl_set_prompt(string);
@@ -899,6 +908,16 @@ bool bt_shell_attach(int fd)
 	if (data.input)
 		return false;
 
+	if (exec_argc > 0) {
+		interactive = true;
+		shell_exec(exec_argc, exec_argv);
+		interactive = false;
+
+		g_main_loop_quit(main_loop);
+
+		return false;
+	}
+
 	io = io_new(fd);
 
 	io_set_read_handler(io, input_read, NULL, NULL);
-- 
2.14.3

