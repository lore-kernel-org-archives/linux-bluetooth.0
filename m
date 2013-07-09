Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 04/21] audio/sink: Reduce dependency on struct audio_device
Date: Tue,  9 Jul 2013 17:39:01 +0300
Message-Id: <1373380758-16489-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1373380758-16489-1-git-send-email-luiz.dentz@gmail.com>
References: <1373380758-16489-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is part of the work necessary to completely remove
struct audio_device
---
 profiles/audio/a2dp.c      |  5 ++--
 profiles/audio/avrcp.c     |  2 +-
 profiles/audio/device.c    |  4 +--
 profiles/audio/manager.c   | 20 ++------------
 profiles/audio/sink.c      | 68 +++++++++++++++++++++++++---------------------
 profiles/audio/sink.h      | 14 +++++-----
 profiles/audio/transport.c |  4 +--
 7 files changed, 55 insertions(+), 62 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index c6973ae..5dc9218 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -403,6 +403,7 @@ static void stream_state_changed(struct avdtp_stream *stream,
 static gboolean auto_config(gpointer data)
 {
 	struct a2dp_setup *setup = data;
+	struct audio_device *dev = setup->dev;
 
 	/* Check if configuration was aborted */
 	if (setup->sep->stream == NULL)
@@ -415,7 +416,7 @@ static gboolean auto_config(gpointer data)
 				stream_state_changed, setup->sep);
 
 	if (setup->sep->type == AVDTP_SEP_TYPE_SOURCE)
-		sink_new_stream(setup->dev, setup->session, setup->stream);
+		sink_new_stream(dev->sink, setup->session, setup->stream);
 	else
 		source_new_stream(setup->dev, setup->session, setup->stream);
 
@@ -618,7 +619,7 @@ static void setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 
 	/* Notify D-Bus interface of the new stream */
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SOURCE)
-		sink_new_stream(dev, session, setup->stream);
+		sink_new_stream(dev->sink, session, setup->stream);
 	else
 		source_new_stream(dev, session, setup->stream);
 
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 4316f8e..763012d 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3425,7 +3425,7 @@ static struct avrcp *session_create(struct avrcp_server *server,
 		session->target = TRUE;
 	else if (dev->source && !dev->sink)
 		session->target = FALSE;
-	else if (dev->sink && sink_is_active(dev))
+	else if (dev->sink && sink_is_active(dev->sink))
 		session->target = TRUE;
 	else
 		session->target = FALSE;
diff --git a/profiles/audio/device.c b/profiles/audio/device.c
index f11c728..bc1ab26 100644
--- a/profiles/audio/device.c
+++ b/profiles/audio/device.c
@@ -154,7 +154,7 @@ static void disconnect_cb(struct btd_device *btd_dev, gboolean removal,
 
 	sink = btd_device_get_service(btd_dev, A2DP_SINK_UUID);
 	if (sink)
-		sink_disconnect(dev, TRUE);
+		sink_disconnect(sink, TRUE);
 	else
 		priv->disconnecting = FALSE;
 }
@@ -261,7 +261,7 @@ void audio_device_unregister(struct audio_device *device)
 	DBG("%s", device_get_path(device->btd_dev));
 
 	if (device->sink)
-		sink_unregister(device);
+		sink_unregister(device->sink);
 
 	if (device->source)
 		source_unregister(device);
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index e905abb..7cc37e5 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -153,7 +153,7 @@ static int avrcp_target_probe(struct btd_service *service)
 
 	audio_dev->control = service;
 
-	if (audio_dev->sink && sink_is_active(audio_dev))
+	if (audio_dev->sink && sink_is_active(audio_dev->sink))
 		avrcp_connect(audio_dev);
 
 	return 0;
@@ -218,34 +218,20 @@ static int a2dp_sink_connect(struct btd_service *service)
 {
 	struct btd_device *dev = btd_service_get_device(service);
 	const char *path = device_get_path(dev);
-	struct audio_device *audio_dev;
 
 	DBG("path %s", path);
 
-	audio_dev = get_audio_dev(dev);
-	if (!audio_dev) {
-		DBG("unable to get a device object");
-		return -1;
-	}
-
-	return sink_connect(audio_dev);
+	return sink_connect(service);
 }
 
 static int a2dp_sink_disconnect(struct btd_service *service)
 {
 	struct btd_device *dev = btd_service_get_device(service);
 	const char *path = device_get_path(dev);
-	struct audio_device *audio_dev;
 
 	DBG("path %s", path);
 
-	audio_dev = get_audio_dev(dev);
-	if (!audio_dev) {
-		DBG("unable to get a device object");
-		return -1;
-	}
-
-	return sink_disconnect(audio_dev, FALSE);
+	return sink_disconnect(service, FALSE);
 }
 
 static int avrcp_target_connect(struct btd_service *service)
diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index eb14848..6a26a65 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -71,7 +71,7 @@ struct sink {
 
 struct sink_state_callback {
 	sink_state_cb cb;
-	struct audio_device *dev;
+	struct btd_service *service;
 	void *user_data;
 	unsigned int id;
 };
@@ -85,24 +85,25 @@ static char *str_state[] = {
 	"SINK_STATE_PLAYING",
 };
 
-static void sink_set_state(struct audio_device *dev, sink_state_t new_state)
+static void sink_set_state(struct btd_service *service, sink_state_t new_state)
 {
-	struct sink *sink = btd_service_get_user_data(dev->sink);
+	struct sink *sink = btd_service_get_user_data(service);
+	struct btd_device *dev = btd_service_get_device(service);
 	sink_state_t old_state = sink->state;
 	GSList *l;
 
 	sink->state = new_state;
 
-	DBG("State changed %s: %s -> %s", device_get_path(dev->btd_dev),
+	DBG("State changed %s: %s -> %s", device_get_path(dev),
 				str_state[old_state], str_state[new_state]);
 
 	for (l = sink_callbacks; l != NULL; l = l->next) {
 		struct sink_state_callback *cb = l->data;
 
-		if (cb->dev != dev)
+		if (cb->service != service)
 			continue;
 
-		cb->cb(dev, old_state, new_state, cb->user_data);
+		cb->cb(service, old_state, new_state, cb->user_data);
 	}
 
 	if (new_state != SINK_STATE_DISCONNECTED)
@@ -123,10 +124,10 @@ static void avdtp_state_callback(struct audio_device *dev,
 
 	switch (new_state) {
 	case AVDTP_SESSION_STATE_DISCONNECTED:
-		sink_set_state(dev, SINK_STATE_DISCONNECTED);
+		sink_set_state(dev->sink, SINK_STATE_DISCONNECTED);
 		break;
 	case AVDTP_SESSION_STATE_CONNECTING:
-		sink_set_state(dev, SINK_STATE_CONNECTING);
+		sink_set_state(dev->sink, SINK_STATE_CONNECTING);
 		break;
 	case AVDTP_SESSION_STATE_CONNECTED:
 		break;
@@ -141,8 +142,8 @@ static void stream_state_changed(struct avdtp_stream *stream,
 					struct avdtp_error *err,
 					void *user_data)
 {
-	struct audio_device *dev = user_data;
-	struct sink *sink = btd_service_get_user_data(dev->sink);
+	struct btd_service *service = user_data;
+	struct sink *sink = btd_service_get_user_data(service);
 
 	if (err)
 		return;
@@ -152,7 +153,7 @@ static void stream_state_changed(struct avdtp_stream *stream,
 		btd_service_disconnecting_complete(sink->service, 0);
 
 		if (sink->disconnect_id > 0) {
-			a2dp_cancel(dev, sink->disconnect_id);
+			a2dp_cancel(sink->dev, sink->disconnect_id);
 			sink->disconnect_id = 0;
 		}
 
@@ -165,10 +166,10 @@ static void stream_state_changed(struct avdtp_stream *stream,
 		break;
 	case AVDTP_STATE_OPEN:
 		btd_service_connecting_complete(sink->service, 0);
-		sink_set_state(dev, SINK_STATE_CONNECTED);
+		sink_set_state(service, SINK_STATE_CONNECTED);
 		break;
 	case AVDTP_STATE_STREAMING:
-		sink_set_state(dev, SINK_STATE_PLAYING);
+		sink_set_state(service, SINK_STATE_PLAYING);
 		break;
 	case AVDTP_STATE_CONFIGURED:
 	case AVDTP_STATE_CLOSING:
@@ -302,12 +303,12 @@ gboolean sink_setup_stream(struct btd_service *service, struct avdtp *session)
 	return TRUE;
 }
 
-int sink_connect(struct audio_device *dev)
+int sink_connect(struct btd_service *service)
 {
-	struct sink *sink = btd_service_get_user_data(dev->sink);
+	struct sink *sink = btd_service_get_user_data(service);
 
 	if (!sink->session)
-		sink->session = avdtp_get(dev);
+		sink->session = avdtp_get(sink->dev);
 
 	if (!sink->session) {
 		DBG("Unable to get a session");
@@ -320,7 +321,7 @@ int sink_connect(struct audio_device *dev)
 	if (sink->stream_state >= AVDTP_STATE_OPEN)
 		return -EALREADY;
 
-	if (!sink_setup_stream(sink->service, NULL)) {
+	if (!sink_setup_stream(service, NULL)) {
 		DBG("Failed to create a stream");
 		return -EIO;
 	}
@@ -330,9 +331,10 @@ int sink_connect(struct audio_device *dev)
 	return 0;
 }
 
-static void sink_free(struct audio_device *dev)
+static void sink_free(struct btd_service *service)
 {
-	struct sink *sink = btd_service_get_user_data(dev->sink);
+	struct sink *sink = btd_service_get_user_data(service);
+	struct audio_device *dev = sink->dev;
 
 	if (sink->cb_id)
 		avdtp_stream_remove_cb(sink->session, sink->stream,
@@ -363,10 +365,13 @@ static void sink_free(struct audio_device *dev)
 	dev->sink = NULL;
 }
 
-void sink_unregister(struct audio_device *dev)
+void sink_unregister(struct btd_service *service)
 {
-	DBG("%s", device_get_path(dev->btd_dev));
-	sink_free(dev);
+	struct btd_device *dev = btd_service_get_device(service);
+
+	DBG("%s", device_get_path(dev));
+
+	sink_free(service);
 }
 
 int sink_init(struct audio_device *dev, struct btd_service *service)
@@ -387,9 +392,9 @@ int sink_init(struct audio_device *dev, struct btd_service *service)
 	return 0;
 }
 
-gboolean sink_is_active(struct audio_device *dev)
+gboolean sink_is_active(struct btd_service *service)
 {
-	struct sink *sink = btd_service_get_user_data(dev->sink);
+	struct sink *sink = btd_service_get_user_data(service);
 
 	if (sink->session)
 		return TRUE;
@@ -397,10 +402,10 @@ gboolean sink_is_active(struct audio_device *dev)
 	return FALSE;
 }
 
-gboolean sink_new_stream(struct audio_device *dev, struct avdtp *session,
+gboolean sink_new_stream(struct btd_service *service, struct avdtp *session,
 				struct avdtp_stream *stream)
 {
-	struct sink *sink = btd_service_get_user_data(dev->sink);
+	struct sink *sink = btd_service_get_user_data(service);
 
 	if (sink->stream)
 		return FALSE;
@@ -411,14 +416,15 @@ gboolean sink_new_stream(struct audio_device *dev, struct avdtp *session,
 	sink->stream = stream;
 
 	sink->cb_id = avdtp_stream_add_cb(session, stream,
-						stream_state_changed, dev);
+						stream_state_changed, service);
 
 	return TRUE;
 }
 
-int sink_disconnect(struct audio_device *dev, gboolean shutdown)
+int sink_disconnect(struct btd_service *service, gboolean shutdown)
 {
-	struct sink *sink = btd_service_get_user_data(dev->sink);
+	struct sink *sink = btd_service_get_user_data(service);
+	struct audio_device *dev = sink->dev;
 
 	if (!sink->session)
 		return -ENOTCONN;
@@ -448,7 +454,7 @@ int sink_disconnect(struct audio_device *dev, gboolean shutdown)
 	return avdtp_close(sink->session, sink->stream, FALSE);
 }
 
-unsigned int sink_add_state_cb(struct audio_device *dev, sink_state_cb cb,
+unsigned int sink_add_state_cb(struct btd_service *service, sink_state_cb cb,
 								void *user_data)
 {
 	struct sink_state_callback *state_cb;
@@ -456,7 +462,7 @@ unsigned int sink_add_state_cb(struct audio_device *dev, sink_state_cb cb,
 
 	state_cb = g_new(struct sink_state_callback, 1);
 	state_cb->cb = cb;
-	state_cb->dev = dev;
+	state_cb->service = service;
 	state_cb->user_data = user_data;
 	state_cb->id = ++id;
 
diff --git a/profiles/audio/sink.h b/profiles/audio/sink.h
index 9fa3ec6..cf0934b 100644
--- a/profiles/audio/sink.h
+++ b/profiles/audio/sink.h
@@ -29,22 +29,22 @@ typedef enum {
 	SINK_STATE_PLAYING,
 } sink_state_t;
 
-typedef void (*sink_state_cb) (struct audio_device *dev,
+typedef void (*sink_state_cb) (struct btd_service *service,
 				sink_state_t old_state,
 				sink_state_t new_state,
 				void *user_data);
 
 struct btd_service;
 
-unsigned int sink_add_state_cb(struct audio_device *dev, sink_state_cb cb,
+unsigned int sink_add_state_cb(struct btd_service *service, sink_state_cb cb,
 							void *user_data);
 gboolean sink_remove_state_cb(unsigned int id);
 
 int sink_init(struct audio_device *dev, struct btd_service *service);
-void sink_unregister(struct audio_device *dev);
-gboolean sink_is_active(struct audio_device *dev);
-int sink_connect(struct audio_device *dev);
-gboolean sink_new_stream(struct audio_device *dev, struct avdtp *session,
+void sink_unregister(struct btd_service *service);
+gboolean sink_is_active(struct btd_service *service);
+int sink_connect(struct btd_service *service);
+gboolean sink_new_stream(struct btd_service *service, struct avdtp *session,
 				struct avdtp_stream *stream);
 gboolean sink_setup_stream(struct btd_service *service, struct avdtp *session);
-int sink_disconnect(struct audio_device *dev, gboolean shutdown);
+int sink_disconnect(struct btd_service *service, gboolean shutdown);
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index f585c3a..3e83a95 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -744,7 +744,7 @@ static void transport_update_playing(struct media_transport *transport,
 		transport_set_state(transport, TRANSPORT_STATE_PENDING);
 }
 
-static void sink_state_changed(struct audio_device *dev,
+static void sink_state_changed(struct btd_service *service,
 						sink_state_t old_state,
 						sink_state_t new_state,
 						void *user_data)
@@ -804,7 +804,7 @@ struct media_transport *media_transport_create(struct audio_device *device,
 
 		if (strcasecmp(uuid, A2DP_SOURCE_UUID) == 0) {
 			a2dp->volume = -1;
-			transport->sink_watch = sink_add_state_cb(device,
+			transport->sink_watch = sink_add_state_cb(device->sink,
 							sink_state_changed,
 							transport);
 		} else {
-- 
1.8.1.4

