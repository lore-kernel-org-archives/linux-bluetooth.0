Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 02/14] tools: Add implementation of TrackList.GetTracksMetadata to mpris-player
Date: Wed, 15 May 2013 18:31:34 +0300
Message-Id: <1368631906-15951-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1368631906-15951-1-git-send-email-luiz.dentz@gmail.com>
References: <1368631906-15951-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 tools/mpris-player.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 84 insertions(+), 2 deletions(-)

diff --git a/tools/mpris-player.c b/tools/mpris-player.c
index 3378227..2e27ee2 100644
--- a/tools/mpris-player.c
+++ b/tools/mpris-player.c
@@ -1511,11 +1511,93 @@ static const GDBusPropertyTable mpris_properties[] = {
 	{ }
 };
 
+static GDBusProxy *find_item(struct player *player, const char *path)
+{
+	struct tracklist *tracklist = player->tracklist;
+	GSList *l;
+
+	for (l = tracklist->items; l; l = l->next) {
+		GDBusProxy *proxy = l->data;
+		const char *p = g_dbus_proxy_get_path(proxy);
+
+		if (g_str_equal(path, p))
+			return proxy;
+	}
+
+	return NULL;
+}
+
+static void append_item_metadata(void *data, void *user_data)
+{
+	GDBusProxy *item = data;
+	DBusMessageIter *iter = user_data;
+	DBusMessageIter var, metadata;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &metadata);
+
+	if (g_dbus_proxy_get_property(item, "Metadata", &var))
+		parse_metadata(&var, &metadata, parse_track_entry);
+
+	dbus_message_iter_close_container(iter, &metadata);
+
+	return;
+}
+
 static DBusMessage *tracklist_get_metadata(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotImplemented",
-					"Not implemented");
+	struct player *player = data;
+	DBusMessage *reply;
+	DBusMessageIter args, array;
+	GSList *l = NULL;
+
+	dbus_message_iter_init(msg, &args);
+
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_ARRAY)
+		return g_dbus_create_error(msg,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid Arguments");
+
+	dbus_message_iter_recurse(&args, &array);
+
+	while (dbus_message_iter_get_arg_type(&array) ==
+						DBUS_TYPE_OBJECT_PATH) {
+		const char *path;
+		GDBusProxy *item;
+
+		dbus_message_iter_get_basic(&array, &path);
+
+		item = find_item(player, path);
+		if (item == NULL)
+			return g_dbus_create_error(msg,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid Arguments");
+
+		l = g_slist_append(l, item);
+
+		dbus_message_iter_next(&array);
+	}
+
+	reply = dbus_message_new_method_return(msg);
+
+	dbus_message_iter_init_append(reply, &args);
+
+	dbus_message_iter_open_container(&args, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_ARRAY_AS_STRING
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&array);
+
+	g_slist_foreach(l, append_item_metadata, &array);
+
+	dbus_message_iter_close_container(&args, &array);
+
+	return reply;
 }
 
 static DBusMessage *tracklist_goto(DBusConnection *conn,
-- 
1.8.1.4

