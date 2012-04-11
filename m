Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>, <lucas.demarchi@profusion.mobi>,
	Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH v2 3/3] AVRCP: Add support to changing active player
Date: Wed, 11 Apr 2012 11:12:35 +0200
Message-ID: <1334135558-21866-1-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is possibility to register more then one player,so this patch
allow to change active player to the freely chosen previously registered
player.
---
 audio/avrcp.c     |   37 +++++++++++++++++++++++++++++
 audio/avrcp.h     |    1 +
 audio/media.c     |   66 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 doc/media-api.txt |   14 +++++++++++
 4 files changed, 118 insertions(+), 0 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index f0c9665..12016b3 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -1327,3 +1327,40 @@ void avrcp_unregister_player(struct avrcp_player *player)
 
 	player_destroy(player);
 }
+
+void avrcp_set_active_player(struct avrcp_player *player)
+{
+	struct avrcp_server *server = player->server;
+	uint8_t status;
+	uint64_t uid;
+
+	status = player->cb->get_status(player->user_data);
+	uid = player->cb->get_uid(player->user_data);
+
+	player_abort_pending_pdu(server->active_player);
+
+	if (status !=
+		server->active_player->cb->get_status(server->active_player->user_data))
+		avrcp_player_event(server->active_player, AVRCP_EVENT_STATUS_CHANGED,
+								&status);
+	avrcp_player_event(server->active_player, AVRCP_EVENT_TRACK_CHANGED,
+						&uid);
+
+	player->registered_events = server->active_player->registered_events;
+	server->active_player->registered_events = 0;
+	memcpy(player->transaction_events,
+				server->active_player->transaction_events, AVRCP_EVENT_LAST);
+
+	player->session = server->active_player->session;
+	server->active_player->session = NULL;
+
+	if (server->active_player->handler) {
+		avctp_unregister_pdu_handler(server->active_player->handler);
+		server->active_player->handler = 0;
+	}
+
+	player->handler = avctp_register_pdu_handler(AVC_OP_VENDORDEP,
+						handle_vendordep_pdu, player);
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
index c0fd0c3..99f1a9a 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -1705,11 +1705,77 @@ static DBusMessage *unregister_player(DBusConnection *conn, DBusMessage *msg,
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
+		if (path && g_strcmp0(mp->path, path) == 0) {
+			DBG("Activate player: %s", mp->path);
+
+			signal_msg = dbus_message_new_signal(mp->path,
+					MEDIA_PLAYER_INTERFACE,
+					"Activated");
+
+			if (signal_msg == NULL) {
+				DBG("Message null");
+				return NULL;
+			}
+
+			if (!dbus_connection_send(conn, signal_msg, NULL)) {
+				DBG("Out of memory");
+				return NULL;
+			}
+
+			dbus_message_unref(signal_msg);
+		} else {
+			signal_msg = dbus_message_new_signal(mp->path,
+					MEDIA_PLAYER_INTERFACE,
+					"Deactivated");
+
+			if (signal_msg == NULL) {
+				DBG("Message null");
+				return NULL;
+			}
+
+			if (!dbus_connection_send(conn, signal_msg, NULL)) {
+				DBG("Out of memory");
+				return NULL;
+			}
+
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
index c53ab7b..c64d1f5 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -123,6 +123,11 @@ Methods		void RegisterEndpoint(object endpoint, dict properties)
 
 			Unregister sender media player.
 
+		void SetActivePlayer(object player)
+
+			Set active media player. Only one active player may be used
+			by remote controller.
+
 MediaPlayer hierarchy
 =====================
 
@@ -188,6 +193,15 @@ Signals		PropertyChanged(string setting, variant value)
 
 					Track duration in milliseconds
 
+		Activated()
+
+			This signal indicates one player to be currently used.
+
+		Deactivated()
+
+			This signal sends to all non-active players and indicates that
+			player lose focus.
+
 Properties	string Equalizer [readwrite]
 
 			Possible values: "off" or "on"
-- 
on behalf of ST-Ericsson

