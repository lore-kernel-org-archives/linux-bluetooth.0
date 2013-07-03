Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 05/20] audio/source: Reduce dependency on struct audio_device
Date: Wed,  3 Jul 2013 18:15:26 +0300
Message-Id: <1372864541-10763-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1372864541-10763-1-git-send-email-luiz.dentz@gmail.com>
References: <1372864541-10763-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is part of the work necessary to completely remove
struct audio_device
---
 profiles/audio/a2dp.c      |  4 +--
 profiles/audio/avdtp.c     |  2 +-
 profiles/audio/device.c    |  2 +-
 profiles/audio/manager.c   | 18 ++----------
 profiles/audio/source.c    | 69 +++++++++++++++++++++++++---------------------
 profiles/audio/source.h    | 17 ++++++------
 profiles/audio/transport.c |  5 ++--
 7 files changed, 55 insertions(+), 62 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 5dc9218..e89be07 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -418,7 +418,7 @@ static gboolean auto_config(gpointer data)
 	if (setup->sep->type == AVDTP_SEP_TYPE_SOURCE)
 		sink_new_stream(dev->sink, setup->session, setup->stream);
 	else
-		source_new_stream(setup->dev, setup->session, setup->stream);
+		source_new_stream(dev->source, setup->session, setup->stream);
 
 done:
 	if (setup->setconf_cb)
@@ -621,7 +621,7 @@ static void setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SOURCE)
 		sink_new_stream(dev->sink, session, setup->stream);
 	else
-		source_new_stream(dev, session, setup->stream);
+		source_new_stream(dev->source, session, setup->stream);
 
 	/* Notify Endpoint */
 	if (a2dp_sep->endpoint) {
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index ca09802..bd73572 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -1167,7 +1167,7 @@ static gboolean disconnect_timeout(gpointer user_data)
 	if (dev && dev->sink && stream_setup)
 		sink_setup_stream(dev->sink, session);
 	else if (dev && dev->source && stream_setup)
-		source_setup_stream(dev, session);
+		source_setup_stream(dev->source, session);
 	else
 		connection_lost(session, ETIMEDOUT);
 
diff --git a/profiles/audio/device.c b/profiles/audio/device.c
index bc1ab26..ea9a771 100644
--- a/profiles/audio/device.c
+++ b/profiles/audio/device.c
@@ -264,7 +264,7 @@ void audio_device_unregister(struct audio_device *device)
 		sink_unregister(device->sink);
 
 	if (device->source)
-		source_unregister(device);
+		source_unregister(device->source);
 
 	if (device->control)
 		control_unregister(device);
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index fa0bddd..59cdecc 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -174,34 +174,20 @@ static int a2dp_source_connect(struct btd_service *service)
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
-	return source_connect(audio_dev);
+	return source_connect(service);
 }
 
 static int a2dp_source_disconnect(struct btd_service *service)
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
-	return source_disconnect(audio_dev, FALSE);
+	return source_disconnect(service, FALSE);
 }
 
 static int a2dp_sink_connect(struct btd_service *service)
diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index 8edb73d..d5cd963 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -72,7 +72,7 @@ struct source {
 
 struct source_state_callback {
 	source_state_cb cb;
-	struct audio_device *dev;
+	struct btd_service *service;
 	void *user_data;
 	unsigned int id;
 };
@@ -86,9 +86,11 @@ static char *str_state[] = {
 	"SOURCE_STATE_PLAYING",
 };
 
-static void source_set_state(struct audio_device *dev, source_state_t new_state)
+static void source_set_state(struct btd_service *service,
+						source_state_t new_state)
 {
-	struct source *source = btd_service_get_user_data(dev->source);
+	struct source *source = btd_service_get_user_data(service);
+	struct audio_device *dev = source->dev;
 	source_state_t old_state = source->state;
 	GSList *l;
 
@@ -100,10 +102,10 @@ static void source_set_state(struct audio_device *dev, source_state_t new_state)
 	for (l = source_callbacks; l != NULL; l = l->next) {
 		struct source_state_callback *cb = l->data;
 
-		if (cb->dev != dev)
+		if (cb->service != service)
 			continue;
 
-		cb->cb(dev, old_state, new_state, cb->user_data);
+		cb->cb(service, old_state, new_state, cb->user_data);
 	}
 
 	if (new_state != SOURCE_STATE_DISCONNECTED)
@@ -124,10 +126,10 @@ static void avdtp_state_callback(struct audio_device *dev,
 
 	switch (new_state) {
 	case AVDTP_SESSION_STATE_DISCONNECTED:
-		source_set_state(dev, SOURCE_STATE_DISCONNECTED);
+		source_set_state(dev->source, SOURCE_STATE_DISCONNECTED);
 		break;
 	case AVDTP_SESSION_STATE_CONNECTING:
-		source_set_state(dev, SOURCE_STATE_CONNECTING);
+		source_set_state(dev->source, SOURCE_STATE_CONNECTING);
 		break;
 	case AVDTP_SESSION_STATE_CONNECTED:
 		break;
@@ -142,8 +144,8 @@ static void stream_state_changed(struct avdtp_stream *stream,
 					struct avdtp_error *err,
 					void *user_data)
 {
-	struct audio_device *dev = user_data;
-	struct source *source = btd_service_get_user_data(dev->source);
+	struct btd_service *service = user_data;
+	struct source *source = btd_service_get_user_data(service);
 
 	if (err)
 		return;
@@ -153,7 +155,7 @@ static void stream_state_changed(struct avdtp_stream *stream,
 		btd_service_disconnecting_complete(source->service, 0);
 
 		if (source->disconnect_id > 0) {
-			a2dp_cancel(dev, source->disconnect_id);
+			a2dp_cancel(source->dev, source->disconnect_id);
 			source->disconnect_id = 0;
 		}
 
@@ -165,10 +167,10 @@ static void stream_state_changed(struct avdtp_stream *stream,
 		source->cb_id = 0;
 		break;
 	case AVDTP_STATE_OPEN:
-		source_set_state(dev, SOURCE_STATE_CONNECTED);
+		source_set_state(service, SOURCE_STATE_CONNECTED);
 		break;
 	case AVDTP_STATE_STREAMING:
-		source_set_state(dev, SOURCE_STATE_PLAYING);
+		source_set_state(service, SOURCE_STATE_PLAYING);
 		break;
 	case AVDTP_STATE_CONFIGURED:
 	case AVDTP_STATE_CLOSING:
@@ -295,9 +297,9 @@ failed:
 	source->session = NULL;
 }
 
-gboolean source_setup_stream(struct audio_device *dev, struct avdtp *session)
+gboolean source_setup_stream(struct btd_service *service, struct avdtp *session)
 {
-	struct source *source = btd_service_get_user_data(dev->source);
+	struct source *source = btd_service_get_user_data(service);
 
 	if (source->connect_id > 0 || source->disconnect_id > 0)
 		return FALSE;
@@ -314,12 +316,12 @@ gboolean source_setup_stream(struct audio_device *dev, struct avdtp *session)
 	return TRUE;
 }
 
-int source_connect(struct audio_device *dev)
+int source_connect(struct btd_service *service)
 {
-	struct source *source = btd_service_get_user_data(dev->source);
+	struct source *source = btd_service_get_user_data(service);
 
 	if (!source->session)
-		source->session = avdtp_get(dev);
+		source->session = avdtp_get(source->dev);
 
 	if (!source->session) {
 		DBG("Unable to get a session");
@@ -332,7 +334,7 @@ int source_connect(struct audio_device *dev)
 	if (source->stream_state >= AVDTP_STATE_OPEN)
 		return -EALREADY;
 
-	if (!source_setup_stream(dev, NULL)) {
+	if (!source_setup_stream(service, NULL)) {
 		DBG("Failed to create a stream");
 		return -EIO;
 	}
@@ -342,9 +344,10 @@ int source_connect(struct audio_device *dev)
 	return 0;
 }
 
-static void source_free(struct audio_device *dev)
+static void source_free(struct btd_service *service)
 {
-	struct source *source = btd_service_get_user_data(dev->source);
+	struct source *source = btd_service_get_user_data(service);
+	struct audio_device *dev = source->dev;
 
 	if (source->cb_id)
 		avdtp_stream_remove_cb(source->session, source->stream,
@@ -375,11 +378,13 @@ static void source_free(struct audio_device *dev)
 	dev->source = NULL;
 }
 
-void source_unregister(struct audio_device *dev)
+void source_unregister(struct btd_service *service)
 {
-	DBG("%s", device_get_path(dev->btd_dev));
+	struct btd_device *dev = btd_service_get_device(service);
+
+	DBG("%s", device_get_path(dev));
 
-	source_free(dev);
+	source_free(service);
 }
 
 struct btd_service *source_init(struct audio_device *dev,
@@ -402,10 +407,10 @@ struct btd_service *source_init(struct audio_device *dev,
 	return service;
 }
 
-gboolean source_new_stream(struct audio_device *dev, struct avdtp *session,
+gboolean source_new_stream(struct btd_service *service, struct avdtp *session,
 				struct avdtp_stream *stream)
 {
-	struct source *source = btd_service_get_user_data(dev->source);
+	struct source *source = btd_service_get_user_data(service);
 
 	if (source->stream)
 		return FALSE;
@@ -416,14 +421,14 @@ gboolean source_new_stream(struct audio_device *dev, struct avdtp *session,
 	source->stream = stream;
 
 	source->cb_id = avdtp_stream_add_cb(session, stream,
-						stream_state_changed, dev);
+						stream_state_changed, service);
 
 	return TRUE;
 }
 
-int source_disconnect(struct audio_device *dev, gboolean shutdown)
+int source_disconnect(struct btd_service *service, gboolean shutdown)
 {
-	struct source *source = btd_service_get_user_data(dev->source);
+	struct source *source = btd_service_get_user_data(service);
 
 	if (!source->session)
 		return -ENOTCONN;
@@ -433,7 +438,7 @@ int source_disconnect(struct audio_device *dev, gboolean shutdown)
 
 	/* cancel pending connect */
 	if (source->connect_id > 0) {
-		a2dp_cancel(dev, source->connect_id);
+		a2dp_cancel(source->dev, source->connect_id);
 		source->connect_id = 0;
 		btd_service_connecting_complete(source->service, -ECANCELED);
 
@@ -453,15 +458,15 @@ int source_disconnect(struct audio_device *dev, gboolean shutdown)
 	return avdtp_close(source->session, source->stream, FALSE);
 }
 
-unsigned int source_add_state_cb(struct audio_device *dev, source_state_cb cb,
-								void *user_data)
+unsigned int source_add_state_cb(struct btd_service *service,
+					source_state_cb cb, void *user_data)
 {
 	struct source_state_callback *state_cb;
 	static unsigned int id = 0;
 
 	state_cb = g_new(struct source_state_callback, 1);
 	state_cb->cb = cb;
-	state_cb->dev = dev;
+	state_cb->service = service;
 	state_cb->user_data = user_data;
 	state_cb->id = ++id;
 
diff --git a/profiles/audio/source.h b/profiles/audio/source.h
index 427de87..b9d4707 100644
--- a/profiles/audio/source.h
+++ b/profiles/audio/source.h
@@ -30,22 +30,23 @@ typedef enum {
 	SOURCE_STATE_PLAYING,
 } source_state_t;
 
-typedef void (*source_state_cb) (struct audio_device *dev,
+typedef void (*source_state_cb) (struct btd_service *service,
 				source_state_t old_state,
 				source_state_t new_state,
 				void *user_data);
 
 struct btd_service;
 
-unsigned int source_add_state_cb(struct audio_device *dev, source_state_cb cb,
-							void *user_data);
+unsigned int source_add_state_cb(struct btd_service *service,
+					source_state_cb cb, void *user_data);
 gboolean source_remove_state_cb(unsigned int id);
 
 struct btd_service *source_init(struct audio_device *dev,
 						struct btd_service *service);
-void source_unregister(struct audio_device *dev);
-int source_connect(struct audio_device *dev);
-gboolean source_new_stream(struct audio_device *dev, struct avdtp *session,
+void source_unregister(struct btd_service *service);
+int source_connect(struct btd_service *service);
+gboolean source_new_stream(struct btd_service *service, struct avdtp *session,
 				struct avdtp_stream *stream);
-gboolean source_setup_stream(struct audio_device *dev, struct avdtp *session);
-int source_disconnect(struct audio_device *dev, gboolean shutdown);
+gboolean source_setup_stream(struct btd_service *service,
+							struct avdtp *session);
+int source_disconnect(struct btd_service *service, gboolean shutdown);
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 3e83a95..b4da18d 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -757,7 +757,7 @@ static void sink_state_changed(struct btd_service *service,
 		transport_update_playing(transport, FALSE);
 }
 
-static void source_state_changed(struct audio_device *dev,
+static void source_state_changed(struct btd_service *service,
 						source_state_t old_state,
 						source_state_t new_state,
 						void *user_data)
@@ -810,7 +810,8 @@ struct media_transport *media_transport_create(struct audio_device *device,
 		} else {
 			a2dp->volume = 127;
 			avrcp_set_volume(device, a2dp->volume);
-			transport->source_watch = source_add_state_cb(device,
+			transport->source_watch = source_add_state_cb(
+							device->source,
 							source_state_changed,
 							transport);
 		}
-- 
1.8.1.4

