Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 10/14] tools: Map mpris:trackid to Item in mpris-player
Date: Wed, 15 May 2013 18:31:42 +0300
Message-Id: <1368631906-15951-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1368631906-15951-1-git-send-email-luiz.dentz@gmail.com>
References: <1368631906-15951-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

mpris:trackid is used as identifier of the current track.
---
 tools/mpris-player.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/mpris-player.c b/tools/mpris-player.c
index a067fe5..cdda3ec 100644
--- a/tools/mpris-player.c
+++ b/tools/mpris-player.c
@@ -1326,6 +1326,21 @@ static gboolean parse_int32_metadata(DBusMessageIter *iter, const char *key,
 	return TRUE;
 }
 
+static gboolean parse_path_metadata(DBusMessageIter *iter, const char *key,
+						DBusMessageIter *metadata)
+{
+	const char *value;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_OBJECT_PATH)
+		return FALSE;
+
+	dbus_message_iter_get_basic(iter, &value);
+
+	dict_append_entry(metadata, key, DBUS_TYPE_OBJECT_PATH, &value);
+
+	return TRUE;
+}
+
 static int parse_track_entry(DBusMessageIter *entry, const char *key,
 						DBusMessageIter *metadata)
 {
@@ -1354,6 +1369,9 @@ static int parse_track_entry(DBusMessageIter *entry, const char *key,
 	} else if (strcasecmp(key, "TrackNumber") == 0) {
 		if (!parse_int32_metadata(&var, "xesam:trackNumber", metadata))
 			return -EINVAL;
+	} else if (strcasecmp(key, "Item") == 0) {
+		if (!parse_path_metadata(&var, "mpris:trackid", metadata))
+			return -EINVAL;
 	}
 
 	return 0;
@@ -1533,12 +1551,16 @@ static void append_item_metadata(void *data, void *user_data)
 	GDBusProxy *item = data;
 	DBusMessageIter *iter = user_data;
 	DBusMessageIter var, metadata;
+	const char *path = g_dbus_proxy_get_path(item);
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
 			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
 			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
 			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &metadata);
 
+	dict_append_entry(&metadata, "mpris:trackid", DBUS_TYPE_OBJECT_PATH,
+									&path);
+
 	if (g_dbus_proxy_get_property(item, "Metadata", &var))
 		parse_metadata(&var, &metadata, parse_track_entry);
 
-- 
1.8.1.4

