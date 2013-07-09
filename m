Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 09/21] audio/AVRCP: Remove dependency on struct audio_device
Date: Tue,  9 Jul 2013 17:39:06 +0300
Message-Id: <1373380758-16489-13-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1373380758-16489-1-git-send-email-luiz.dentz@gmail.com>
References: <1373380758-16489-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is part of the work necessary to completely remove
struct audio_device
---
 profiles/audio/avrcp.c     | 51 ++++++++++++++++++++++------------------------
 profiles/audio/avrcp.h     |  8 ++++----
 profiles/audio/device.c    |  8 ++++----
 profiles/audio/manager.c   |  2 +-
 profiles/audio/media.c     | 11 +++++-----
 profiles/audio/transport.c | 12 +++++------
 profiles/audio/transport.h |  4 ++--
 7 files changed, 47 insertions(+), 49 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 1a5c477..cd0a736 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -53,7 +53,6 @@
 
 #include "log.h"
 #include "error.h"
-#include "device.h"
 #include "manager.h"
 #include "avctp.h"
 #include "avrcp.h"
@@ -213,7 +212,7 @@ struct avrcp_player {
 struct avrcp {
 	struct avrcp_server *server;
 	struct avctp *conn;
-	struct audio_device *dev;
+	struct btd_device *dev;
 	struct avrcp_player *player;
 	gboolean target;
 	uint16_t version;
@@ -1417,7 +1416,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 						uint8_t transaction)
 {
 	struct avrcp_player *player = session->player;
-	struct audio_device *dev = session->dev;
+	struct btd_device *dev = session->dev;
 	uint16_t len = ntohs(pdu->params_len);
 	uint64_t uid;
 	GList *settings;
@@ -2820,7 +2819,7 @@ static struct avrcp_player *create_ct_player(struct avrcp *session,
 	player = g_new0(struct avrcp_player, 1);
 	player->sessions = g_slist_prepend(player->sessions, session);
 
-	path = device_get_path(session->dev->btd_dev);
+	path = device_get_path(session->dev);
 
 	mp = media_player_controller_create(path, id);
 	if (mp == NULL)
@@ -3256,7 +3255,7 @@ static struct avrcp *find_session(GSList *list, struct btd_device *dev)
 	for (; list; list = list->next) {
 		struct avrcp *session = list->data;
 
-		if (session->dev->btd_dev == dev)
+		if (session->dev == dev)
 			return session;
 	}
 
@@ -3316,8 +3315,7 @@ static void session_tg_init_control(struct avrcp *session)
 		avrcp_register_notification(session,
 						AVRCP_EVENT_VOLUME_CHANGED);
 
-	service = btd_device_get_service(session->dev->btd_dev,
-							AVRCP_REMOTE_UUID);
+	service = btd_device_get_service(session->dev, AVRCP_REMOTE_UUID);
 	if (service != NULL)
 		btd_service_connecting_complete(service, 0);
 }
@@ -3346,9 +3344,7 @@ static void session_ct_init_control(struct avrcp *session)
 	if (session->version >= 0x0104)
 		session->supported_events = (1 << AVRCP_EVENT_VOLUME_CHANGED);
 
-
-	service = btd_device_get_service(session->dev->btd_dev,
-							AVRCP_TARGET_UUID);
+	service = btd_device_get_service(session->dev, AVRCP_TARGET_UUID);
 	if (service != NULL)
 		btd_service_connecting_complete(service, 0);
 
@@ -3390,8 +3386,7 @@ static void session_tg_destroy(struct avrcp *session)
 	if (player != NULL)
 		player->sessions = g_slist_remove(player->sessions, session);
 
-	service = btd_device_get_service(session->dev->btd_dev,
-							AVRCP_REMOTE_UUID);
+	service = btd_device_get_service(session->dev, AVRCP_REMOTE_UUID);
 	if (service == NULL)
 		return session_destroy(session);
 
@@ -3411,8 +3406,7 @@ static void session_ct_destroy(struct avrcp *session)
 
 	g_slist_free_full(session->players, player_destroy);
 
-	service = btd_device_get_service(session->dev->btd_dev,
-							AVRCP_TARGET_UUID);
+	service = btd_device_get_service(session->dev, AVRCP_TARGET_UUID);
 	if (service == NULL)
 		return session_destroy(session);
 
@@ -3431,25 +3425,28 @@ static struct avrcp *session_create(struct avrcp_server *server,
 	const sdp_record_t *rec;
 	sdp_list_t *list;
 	sdp_profile_desc_t *desc;
-	struct audio_device *dev = manager_get_audio_device(device, FALSE);
+	struct btd_service *sink, *source;
 
 	session = g_new0(struct avrcp, 1);
 	session->server = server;
 	session->conn = avctp_connect(device);
-	session->dev = dev;
+	session->dev = device;
 
 	server->sessions = g_slist_append(server->sessions, session);
 
+	sink = btd_device_get_service(device, A2DP_SINK_UUID);
+	source = btd_device_get_service(device, A2DP_SOURCE_UUID);
+
 	/* If sink and source are not supported assume the controller must
 	 * be the initiator
 	 */
-	if (dev->sink == NULL && dev->source == NULL)
+	if (sink == NULL && source == NULL)
 		session->target = !avctp_is_initiator(session->conn);
-	else if (dev->sink && !dev->source)
+	else if (sink && !source)
 		session->target = TRUE;
-	else if (dev->source && !dev->sink)
+	else if (source && !sink)
 		session->target = FALSE;
-	else if (dev->sink && sink_is_active(dev->sink))
+	else if (sink && sink_is_active(sink))
 		session->target = TRUE;
 	else
 		session->target = FALSE;
@@ -3535,22 +3532,22 @@ static void state_changed(struct btd_device *device, avctp_state_t old_state,
 	}
 }
 
-gboolean avrcp_connect(struct audio_device *dev)
+gboolean avrcp_connect(struct btd_device *dev)
 {
 	struct avctp *session;
 
-	session = avctp_connect(dev->btd_dev);
+	session = avctp_connect(dev);
 	if (session)
 		return FALSE;
 
 	return TRUE;
 }
 
-void avrcp_disconnect(struct audio_device *dev)
+void avrcp_disconnect(struct btd_device *dev)
 {
 	struct avctp *session;
 
-	session = avctp_get(dev->btd_dev);
+	session = avctp_get(dev);
 	if (!session)
 		return;
 
@@ -3781,18 +3778,18 @@ static gboolean avrcp_handle_set_volume(struct avctp *conn,
 	return FALSE;
 }
 
-int avrcp_set_volume(struct audio_device *dev, uint8_t volume)
+int avrcp_set_volume(struct btd_device *dev, uint8_t volume)
 {
 	struct avrcp_server *server;
 	struct avrcp *session;
 	uint8_t buf[AVRCP_HEADER_LENGTH + 2];
 	struct avrcp_header *pdu = (void *) buf;
 
-	server = find_server(servers, device_get_adapter(dev->btd_dev));
+	server = find_server(servers, device_get_adapter(dev));
 	if (server == NULL)
 		return -EINVAL;
 
-	session = find_session(server->sessions, dev->btd_dev);
+	session = find_session(server->sessions, dev);
 	if (session == NULL)
 		return -ENOTCONN;
 
diff --git a/profiles/audio/avrcp.h b/profiles/audio/avrcp.h
index 6a435e6..2ec1664 100644
--- a/profiles/audio/avrcp.h
+++ b/profiles/audio/avrcp.h
@@ -91,7 +91,7 @@ struct avrcp_player_cb {
 	const char *(*get_status) (void *user_data);
 	uint32_t (*get_position) (void *user_data);
 	uint32_t (*get_duration) (void *user_data);
-	void (*set_volume) (uint8_t volume, struct audio_device *dev,
+	void (*set_volume) (uint8_t volume, struct btd_device *dev,
 							void *user_data);
 	bool (*play) (void *user_data);
 	bool (*stop) (void *user_data);
@@ -105,9 +105,9 @@ void avrcp_target_unregister(struct btd_adapter *adapter);
 int avrcp_remote_register(struct btd_adapter *adapter, GKeyFile *config);
 void avrcp_remote_unregister(struct btd_adapter *adapter);
 
-gboolean avrcp_connect(struct audio_device *dev);
-void avrcp_disconnect(struct audio_device *dev);
-int avrcp_set_volume(struct audio_device *dev, uint8_t volume);
+gboolean avrcp_connect(struct btd_device *dev);
+void avrcp_disconnect(struct btd_device *dev);
+int avrcp_set_volume(struct btd_device *dev, uint8_t volume);
 
 struct avrcp_player *avrcp_register_player(struct btd_adapter *adapter,
 						struct avrcp_player_cb *cb,
diff --git a/profiles/audio/device.c b/profiles/audio/device.c
index e9c36cc..9b2e393 100644
--- a/profiles/audio/device.c
+++ b/profiles/audio/device.c
@@ -106,7 +106,7 @@ static gboolean control_connect_timeout(gpointer user_data)
 	dev->priv->control_timer = 0;
 
 	if (dev->control)
-		avrcp_connect(dev);
+		avrcp_connect(dev->btd_dev);
 
 	return FALSE;
 }
@@ -150,7 +150,7 @@ static void disconnect_cb(struct btd_device *btd_dev, gboolean removal,
 	device_remove_control_timer(dev);
 
 	if (dev->control && priv->avctp_state != AVCTP_STATE_DISCONNECTED)
-		avrcp_disconnect(dev);
+		avrcp_disconnect(dev->btd_dev);
 
 	sink = btd_device_get_service(btd_dev, A2DP_SINK_UUID);
 	if (sink)
@@ -173,7 +173,7 @@ static void device_avdtp_cb(struct btd_device *device, struct avdtp *session,
 		if (avdtp_stream_setup_active(session))
 			device_set_control_timer(dev);
 		else
-			avrcp_connect(dev);
+			avrcp_connect(dev->btd_dev);
 	}
 }
 
@@ -191,7 +191,7 @@ static void device_sink_cb(struct audio_device *dev,
 		if (dev->control) {
 			device_remove_control_timer(dev);
 			if (priv->avctp_state != AVCTP_STATE_DISCONNECTED)
-				avrcp_disconnect(dev);
+				avrcp_disconnect(dev->btd_dev);
 		}
 		break;
 	case BTD_SERVICE_STATE_CONNECTING:
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 046638d..6b5e5d2 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -154,7 +154,7 @@ static int avrcp_target_probe(struct btd_service *service)
 	audio_dev->control = service;
 
 	if (audio_dev->sink && sink_is_active(audio_dev->sink))
-		avrcp_connect(audio_dev);
+		avrcp_connect(audio_dev->btd_dev);
 
 	return 0;
 }
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index d4d82cf..6fe5e04 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -379,9 +379,10 @@ static gboolean select_configuration(struct media_endpoint *endpoint,
 static int transport_device_cmp(gconstpointer data, gconstpointer user_data)
 {
 	struct media_transport *transport = (struct media_transport *) data;
-	const struct audio_device *device = user_data;
+	const struct btd_device *device = user_data;
+	const struct audio_device *dev = media_transport_get_dev(transport);
 
-	if (device == media_transport_get_dev(transport))
+	if (device == dev->btd_dev)
 		return 0;
 
 	return -1;
@@ -389,7 +390,7 @@ static int transport_device_cmp(gconstpointer data, gconstpointer user_data)
 
 static struct media_transport *find_device_transport(
 					struct media_endpoint *endpoint,
-					struct audio_device *device)
+					struct btd_device *device)
 {
 	GSList *match;
 
@@ -414,7 +415,7 @@ static gboolean set_configuration(struct media_endpoint *endpoint,
 	DBusMessageIter iter;
 	struct media_transport *transport;
 
-	transport = find_device_transport(endpoint, device);
+	transport = find_device_transport(endpoint, device->btd_dev);
 
 	if (transport != NULL)
 		return FALSE;
@@ -1148,7 +1149,7 @@ static uint32_t get_duration(void *user_data)
 	return mp->duration;
 }
 
-static void set_volume(uint8_t volume, struct audio_device *dev, void *user_data)
+static void set_volume(uint8_t volume, struct btd_device *dev, void *user_data)
 {
 	struct media_player *mp = user_data;
 	GSList *l;
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 6aa5d41..c8a806d 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -666,7 +666,7 @@ static void set_volume(const GDBusPropertyTable *property,
 	}
 
 	if (a2dp->volume != volume)
-		avrcp_set_volume(transport->device, volume);
+		avrcp_set_volume(transport->device->btd_dev, volume);
 
 	a2dp->volume = volume;
 
@@ -809,7 +809,7 @@ struct media_transport *media_transport_create(struct audio_device *device,
 							transport);
 		} else {
 			a2dp->volume = 127;
-			avrcp_set_volume(device, a2dp->volume);
+			avrcp_set_volume(device->btd_dev, a2dp->volume);
 			transport->source_watch = source_add_state_cb(
 							device->source,
 							source_state_changed,
@@ -883,7 +883,7 @@ void media_transport_update_volume(struct media_transport *transport,
 					MEDIA_TRANSPORT_INTERFACE, "Volume");
 }
 
-uint8_t media_transport_get_device_volume(struct audio_device *dev)
+uint8_t media_transport_get_device_volume(struct btd_device *dev)
 {
 	GSList *l;
 
@@ -892,7 +892,7 @@ uint8_t media_transport_get_device_volume(struct audio_device *dev)
 
 	for (l = transports; l; l = l->next) {
 		struct media_transport *transport = l->data;
-		if (transport->device != dev)
+		if (transport->device->btd_dev != dev)
 			continue;
 
 		/* Volume is A2DP only */
@@ -903,7 +903,7 @@ uint8_t media_transport_get_device_volume(struct audio_device *dev)
 	return 0;
 }
 
-void media_transport_update_device_volume(struct audio_device *dev,
+void media_transport_update_device_volume(struct btd_device *dev,
 								uint8_t volume)
 {
 	GSList *l;
@@ -913,7 +913,7 @@ void media_transport_update_device_volume(struct audio_device *dev,
 
 	for (l = transports; l; l = l->next) {
 		struct media_transport *transport = l->data;
-		if (transport->device != dev)
+		if (transport->device->btd_dev != dev)
 			continue;
 
 		/* Volume is A2DP only */
diff --git a/profiles/audio/transport.h b/profiles/audio/transport.h
index 5e5da20..1501bf4 100644
--- a/profiles/audio/transport.h
+++ b/profiles/audio/transport.h
@@ -39,6 +39,6 @@ void media_transport_update_volume(struct media_transport *transport,
 void transport_get_properties(struct media_transport *transport,
 							DBusMessageIter *iter);
 
-uint8_t media_transport_get_device_volume(struct audio_device *dev);
-void media_transport_update_device_volume(struct audio_device *dev,
+uint8_t media_transport_get_device_volume(struct btd_device *dev);
+void media_transport_update_device_volume(struct btd_device *dev,
 								uint8_t volume);
-- 
1.8.1.4

