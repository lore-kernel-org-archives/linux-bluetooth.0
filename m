Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 02/20] audio/source: Use service user_data for private data
Date: Wed,  3 Jul 2013 18:15:23 +0300
Message-Id: <1372864541-10763-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1372864541-10763-1-git-send-email-luiz.dentz@gmail.com>
References: <1372864541-10763-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This remove the need of forward declaration of struct source and prepare
for a complete removal of struct audio_device.
---
 profiles/audio/avdtp.c  |  2 +-
 profiles/audio/device.h |  3 +--
 profiles/audio/source.c | 26 +++++++++++++++-----------
 profiles/audio/source.h |  6 +++---
 4 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 0d67e67..7874cf6 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -1167,7 +1167,7 @@ static gboolean disconnect_timeout(gpointer user_data)
 	if (dev && dev->sink && stream_setup)
 		sink_setup_stream(dev, session);
 	else if (dev && dev->source && stream_setup)
-		source_setup_stream(dev->source, session);
+		source_setup_stream(dev, session);
 	else
 		connection_lost(session, ETIMEDOUT);
 
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
diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index 226c372..8edb73d 100644
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
@@ -295,8 +295,10 @@ failed:
 	source->session = NULL;
 }
 
-gboolean source_setup_stream(struct source *source, struct avdtp *session)
+gboolean source_setup_stream(struct audio_device *dev, struct avdtp *session)
 {
+	struct source *source = btd_service_get_user_data(dev->source);
+
 	if (source->connect_id > 0 || source->disconnect_id > 0)
 		return FALSE;
 
@@ -314,7 +316,7 @@ gboolean source_setup_stream(struct source *source, struct avdtp *session)
 
 int source_connect(struct audio_device *dev)
 {
-	struct source *source = dev->source;
+	struct source *source = btd_service_get_user_data(dev->source);
 
 	if (!source->session)
 		source->session = avdtp_get(dev);
@@ -330,7 +332,7 @@ int source_connect(struct audio_device *dev)
 	if (source->stream_state >= AVDTP_STATE_OPEN)
 		return -EALREADY;
 
-	if (!source_setup_stream(source, NULL)) {
+	if (!source_setup_stream(dev, NULL)) {
 		DBG("Failed to create a stream");
 		return -EIO;
 	}
@@ -342,7 +344,7 @@ int source_connect(struct audio_device *dev)
 
 static void source_free(struct audio_device *dev)
 {
-	struct source *source = dev->source;
+	struct source *source = btd_service_get_user_data(dev->source);
 
 	if (source->cb_id)
 		avdtp_stream_remove_cb(source->session, source->stream,
@@ -380,7 +382,7 @@ void source_unregister(struct audio_device *dev)
 	source_free(dev);
 }
 
-struct source *source_init(struct audio_device *dev,
+struct btd_service *source_init(struct audio_device *dev,
 						struct btd_service *service)
 {
 	struct source *source;
@@ -395,13 +397,15 @@ struct source *source_init(struct audio_device *dev,
 	source->avdtp_callback_id = avdtp_add_state_cb(dev,
 							avdtp_state_callback);
 
-	return source;
+	btd_service_set_user_data(service, source);
+
+	return service;
 }
 
 gboolean source_new_stream(struct audio_device *dev, struct avdtp *session,
 				struct avdtp_stream *stream)
 {
-	struct source *source = dev->source;
+	struct source *source = btd_service_get_user_data(dev->source);
 
 	if (source->stream)
 		return FALSE;
@@ -419,7 +423,7 @@ gboolean source_new_stream(struct audio_device *dev, struct avdtp *session,
 
 int source_disconnect(struct audio_device *dev, gboolean shutdown)
 {
-	struct source *source = dev->source;
+	struct source *source = btd_service_get_user_data(dev->source);
 
 	if (!source->session)
 		return -ENOTCONN;
diff --git a/profiles/audio/source.h b/profiles/audio/source.h
index 8bd20a7..427de87 100644
--- a/profiles/audio/source.h
+++ b/profiles/audio/source.h
@@ -41,11 +41,11 @@ unsigned int source_add_state_cb(struct audio_device *dev, source_state_cb cb,
 							void *user_data);
 gboolean source_remove_state_cb(unsigned int id);
 
-struct source *source_init(struct audio_device *dev,
-				struct btd_service *service);
+struct btd_service *source_init(struct audio_device *dev,
+						struct btd_service *service);
 void source_unregister(struct audio_device *dev);
 int source_connect(struct audio_device *dev);
 gboolean source_new_stream(struct audio_device *dev, struct avdtp *session,
 				struct avdtp_stream *stream);
-gboolean source_setup_stream(struct source *source, struct avdtp *session);
+gboolean source_setup_stream(struct audio_device *dev, struct avdtp *session);
 int source_disconnect(struct audio_device *dev, gboolean shutdown);
-- 
1.8.1.4

