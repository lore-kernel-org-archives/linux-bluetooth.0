Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/shell: Print commands when --help option is given
Date: Fri,  7 Sep 2018 11:18:59 +0300
Message-Id: <20180907081859.19943-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables the user to see what command could be given in the
non-interactive mode e.g:

> bluetooth-player --help
bluetooth-player ver 5.50
Usage:
	bluetooth-player [--options] [commands]
Options:
	--timeout 	Timeout in seconds for non-interactive mode
	--version 	Display version
	--help 		Display help
Commands:
	list		List available players
	show		Player information
	select		Select default player
	play		Start playback
	pause		Pause playback
	stop		Stop playback
	next		Jump to next item
	previous	Jump to previous item
	fast-forward	Fast forward playback
	rewind		Rewind playback
	equalizer	Enable/Disable equalizer
	repeat		Set repeat mode
	shuffle		Set shuffle mode
	scan		Set scan mode
	change-folder	Change current folder
	list-items	List items of current folder
	search		Search items containing string
	queue		Add item to playlist queue
	show-item	Show item information
---
 src/shared/shell.c | 54 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 53f513613..9b0125579 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -61,6 +61,8 @@ struct bt_shell_env {
 	void *value;
 };
 
+static char *cmplt = "help";
+
 static struct {
 	bool init;
 	char *name;
@@ -97,9 +99,41 @@ static void cmd_quit(int argc, char *argv[])
 	mainloop_quit();
 }
 
+static void print_cmds(void)
+{
+	const struct bt_shell_menu_entry *entry;
+	const struct queue_entry *submenu;
+
+	if (!data.menu)
+		return;
+
+	printf("Commands:\n");
+
+	for (entry = data.menu->entries; entry->cmd; entry++) {
+		printf("\t%s%s\t%s\n", entry->cmd,
+			strlen(entry->cmd) < 8 ? "\t" : "", entry->desc);
+	}
+
+	for (submenu = queue_get_entries(data.submenus); submenu;
+					submenu = submenu->next) {
+		struct bt_shell_menu *menu = submenu->data;
+
+		printf("\n\t%s.:\n", menu->name);
+
+		for (entry = menu->entries; entry->cmd; entry++) {
+			printf("\t\t%s%s\t%s\n", entry->cmd,
+				strlen(entry->cmd) < 8 ? "\t" : "",
+				entry->desc);
+		}
+	}
+}
+
 static void cmd_help(int argc, char *argv[])
 {
-	shell_print_menu();
+	if (argv[0] == cmplt)
+		print_cmds();
+	else
+		shell_print_menu();
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
@@ -955,11 +989,18 @@ static const struct option main_options[] = {
 
 static void usage(int argc, char **argv, const struct bt_shell_opt *opt)
 {
+	const char *name;
 	unsigned int i;
 
-	printf("%s ver %s\n", argv[0], VERSION);
+	name = strrchr(argv[0], '/');
+	if (!name)
+		name = argv[0];
+	else
+		name++;
+
+	printf("%s ver %s\n", name, VERSION);
 	printf("Usage:\n"
-		"\t%s [options]\n", argv[0]);
+		"\t%s [--options] [commands]\n", name);
 
 	printf("Options:\n");
 
@@ -997,8 +1038,10 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
 			return;
 		case 'h':
 			usage(argc, argv, opt);
-			exit(EXIT_SUCCESS);
-			return;
+			data.argc = 1;
+			data.argv = &cmplt;
+			data.mode = 1;
+			goto done;
 		case 't':
 			data.timeout = atoi(optarg);
 			break;
@@ -1030,6 +1073,7 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
 	optind = 0;
 	data.mode = (data.argc > 0);
 
+done:
 	if (data.mode)
 		bt_shell_set_env("NON_INTERACTIVE", &data.mode);
 
-- 
2.17.1
