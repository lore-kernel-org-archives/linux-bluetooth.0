Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 09/14] tools: Add implementation of Playlists.GetPlaylists to mpris-player
Date: Wed, 15 May 2013 18:31:41 +0300
Message-Id: <1368631906-15951-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1368631906-15951-1-git-send-email-luiz.dentz@gmail.com>
References: <1368631906-15951-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 tools/mpris-player.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/tools/mpris-player.c b/tools/mpris-player.c
index 47e98d7..a067fe5 100644
--- a/tools/mpris-player.c
+++ b/tools/mpris-player.c
@@ -1797,8 +1797,49 @@ static DBusMessage *playlist_activate(DBusConnection *conn,
 static DBusMessage *playlist_get(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotImplemented",
-					"Not implemented");
+	struct player *player = data;
+	struct tracklist *tracklist = player->tracklist;
+	uint32_t index, count;
+	const char *order;
+	dbus_bool_t reverse;
+	DBusMessage *reply;
+	DBusMessageIter iter, entry, value, name;
+	const char *string;
+	const char *empty = "";
+
+	if (!dbus_message_get_args(msg, NULL,
+					DBUS_TYPE_UINT32, &index,
+					DBUS_TYPE_UINT32, &count,
+					DBUS_TYPE_STRING, &order,
+					DBUS_TYPE_BOOLEAN, &reverse,
+					DBUS_TYPE_INVALID))
+		return g_dbus_create_error(msg,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid Arguments");
+
+	reply = dbus_message_new_method_return(msg);
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY, "(oss)",
+								&entry);
+	dbus_message_iter_open_container(&entry, DBUS_TYPE_STRUCT, NULL,
+								&value);
+	dbus_message_iter_append_basic(&value, DBUS_TYPE_OBJECT_PATH,
+						&tracklist->playlist);
+	if (g_dbus_proxy_get_property(tracklist->proxy, "Name", &name)) {
+		dbus_message_iter_get_basic(&name, &string);
+		dbus_message_iter_append_basic(&value, DBUS_TYPE_STRING,
+								&string);
+	} else {
+		dbus_message_iter_append_basic(&value, DBUS_TYPE_STRING,
+							&tracklist->playlist);
+	}
+	dbus_message_iter_append_basic(&value, DBUS_TYPE_STRING, &empty);
+	dbus_message_iter_close_container(&entry, &value);
+	dbus_message_iter_close_container(&iter, &entry);
+
+	return reply;
 }
 
 static const GDBusMethodTable playlist_methods[] = {
-- 
1.8.1.4

