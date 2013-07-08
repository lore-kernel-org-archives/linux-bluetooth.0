Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 13/20] audio/source: Remove dependency on struct audio_device
Date: Mon,  8 Jul 2013 17:10:19 +0300
Message-Id: <1373292626-3776-14-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1373292626-3776-1-git-send-email-luiz.dentz@gmail.com>
References: <1373292626-3776-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is part of the work necessary to completely remove
struct audio_device
---
 profiles/audio/manager.c |  2 +-
 profiles/audio/source.c  | 22 +++++++++-------------
 profiles/audio/source.h  |  2 +-
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index cafb4dc..586f943 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -116,7 +116,7 @@ static int a2dp_source_probe(struct btd_service *service)
 
 	audio_dev->source = service;
 
-	return source_init(audio_dev, service);
+	return source_init(service);
 }
 
 static int a2dp_sink_probe(struct btd_service *service)
diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index 8430121..3cb3dbb 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -40,11 +40,10 @@
 
 #include "log.h"
 
-#include "../src/adapter.h"
-#include "../src/device.h"
-#include "../src/service.h"
+#include "src/adapter.h"
+#include "src/device.h"
+#include "src/service.h"
 
-#include "device.h"
 #include "avdtp.h"
 #include "media.h"
 #include "a2dp.h"
@@ -56,7 +55,6 @@
 #define STREAM_SETUP_RETRY_TIMER 2
 
 struct source {
-	struct audio_device *dev;
 	struct btd_service *service;
 	struct avdtp *session;
 	struct avdtp_stream *stream;
@@ -88,13 +86,13 @@ static char *str_state[] = {
 
 static void source_set_state(struct source *source, source_state_t new_state)
 {
-	struct audio_device *dev = source->dev;
+	struct btd_device *dev = btd_service_get_device(source->service);
 	source_state_t old_state = source->state;
 	GSList *l;
 
 	source->state = new_state;
 
-	DBG("State changed %s: %s -> %s", device_get_path(dev->btd_dev),
+	DBG("State changed %s: %s -> %s", device_get_path(dev),
 				str_state[old_state], str_state[new_state]);
 
 	for (l = source_callbacks; l != NULL; l = l->next) {
@@ -338,7 +336,6 @@ int source_connect(struct btd_service *service)
 static void source_free(struct btd_service *service)
 {
 	struct source *source = btd_service_get_user_data(service);
-	struct audio_device *dev = source->dev;
 
 	if (source->cb_id)
 		avdtp_stream_remove_cb(source->session, source->stream,
@@ -366,7 +363,6 @@ static void source_free(struct btd_service *service)
 	btd_service_unref(source->service);
 
 	g_free(source);
-	dev->source = NULL;
 }
 
 void source_unregister(struct btd_service *service)
@@ -378,18 +374,18 @@ void source_unregister(struct btd_service *service)
 	source_free(service);
 }
 
-int source_init(struct audio_device *dev, struct btd_service *service)
+int source_init(struct btd_service *service)
 {
+	struct btd_device *dev = btd_service_get_device(service);
 	struct source *source;
 
-	DBG("%s", device_get_path(dev->btd_dev));
+	DBG("%s", device_get_path(dev));
 
 	source = g_new0(struct source, 1);
 
-	source->dev = dev;
 	source->service = btd_service_ref(service);
 
-	source->avdtp_callback_id = avdtp_add_state_cb(dev->btd_dev,
+	source->avdtp_callback_id = avdtp_add_state_cb(dev,
 							avdtp_state_callback,
 							source);
 
diff --git a/profiles/audio/source.h b/profiles/audio/source.h
index 6c35d6e..c16fb4b 100644
--- a/profiles/audio/source.h
+++ b/profiles/audio/source.h
@@ -41,7 +41,7 @@ unsigned int source_add_state_cb(struct btd_service *service,
 					source_state_cb cb, void *user_data);
 gboolean source_remove_state_cb(unsigned int id);
 
-int source_init(struct audio_device *dev, struct btd_service *service);
+int source_init(struct btd_service *service);
 void source_unregister(struct btd_service *service);
 int source_connect(struct btd_service *service);
 gboolean source_new_stream(struct btd_service *service, struct avdtp *session,
-- 
1.8.1.4

