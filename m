Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 16/20] audio/manager: Remove dependency on struct audio_device
Date: Mon,  8 Jul 2013 17:10:22 +0300
Message-Id: <1373292626-3776-17-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1373292626-3776-1-git-send-email-luiz.dentz@gmail.com>
References: <1373292626-3776-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is part of the work necessary to completely remove
struct audio_device
---
 profiles/audio/manager.c | 144 ++++++++++++-----------------------------------
 profiles/audio/manager.h |  10 ----
 2 files changed, 35 insertions(+), 119 deletions(-)

diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 586f943..cb40583 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -50,13 +50,12 @@
 
 #include "lib/uuid.h"
 #include "glib-helper.h"
-#include "../src/adapter.h"
-#include "../src/device.h"
-#include "../src/profile.h"
-#include "../src/service.h"
+#include "src/adapter.h"
+#include "src/device.h"
+#include "src/profile.h"
+#include "src/service.h"
 
 #include "log.h"
-#include "device.h"
 #include "error.h"
 #include "avdtp.h"
 #include "media.h"
@@ -69,115 +68,63 @@
 #include "sdpd.h"
 
 static GKeyFile *config = NULL;
-static GSList *devices = NULL;
 
-static struct audio_device *get_audio_dev(struct btd_device *device)
-{
-	return manager_get_audio_device(device, TRUE);
-}
-
-static struct audio_device *manager_find_device(struct btd_device *device)
+static int a2dp_source_probe(struct btd_service *service)
 {
-	GSList *l;
+	struct btd_device *dev = btd_service_get_device(service);
 
-	for (l = devices; l != NULL; l = l->next) {
-		struct audio_device *dev = l->data;
+	DBG("path %s", device_get_path(dev));
 
-		if (dev->btd_dev == device)
-			return dev;
-	}
+	source_init(service);
 
-	return NULL;
+	return 0;
 }
 
-static void audio_remove(struct btd_service *service)
+static void a2dp_source_remove(struct btd_service *service)
 {
-	struct btd_device *device = btd_service_get_device(service);
-	struct audio_device *dev;
-
-	dev = manager_find_device(device);
-	if (dev == NULL)
-		return;
-
-	devices = g_slist_remove(devices, dev);
-	audio_device_unregister(dev);
+	source_unregister(service);
 }
 
-static int a2dp_source_probe(struct btd_service *service)
+static int a2dp_sink_probe(struct btd_service *service)
 {
-	struct btd_device *device = btd_service_get_device(service);
-	struct audio_device *audio_dev;
-
-	audio_dev = get_audio_dev(device);
-	if (!audio_dev) {
-		DBG("unable to get a device object");
-		return -1;
-	}
+	struct btd_device *dev = btd_service_get_device(service);
 
-	audio_dev->source = service;
+	DBG("path %s", device_get_path(dev));
 
-	return source_init(service);
+	return sink_init(service);
 }
 
-static int a2dp_sink_probe(struct btd_service *service)
+static void a2dp_sink_remove(struct btd_service *service)
 {
-	struct btd_device *device = btd_service_get_device(service);
-	struct audio_device *audio_dev;
-
-	audio_dev = get_audio_dev(device);
-	if (!audio_dev) {
-		DBG("unable to get a device object");
-		return -1;
-	}
-
-	audio_dev->sink = service;
-
-	return sink_init(service);
+	sink_unregister(service);
 }
 
 static int avrcp_target_probe(struct btd_service *service)
 {
-	struct btd_device *device = btd_service_get_device(service);
-	struct audio_device *audio_dev;
-	int err;
-
-	audio_dev = get_audio_dev(device);
-	if (!audio_dev) {
-		DBG("unable to get a device object");
-		return -1;
-	}
-
-	err = control_init_target(service);
-	if (err < 0)
-		return 0;
+	struct btd_device *dev = btd_service_get_device(service);
 
-	audio_dev->control = service;
+	DBG("path %s", device_get_path(dev));
 
-	if (audio_dev->sink && sink_is_active(audio_dev->sink))
-		avrcp_connect(audio_dev->btd_dev);
+	return control_init_target(service);
+}
 
