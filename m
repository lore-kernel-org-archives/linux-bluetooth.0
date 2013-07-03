Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 13/20] audio/source: Remove dependency on struct audio_device
Date: Wed,  3 Jul 2013 18:15:34 +0300
Message-Id: <1372864541-10763-14-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1372864541-10763-1-git-send-email-luiz.dentz@gmail.com>
References: <1372864541-10763-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is part of the work necessary to completely remove
struct audio_device
---
 profiles/audio/manager.c |  2 +-
 profiles/audio/source.c  | 23 +++++++++--------------
 profiles/audio/source.h  |  3 +--
 3 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 12c7b10..4aaf960 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -114,7 +114,7 @@ static int a2dp_source_probe(struct btd_service *service)
 		return -1;
 	}
 
-	audio_dev->source = source_init(audio_dev, service);
+	audio_dev->source = source_init(service);
 
 	return 0;
 }
diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index 87b7309..64570a6 100644
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
@@ -345,7 +343,6 @@ int source_connect(struct btd_service *service)
 static void source_free(struct btd_service *service)
 {
 	struct source *source = btd_service_get_user_data(service);
-	struct audio_device *dev = source->dev;
 
 	if (source->cb_id)
 		avdtp_stream_remove_cb(source->session, source->stream,
@@ -373,7 +370,6 @@ static void source_free(struct btd_service *service)
 	btd_service_unref(source->service);
 
 	g_free(source);
-	dev->source = NULL;
 }
 
 void source_unregister(struct btd_service *service)
@@ -385,19 +381,18 @@ void source_unregister(struct btd_service *service)
 	source_free(service);
 }
 
-struct btd_service *source_init(struct audio_device *dev,
-						struct btd_service *service)
+struct btd_service *source_init(struct btd_service *service)
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
index b9d4707..4012154 100644
--- a/profiles/audio/source.h
+++ b/profiles/audio/source.h
@@ -41,8 +41,7 @@ unsigned int source_add_state_cb(struct btd_service *service,
 					source_state_cb cb, void *user_data);
 gboolean source_remove_state_cb(unsigned int id);
 
-struct btd_service *source_init(struct audio_device *dev,
-						struct btd_service *service);
+struct btd_service *source_init(struct btd_service *service);
 void source_unregister(struct btd_service *service);
 int source_connect(struct btd_service *service);
 gboolean source_new_stream(struct btd_service *service, struct avdtp *session,
-- 
1.8.1.4

