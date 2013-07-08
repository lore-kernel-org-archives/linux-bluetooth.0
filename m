Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 12/20] audio/sink: Remove dependency on struct audio_device
Date: Mon,  8 Jul 2013 17:10:18 +0300
Message-Id: <1373292626-3776-13-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1373292626-3776-1-git-send-email-luiz.dentz@gmail.com>
References: <1373292626-3776-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is part of the work necessary to completely remove
struct audio_device
---
 profiles/audio/manager.c |  2 +-
 profiles/audio/sink.c    | 20 ++++++++------------
 profiles/audio/sink.h    |  2 +-
 3 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index ca4b9d4..cafb4dc 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -132,7 +132,7 @@ static int a2dp_sink_probe(struct btd_service *service)
 
 	audio_dev->sink = service;
 
-	return sink_init(audio_dev, service);
+	return sink_init(service);
 }
 
 static int avrcp_target_probe(struct btd_service *service)
diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index 898ffea..9226002 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -39,11 +39,10 @@
 
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
@@ -55,7 +54,6 @@
 #define STREAM_SETUP_RETRY_TIMER 2
 
 struct sink {
-	struct audio_device *dev;
 	struct btd_service *service;
 	struct avdtp *session;
 	struct avdtp_stream *stream;
@@ -335,7 +333,6 @@ int sink_connect(struct btd_service *service)
 static void sink_free(struct btd_service *service)
 {
 	struct sink *sink = btd_service_get_user_data(service);
-	struct audio_device *dev = sink->dev;
 
 	if (sink->cb_id)
 		avdtp_stream_remove_cb(sink->session, sink->stream,
@@ -363,7 +360,6 @@ static void sink_free(struct btd_service *service)
 	btd_service_unref(sink->service);
 
 	g_free(sink);
-	dev->sink = NULL;
 }
 
 void sink_unregister(struct btd_service *service)
@@ -375,19 +371,19 @@ void sink_unregister(struct btd_service *service)
 	sink_free(service);
 }
 
-int sink_init(struct audio_device *dev, struct btd_service *service)
+int sink_init(struct btd_service *service)
 {
+	struct btd_device *dev = btd_service_get_device(service);
 	struct sink *sink;
 
-	DBG("%s", device_get_path(dev->btd_dev));
+	DBG("%s", device_get_path(dev));
 
 	sink = g_new0(struct sink, 1);
 
-	sink->dev = dev;
 	sink->service = btd_service_ref(service);
 
-	sink->avdtp_callback_id = avdtp_add_state_cb(dev->btd_dev,
-						avdtp_state_callback, sink);
+	sink->avdtp_callback_id = avdtp_add_state_cb(dev, avdtp_state_callback,
+									sink);
 
 	btd_service_set_user_data(service, sink);
 
diff --git a/profiles/audio/sink.h b/profiles/audio/sink.h
index cf0934b..904a33d 100644
--- a/profiles/audio/sink.h
+++ b/profiles/audio/sink.h
@@ -40,7 +40,7 @@ unsigned int sink_add_state_cb(struct btd_service *service, sink_state_cb cb,
 							void *user_data);
 gboolean sink_remove_state_cb(unsigned int id);
 
-int sink_init(struct audio_device *dev, struct btd_service *service);
+int sink_init(struct btd_service *service);
 void sink_unregister(struct btd_service *service);
 gboolean sink_is_active(struct btd_service *service);
 int sink_connect(struct btd_service *service);
-- 
1.8.1.4

