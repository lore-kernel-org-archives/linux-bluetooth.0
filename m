Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 01/21] audio/sink: Use service user_data for private data
Date: Tue,  9 Jul 2013 17:38:55 +0300
Message-Id: <1373380758-16489-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1373380758-16489-1-git-send-email-luiz.dentz@gmail.com>
References: <1373380758-16489-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This remove the need of forward declaration of struct sink and prepare
for a complete removal of struct audio_device.
---
 profiles/audio/device.c  | 54 +++++++++++++++++++++++++++++-------------------
 profiles/audio/device.h  |  3 +--
 profiles/audio/manager.c |  4 ++--
 profiles/audio/sink.c    | 28 ++++++++++++++-----------
 profiles/audio/sink.h    |  4 ++--
 5 files changed, 54 insertions(+), 39 deletions(-)

diff --git a/profiles/audio/device.c b/profiles/audio/device.c
index 3fa49ad..f11c728 100644
--- a/profiles/audio/device.c
+++ b/profiles/audio/device.c
@@ -42,10 +42,12 @@
 #include <dbus/dbus.h>
 #include <gdbus/gdbus.h>
 
-#include "log.h"
-#include "../src/adapter.h"
-#include "../src/device.h"
+#include "lib/uuid.h"
+#include "src/adapter.h"
+#include "src/device.h"
+#include "src/service.h"
 
+#include "log.h"
 #include "error.h"
 #include "dbus-common.h"
 #include "device.h"
@@ -61,7 +63,7 @@
 #define AVDTP_CONNECT_TIMEOUT_BOOST 1
 
 struct dev_priv {
-	sink_state_t sink_state;
+	btd_service_state_t sink_state;
 	avctp_state_t avctp_state;
 
 	guint control_timer;
@@ -69,9 +71,9 @@ struct dev_priv {
 
 	gboolean disconnecting;
 
+	unsigned int service_cb_id;
 	unsigned int avdtp_callback_id;
 	unsigned int avctp_callback_id;
-	unsigned int sink_callback_id;
 };
 
 static void device_free(struct audio_device *dev)
@@ -87,7 +89,7 @@ static void device_free(struct audio_device *dev)
 
 		avdtp_remove_state_cb(priv->avdtp_callback_id);
 		avctp_remove_state_cb(priv->avctp_callback_id);
-		sink_remove_state_cb(priv->sink_callback_id);
+		btd_service_remove_state_cb(priv->service_cb_id);
 
 		g_free(priv);
 	}
