Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH] AVRCP: Add support for changing active player
Date: Tue, 27 Mar 2012 12:28:13 +0200
Message-ID: <1332844093-1818-1-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is possibility to register more then one player, so this patch
allow to change active player to the freely chosen previously
registered player.
---
 audio/avrcp.c     |    7 ++++++
 audio/avrcp.h     |    1 +
 audio/media.c     |   62 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 doc/media-api.txt |    5 ++++
 4 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 8eba046..aba453a 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -1327,3 +1327,10 @@ void avrcp_unregister_player(struct avrcp_player *player)
 
 	player_destroy(player);
 }
+
+void avrcp_set_active_player(struct avrcp_player *player)
+{
+	struct avrcp_server *server = player->server;
+
+	server->active_player = player;
+}
diff --git a/audio/avrcp.h b/audio/avrcp.h
index 8a09546..f2041a7 100644
--- a/audio/avrcp.h
+++ b/audio/avrcp.h
@@ -96,6 +96,7 @@ struct avrcp_player *avrcp_register_player(const bdaddr_t *src,
 						void *user_data,
 						GDestroyNotify destroy);
 void avrcp_unregister_player(struct avrcp_player *player);
+void avrcp_set_active_player(struct avrcp_player *player);
 
 int avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data);
 
diff --git a/audio/media.c b/audio/media.c
index c0fd0c3..00b35ef 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -1705,11 +1705,73 @@ static DBusMessage *unregister_player(DBusConnection *conn, DBusMessage *msg,
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
+static DBusMessage *set_active_player(DBusConnection *conn, DBusMessage *msg,
+					void *data)
+{
+	struct media_adapter *adapter = data;
+	struct media_player *player;
+	const char *sender, *path;
+	DBusMessage *signal_msg;
+	GSList *l;
+
+	if (!dbus_message_get_args(msg, NULL,
+				DBUS_TYPE_OBJECT_PATH, &path,
+				DBUS_TYPE_INVALID))
+		return NULL;
+
+	sender = dbus_message_get_sender(msg);
+
+	player = media_adapter_find_player(adapter, sender, path);
+	if (player == NULL)
+		return btd_error_does_not_exist(msg);
+
+	avrcp_set_active_player(player->player);
+
+	for (l = adapter->players; l; l = l->next) {
+		struct media_player *mp = l->data;
+
+		if (sender && g_strcmp0(mp->sender, sender) != 0)
+			continue;
+
+		if (path && g_strcmp0(mp->path, path) == 0) {
+			DBG("activate player <%s>", mp->path);
+			signal_msg = dbus_message_new_signal(mp->path,
+					MEDIA_PLAYER_INTERFACE,
+					"Activated");
+			if (signal_msg == NULL) {
+				DBG("Message Null");
+				return NULL;
+			}
+			if (!dbus_connection_send(conn, signal_msg, NULL)) {
+				DBG("Out Of Memory");
+				return NULL;
+			}
+			dbus_message_unref(signal_msg);
+		} else {
+			signal_msg = dbus_message_new_signal(mp->path,
+					MEDIA_PLAYER_INTERFACE,
+					"Deactivated");
+			if (signal_msg == NULL) {
+				DBG("Message Null");
+				return NULL;
+			}
+			if (!dbus_connection_send(conn, signal_msg, NULL)) {
+				DBG("Out Of Memory");
+				return NULL;
+			}
+			dbus_message_unref(signal_msg);
+		}
+	}
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
 static GDBusMethodTable media_methods[] = {
 	{ "RegisterEndpoint",	"oa{sv}",	"",	register_endpoint },
 	{ "UnregisterEndpoint",	"o",		"",	unregister_endpoint },
 	{ "RegisterPlayer",	"oa{sv}a{sv}","",	register_player },
 	{ "UnregisterPlayer",	"o",		"",	unregister_player },
+	{ "SetActivePlayer",	"o",		"",	set_active_player },
 	{ },
 };
 
diff --git a/doc/media-api.txt b/doc/media-api.txt
index c53ab7b..d2c6f2e 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -123,6 +123,11 @@ Methods		void RegisterEndpoint(object endpoint, dict properties)
 
 			Unregister sender media player.
 
+		void SetActivePlayer(object player)
+
+			Set active media player. Only active player may be used
+			by remote controller.
+
 MediaPlayer hierarchy
 =====================
 
-- 
on behalf of ST-Ericsson

