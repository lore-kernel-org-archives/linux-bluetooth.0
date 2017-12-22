Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 3/8] tools/bluetooth-player: Use g_dbus_proxy_lookup()
 instead of find_*
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <6f0b4053-4936-8d8c-3095-d6326d9a0e93@jp.fujitsu.com>
Message-ID: <3f67b6ec-5001-7998-c450-88f23d2f7835@jp.fujitsu.com>
Date: Fri, 22 Dec 2017 16:35:39 +0900
MIME-Version: 1.0
In-Reply-To: <6f0b4053-4936-8d8c-3095-d6326d9a0e93@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Uses g_dbus_proxy_lookup() instead of find_{player,folder,item}
---
 tools/bluetooth-player.c | 96 +++++++++++++++++-------------------------------
 1 file changed, 33 insertions(+), 63 deletions(-)

diff --git a/tools/bluetooth-player.c b/tools/bluetooth-player.c
index b22de2775..4fbae0c0a 100644
--- a/tools/bluetooth-player.c
+++ b/tools/bluetooth-player.c
@@ -51,9 +51,9 @@
 
 static DBusConnection *dbus_conn;
 static GDBusProxy *default_player;
-static GSList *players = NULL;
-static GSList *folders = NULL;
-static GSList *items = NULL;
+static GList *players = NULL;
+static GList *folders = NULL;
+static GList *items = NULL;
 
 static void connect_handler(DBusConnection *connection, void *user_data)
 {
@@ -90,25 +90,12 @@ static void play_reply(DBusMessage *message, void *user_data)
 	bt_shell_printf("Play successful\n");
 }
 
