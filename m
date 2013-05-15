Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 08/14] tools: Add implementation of Playlists.ActivatePlaylist to mpris-player
Date: Wed, 15 May 2013 18:31:40 +0300
Message-Id: <1368631906-15951-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1368631906-15951-1-git-send-email-luiz.dentz@gmail.com>
References: <1368631906-15951-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 tools/mpris-player.c | 99 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 59 insertions(+), 40 deletions(-)

diff --git a/tools/mpris-player.c b/tools/mpris-player.c
index 9ac59b3..47e98d7 100644
--- a/tools/mpris-player.c
+++ b/tools/mpris-player.c
@@ -1730,11 +1730,68 @@ static const GDBusPropertyTable tracklist_properties[] = {
 	{ }
 };
 
+static void list_items_setup(DBusMessageIter *iter, void *user_data)
+{
+	DBusMessageIter dict;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&dict);
+	dbus_message_iter_close_container(iter, &dict);
+}
+
+static void change_folder_reply(DBusMessage *message, void *user_data)
+{
+	struct player *player = user_data;
+	struct tracklist *tracklist = player->tracklist;
+	DBusError err;
+
+	dbus_error_init(&err);
+	if (dbus_set_error_from_message(&err, message)) {
+		fprintf(stderr, "error: %s", err.name);
+		return;
+	}
+
+	g_dbus_proxy_method_call(tracklist->proxy, "ListItems",
+					list_items_setup, NULL, NULL, NULL);
+}
+
+static void change_folder_setup(DBusMessageIter *iter, void *user_data)
+{
+	struct player *player = user_data;
+	struct tracklist *tracklist = player->tracklist;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH,
+							&tracklist->playlist);
+}
+
 static DBusMessage *playlist_activate(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotImplemented",
-					"Not implemented");
+	struct player *player = data;
+	struct tracklist *tracklist = player->tracklist;
+	const char *path;
+
+	if (!dbus_message_get_args(msg, NULL,
+					DBUS_TYPE_OBJECT_PATH, &path,
+					DBUS_TYPE_INVALID))
+		return g_dbus_create_error(msg,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid Arguments");
+
+	if (!g_str_equal(path, tracklist->playlist))
+		return g_dbus_create_error(msg,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid Arguments");
+
+	g_dbus_proxy_method_call(tracklist->proxy, "ChangeFolder",
+				change_folder_setup, change_folder_reply,
+				player, NULL);
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
 static DBusMessage *playlist_get(DBusConnection *conn, DBusMessage *msg,
@@ -1848,44 +1905,6 @@ static GDBusProxy *find_transport_by_path(const char *path)
 	return NULL;
 }
 
-static void list_items_setup(DBusMessageIter *iter, void *user_data)
-{
-	DBusMessageIter dict;
-
-	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
-					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-					DBUS_TYPE_STRING_AS_STRING
-					DBUS_TYPE_VARIANT_AS_STRING
-					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
-					&dict);
-	dbus_message_iter_close_container(iter, &dict);
-}
-
-static void change_folder_reply(DBusMessage *message, void *user_data)
-{
-	struct player *player = user_data;
-	struct tracklist *tracklist = player->tracklist;
-	DBusError err;
-
-	dbus_error_init(&err);
-	if (dbus_set_error_from_message(&err, message)) {
-		fprintf(stderr, "error: %s", err.name);
-		return;
-	}
-
-	g_dbus_proxy_method_call(tracklist->proxy, "ListItems",
-					list_items_setup, NULL, NULL, NULL);
-}
-
-static void change_folder_setup(DBusMessageIter *iter, void *user_data)
-{
-	struct player *player = user_data;
-	struct tracklist *tracklist = player->tracklist;
-
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH,
-							&tracklist->playlist);
-}
-
 static void register_tracklist(struct player *player, const char *playlist)
 {
 	struct tracklist *tracklist;
-- 
1.8.1.4

