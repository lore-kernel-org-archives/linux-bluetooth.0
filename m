Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v3 02/27] control: Simplify UUID handling during probe
Date: Fri, 26 Apr 2013 08:16:58 +0200
Message-Id: <1366957043-2383-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

There is actually one single UUID which can be received during probe, so
simplify the code accordingly.
---
 profiles/audio/control.c | 8 ++++----
 profiles/audio/control.h | 4 ++--
 profiles/audio/manager.c | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index 6086bde..fd5ff92 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -253,13 +253,13 @@ void control_unregister(struct audio_device *dev)
 						AUDIO_CONTROL_INTERFACE);
 }
 
-void control_update(struct control *control, GSList *uuids)
+void control_update(struct control *control, const char *uuid)
 {
-	if (g_slist_find_custom(uuids, AVRCP_TARGET_UUID, bt_uuid_strcmp))
+	if (bt_uuid_strcmp(uuid, AVRCP_TARGET_UUID) == 0)
 		control->target = TRUE;
 }
 
-struct control *control_init(struct audio_device *dev, GSList *uuids)
+struct control *control_init(struct audio_device *dev, const char *uuid)
 {
 	struct control *control;
 
@@ -276,7 +276,7 @@ struct control *control_init(struct audio_device *dev, GSList *uuids)
 
 	control = g_new0(struct control, 1);
 
-	control_update(control, uuids);
+	control_update(control, uuid);
 
 	control->avctp_id = avctp_add_state_cb(dev, state_changed);
 
diff --git a/profiles/audio/control.h b/profiles/audio/control.h
index de0259e..82ad0d2 100644
--- a/profiles/audio/control.h
+++ b/profiles/audio/control.h
@@ -24,8 +24,8 @@
 
 #define AUDIO_CONTROL_INTERFACE "org.bluez.MediaControl1"
 
-struct control *control_init(struct audio_device *dev, GSList *uuids);
-void control_update(struct control *control, GSList *uuids);
+struct control *control_init(struct audio_device *dev, const char *uuid);
+void control_update(struct control *control, const char *uuid);
 void control_unregister(struct audio_device *dev);
 gboolean control_is_active(struct audio_device *dev);
 
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 4517815..8131a3e 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -145,9 +145,9 @@ static int avrcp_probe(struct btd_profile *p, struct btd_device *device,
 	}
 
 	if (audio_dev->control)
-		control_update(audio_dev->control, uuids);
+		control_update(audio_dev->control, p->remote_uuid);
 	else
-		audio_dev->control = control_init(audio_dev, uuids);
+		audio_dev->control = control_init(audio_dev, p->remote_uuid);
 
 	if (audio_dev->sink && sink_is_active(audio_dev))
 		avrcp_connect(audio_dev);
-- 
1.8.1.4

