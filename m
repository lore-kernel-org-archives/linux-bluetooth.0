Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] audio: Make use of .device_probe in all AVRCP profile drivers
Date: Thu, 23 May 2013 11:58:30 -0700
Message-Id: <1369335511-8874-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1369335511-8874-1-git-send-email-luiz.dentz@gmail.com>
References: <1369335511-8874-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

We should not rely on the order of the profile driver registration nor
recheck if the UUID match every time.
---
 profiles/audio/control.c | 36 ++++++++++++++++++++++++++++++++----
 profiles/audio/control.h |  4 +++-
 profiles/audio/manager.c | 27 ++++++++++++++++++++-------
 3 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index cdba385..f520e49 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -294,11 +294,13 @@ void control_update(struct control *control, struct btd_service *service)
 		control->remote = btd_service_ref(service);
 }
 
-struct control *control_init(struct audio_device *dev,
-						struct btd_service *service)
+static struct control *control_init(struct audio_device *dev)
 {
 	struct control *control;
 
+	if (dev->control != NULL)
+		return dev->control;
+
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 					device_get_path(dev->btd_dev),
 					AUDIO_CONTROL_INTERFACE,
@@ -312,13 +314,39 @@ struct control *control_init(struct audio_device *dev,
 
 	control = g_new0(struct control, 1);
 
-	control_update(control, service);
-
 	control->avctp_id = avctp_add_state_cb(dev, state_changed);
 
 	return control;
 }
 
+struct control *control_init_target(struct audio_device *dev,
+						struct btd_service *service)
+{
+	struct control *control;
+
+	control = control_init(dev);
+	if (control == NULL)
+		return NULL;
+
+	control->target = btd_service_ref(service);
+
+	return control;
+}
+
+struct control *control_init_remote(struct audio_device *dev,
+						struct btd_service *service)
+{
+	struct control *control;
+
+	control = control_init(dev);
+	if (control == NULL)
+		return NULL;
+
+	control->remote = btd_service_ref(service);
+
+	return control;
+}
+
 gboolean control_is_active(struct audio_device *dev)
 {
 	struct control *control = dev->control;
diff --git a/profiles/audio/control.h b/profiles/audio/control.h
index 0a0f208..369cca6 100644
--- a/profiles/audio/control.h
+++ b/profiles/audio/control.h
@@ -26,7 +26,9 @@
 
 struct btd_service;
 
-struct control *control_init(struct audio_device *dev,
+struct control *control_init_target(struct audio_device *dev,
+						struct btd_service *service);
+struct control *control_init_remote(struct audio_device *dev,
 						struct btd_service *service);
 void control_update(struct control *control, struct btd_service *service);
 void control_unregister(struct audio_device *dev);
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 1518e5d..7f02fbd 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -135,7 +135,7 @@ static int a2dp_sink_probe(struct btd_service *service)
 	return 0;
 }
 
-static int avrcp_probe(struct btd_service *service)
+static int avrcp_target_probe(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
 	struct audio_device *audio_dev;
@@ -146,10 +146,7 @@ static int avrcp_probe(struct btd_service *service)
 		return -1;
 	}
 
-	if (audio_dev->control)
-		control_update(audio_dev->control, service);
-	else
-		audio_dev->control = control_init(audio_dev, service);
+	audio_dev->control = control_init_target(audio_dev, service);
 
 	if (audio_dev->sink && sink_is_active(audio_dev))
 		avrcp_connect(audio_dev);
@@ -157,6 +154,22 @@ static int avrcp_probe(struct btd_service *service)
 	return 0;
 }
 
+static int avrcp_remote_probe(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct audio_device *audio_dev;
+
+	audio_dev = get_audio_dev(device);
+	if (!audio_dev) {
+		DBG("unable to get a device object");
+		return -1;
+	}
+
+	audio_dev->control = control_init_remote(audio_dev, service);
+
+	return 0;
+}
+
 static int a2dp_source_connect(struct btd_service *service)
 {
 	struct btd_device *dev = btd_service_get_device(service);
@@ -373,7 +386,7 @@ static struct btd_profile avrcp_target_profile = {
 	.name		= "audio-avrcp-target",
 
 	.remote_uuid	= AVRCP_TARGET_UUID,
-	.device_probe	= avrcp_probe,
+	.device_probe	= avrcp_target_probe,
 	.device_remove	= audio_remove,
 
 	.connect	= avrcp_target_connect,
@@ -387,7 +400,7 @@ static struct btd_profile avrcp_remote_profile = {
 	.name		= "audio-avrcp-control",
 
 	.remote_uuid	= AVRCP_REMOTE_UUID,
-	.device_probe	= avrcp_probe,
+	.device_probe	= avrcp_remote_probe,
 	.device_remove	= audio_remove,
 
 	.adapter_probe	= avrcp_remote_server_probe,
-- 
1.8.1.4

