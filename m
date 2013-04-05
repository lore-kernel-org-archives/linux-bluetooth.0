Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v2 07/11] audio: Hold a reference to btd_service
Date: Fri,  5 Apr 2013 13:45:44 +0200
Message-Id: <1365162348-25541-8-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1365162348-25541-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1365162348-25541-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Profile implementations are expected to hold a reference to probed
services, so update the audio profiles accordingly.
---
 profiles/audio/control.c | 28 ++++++++++++++++++++++------
 profiles/audio/control.h |  7 +++++--
 profiles/audio/manager.c |  9 ++++-----
 profiles/audio/sink.c    |  6 +++++-
 profiles/audio/sink.h    |  4 +++-
 profiles/audio/source.c  |  7 ++++++-
 profiles/audio/source.h  |  5 ++++-
 7 files changed, 49 insertions(+), 17 deletions(-)

diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index fd5ff92..10cd1de 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -48,6 +48,8 @@
 #include "lib/uuid.h"
 #include "../src/adapter.h"
 #include "../src/device.h"
+#include "../src/profile.h"
+#include "../src/service.h"
 
 #include "log.h"
 #include "error.h"
@@ -61,7 +63,8 @@
 
 struct control {
 	struct avctp *session;
-	gboolean target;
+	struct btd_service *target;
+	struct btd_service *remote;
 	unsigned int avctp_id;
 };
 
@@ -242,6 +245,12 @@ static void path_unregister(void *data)
 
 	avctp_remove_state_cb(control->avctp_id);
 
+	if (control->target)
+		btd_service_unref(control->target);
+
+	if (control->remote)
+		btd_service_unref(control->remote);
+
 	g_free(control);
 	dev->control = NULL;
 }
@@ -253,13 +262,20 @@ void control_unregister(struct audio_device *dev)
 						AUDIO_CONTROL_INTERFACE);
 }
 
-void control_update(struct control *control, const char *uuid)
+void control_update(struct control *control, struct btd_service *service)
 {
-	if (bt_uuid_strcmp(uuid, AVRCP_TARGET_UUID) == 0)
-		control->target = TRUE;
+	struct btd_profile *p = btd_service_get_profile(service);
+	const char *uuid = p->remote_uuid;
+
+	if (!control->target && bt_uuid_strcmp(uuid, AVRCP_TARGET_UUID) == 0)
+		control->target = btd_service_ref(service);
+	else if (!control->remote &&
+				bt_uuid_strcmp(uuid, AVRCP_REMOTE_UUID) == 0)
+		control->remote = btd_service_ref(service);
 }
 
-struct control *control_init(struct audio_device *dev, const char *uuid)
+struct control *control_init(struct audio_device *dev,
+						struct btd_service *service)
 {
 	struct control *control;
 
@@ -276,7 +292,7 @@ struct control *control_init(struct audio_device *dev, const char *uuid)
 
 	control = g_new0(struct control, 1);
 
-	control_update(control, uuid);
+	control_update(control, service);
 
 	control->avctp_id = avctp_add_state_cb(dev, state_changed);
 
diff --git a/profiles/audio/control.h b/profiles/audio/control.h
index 82ad0d2..0176b54 100644
--- a/profiles/audio/control.h
+++ b/profiles/audio/control.h
@@ -24,8 +24,11 @@
 
 #define AUDIO_CONTROL_INTERFACE "org.bluez.MediaControl1"
 
-struct control *control_init(struct audio_device *dev, const char *uuid);
-void control_update(struct control *control, const char *uuid);
+struct btd_service;
+
+struct control *control_init(struct audio_device *dev,
+						struct btd_service *service);
+void control_update(struct control *control, struct btd_service *service);
 void control_unregister(struct audio_device *dev);
 gboolean control_is_active(struct audio_device *dev);
 
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index ff4590e..e886e12 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -114,7 +114,7 @@ static int a2dp_source_probe(struct btd_service *service)
 		return -1;
 	}
 
-	audio_dev->source = source_init(audio_dev);
+	audio_dev->source = source_init(audio_dev, service);
 
 	return 0;
 }
@@ -130,7 +130,7 @@ static int a2dp_sink_probe(struct btd_service *service)
 		return -1;
 	}
 
-	audio_dev->sink = sink_init(audio_dev);
+	audio_dev->sink = sink_init(audio_dev, service);
 
 	return 0;
 }
@@ -138,7 +138,6 @@ static int a2dp_sink_probe(struct btd_service *service)
 static int avrcp_probe(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
-	struct btd_profile *p = btd_service_get_profile(service);
 	struct audio_device *audio_dev;
 
 	audio_dev = get_audio_dev(device);
@@ -148,9 +147,9 @@ static int avrcp_probe(struct btd_service *service)
 	}
 
 	if (audio_dev->control)
