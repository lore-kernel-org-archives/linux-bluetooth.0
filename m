Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/shell: Enable generator for submenus
Date: Thu, 15 Mar 2018 15:52:42 +0200
Message-Id: <20180315135242.27251-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables command generator to work with submenu commands like:

[bluetooth]# advertise.
advertise.appearance    advertise.manufacturer  advertise.timeout
advertise.clear         advertise.name          advertise.tx-power
advertise.duration      advertise.service       advertise.uuids

Note that by default submenus commands will not be shown until . is
present in the input, that way only one command list is active at time.
---
 src/shared/shell.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 3b680d7b0..0a05b5215 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -102,7 +102,7 @@ static void cmd_help(int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
-static const struct bt_shell_menu *find_menu(const char *name)
+static const struct bt_shell_menu *find_menu(const char *name, size_t len)
 {
 	const struct queue_entry *entry;
 
@@ -110,8 +110,10 @@ static const struct bt_shell_menu *find_menu(const char *name)
 						entry = entry->next) {
 		struct bt_shell_menu *menu = entry->data;
 
-		if (!strcmp(menu->name, name))
+		if (!strncmp(menu->name, name, len))
 			return menu;
+
+
 	}
 
 	return NULL;
@@ -151,7 +153,7 @@ static void cmd_menu(int argc, char *argv[])
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	menu = find_menu(argv[1]);
+	menu = find_menu(argv[1], strlen(argv[1]));
 	if (!menu) {
 		bt_shell_printf("Unable find menu with name: %s\n", argv[1]);
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
@@ -403,7 +405,7 @@ static int submenu_exec(int argc, char *argv[])
 	len = name - argv[0];
 	name[0] = '\0';
 
-	submenu = find_menu(argv[0]);
+	submenu = find_menu(argv[0], strlen(argv[0]));
 	if (!submenu)
 		return -ENOENT;
 
@@ -601,12 +603,15 @@ static char *find_cmd(const char *text,
 static char *cmd_generator(const char *text, int state)
 {
 	static int index;
-	static bool default_menu_enabled;
+	static bool default_menu_enabled, submenu_enabled;
+	static const struct bt_shell_menu *menu;
 	char *cmd;
 
 	if (!state) {
 		index = 0;
+		menu = NULL;
 		default_menu_enabled = true;
+		submenu_enabled = false;
 	}
 
 	if (default_menu_enabled) {
@@ -615,11 +620,33 @@ static char *cmd_generator(const char *text, int state)
 			return cmd;
 		} else {
 			index = 0;
+			menu = data.menu;
 			default_menu_enabled = false;
 		}
 	}
 
-	return find_cmd(text, data.menu->entries, &index);
+	if (!submenu_enabled) {
+		cmd = find_cmd(text, menu->entries, &index);
+		if (cmd || menu != data.main)
+			return cmd;
+
+		cmd = strrchr(text, '.');
+		if (!cmd)
+			return NULL;
+
+		menu = find_menu(text, cmd - text);
+		if (!menu)
+			return NULL;
+
+		index = 0;
+		submenu_enabled = true;
+	}
+
+	cmd = find_cmd(text + strlen(menu->name) + 1, menu->entries, &index);
+	if (cmd)
+		asprintf(&cmd, "%s.%s", menu->name, cmd);
+
+	return cmd;
 }
 
 static wordexp_t args;
-- 
2.14.3