-	return 0;
+static void avrcp_target_remove(struct btd_service *service)
+{
+	control_unregister(service);
 }
 
 static int avrcp_remote_probe(struct btd_service *service)
 {
-	struct btd_device *device = btd_service_get_device(service);
-	struct audio_device *audio_dev;
-	int err;
-
-	audio_dev = get_audio_dev(device);
-	if (!audio_dev) {
-		DBG("unable to get a device object");
-		return -1;
-	}
+	struct btd_device *dev = btd_service_get_device(service);
 
-	err = control_init_remote(service);
-	if (err < 0)
-		return err;
+	DBG("path %s", device_get_path(dev));
 
-	audio_dev->control = service;
+	return control_init_remote(service);
+}
 
-	return 0;
+static void avrcp_remote_remove(struct btd_service *service)
+{
+	control_unregister(service);
 }
 
 static int a2dp_source_connect(struct btd_service *service)
@@ -324,7 +271,7 @@ static struct btd_profile a2dp_source_profile = {
 
 	.remote_uuid	= A2DP_SOURCE_UUID,
 	.device_probe	= a2dp_source_probe,
-	.device_remove	= audio_remove,
+	.device_remove	= a2dp_source_remove,
 
 	.auto_connect	= true,
 	.connect	= a2dp_source_connect,
@@ -340,7 +287,7 @@ static struct btd_profile a2dp_sink_profile = {
 
 	.remote_uuid	= A2DP_SINK_UUID,
 	.device_probe	= a2dp_sink_probe,
-	.device_remove	= audio_remove,
+	.device_remove	= a2dp_sink_remove,
 
 	.auto_connect	= true,
 	.connect	= a2dp_sink_connect,
@@ -355,7 +302,7 @@ static struct btd_profile avrcp_target_profile = {
 
 	.remote_uuid	= AVRCP_TARGET_UUID,
 	.device_probe	= avrcp_target_probe,
-	.device_remove	= audio_remove,
+	.device_remove	= avrcp_target_remove,
 
 	.connect	= avrcp_target_connect,
 	.disconnect	= avrcp_target_disconnect,
@@ -369,7 +316,7 @@ static struct btd_profile avrcp_remote_profile = {
 
 	.remote_uuid	= AVRCP_REMOTE_UUID,
 	.device_probe	= avrcp_remote_probe,
-	.device_remove	= audio_remove,
+	.device_remove	= avrcp_remote_remove,
 
 	.adapter_probe	= avrcp_remote_server_probe,
 	.adapter_remove = avrcp_remote_server_remove,
@@ -411,27 +358,6 @@ void audio_manager_exit(void)
 	btd_unregister_adapter_driver(&media_driver);
 }
 
-struct audio_device *manager_get_audio_device(struct btd_device *device,
-							gboolean create)
-{
-	struct audio_device *dev;
-
-	dev = manager_find_device(device);
-	if (dev)
-		return dev;
-
-	if (!create)
-		return NULL;
-
-	dev = audio_device_register(device);
-	if (!dev)
-		return NULL;
-
-	devices = g_slist_append(devices, dev);
-
-	return dev;
-}
-
 static void set_fast_connectable(struct btd_adapter *adapter,
 							gpointer user_data)
 {
diff --git a/profiles/audio/manager.h b/profiles/audio/manager.h
index b8d8ef7..de8d791 100644
--- a/profiles/audio/manager.h
+++ b/profiles/audio/manager.h
@@ -22,19 +22,9 @@
  *
  */
 
-struct enabled_interfaces {
-	gboolean sink;
-	gboolean source;
-	gboolean control;
-	gboolean media_player;
-};
-
 int audio_manager_init(GKeyFile *config);
 void audio_manager_exit(void);
 
-struct audio_device *manager_get_audio_device(struct btd_device *device,
-							gboolean create);
-
 /* TRUE to enable fast connectable and FALSE to disable fast connectable for all
  * audio adapters. */
 void manager_set_fast_connectable(gboolean enable);
-- 
1.8.1.4

