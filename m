Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Vincent Petry <pvince81@googlemail.com>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: [PATCH BlueZ] shared/shell: Print out help if using invalid command
Message-ID: <360f80ad-6ec6-e285-b560-94404ee30bb6@jp.fujitsu.com>
Date: Tue, 6 Feb 2018 14:27:29 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Because Vincent Petry kindly reported that it is hard to use a command
in a submenu, clients are changed to print out help messages as below
when an invalid command is used.

  [bluetooth]# list-attributes
  Invalid command in menu main: list-attributes

  Use "help" for a list of available commands in a menu.
  Use "menu <submenu>" if you want to enter any submenu.
  Use "back" if you want to return to menu main.
---
 src/shared/shell.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index f1b85f202..47c048122 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -191,6 +191,15 @@ static const struct bt_shell_menu_entry default_menu[] = {
 	{ }
 };
 
+static void shell_print_help(void)
+{
+	print_text(COLOR_HIGHLIGHT,
+		"\n"
+		"Use \"help\" for a list of available commands in a menu.\n"
+		"Use \"menu <submenu>\" if you want to enter any submenu.\n"
+		"Use \"back\" if you want to return to menu main.");
+}
+
 static void shell_print_menu(void)
 {
 	const struct bt_shell_menu_entry *entry;
@@ -341,8 +350,12 @@ static void shell_exec(int argc, char *argv[])
 		return;
 
 	if (menu_exec(default_menu, argc, argv) == -ENOENT) {
-		if (menu_exec(data.menu->entries, argc, argv) == -ENOENT)
-			print_text(COLOR_HIGHLIGHT, "Invalid command");
+		if (menu_exec(data.menu->entries, argc, argv) == -ENOENT) {
+			print_text(COLOR_HIGHLIGHT,
+					"Invalid command in menu %s: %s",
+					data.menu->name , argv[0]);
+			shell_print_help();
+		}
 	}
 }
 
-- 
2.14.1

