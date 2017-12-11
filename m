Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 2/4] toosl/bluetooth-player: Remove extra commands
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <8b962f05-12c2-8bd9-31ca-1700a45bbdae@jp.fujitsu.com>
Message-ID: <0eb18573-40ae-f77f-e0af-7f3b563e1ecc@jp.fujitsu.com>
Date: Mon, 11 Dec 2017 16:16:34 +0900
MIME-Version: 1.0
In-Reply-To: <8b962f05-12c2-8bd9-31ca-1700a45bbdae@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Removes the output of redundant commands in bluetooth-player since the
previous patch ("shared/shell: Fix hidden default menu if no submenu")
made bluetooth-player output the default menu.
---
 tools/bluetooth-player.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/tools/bluetooth-player.c b/tools/bluetooth-player.c
index f819488f3..b22de2775 100644
--- a/tools/bluetooth-player.c
+++ b/tools/bluetooth-player.c
@@ -49,7 +49,6 @@
 #define BLUEZ_MEDIA_FOLDER_INTERFACE "org.bluez.MediaFolder1"
 #define BLUEZ_MEDIA_ITEM_INTERFACE "org.bluez.MediaItem1"
 
-static GMainLoop *main_loop;
 static DBusConnection *dbus_conn;
 static GDBusProxy *default_player;
 static GSList *players = NULL;
@@ -66,11 +65,6 @@ static void disconnect_handler(DBusConnection *connection, void *user_data)
 	bt_shell_set_prompt(PROMPT_OFF);
 }
 
-static void cmd_quit(int argc, char *argv[])
-{
-	g_main_loop_quit(main_loop);
-}
-
 static bool check_default_player(void)
 {
 	if (!default_player) {
@@ -971,9 +965,6 @@ static const struct bt_shell_menu main_menu = {
 					"Search items containing string" },
 	{ "queue",       "<item>",    cmd_queue, "Add item to playlist queue" },
 	{ "show-item",   "<item>",    cmd_show_item, "Show item information" },
-	{ "quit",         NULL,       cmd_quit, "Quit program" },
-	{ "exit",         NULL,       cmd_quit },
-	{ "help" },
 	{} },
 };
 
-- 
2.14.1

