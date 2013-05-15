Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 03/14] tools: Add implementation of TrackList.GoTo to mpris-player
Date: Wed, 15 May 2013 18:31:35 +0300
Message-Id: <1368631906-15951-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1368631906-15951-1-git-send-email-luiz.dentz@gmail.com>
References: <1368631906-15951-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 tools/mpris-player.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/tools/mpris-player.c b/tools/mpris-player.c
index 2e27ee2..3fa9cd6 100644
--- a/tools/mpris-player.c
+++ b/tools/mpris-player.c
@@ -1600,11 +1600,61 @@ static DBusMessage *tracklist_get_metadata(DBusConnection *conn,
 	return reply;
 }
 
+static void item_play_reply(DBusMessage *message, void *user_data)
+{
+	struct pending_call *p = user_data;
+	struct player *player = p->player;
+	DBusMessage *msg = p->msg;
+	DBusMessage *reply;
+	DBusError err;
+
+	dbus_error_init(&err);
+	if (dbus_set_error_from_message(&err, message)) {
+		fprintf(stderr, "error: %s", err.name);
+		reply = g_dbus_create_error(msg, err.name, "%s", err.message);
+		dbus_error_free(&err);
+	} else
+		reply = g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+
+	g_dbus_send_message(player->conn, reply);
+}
+
+static void item_play(struct player *player, DBusMessage *msg,
+							GDBusProxy *item)
+{
+	struct pending_call *p;
+
+	p = g_new0(struct pending_call, 1);
+	p->player = player;
+	p->msg = dbus_message_ref(msg);
+
+	g_dbus_proxy_method_call(item, "Play", NULL, item_play_reply,
+						p, pending_call_free);
+}
+
 static DBusMessage *tracklist_goto(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotImplemented",
-					"Not implemented");
+	struct player *player = data;
+	GDBusProxy *item;
+	const char *path;
+
+	if (!dbus_message_get_args(msg, NULL,
+					DBUS_TYPE_OBJECT_PATH, &path,
+					DBUS_TYPE_INVALID))
+		return g_dbus_create_error(msg,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments");
+
+	item = find_item(player, path);
+	if (item == NULL)
+		return g_dbus_create_error(msg,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments");
+
+	item_play(player, msg, item);
+
+	return NULL;
 }
 
 static DBusMessage *tracklist_add_track(DBusConnection *conn,
-- 
1.8.1.4