@@ -138,6 +140,7 @@ static void disconnect_cb(struct btd_device *btd_dev, gboolean removal,
 {
 	struct audio_device *dev = user_data;
 	struct dev_priv *priv = dev->priv;
+	struct btd_service *sink;
 
 	if (priv->disconnecting)
 		return;
@@ -149,7 +152,8 @@ static void disconnect_cb(struct btd_device *btd_dev, gboolean removal,
 	if (dev->control && priv->avctp_state != AVCTP_STATE_DISCONNECTED)
 		avrcp_disconnect(dev);
 
-	if (dev->sink && priv->sink_state != SINK_STATE_DISCONNECTED)
+	sink = btd_device_get_service(btd_dev, A2DP_SINK_UUID);
+	if (sink)
 		sink_disconnect(dev, TRUE);
 	else
 		priv->disconnecting = FALSE;
@@ -171,30 +175,25 @@ static void device_avdtp_cb(struct audio_device *dev, struct avdtp *session,
 }
 
 static void device_sink_cb(struct audio_device *dev,
-				sink_state_t old_state,
-				sink_state_t new_state,
-				void *user_data)
+				btd_service_state_t old_state,
+				btd_service_state_t new_state)
 {
 	struct dev_priv *priv = dev->priv;
 
-	if (!dev->sink)
-		return;
-
 	priv->sink_state = new_state;
 
 	switch (new_state) {
-	case SINK_STATE_DISCONNECTED:
+	case BTD_SERVICE_STATE_UNAVAILABLE:
+	case BTD_SERVICE_STATE_DISCONNECTED:
 		if (dev->control) {
 			device_remove_control_timer(dev);
 			if (priv->avctp_state != AVCTP_STATE_DISCONNECTED)
 				avrcp_disconnect(dev);
 		}
 		break;
-	case SINK_STATE_CONNECTING:
-		break;
-	case SINK_STATE_CONNECTED:
-		break;
-	case SINK_STATE_PLAYING:
+	case BTD_SERVICE_STATE_CONNECTING:
+	case BTD_SERVICE_STATE_CONNECTED:
+	case BTD_SERVICE_STATE_DISCONNECTING:
 		break;
 	}
 }
@@ -222,6 +221,20 @@ static void device_avctp_cb(struct audio_device *dev, avctp_state_t old_state,
 	}
 }
 
+static void service_cb(struct btd_service *service,
+						btd_service_state_t old_state,
+						btd_service_state_t new_state,
+						void *user_data)
+{
+	struct audio_device *dev = user_data;
+
+	if (dev->btd_dev != btd_service_get_device(service))
+		return;
+
+	if (service == dev->sink)
+		device_sink_cb(dev, old_state, new_state);
+}
+
 struct audio_device *audio_device_register(struct btd_device *device)
 {
 	struct audio_device *dev;
@@ -236,8 +249,7 @@ struct audio_device *audio_device_register(struct btd_device *device)
 	dev->priv->dc_id = device_add_disconnect_watch(dev->btd_dev,
 							disconnect_cb, dev,
 							NULL);
-	dev->priv->sink_callback_id = sink_add_state_cb(dev, device_sink_cb,
-									NULL);
+	dev->priv->service_cb_id = btd_service_add_state_cb(service_cb, dev);
 	dev->priv->avdtp_callback_id = avdtp_add_state_cb(dev, device_avdtp_cb);
 	dev->priv->avctp_callback_id = avctp_add_state_cb(dev, device_avctp_cb);
 
diff --git a/profiles/audio/device.h b/profiles/audio/device.h
index 286bcdd..e24bdf9 100644
--- a/profiles/audio/device.h
+++ b/profiles/audio/device.h
@@ -25,13 +25,12 @@
 struct audio_device;
 struct source;
 struct control;
-struct sink;
 struct dev_priv;
 
 struct audio_device {
 	struct btd_device *btd_dev;
 
-	struct sink *sink;
+	struct btd_service *sink;
 	struct source *source;
 	struct control *control;
 
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 7f02fbd..be78818 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -130,9 +130,9 @@ static int a2dp_sink_probe(struct btd_service *service)
 		return -1;
 	}
 
-	audio_dev->sink = sink_init(audio_dev, service);
+	audio_dev->sink = service;
 
-	return 0;
+	return sink_init(audio_dev, service);
 }
 
 static int avrcp_target_probe(struct btd_service *service)
diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index f55efe8..eb14848 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -87,7 +87,7 @@ static char *str_state[] = {
 
 static void sink_set_state(struct audio_device *dev, sink_state_t new_state)
 {
-	struct sink *sink = dev->sink;
+	struct sink *sink = btd_service_get_user_data(dev->sink);
 	sink_state_t old_state = sink->state;
 	GSList *l;
 
@@ -119,7 +119,7 @@ static void avdtp_state_callback(struct audio_device *dev,
 					avdtp_session_state_t old_state,
 					avdtp_session_state_t new_state)
 {
-	struct sink *sink = dev->sink;
+	struct sink *sink = btd_service_get_user_data(dev->sink);
 
 	switch (new_state) {
 	case AVDTP_SESSION_STATE_DISCONNECTED:
@@ -142,7 +142,7 @@ static void stream_state_changed(struct avdtp_stream *stream,
 					void *user_data)
 {
 	struct audio_device *dev = user_data;
-	struct sink *sink = dev->sink;
+	struct sink *sink = btd_service_get_user_data(dev->sink);
 
 	if (err)
 		return;
@@ -283,8 +283,10 @@ failed:
 	sink->session = NULL;
 }
 
-gboolean sink_setup_stream(struct sink *sink, struct avdtp *session)
+gboolean sink_setup_stream(struct btd_service *service, struct avdtp *session)
 {
+	struct sink *sink = btd_service_get_user_data(service);
+
 	if (sink->connect_id > 0 || sink->disconnect_id > 0)
 		return FALSE;
 
@@ -302,7 +304,7 @@ gboolean sink_setup_stream(struct sink *sink, struct avdtp *session)
 
 int sink_connect(struct audio_device *dev)
 {
-	struct sink *sink = dev->sink;
+	struct sink *sink = btd_service_get_user_data(dev->sink);
 
 	if (!sink->session)
 		sink->session = avdtp_get(dev);
@@ -318,7 +320,7 @@ int sink_connect(struct audio_device *dev)
 	if (sink->stream_state >= AVDTP_STATE_OPEN)
 		return -EALREADY;
 
-	if (!sink_setup_stream(sink, NULL)) {
+	if (!sink_setup_stream(sink->service, NULL)) {
 		DBG("Failed to create a stream");
 		return -EIO;
 	}
@@ -330,7 +332,7 @@ int sink_connect(struct audio_device *dev)
 
 static void sink_free(struct audio_device *dev)
 {
-	struct sink *sink = dev->sink;
+	struct sink *sink = btd_service_get_user_data(dev->sink);
 
 	if (sink->cb_id)
 		avdtp_stream_remove_cb(sink->session, sink->stream,
@@ -367,7 +369,7 @@ void sink_unregister(struct audio_device *dev)
 	sink_free(dev);
 }
 
-struct sink *sink_init(struct audio_device *dev, struct btd_service *service)
+int sink_init(struct audio_device *dev, struct btd_service *service)
 {
 	struct sink *sink;
 
@@ -380,12 +382,14 @@ struct sink *sink_init(struct audio_device *dev, struct btd_service *service)
 
 	sink->avdtp_callback_id = avdtp_add_state_cb(dev, avdtp_state_callback);
 
-	return sink;
+	btd_service_set_user_data(service, sink);
+
+	return 0;
 }
 
 gboolean sink_is_active(struct audio_device *dev)
 {
-	struct sink *sink = dev->sink;
+	struct sink *sink = btd_service_get_user_data(dev->sink);
 
 	if (sink->session)
 		return TRUE;
@@ -396,7 +400,7 @@ gboolean sink_is_active(struct audio_device *dev)
 gboolean sink_new_stream(struct audio_device *dev, struct avdtp *session,
 				struct avdtp_stream *stream)
 {
-	struct sink *sink = dev->sink;
+	struct sink *sink = btd_service_get_user_data(dev->sink);
 
 	if (sink->stream)
 		return FALSE;
@@ -414,7 +418,7 @@ gboolean sink_new_stream(struct audio_device *dev, struct avdtp *session,
 
 int sink_disconnect(struct audio_device *dev, gboolean shutdown)
 {
-	struct sink *sink = dev->sink;
+	struct sink *sink = btd_service_get_user_data(dev->sink);
 
 	if (!sink->session)
 		return -ENOTCONN;
diff --git a/profiles/audio/sink.h b/profiles/audio/sink.h
index 1a80756..9fa3ec6 100644
--- a/profiles/audio/sink.h
+++ b/profiles/audio/sink.h
@@ -40,11 +40,11 @@ unsigned int sink_add_state_cb(struct audio_device *dev, sink_state_cb cb,
 							void *user_data);
 gboolean sink_remove_state_cb(unsigned int id);
 
-struct sink *sink_init(struct audio_device *dev, struct btd_service *service);
+int sink_init(struct audio_device *dev, struct btd_service *service);
 void sink_unregister(struct audio_device *dev);
 gboolean sink_is_active(struct audio_device *dev);
 int sink_connect(struct audio_device *dev);
 gboolean sink_new_stream(struct audio_device *dev, struct avdtp *session,
 				struct avdtp_stream *stream);
-gboolean sink_setup_stream(struct sink *sink, struct avdtp *session);
+gboolean sink_setup_stream(struct btd_service *service, struct avdtp *session);
 int sink_disconnect(struct audio_device *dev, gboolean shutdown);
-- 
1.8.1.4

