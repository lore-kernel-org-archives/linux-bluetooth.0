Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/8] shared/shell: Add non-interactive mode
Date: Wed, 21 Feb 2018 16:14:49 +0200
Message-Id: <20180221141456.6656-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This detects if any command was given as parameter, execute it and
exit disabling all other outputs:

bluetoothctl list
Controller 00:1B:DC:07:31:88 Vudentz's T460s #1 [default]
Controller B8:8A:60:D8:17:D7 BlueZ-1

It is also possible to run interactive command with use of timeout
option:

bluetoothctl --timeout=10 advertise on
Agent registered
[CHG] Controller 00:1B:DC:07:31:88 SupportedInstances: 0x04
[CHG] Controller 00:1B:DC:07:31:88 ActiveInstances: 0x01
Advertising object registered
Tx Power: off
Name: off
Apperance: off
---
 src/shared/shell.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 0ac492886..0f6d613bd 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -62,6 +62,10 @@ struct bt_shell_env {
 };
 
 static struct {
+	int argc;
+	char **argv;
+	bool mode;
+	int timeout;
 	struct io *input;
 
 	bool saved_prompt;
@@ -373,6 +377,9 @@ void bt_shell_printf(const char *fmt, ...)
 	char *saved_line;
 	int saved_point;
 
+	if (!data.input)
+		return;
+
 	save_input = !RL_ISSTATE(RL_STATE_DONE);
 
 	if (save_input) {
@@ -744,6 +751,7 @@ static void rl_init(void)
 static const struct option main_options[] = {
 	{ "version",	no_argument, 0, 'v' },
 	{ "help",	no_argument, 0, 'h' },
+	{ "timeout",	required_argument, 0, 't' },
 };
 
 static void usage(int argc, char **argv, const struct bt_shell_opt *opt)
@@ -759,7 +767,8 @@ static void usage(int argc, char **argv, const struct bt_shell_opt *opt)
 	for (i = 0; opt && opt->options[i].name; i++)
 		printf("\t--%s \t%s\n", opt->options[i].name, opt->help[i]);
 
-	printf("\t--version \tDisplay version\n"
+	printf("\t--timeout \t\tTimeout in seconds for non-interactive mode\n"
+		"\t--version \tDisplay version\n"
 		"\t--help \t\tDisplay help\n");
 }
 
@@ -791,6 +800,9 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
 			usage(argc, argv, opt);
 			exit(EXIT_SUCCESS);
 			return;
+		case 't':
+			data.timeout = atoi(optarg);
+			break;
 		default:
 			if (c != opt->options[index - offset].val) {
 				usage(argc, argv, opt);
@@ -802,6 +814,10 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
 		}
 	}
 
+	data.argc = argc - optind;
+	data.argv = argv + optind;
+	data.mode = (data.argc > 0);
+
 	main_loop = g_main_loop_new(NULL, FALSE);
 
 	rl_init();
@@ -873,7 +889,7 @@ bool bt_shell_add_submenu(const struct bt_shell_menu *menu)
 
 void bt_shell_set_prompt(const char *string)
 {
-	if (!main_loop)
+	if (!main_loop || data.mode)
 		return;
 
 	rl_set_prompt(string);
@@ -888,6 +904,13 @@ static bool input_read(struct io *io, void *user_data)
 	return true;
 }
 
+static gboolean shell_quit(void *data)
+{
+	g_main_loop_quit(main_loop);
+
+	return FALSE;
+}
+
 bool bt_shell_attach(int fd)
 {
 	struct io *io;
@@ -903,6 +926,16 @@ bool bt_shell_attach(int fd)
 
 	data.input = io;
 
+	if (data.mode) {
+		shell_exec(data.argc, data.argv);
+
+		if (!data.timeout) {
+			bt_shell_detach();
+			g_main_loop_quit(main_loop);
+		} else
+			g_timeout_add_seconds(data.timeout, shell_quit, NULL);
+	}
+
 	return true;
 }
 
-- 
2.14.3

