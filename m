Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: [PATCH BlueZ v2 1/2] tools/bluetooth-player: Merge cmd_play{,_item}()
Message-ID: <053aee30-4bef-c9b6-c7b6-a0f954c7910c@jp.fujitsu.com>
Date: Mon, 12 Mar 2018 10:56:12 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
Changes since v1
 - separate into two patch which are 1/2 and 2/2.

 tools/bluetooth-player.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/tools/bluetooth-player.c b/tools/bluetooth-player.c
index 75650a722..13b70349e 100644
--- a/tools/bluetooth-player.c
+++ b/tools/bluetooth-player.c
@@ -115,15 +115,21 @@ static void play_reply(DBusMessage *message, void *user_data)
 	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
-static void cmd_play_item(int argc, char *argv[])
+static void cmd_play(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
 
-	proxy = g_dbus_proxy_lookup(items, NULL, argv[1],
+	if (argc > 1) {
+		proxy = g_dbus_proxy_lookup(items, NULL, argv[1],
 						BLUEZ_MEDIA_ITEM_INTERFACE);
-	if (proxy == NULL) {
-		bt_shell_printf("Item %s not available\n", argv[1]);
-		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		if (proxy == NULL) {
+			bt_shell_printf("Item %s not available\n", argv[1]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+	} else {
+		if (!check_default_player())
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		proxy = default_player;
 	}
 
 	if (g_dbus_proxy_method_call(proxy, "Play", NULL, play_reply,
@@ -132,24 +138,7 @@ static void cmd_play_item(int argc, char *argv[])
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	bt_shell_printf("Attempting to play %s\n", argv[1]);
-}
-
-static void cmd_play(int argc, char *argv[])
-{
-	if (argc > 1)
-		return cmd_play_item(argc, argv);
-
-	if (!check_default_player())
-		return bt_shell_noninteractive_quit(EXIT_FAILURE);
-
-	if (g_dbus_proxy_method_call(default_player, "Play", NULL, play_reply,
-							NULL, NULL) == FALSE) {
-		bt_shell_printf("Failed to play\n");
-		return bt_shell_noninteractive_quit(EXIT_FAILURE);
-	}
-
-	bt_shell_printf("Attempting to play\n");
+	bt_shell_printf("Attempting to play %s\n", argv[1] ? : "");
 }
 
 static void pause_reply(DBusMessage *message, void *user_data)
-- 
2.14.1