-		control_update(audio_dev->control, p->remote_uuid);
+		control_update(audio_dev->control, service);
 	else
-		audio_dev->control = control_init(audio_dev, p->remote_uuid);
+		audio_dev->control = control_init(audio_dev, service);
 
 	if (audio_dev->sink && sink_is_active(audio_dev))
 		avrcp_connect(audio_dev);
diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index f023307..9f1a2d9 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -41,6 +41,7 @@
 
 #include "../src/adapter.h"
 #include "../src/device.h"
+#include "../src/service.h"
 
 #include "device.h"
 #include "avdtp.h"
@@ -55,6 +56,7 @@
 
 struct sink {
 	struct audio_device *dev;
+	struct btd_service *service;
 	struct avdtp *session;
 	struct avdtp_stream *stream;
 	unsigned int cb_id;
@@ -361,6 +363,7 @@ static void sink_free(struct audio_device *dev)
 		g_source_remove(sink->retry_id);
 
 	avdtp_remove_state_cb(sink->avdtp_callback_id);
+	btd_service_unref(sink->service);
 
 	g_free(sink);
 	dev->sink = NULL;
@@ -372,7 +375,7 @@ void sink_unregister(struct audio_device *dev)
 	sink_free(dev);
 }
 
-struct sink *sink_init(struct audio_device *dev)
+struct sink *sink_init(struct audio_device *dev, struct btd_service *service)
 {
 	struct sink *sink;
 
@@ -381,6 +384,7 @@ struct sink *sink_init(struct audio_device *dev)
 	sink = g_new0(struct sink, 1);
 
 	sink->dev = dev;
+	sink->service = btd_service_ref(service);
 
 	sink->avdtp_callback_id = avdtp_add_state_cb(dev, avdtp_state_callback);
 
diff --git a/profiles/audio/sink.h b/profiles/audio/sink.h
index ba0dde8..1f20545 100644
--- a/profiles/audio/sink.h
+++ b/profiles/audio/sink.h
@@ -36,11 +36,13 @@ typedef void (*sink_state_cb) (struct audio_device *dev,
 				sink_state_t new_state,
 				void *user_data);
 
+struct btd_service;
+
 unsigned int sink_add_state_cb(struct audio_device *dev, sink_state_cb cb,
 							void *user_data);
 gboolean sink_remove_state_cb(unsigned int id);
 
-struct sink *sink_init(struct audio_device *dev);
+struct sink *sink_init(struct audio_device *dev, struct btd_service *service);
 void sink_unregister(struct audio_device *dev);
 gboolean sink_is_active(struct audio_device *dev);
 int sink_connect(struct audio_device *dev);
diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index 5d9e237..20fd412 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -42,6 +42,7 @@
 
 #include "../src/adapter.h"
 #include "../src/device.h"
+#include "../src/service.h"
 
 #include "device.h"
 #include "avdtp.h"
@@ -56,6 +57,7 @@
 
 struct source {
 	struct audio_device *dev;
+	struct btd_service *service;
 	struct avdtp *session;
 	struct avdtp_stream *stream;
 	unsigned int cb_id;
@@ -365,6 +367,7 @@ static void source_free(struct audio_device *dev)
 		g_source_remove(source->retry_id);
 
 	avdtp_remove_state_cb(source->avdtp_callback_id);
+	btd_service_unref(source->service);
 
 	g_free(source);
 	dev->source = NULL;
@@ -377,7 +380,8 @@ void source_unregister(struct audio_device *dev)
 	source_free(dev);
 }
 
-struct source *source_init(struct audio_device *dev)
+struct source *source_init(struct audio_device *dev,
+						struct btd_service *service)
 {
 	struct source *source;
 
@@ -386,6 +390,7 @@ struct source *source_init(struct audio_device *dev)
 	source = g_new0(struct source, 1);
 
 	source->dev = dev;
+	source->service = btd_service_ref(service);
 
 	source->avdtp_callback_id = avdtp_add_state_cb(dev,
 							avdtp_state_callback);
diff --git a/profiles/audio/source.h b/profiles/audio/source.h
index 61afd94..0156423 100644
--- a/profiles/audio/source.h
+++ b/profiles/audio/source.h
@@ -37,11 +37,14 @@ typedef void (*source_state_cb) (struct audio_device *dev,
 				source_state_t new_state,
 				void *user_data);
 
+struct btd_service;
+
 unsigned int source_add_state_cb(struct audio_device *dev, source_state_cb cb,
 							void *user_data);
 gboolean source_remove_state_cb(unsigned int id);
 
-struct source *source_init(struct audio_device *dev);
+struct source *source_init(struct audio_device *dev,
+				struct btd_service *service);
 void source_unregister(struct audio_device *dev);
 int source_connect(struct audio_device *dev);
 gboolean source_new_stream(struct audio_device *dev, struct avdtp *session,
-- 
1.8.1.4

