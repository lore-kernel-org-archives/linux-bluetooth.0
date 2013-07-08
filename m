Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 08/20] audio/AVDTP: Remove dependency on struct audio_device
Date: Mon,  8 Jul 2013 17:10:14 +0300
Message-Id: <1373292626-3776-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1373292626-3776-1-git-send-email-luiz.dentz@gmail.com>
References: <1373292626-3776-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is part of the work necessary to completely remove
struct audio_device
---
 profiles/audio/avdtp.c     | 97 +++++++++++++++++++++-------------------------
 profiles/audio/avdtp.h     | 13 ++++---
 profiles/audio/device.c    | 10 +++--
 profiles/audio/sink.c      | 24 ++++++------
 profiles/audio/source.c    | 31 +++++++--------
 profiles/audio/transport.c |  2 +-
 6 files changed, 87 insertions(+), 90 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index bd73572..07644e5 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -47,10 +47,9 @@
 #include "log.h"
 
 #include "lib/uuid.h"
-#include "../src/adapter.h"
-#include "../src/device.h"
+#include "src/adapter.h"
+#include "src/device.h"
 
-#include "device.h"
 #include "manager.h"
 #include "control.h"
 #include "avdtp.h"
@@ -356,8 +355,9 @@ struct stream_callback {
 
 struct avdtp_state_callback {
 	avdtp_session_state_cb cb;
-	struct audio_device *dev;
+	struct btd_device *dev;
 	unsigned int id;
+	void *user_data;
 };
 
 struct avdtp_stream {
@@ -714,24 +714,17 @@ static void avdtp_set_state(struct avdtp *session,
 					avdtp_session_state_t new_state)
 {
 	GSList *l;
-	struct audio_device *dev;
 	avdtp_session_state_t old_state = session->state;
 
 	session->state = new_state;
 
-	dev = manager_get_audio_device(avdtp_get_device(session), FALSE);
-	if (dev == NULL) {
-		error("%s(): No matching audio device", __func__);
-		return;
-	}
-
 	for (l = avdtp_callbacks; l != NULL; l = l->next) {
 		struct avdtp_state_callback *cb = l->data;
 
-		if (dev != cb->dev)
+		if (session->device != cb->dev)
 			continue;
 
-		cb->cb(dev, session, old_state, new_state);
+		cb->cb(cb->dev, session, old_state, new_state, cb->user_data);
 	}
 }
 
@@ -1155,21 +1148,27 @@ static void avdtp_free(void *data)
 static gboolean disconnect_timeout(gpointer user_data)
 {
 	struct avdtp *session = user_data;
-	struct audio_device *dev;
+	struct btd_service *service;
 	gboolean stream_setup;
 
 	session->dc_timer = 0;
 
 	stream_setup = session->stream_setup;
 	session->stream_setup = FALSE;
-	dev = manager_get_audio_device(session->device, FALSE);
 
-	if (dev && dev->sink && stream_setup)
-		sink_setup_stream(dev->sink, session);
-	else if (dev && dev->source && stream_setup)
-		source_setup_stream(dev->source, session);
-	else
-		connection_lost(session, ETIMEDOUT);
+	service = btd_device_get_service(session->device, A2DP_SINK_UUID);
+	if (service && stream_setup) {
+		sink_setup_stream(service, session);
+		return FALSE;
+	}
+
+	service = btd_device_get_service(session->device, A2DP_SOURCE_UUID);
+	if (service && stream_setup) {
+		source_setup_stream(service, session);
+		return FALSE;
+	}
+
+	connection_lost(session, ETIMEDOUT);
 
 	return FALSE;
 }
@@ -1458,7 +1457,7 @@ static gboolean avdtp_setconf_cmd(struct avdtp *session, uint8_t transaction,
 	struct avdtp_local_sep *sep;
 	struct avdtp_stream *stream;
 	uint8_t err, category = 0x00;
-	struct audio_device *dev;
+	struct btd_service *service;
 	GSList *l;
 
 	if (size < sizeof(struct setconf_req)) {
@@ -1477,18 +1476,15 @@ static gboolean avdtp_setconf_cmd(struct avdtp *session, uint8_t transaction,
 		goto failed;
 	}
 
-	dev = manager_get_audio_device(avdtp_get_device(session), FALSE);
-	if (!dev) {
-		error("Unable to get a audio device object");
-		err = AVDTP_BAD_STATE;
-		goto failed;
-	}
-
 	switch (sep->info.type) {
 	case AVDTP_SEP_TYPE_SOURCE:
-		if (!dev->sink) {
-			btd_device_add_uuid(dev->btd_dev, A2DP_SINK_UUID);
-			if (!dev->sink) {
+		service = btd_device_get_service(session->device,
+							A2DP_SINK_UUID);
+		if (service == NULL) {
+			btd_device_add_uuid(session->device, A2DP_SINK_UUID);
+			service = btd_device_get_service(session->device,
+							A2DP_SINK_UUID);
+			if (service == NULL) {
 				error("Unable to get a audio sink object");
 				err = AVDTP_BAD_STATE;
 				goto failed;
@@ -1496,9 +1492,13 @@ static gboolean avdtp_setconf_cmd(struct avdtp *session, uint8_t transaction,
 		}
 		break;
 	case AVDTP_SEP_TYPE_SINK:
-		if (!dev->source) {
-			btd_device_add_uuid(dev->btd_dev, A2DP_SOURCE_UUID);
-			if (!dev->source) {
+		service = btd_device_get_service(session->device,
+							A2DP_SOURCE_UUID);
+		if (service == NULL) {
+			btd_device_add_uuid(session->device, A2DP_SOURCE_UUID);
+			service = btd_device_get_service(session->device,
+							A2DP_SOURCE_UUID);
+			if (service == NULL) {
 				error("Unable to get a audio source object");
 				err = AVDTP_BAD_STATE;
 				goto failed;
@@ -2348,11 +2348,11 @@ static struct avdtp *avdtp_get_internal(struct btd_device *device)
 	return session;
 }
 
-struct avdtp *avdtp_get(struct audio_device *device)
+struct avdtp *avdtp_get(struct btd_device *device)
 {
 	struct avdtp *session;
 
-	session = avdtp_get_internal(device->btd_dev);
+	session = avdtp_get_internal(device);
 
 	if (!session)
 		return NULL;
@@ -2465,7 +2465,6 @@ static void auth_cb(DBusError *derr, void *user_data)
 static void avdtp_confirm_cb(GIOChannel *chan, gpointer data)
 {
 	struct avdtp *session;
-	struct audio_device *dev;
 	char address[18];
 	bdaddr_t src, dst;
 	GError *err = NULL;
@@ -2514,16 +2513,7 @@ static void avdtp_confirm_cb(GIOChannel *chan, gpointer data)
 		goto drop;
 	}
 
-	dev = manager_get_audio_device(device, FALSE);
-	if (!dev) {
-		dev = manager_get_audio_device(device, TRUE);
-		if (!dev) {
-			error("Unable to get audio device object for %s",
-					address);
-			goto drop;
-		}
-		btd_device_add_uuid(dev->btd_dev, ADVANCED_AUDIO_UUID);
-	}
+	btd_device_add_uuid(device, ADVANCED_AUDIO_UUID);
 
 	session->io = g_io_channel_ref(chan);
 	avdtp_set_state(session, AVDTP_SESSION_STATE_CONNECTING);
@@ -3186,16 +3176,16 @@ static gboolean avdtp_parse_rej(struct avdtp *session,
 	}
 }
 
-gboolean avdtp_is_connected(struct audio_device *device)
+gboolean avdtp_is_connected(struct btd_device *device)
 {
 	struct avdtp_server *server;
 	struct avdtp *session;
 
-	server = find_server(servers, device_get_adapter(device->btd_dev));
+	server = find_server(servers, device_get_adapter(device));
 	if (!server)
 		return FALSE;
 
-	session = find_session(server->sessions, device->btd_dev);
+	session = find_session(server->sessions, device);
 	if (!session)
 		return FALSE;
 
@@ -3922,8 +3912,8 @@ void avdtp_set_device_disconnect(struct avdtp *session, gboolean dev_dc)
 	session->device_disconnect = dev_dc;
 }
 
-unsigned int avdtp_add_state_cb(struct audio_device *dev,
-				avdtp_session_state_cb cb)
+unsigned int avdtp_add_state_cb(struct btd_device *dev,
+				avdtp_session_state_cb cb, void *user_data)
 {
 	struct avdtp_state_callback *state_cb;
 	static unsigned int id = 0;
@@ -3932,6 +3922,7 @@ unsigned int avdtp_add_state_cb(struct audio_device *dev,
 	state_cb->cb = cb;
 	state_cb->dev = dev;
 	state_cb->id = ++id;
+	state_cb->user_data = user_data;
 
 	avdtp_callbacks = g_slist_append(avdtp_callbacks, state_cb);
 
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index 4e6a597..4d3e6c8 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -116,10 +116,11 @@ struct avdtp_media_codec_capability {
 #error "Unknown byte order"
 #endif
 
-typedef void (*avdtp_session_state_cb) (struct audio_device *dev,
+typedef void (*avdtp_session_state_cb) (struct btd_device *dev,
 					struct avdtp *session,
 					avdtp_session_state_t old_state,
-					avdtp_session_state_t new_state);
+					avdtp_session_state_t new_state,
+					void *user_data);
 
 typedef void (*avdtp_stream_state_cb) (struct avdtp_stream *stream,
 					avdtp_state_t old_state,
@@ -212,12 +213,12 @@ struct avdtp_sep_ind {
 typedef void (*avdtp_discover_cb_t) (struct avdtp *session, GSList *seps,
 					struct avdtp_error *err, void *user_data);
 
-struct avdtp *avdtp_get(struct audio_device *device);
+struct avdtp *avdtp_get(struct btd_device *device);
 
 void avdtp_unref(struct avdtp *session);
 struct avdtp *avdtp_ref(struct avdtp *session);
 
-gboolean avdtp_is_connected(struct audio_device *device);
+gboolean avdtp_is_connected(struct btd_device *device);
 
 struct avdtp_service_capability *avdtp_service_cap_new(uint8_t category,
 							void *data, int size);
@@ -259,8 +260,8 @@ gboolean avdtp_stream_has_capabilities(struct avdtp_stream *stream,
 struct avdtp_remote_sep *avdtp_stream_get_remote_sep(
 						struct avdtp_stream *stream);
 
-unsigned int avdtp_add_state_cb(struct audio_device *dev,
-				avdtp_session_state_cb cb);
+unsigned int avdtp_add_state_cb(struct btd_device *dev,
+				avdtp_session_state_cb cb, void *user_data);
 
 gboolean avdtp_remove_state_cb(unsigned int id);
 
diff --git a/profiles/audio/device.c b/profiles/audio/device.c
index 0112cd1..e9c36cc 100644
--- a/profiles/audio/device.c
+++ b/profiles/audio/device.c
@@ -159,10 +159,13 @@ static void disconnect_cb(struct btd_device *btd_dev, gboolean removal,
 		priv->disconnecting = FALSE;
 }
 
-static void device_avdtp_cb(struct audio_device *dev, struct avdtp *session,
+static void device_avdtp_cb(struct btd_device *device, struct avdtp *session,
 				avdtp_session_state_t old_state,
-				avdtp_session_state_t new_state)
+				avdtp_session_state_t new_state,
+				void *user_data)
 {
+	struct audio_device *dev = user_data;
+
 	if (!dev->control)
 		return;
 
@@ -252,7 +255,8 @@ struct audio_device *audio_device_register(struct btd_device *device)
 							disconnect_cb, dev,
 							NULL);
 	dev->priv->service_cb_id = btd_service_add_state_cb(service_cb, dev);
-	dev->priv->avdtp_callback_id = avdtp_add_state_cb(dev, device_avdtp_cb);
+	dev->priv->avdtp_callback_id = avdtp_add_state_cb(device,
+							device_avdtp_cb, dev);
 	dev->priv->avctp_callback_id = avctp_add_state_cb(device,
 							device_avctp_cb, dev);
 
diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index 6a26a65..9f85cda 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -85,9 +85,9 @@ static char *str_state[] = {
 	"SINK_STATE_PLAYING",
 };
 
-static void sink_set_state(struct btd_service *service, sink_state_t new_state)
+static void sink_set_state(struct sink *sink, sink_state_t new_state)
 {
-	struct sink *sink = btd_service_get_user_data(service);
+	struct btd_service *service = sink->service;
 	struct btd_device *dev = btd_service_get_device(service);
 	sink_state_t old_state = sink->state;
 	GSList *l;
@@ -115,19 +115,20 @@ static void sink_set_state(struct btd_service *service, sink_state_t new_state)
 	}
 }
 
-static void avdtp_state_callback(struct audio_device *dev,
+static void avdtp_state_callback(struct btd_device *dev,
 					struct avdtp *session,
 					avdtp_session_state_t old_state,
-					avdtp_session_state_t new_state)
+					avdtp_session_state_t new_state,
+					void *user_data)
 {
-	struct sink *sink = btd_service_get_user_data(dev->sink);
+	struct sink *sink = user_data;
 
 	switch (new_state) {
 	case AVDTP_SESSION_STATE_DISCONNECTED:
-		sink_set_state(dev->sink, SINK_STATE_DISCONNECTED);
+		sink_set_state(sink, SINK_STATE_DISCONNECTED);
 		break;
 	case AVDTP_SESSION_STATE_CONNECTING:
-		sink_set_state(dev->sink, SINK_STATE_CONNECTING);
+		sink_set_state(sink, SINK_STATE_CONNECTING);
 		break;
 	case AVDTP_SESSION_STATE_CONNECTED:
 		break;
@@ -166,10 +167,10 @@ static void stream_state_changed(struct avdtp_stream *stream,
 		break;
 	case AVDTP_STATE_OPEN:
 		btd_service_connecting_complete(sink->service, 0);
-		sink_set_state(service, SINK_STATE_CONNECTED);
+		sink_set_state(sink, SINK_STATE_CONNECTED);
 		break;
 	case AVDTP_STATE_STREAMING:
-		sink_set_state(service, SINK_STATE_PLAYING);
+		sink_set_state(sink, SINK_STATE_PLAYING);
 		break;
 	case AVDTP_STATE_CONFIGURED:
 	case AVDTP_STATE_CLOSING:
@@ -308,7 +309,7 @@ int sink_connect(struct btd_service *service)
 	struct sink *sink = btd_service_get_user_data(service);
 
 	if (!sink->session)
-		sink->session = avdtp_get(sink->dev);
+		sink->session = avdtp_get(btd_service_get_device(service));
 
 	if (!sink->session) {
 		DBG("Unable to get a session");
@@ -385,7 +386,8 @@ int sink_init(struct audio_device *dev, struct btd_service *service)
 	sink->dev = dev;
 	sink->service = btd_service_ref(service);
 
-	sink->avdtp_callback_id = avdtp_add_state_cb(dev, avdtp_state_callback);
+	sink->avdtp_callback_id = avdtp_add_state_cb(dev->btd_dev,
+						avdtp_state_callback, sink);
 
 	btd_service_set_user_data(service, sink);
 
diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index 5fed576..f9eade5 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -86,10 +86,8 @@ static char *str_state[] = {
 	"SOURCE_STATE_PLAYING",
 };
 
-static void source_set_state(struct btd_service *service,
-						source_state_t new_state)
+static void source_set_state(struct source *source, source_state_t new_state)
 {
-	struct source *source = btd_service_get_user_data(service);
 	struct audio_device *dev = source->dev;
 	source_state_t old_state = source->state;
 	GSList *l;
@@ -102,10 +100,10 @@ static void source_set_state(struct btd_service *service,
 	for (l = source_callbacks; l != NULL; l = l->next) {
 		struct source_state_callback *cb = l->data;
 
-		if (cb->service != service)
+		if (cb->service != source->service)
 			continue;
 
-		cb->cb(service, old_state, new_state, cb->user_data);
+		cb->cb(source->service, old_state, new_state, cb->user_data);
 	}
 
 	if (new_state != SOURCE_STATE_DISCONNECTED)
@@ -117,19 +115,19 @@ static void source_set_state(struct btd_service *service,
 	}
 }
 
-static void avdtp_state_callback(struct audio_device *dev,
-					struct avdtp *session,
+static void avdtp_state_callback(struct btd_device *dev, struct avdtp *session,
 					avdtp_session_state_t old_state,
-					avdtp_session_state_t new_state)
+					avdtp_session_state_t new_state,
+					void *user_data)
 {
-	struct source *source = btd_service_get_user_data(dev->source);
+	struct source *source = user_data;
 
 	switch (new_state) {
 	case AVDTP_SESSION_STATE_DISCONNECTED:
-		source_set_state(dev->source, SOURCE_STATE_DISCONNECTED);
+		source_set_state(source, SOURCE_STATE_DISCONNECTED);
 		break;
 	case AVDTP_SESSION_STATE_CONNECTING:
-		source_set_state(dev->source, SOURCE_STATE_CONNECTING);
+		source_set_state(source, SOURCE_STATE_CONNECTING);
 		break;
 	case AVDTP_SESSION_STATE_CONNECTED:
 		break;
@@ -168,10 +166,10 @@ static void stream_state_changed(struct avdtp_stream *stream,
 		break;
 	case AVDTP_STATE_OPEN:
 		btd_service_connecting_complete(source->service, 0);
-		source_set_state(service, SOURCE_STATE_CONNECTED);
+		source_set_state(source, SOURCE_STATE_CONNECTED);
 		break;
 	case AVDTP_STATE_STREAMING:
-		source_set_state(service, SOURCE_STATE_PLAYING);
+		source_set_state(source, SOURCE_STATE_PLAYING);
 		break;
 	case AVDTP_STATE_CONFIGURED:
 	case AVDTP_STATE_CLOSING:
@@ -314,7 +312,7 @@ int source_connect(struct btd_service *service)
 	struct source *source = btd_service_get_user_data(service);
 
 	if (!source->session)
-		source->session = avdtp_get(source->dev);
+		source->session = avdtp_get(btd_service_get_device(service));
 
 	if (!source->session) {
 		DBG("Unable to get a session");
@@ -391,8 +389,9 @@ int source_init(struct audio_device *dev, struct btd_service *service)
 	source->dev = dev;
 	source->service = btd_service_ref(service);
 
-	source->avdtp_callback_id = avdtp_add_state_cb(dev,
-							avdtp_state_callback);
+	source->avdtp_callback_id = avdtp_add_state_cb(dev->btd_dev,
+							avdtp_state_callback,
+							source);
 
 	btd_service_set_user_data(service, source);
 
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index b4da18d..6aa5d41 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -332,7 +332,7 @@ static guint resume_a2dp(struct media_transport *transport,
 	guint id;
 
 	if (a2dp->session == NULL) {
-		a2dp->session = avdtp_get(transport->device);
+		a2dp->session = avdtp_get(transport->device->btd_dev);
 		if (a2dp->session == NULL)
 			return 0;
 	}
-- 
1.8.1.4

