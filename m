Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 10/14] shared/shell: Allow executing submenu commands
Date: Mon, 26 Feb 2018 17:53:32 +0200
Message-Id: <20180226155336.25875-11-luiz.dentz@gmail.com>
In-Reply-To: <20180226155336.25875-1-luiz.dentz@gmail.com>
References: <20180226155336.25875-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes it possible to execute submenu commands directly from the
main menu by using the format <submenu>.<command>:

[bluetooth]# advertise.uuids 0x1820
[bluetooth]# advertise.name blah
[bluetooth]# advertise on
Advertising object registered
UUID: Internet Protocol Support(0x1820)
Tx Power: off
LocalName: blah
Apperance: off
---
 src/shared/shell.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index b5556a288..cd46532fe 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -356,6 +356,34 @@ static int menu_exec(const struct bt_shell_menu_entry *entry,
 	return -ENOENT;
 }
 
+static int submenu_exec(int argc, char *argv[])
+{
+	char *name;
+	int len, tlen;
+	const struct bt_shell_menu *submenu;
+
+	if (data.menu != data.main)
+		return -ENOENT;
+
+	name = strchr(argv[0], '.');
+	if (!name)
+		return -ENOENT;
+
+	tlen = strlen(argv[0]);
+	len = name - argv[0];
+	name[0] = '\0';
+
+	submenu = find_menu(argv[0]);
+	if (!submenu)
+		return -ENOENT;
+
+	/* Replace submenu.command with command */
+	memmove(argv[0], argv[0] + len + 1, tlen - len - 1);
+	memset(argv[0] + tlen - len - 1, 0, len + 1);
+
+	return menu_exec(submenu->entries, argc, argv);
+}
+
 static void shell_exec(int argc, char *argv[])
 {
 	if (!data.menu || !argv[0])
@@ -363,10 +391,12 @@ static void shell_exec(int argc, char *argv[])
 
 	if (menu_exec(default_menu, argc, argv) == -ENOENT) {
 		if (menu_exec(data.menu->entries, argc, argv) == -ENOENT) {
-			print_text(COLOR_HIGHLIGHT,
+			if (submenu_exec(argc, argv) == -ENOENT) {
+				print_text(COLOR_HIGHLIGHT,
 					"Invalid command in menu %s: %s",
 					data.menu->name , argv[0]);
-			shell_print_help();
+				shell_print_help();
+			}
 		}
 	}
 }
-- 
2.14.3

