Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 02/21] audio/source: Use service user_data for private data
Date: Tue,  9 Jul 2013 17:38:57 +0300
Message-Id: <1373380758-16489-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1373380758-16489-1-git-send-email-luiz.dentz@gmail.com>
References: <1373380758-16489-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This remove the need of forward declaration of struct source and prepare
for a complete removal of struct audio_device.
---
 profiles/audio/device.h  |  3 +--
 profiles/audio/manager.c |  4 ++--
 profiles/audio/source.c  | 28 ++++++++++++++++------------
 profiles/audio/source.h  |  6 +++---
 4 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/profiles/audio/device.h b/profiles/audio/device.h
index e24bdf9..9e0147e 100644
--- a/profiles/audio/device.h
+++ b/profiles/audio/device.h
@@ -23,7 +23,6 @@
  */
 
 struct audio_device;
-struct source;
 struct control;
 struct dev_priv;
 
@@ -31,7 +30,7 @@ struct audio_device {
 	struct btd_device *btd_dev;
 
 	struct btd_service *sink;
-	struct source *source;
+	struct btd_service *source;
 	struct control *control;
 
 	struct dev_priv *priv;
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index be78818..9de5a02 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -114,9 +114,9 @@ static int a2dp_source_probe(struct btd_service *service)
 		return -1;
 	}
 
-	audio_dev->source = source_init(audio_dev, service);
+	audio_dev->source = service;
 
-	return 0;
+	return source_init(audio_dev, service);
 }
 
 static int a2dp_sink_probe(struct btd_service *service)
diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index 73c3185..a80df2a 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -88,7 +88,7 @@ static char *str_state[] = {
 
 static void source_set_state(struct audio_device *dev, source_state_t new_state)
 {
-	struct source *source = dev->source;
+	struct source *source = btd_service_get_user_data(dev->source);
 	source_state_t old_state = source->state;
 	GSList *l;
 
@@ -120,7 +120,7 @@ static void avdtp_state_callback(struct audio_device *dev,
 					avdtp_session_state_t old_state,
 					avdtp_session_state_t new_state)
 {
-	struct source *source = dev->source;
+	struct source *source = btd_service_get_user_data(dev->source);
 
 	switch (new_state) {
 	case AVDTP_SESSION_STATE_DISCONNECTED:
@@ -143,7 +143,7 @@ static void stream_state_changed(struct avdtp_stream *stream,
 					void *user_data)
 {
 	struct audio_device *dev = user_data;
-	struct source *source = dev->source;
+	struct source *source = btd_service_get_user_data(dev->source);
 
 	if (err)
 		return;
@@ -287,8 +287,11 @@ failed:
 	source->session = NULL;
 }
 
-gboolean source_setup_stream(struct source *source, struct avdtp *session)
+gboolean source_setup_stream(struct btd_service *service,
+							struct avdtp *session)
 {
+	struct source *source = btd_service_get_user_data(service);
+
 	if (source->connect_id > 0 || source->disconnect_id > 0)
 		return FALSE;
 
@@ -306,7 +309,7 @@ gboolean source_setup_stream(struct source *source, struct avdtp *session)
 
 int source_connect(struct audio_device *dev)
 {
-	struct source *source = dev->source;
+	struct source *source = btd_service_get_user_data(dev->source);
 
 	if (!source->session)
 		source->session = avdtp_get(dev);
@@ -322,7 +325,7 @@ int source_connect(struct audio_device *dev)
 	if (source->stream_state >= AVDTP_STATE_OPEN)
 		return -EALREADY;
 
-	if (!source_setup_stream(source, NULL)) {
+	if (!source_setup_stream(source->service, NULL)) {
 		DBG("Failed to create a stream");
 		return -EIO;
 	}
@@ -334,7 +337,7 @@ int source_connect(struct audio_device *dev)
 
 static void source_free(struct audio_device *dev)
 {
-	struct source *source = dev->source;
+	struct source *source = btd_service_get_user_data(dev->source);
 
 	if (source->cb_id)
 		avdtp_stream_remove_cb(source->session, source->stream,
@@ -372,8 +375,7 @@ void source_unregister(struct audio_device *dev)
 	source_free(dev);
 }
 
-struct source *source_init(struct audio_device *dev,
-						struct btd_service *service)
+int source_init(struct audio_device *dev, struct btd_service *service)
 {
 	struct source *source;
 
@@ -387,13 +389,15 @@ struct source *source_init(struct audio_device *dev,
 	source->avdtp_callback_id = avdtp_add_state_cb(dev,
 							avdtp_state_callback);
 
-	return source;
+	btd_service_set_user_data(service, source);
+
+	return 0;
 }
 
 gboolean source_new_stream(struct audio_device *dev, struct avdtp *session,
 				struct avdtp_stream *stream)
 {
-	struct source *source = dev->source;
+	struct source *source = btd_service_get_user_data(dev->source);
 
 	if (source->stream)
 		return FALSE;
@@ -411,7 +415,7 @@ gboolean source_new_stream(struct audio_device *dev, struct avdtp *session,
 
 int source_disconnect(struct audio_device *dev, gboolean shutdown)
 {
-	struct source *source = dev->source;
+	struct source *source = btd_service_get_user_data(dev->source);
 
 	if (!source->session)
 		return -ENOTCONN;
diff --git a/profiles/audio/source.h b/profiles/audio/source.h
index 8bd20a7..ac7ffbd 100644
--- a/profiles/audio/source.h
+++ b/profiles/audio/source.h
@@ -41,11 +41,11 @@ unsigned int source_add_state_cb(struct audio_device *dev, source_state_cb cb,
 							void *user_data);
 gboolean source_remove_state_cb(unsigned int id);
 
-struct source *source_init(struct audio_device *dev,
-				struct btd_service *service);
+int source_init(struct audio_device *dev, struct btd_service *service);
 void source_unregister(struct audio_device *dev);
 int source_connect(struct audio_device *dev);
 gboolean source_new_stream(struct audio_device *dev, struct avdtp *session,
 				struct avdtp_stream *stream);
-gboolean source_setup_stream(struct source *source, struct avdtp *session);
+gboolean source_setup_stream(struct btd_service *service,
+							struct avdtp *session);
 int source_disconnect(struct audio_device *dev, gboolean shutdown);
-- 
1.8.1.4

