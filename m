Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ v2 7/8] tools/bluetooth-player: Add generator for
 player/item
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <2003783a-cdd8-597a-6438-967ffafe67c8@jp.fujitsu.com>
Message-ID: <7313dc41-ed66-425c-2189-fa6c12cc4c16@jp.fujitsu.com>
Date: Thu, 28 Dec 2017 14:44:20 +0900
MIME-Version: 1.0
In-Reply-To: <2003783a-cdd8-597a-6438-967ffafe67c8@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/bluetooth-player.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/tools/bluetooth-player.c b/tools/bluetooth-player.c
index 0ab8cab33..709ef5633 100644
--- a/tools/bluetooth-player.c
+++ b/tools/bluetooth-player.c
@@ -75,6 +75,27 @@ static bool check_default_player(void)
 	return TRUE;
 }
 
+static char *generic_generator(const char *text, int state, GList *source)
+{
+	static int index = 0;
+
+	if (!state) {
+		index = 0;
+	}
+
+	return g_dbus_proxy_path_lookup(source, &index, text);
+}
+
+static char *player_generator(const char *text, int state)
+{
+	return generic_generator(text, state, players);
+}
+
+static char *item_generator(const char *text, int state)
+{
+	return generic_generator(text, state, items);
+}
+
 static void play_reply(DBusMessage *message, void *user_data)
 {
 	DBusError error;
@@ -911,9 +932,12 @@ static const struct bt_shell_menu main_menu = {
 	.name = "main",
 	.entries = {
 	{ "list",         NULL,       cmd_list, "List available players" },
-	{ "show",         "[player]", cmd_show, "Player information" },
-	{ "select",       "<player>", cmd_select, "Select default player" },
-	{ "play",         "[item]",   cmd_play, "Start playback" },
+	{ "show",         "[player]", cmd_show, "Player information",
+							player_generator},
+	{ "select",       "<player>", cmd_select, "Select default player",
+							player_generator},
+	{ "play",         "[item]",   cmd_play, "Start playback",
+							item_generator},
 	{ "pause",        NULL,       cmd_pause, "Pause playback" },
 	{ "stop",         NULL,       cmd_stop, "Stop playback" },
 	{ "next",         NULL,       cmd_next, "Jump to next item" },
@@ -935,8 +959,10 @@ static const struct bt_shell_menu main_menu = {
 					"List items of current folder" },
 	{ "search",     "<string>",   cmd_search,
 					"Search items containing string" },
-	{ "queue",       "<item>",    cmd_queue, "Add item to playlist queue" },
-	{ "show-item",   "<item>",    cmd_show_item, "Show item information" },
+	{ "queue",       "<item>",    cmd_queue, "Add item to playlist queue",
+							item_generator},
+	{ "show-item",   "<item>",    cmd_show_item, "Show item information",
+							item_generator},
 	{} },
 };
 
-- 
2.14.1