-static GDBusProxy *find_item(const char *path)
-{
-	GSList *l;
-
-	for (l = items; l; l = g_slist_next(l)) {
-		GDBusProxy *proxy = l->data;
-
-		if (strcmp(path, g_dbus_proxy_get_path(proxy)) == 0)
-			return proxy;
-	}
-
-	return NULL;
-}
-
 static void cmd_play_item(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
 
-	proxy = find_item(argv[1]);
+	proxy = g_dbus_proxy_lookup(items, argv[1],
+						BLUEZ_MEDIA_ITEM_INTERFACE);
 	if (proxy == NULL) {
 		bt_shell_printf("Item %s not available\n", argv[1]);
 		return;
@@ -460,28 +447,14 @@ static void print_player(GDBusProxy *proxy, const char *description)
 
 static void cmd_list(int argc, char *arg[])
 {
-	GSList *l;
+	GList *l;
 
-	for (l = players; l; l = g_slist_next(l)) {
+	for (l = players; l; l = g_list_next(l)) {
 		GDBusProxy *proxy = l->data;
 		print_player(proxy, NULL);
 	}
 }
 
-static GDBusProxy *find_player(const char *path)
-{
-	GSList *l;
-
-	for (l = players; l; l = g_slist_next(l)) {
-		GDBusProxy *proxy = l->data;
-
-		if (strcmp(path, g_dbus_proxy_get_path(proxy)) == 0)
-			return proxy;
-	}
-
-	return NULL;
-}
-
 static void print_iter(const char *label, const char *name,
 						DBusMessageIter *iter)
 {
@@ -557,25 +530,12 @@ static void print_property(GDBusProxy *proxy, const char *name)
 	print_iter("\t", name, &iter);
 }
 
-static GDBusProxy *find_folder(const char *path)
-{
-	GSList *l;
-
-	for (l = folders; l; l = g_slist_next(l)) {
-		GDBusProxy *proxy = l->data;
-
-		if (strcmp(path, g_dbus_proxy_get_path(proxy)) == 0)
-			return proxy;
-	}
-
-	return NULL;
-}
-
 static void cmd_show_item(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
 
-	proxy = find_item(argv[1]);
+	proxy = g_dbus_proxy_lookup(items, argv[1],
+						BLUEZ_MEDIA_ITEM_INTERFACE);
 	if (!proxy) {
 		bt_shell_printf("Item %s not available\n", argv[1]);
 		return;
@@ -605,7 +565,8 @@ static void cmd_show(int argc, char *argv[])
 
 		proxy = default_player;
 	} else {
-		proxy = find_player(argv[1]);
+		proxy = g_dbus_proxy_lookup(players, argv[1],
+						BLUEZ_MEDIA_PLAYER_INTERFACE);
 		if (!proxy) {
 			bt_shell_printf("Player %s not available\n", argv[1]);
 			return;
@@ -623,7 +584,8 @@ static void cmd_show(int argc, char *argv[])
 	print_property(proxy, "Position");
 	print_property(proxy, "Track");
 
-	folder = find_folder(g_dbus_proxy_get_path(proxy));
+	folder = g_dbus_proxy_lookup(folders, g_dbus_proxy_get_path(proxy),
+					BLUEZ_MEDIA_FOLDER_INTERFACE);
 	if (folder == NULL)
 		return;
 
@@ -637,7 +599,7 @@ static void cmd_show(int argc, char *argv[])
 
 	dbus_message_iter_get_basic(&iter, &path);
 
-	item = find_item(path);
+	item = g_dbus_proxy_lookup(items, path, BLUEZ_MEDIA_ITEM_INTERFACE);
 	if (item == NULL)
 		return;
 
@@ -650,7 +612,8 @@ static void cmd_select(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
 
-	proxy = find_player(argv[1]);
+	proxy = g_dbus_proxy_lookup(players, argv[1],
+						BLUEZ_MEDIA_PLAYER_INTERFACE);
 	if (proxy == NULL) {
 		bt_shell_printf("Player %s not available\n", argv[1]);
 		return;
@@ -697,7 +660,9 @@ static void cmd_change_folder(int argc, char *argv[])
 	if (check_default_player() == FALSE)
 		return;
 
-	proxy = find_folder(g_dbus_proxy_get_path(default_player));
+	proxy = g_dbus_proxy_lookup(folders,
+					g_dbus_proxy_get_path(default_player),
+					BLUEZ_MEDIA_FOLDER_INTERFACE);
 	if (proxy == NULL) {
 		bt_shell_printf("Operation not supported\n");
 		return;
@@ -799,7 +764,9 @@ static void cmd_list_items(int argc, char *argv[])
 	if (check_default_player() == FALSE)
 		return;
 
-	proxy = find_folder(g_dbus_proxy_get_path(default_player));
+	proxy = g_dbus_proxy_lookup(folders,
+					g_dbus_proxy_get_path(default_player),
+					BLUEZ_MEDIA_FOLDER_INTERFACE);
 	if (proxy == NULL) {
 		bt_shell_printf("Operation not supported\n");
 		return;
@@ -882,7 +849,9 @@ static void cmd_search(int argc, char *argv[])
 	if (check_default_player() == FALSE)
 		return;
 
-	proxy = find_folder(g_dbus_proxy_get_path(default_player));
+	proxy = g_dbus_proxy_lookup(folders,
+					g_dbus_proxy_get_path(default_player),
+					BLUEZ_MEDIA_FOLDER_INTERFACE);
 	if (proxy == NULL) {
 		bt_shell_printf("Operation not supported\n");
 		return;
@@ -919,7 +888,8 @@ static void cmd_queue(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
 
-	proxy = find_item(argv[1]);
+	proxy = g_dbus_proxy_lookup(items, argv[1],
+						BLUEZ_MEDIA_ITEM_INTERFACE);
 	if (proxy == NULL) {
 		bt_shell_printf("Item %s not available\n", argv[1]);
 		return;
@@ -970,7 +940,7 @@ static const struct bt_shell_menu main_menu = {
 
 static void player_added(GDBusProxy *proxy)
 {
-	players = g_slist_append(players, proxy);
+	players = g_list_append(players, proxy);
 
 	if (default_player == NULL)
 		default_player = proxy;
@@ -992,7 +962,7 @@ static void print_folder(GDBusProxy *proxy, const char *description)
 
 static void folder_added(GDBusProxy *proxy)
 {
-	folders = g_slist_append(folders, proxy);
+	folders = g_list_append(folders, proxy);
 
 	print_folder(proxy, COLORED_NEW);
 }
@@ -1017,7 +987,7 @@ static void print_item(GDBusProxy *proxy, const char *description)
 
 static void item_added(GDBusProxy *proxy)
 {
-	items = g_slist_append(items, proxy);
+	items = g_list_append(items, proxy);
 
 	print_item(proxy, COLORED_NEW);
 }
@@ -1043,19 +1013,19 @@ static void player_removed(GDBusProxy *proxy)
 	if (default_player == proxy)
 		default_player = NULL;
 
-	players = g_slist_remove(players, proxy);
+	players = g_list_remove(players, proxy);
 }
 
 static void folder_removed(GDBusProxy *proxy)
 {
-	folders = g_slist_remove(folders, proxy);
+	folders = g_list_remove(folders, proxy);
 
 	print_folder(proxy, COLORED_DEL);
 }
 
 static void item_removed(GDBusProxy *proxy)
 {
-	items = g_slist_remove(items, proxy);
+	items = g_list_remove(items, proxy);
 
 	print_item(proxy, COLORED_DEL);
 }
-- 
2.14.1

