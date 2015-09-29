Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] audio/control: Add Player property to MediaControl1
Date: Tue, 29 Sep 2015 16:45:31 +0300
Message-Id: <1443534331-27997-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1443534331-27997-1-git-send-email-luiz.dentz@gmail.com>
References: <1443534331-27997-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds Player property to MediaControl1 interface which contains the
object path of the addressed player.
---
 profiles/audio/avrcp.c   | 17 +++++++++++++----
 profiles/audio/control.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 profiles/audio/control.h |  2 ++
 profiles/audio/player.c  |  5 +++++
 profiles/audio/player.h  |  1 +
 5 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index a3ed16a..44f8929 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3191,6 +3191,15 @@ static const struct media_player_callback ct_cbs = {
 	.total_items = ct_get_total_numberofitems,
 };
 
+static void set_ct_player(struct avrcp *session, struct avrcp_player *player)
+{
+	struct btd_service *service;
+
+	session->controller->player = player;
+	service = btd_device_get_service(session->dev, AVRCP_TARGET_UUID);
+	control_set_player(service, media_player_get_path(player->user_data));
+}
+
 static struct avrcp_player *create_ct_player(struct avrcp *session,
 								uint16_t id)
 {
@@ -3212,7 +3221,7 @@ static struct avrcp_player *create_ct_player(struct avrcp *session,
 	player->destroy = (GDestroyNotify) media_player_destroy;
 
 	if (session->controller->player == NULL)
-		session->controller->player = player;
+		set_ct_player(session, player);
 
 	session->controller->players = g_slist_prepend(
 						session->controller->players,
@@ -3327,8 +3336,8 @@ static void player_remove(gpointer data)
 
 		/* Check if current player is being removed */
 		if (controller->player == player)
-			controller->player = g_slist_nth_data(
-							controller->players, 0);
+			set_ct_player(session, g_slist_nth_data(
+						controller->players, 0));
 	}
 
 	player_destroy(player);
@@ -3503,7 +3512,7 @@ static void avrcp_addressed_player_changed(struct avrcp *session,
 	}
 
 	player->uid_counter = get_be16(&pdu->params[3]);
-	session->controller->player = player;
+	set_ct_player(session, player);
 
 	if (player->features != NULL)
 		return;
diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index d109d1f..5c48882 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -59,6 +59,7 @@
 
 #include "avctp.h"
 #include "control.h"
+#include "player.h"
 
 static GSList *devices = NULL;
 
@@ -68,6 +69,8 @@ struct control {
 	struct btd_service *target;
 	struct btd_service *remote;
 	unsigned int avctp_id;
+	const char *player;
+	GSList *players;
 };
 
 static void state_changed(struct btd_device *dev, avctp_state_t old_state,
@@ -81,9 +84,12 @@ static void state_changed(struct btd_device *dev, avctp_state_t old_state,
 	switch (new_state) {
 	case AVCTP_STATE_DISCONNECTED:
 		control->session = NULL;
+		control->player = NULL;
 
 		g_dbus_emit_property_changed(conn, path,
 					AUDIO_CONTROL_INTERFACE, "Connected");
+		g_dbus_emit_property_changed(conn, path,
+					AUDIO_CONTROL_INTERFACE, "Player");
 
 		break;
 	case AVCTP_STATE_CONNECTING:
@@ -215,6 +221,28 @@ static gboolean control_property_get_connected(
 	return TRUE;
 }
 
+static gboolean control_player_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct control *control = data;
+
+	return control->player != NULL;
+}
+
+static gboolean control_get_player(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct control *control = data;
+
+	if (!control->player)
+		return FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH,
+							&control->player);
+
+	return TRUE;
+}
+
 static const GDBusMethodTable control_methods[] = {
 	{ GDBUS_DEPRECATED_METHOD("Play", NULL, NULL, control_play) },
 	{ GDBUS_DEPRECATED_METHOD("Pause", NULL, NULL, control_pause) },
@@ -232,6 +260,7 @@ static const GDBusMethodTable control_methods[] = {
 
 static const GDBusPropertyTable control_properties[] = {
 	{ "Connected", "b", control_property_get_connected },
+	{ "Player", "o", control_get_player, NULL, control_player_exists },
 	{ }
 };
 
@@ -254,6 +283,7 @@ static void path_unregister(void *data)
 		btd_service_unref(control->remote);
 
 	devices = g_slist_remove(devices, control);
+	g_slist_free(control->players);
 	g_free(control);
 }
 
@@ -340,3 +370,22 @@ int control_init_remote(struct btd_service *service)
 
 	return 0;
 }
+
+int control_set_player(struct btd_service *service, const char *path)
+{
+	struct control *control = btd_service_get_user_data(service);
+
+	if (!control->session)
+		return -ENOTCONN;
+
+	if (g_strcmp0(control->player, path) == 0)
+		return -EALREADY;
+
+	control->player = path;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+					device_get_path(control->dev),
+					AUDIO_CONTROL_INTERFACE, "Player");
+
+	return 0;
+}
diff --git a/profiles/audio/control.h b/profiles/audio/control.h
index 4bda896..aab2631 100644
--- a/profiles/audio/control.h
+++ b/profiles/audio/control.h
@@ -32,3 +32,5 @@ void control_unregister(struct btd_service *service);
 
 int control_connect(struct btd_service *service);
 int control_disconnect(struct btd_service *service);
+
+int control_set_player(struct btd_service *service, const char *path);
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 147bcbf..4736396 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -1193,6 +1193,11 @@ struct media_player *media_player_controller_create(const char *path,
 	return mp;
 }
 
+const char *media_player_get_path(struct media_player *mp)
+{
+	return mp->path;
+}
+
 void media_player_set_duration(struct media_player *mp, uint32_t duration)
 {
 	char *value, *curval;
diff --git a/profiles/audio/player.h b/profiles/audio/player.h
index 0871904..4ad8bfe 100644
--- a/profiles/audio/player.h
+++ b/profiles/audio/player.h
@@ -70,6 +70,7 @@ struct media_player_callback {
 
 struct media_player *media_player_controller_create(const char *path,
 								uint16_t id);
+const char *media_player_get_path(struct media_player *mp);
 void media_player_destroy(struct media_player *mp);
 void media_player_set_duration(struct media_player *mp, uint32_t duration);
 void media_player_set_position(struct media_player *mp, uint32_t position);
-- 
2.4.3

