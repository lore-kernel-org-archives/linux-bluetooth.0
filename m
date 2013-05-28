Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 07/13] player: Add support for MediaItem.Metadata property
Date: Tue, 28 May 2013 15:51:25 +0300
Message-Id: <1369745491-23897-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1369745491-23897-1-git-send-email-luiz.dentz@gmail.com>
References: <1369745491-23897-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 profiles/audio/player.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index e7fe6ba..deae112 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -66,6 +66,7 @@ struct media_item {
 	player_folder_type_t	folder_type;	/* Folder type */
 	bool			playable;	/* Item playable flag */
 	uint64_t		uid;		/* Item uid */
+	GHashTable		*metadata;	/* Item metadata */
 };
 
 struct media_folder {
@@ -760,6 +761,9 @@ static DBusMessage *media_folder_list_items(DBusConnection *conn,
 
 static void media_item_free(struct media_item *item)
 {
+	if (item->metadata != NULL)
+		g_hash_table_unref(item->metadata);
+
 	g_free(item->path);
 	g_free(item->name);
 	g_free(item);
@@ -1438,6 +1442,37 @@ static gboolean get_folder_type(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean metadata_exists(const GDBusPropertyTable *property, void *data)
+{
+	struct media_item *item = data;
+
+	return item->metadata != NULL;
+}
+
+static gboolean get_metadata(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_item *item = data;
+	DBusMessageIter dict;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&dict);
+
+	if (g_hash_table_size(item->metadata) > 0)
+		g_hash_table_foreach(item->metadata, append_metadata, &dict);
+	else if (item->name != NULL)
+		dict_append_entry(&dict, "Title", DBUS_TYPE_STRING,
+								&item->name);
+
+	dbus_message_iter_close_container(iter, &dict);
+
+	return TRUE;
+}
+
 static const GDBusMethodTable media_item_methods[] = {
 	{ GDBUS_EXPERIMENTAL_METHOD("Play", NULL, NULL,
 					media_item_play) },
@@ -1455,6 +1490,8 @@ static const GDBusPropertyTable media_item_properties[] = {
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ "Playable", "b", get_playable, NULL, NULL,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Metadata", "a{sv}", get_metadata, NULL, metadata_exists,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ }
 };
 
@@ -1513,8 +1550,11 @@ struct media_item *media_player_create_item(struct media_player *mp,
 		return NULL;
 	}
 
-	if (type != PLAYER_ITEM_TYPE_FOLDER)
+	if (type != PLAYER_ITEM_TYPE_FOLDER) {
 		folder->items = g_slist_prepend(folder->items, item);
+		item->metadata = g_hash_table_new_full(g_str_hash, g_str_equal,
+							g_free, g_free);
+	}
 
 	DBG("%s", item->path);
 
-- 
1.8.1.4

