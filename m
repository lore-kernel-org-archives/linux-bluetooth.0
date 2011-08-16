Return-Path: <cyrus@holtmann.org>
From: Prasad Bhat <prasadbhat22@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/6] This adds video-sink and video-source interfaces and vdp_server_driver to audio/manager{.c, .h}
Date: Tue, 16 Aug 2011 19:13:57 +0530
Message-Id: <1313502238-7581-5-git-send-email-prasadbhat22@gmail.com>
In-Reply-To: <1313502238-7581-1-git-send-email-prasadbhat22@gmail.com>
References: <1313502238-7581-1-git-send-email-prasadbhat22@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/manager.c |   87 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 audio/manager.h |    2 +
 2 files changed, 89 insertions(+), 0 deletions(-)

diff --git a/audio/manager.c b/audio/manager.c
index 6e583cf..352d91d 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -59,10 +59,13 @@
 #include "avdtp.h"
 #include "media.h"
 #include "a2dp.h"
+#include "vdp.h"
 #include "headset.h"
 #include "gateway.h"
 #include "sink.h"
 #include "source.h"
+#include "video-sink.h"
+#include "video-source.h"
 #include "control.h"
 #include "manager.h"
 #include "sdpd.h"
@@ -119,6 +122,8 @@ static struct enabled_interfaces enabled = {
 	.socket		= TRUE,
 	.media		= FALSE,
 	.media_player	= FALSE,
+	.video_sink	= FALSE,
+	.video_source	= FALSE,
 };
 
 static struct audio_adapter *find_adapter(GSList *list,
@@ -149,6 +154,10 @@ gboolean server_is_enabled(bdaddr_t *src, uint16_t svc)
 		return enabled.sink;
 	case AUDIO_SOURCE_SVCLASS_ID:
 		return enabled.source;
+	case VIDEO_SINK_SVCLASS_ID:
+		return enabled.video_sink;
+	case VIDEO_SOURCE_SVCLASS_ID:
+		return enabled.video_source;
 	case AV_REMOTE_TARGET_SVCLASS_ID:
 	case AV_REMOTE_SVCLASS_ID:
 		return enabled.control;
@@ -214,6 +223,16 @@ static void handle_uuid(const char *uuidstr, struct audio_device *device)
 		if (device->source == NULL)
 			device->source = source_init(device);
 		break;
+	case VIDEO_SINK_SVCLASS_ID:
+		DBG("Found Video Sink");
+		if (device->video_sink == NULL)
+			device->video_sink = video_sink_register(device);
+		break;
+	case VIDEO_SOURCE_SVCLASS_ID:
+		DBG("Found Video Source");
+		if (device->video_source == NULL)	
+			device->video_source = video_source_register(device);
+		break;
 	case AV_REMOTE_SVCLASS_ID:
 	case AV_REMOTE_TARGET_SVCLASS_ID:
 		DBG("Found AV %s", uuid16 == AV_REMOTE_SVCLASS_ID ?
@@ -1035,6 +1054,45 @@ static void a2dp_server_remove(struct btd_adapter *adapter)
 	audio_adapter_unref(adp);
 }
 
+static int vdp_server_probe(struct btd_adapter *adapter)
+{
+	struct audio_adapter *adp;
+	const gchar *path = adapter_get_path(adapter);
+	bdaddr_t src;
+	int err;
+
+	DBG("path %s", path);
+
+	adp = audio_adapter_get(adapter);
+	if (!adp)
+		return -EINVAL;
+
+	adapter_get_address(adapter, &src);
+
+	err = vdp_register(connection, &src, config);
+	if (err < 0)
+		audio_adapter_unref(adp);
+
+	return err;
+}
+
+static void vdp_server_remove(struct btd_adapter *adapter)
+{
+	struct audio_adapter *adp;
+	const gchar *path = adapter_get_path(adapter);
+	bdaddr_t src;
+
+	DBG("path %s", path);
+
+	adp = find_adapter(adapters, adapter);
+	if (!adp)
+		return;
+
+	adapter_get_address(adapter, &src);
+	vdp_unregister(&src);
+	audio_adapter_unref(adp);
+}
+
 static int avrcp_server_probe(struct btd_adapter *adapter)
 {
 	struct audio_adapter *adp;
@@ -1105,6 +1163,7 @@ static struct btd_device_driver audio_driver = {
 	.name	= "audio",
 	.uuids	= BTD_UUIDS(HSP_HS_UUID, HFP_HS_UUID, HSP_AG_UUID, HFP_AG_UUID,
 			ADVANCED_AUDIO_UUID, A2DP_SOURCE_UUID, A2DP_SINK_UUID,
+			VIDEO_DISTRIBUTION_UUID, VDP_SOURCE_UUID, VDP_SINK_UUID,
 			AVRCP_TARGET_UUID, AVRCP_REMOTE_UUID),
 	.probe	= audio_probe,
 	.remove	= audio_remove,
@@ -1128,6 +1187,12 @@ static struct btd_adapter_driver a2dp_server_driver = {
 	.remove	= a2dp_server_remove,
 };
 
+static struct btd_adapter_driver vdp_server_driver = {
+	.name	= "video-vdp",
+	.probe	= vdp_server_probe,
+	.remove	= vdp_server_remove,
+};
+
 static struct btd_adapter_driver avrcp_server_driver = {
 	.name	= "audio-control",
 	.probe	= avrcp_server_probe,
@@ -1166,6 +1231,10 @@ int audio_manager_init(DBusConnection *conn, GKeyFile *conf,
 			enabled.sink = TRUE;
 		else if (g_str_equal(list[i], "Source"))
 			enabled.source = TRUE;
+		else if (g_str_equal(list[i], "VideoSink"))
+			enabled.video_sink = TRUE;
+		else if (g_str_equal(list[i], "VideoSource"))
+			enabled.video_source = TRUE;
 		else if (g_str_equal(list[i], "Control"))
 			enabled.control = TRUE;
 		else if (g_str_equal(list[i], "Socket"))
@@ -1189,6 +1258,10 @@ int audio_manager_init(DBusConnection *conn, GKeyFile *conf,
 			enabled.sink = FALSE;
 		else if (g_str_equal(list[i], "Source"))
 			enabled.source = FALSE;
+		else if (g_str_equal(list[i], "VideoSink"))
+			enabled.video_sink = FALSE;
+		else if (g_str_equal(list[i], "VideoSource"))
+			enabled.video_source = FALSE;
 		else if (g_str_equal(list[i], "Control"))
 			enabled.control = FALSE;
 		else if (g_str_equal(list[i], "Socket"))
@@ -1239,6 +1312,9 @@ proceed:
 	if (enabled.source || enabled.sink)
 		btd_register_adapter_driver(&a2dp_server_driver);
 
+	if (enabled.video_source || enabled.video_sink)
+		btd_register_adapter_driver(&vdp_server_driver);
+
 	if (enabled.control)
 		btd_register_adapter_driver(&avrcp_server_driver);
 
@@ -1278,6 +1354,9 @@ void audio_manager_exit(void)
 	if (enabled.source || enabled.sink)
 		btd_unregister_adapter_driver(&a2dp_server_driver);
 
+	if (enabled.video_source || enabled.video_sink)
+		btd_unregister_adapter_driver(&vdp_server_driver);
+
 	if (enabled.control)
 		btd_unregister_adapter_driver(&avrcp_server_driver);
 
@@ -1320,6 +1399,14 @@ struct audio_device *manager_find_device(const char *path,
 				&& !dev->source)
 			continue;
 
+		if (interface && !strcmp(VIDEO_SINK_INTERFACE, interface)
+				&& !dev->video_sink)
+			continue;
+	
+		if (interface && !strcmp(VIDEO_SOURCE_INTERFACE, interface)
+				&& !dev->video_source)
+			continue;
+
 		if (interface && !strcmp(AUDIO_CONTROL_INTERFACE, interface)
 				&& !dev->control)
 			continue;
diff --git a/audio/manager.h b/audio/manager.h
index cfc646c..6c61da4 100644
--- a/audio/manager.h
+++ b/audio/manager.h
@@ -28,6 +28,8 @@ struct enabled_interfaces {
 	gboolean gateway;
 	gboolean sink;
 	gboolean source;
+	gboolean video_sink;
+	gboolean video_source;
 	gboolean control;
 	gboolean socket;
 	gboolean media;
-- 
1.7.6

