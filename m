Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] audio/control: Remove control_update
Date: Thu, 23 May 2013 11:58:31 -0700
Message-Id: <1369335511-8874-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1369335511-8874-1-git-send-email-luiz.dentz@gmail.com>
References: <1369335511-8874-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 profiles/audio/control.c | 12 ------------
 profiles/audio/control.h |  1 -
 2 files changed, 13 deletions(-)

diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index f520e49..c33dcad 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -282,18 +282,6 @@ void control_unregister(struct audio_device *dev)
 						AUDIO_CONTROL_INTERFACE);
 }
 
-void control_update(struct control *control, struct btd_service *service)
-{
-	struct btd_profile *p = btd_service_get_profile(service);
-	const char *uuid = p->remote_uuid;
-
-	if (!control->target && bt_uuid_strcmp(uuid, AVRCP_TARGET_UUID) == 0)
-		control->target = btd_service_ref(service);
-	else if (!control->remote &&
-				bt_uuid_strcmp(uuid, AVRCP_REMOTE_UUID) == 0)
-		control->remote = btd_service_ref(service);
-}
-
 static struct control *control_init(struct audio_device *dev)
 {
 	struct control *control;
diff --git a/profiles/audio/control.h b/profiles/audio/control.h
index 369cca6..af6893b 100644
--- a/profiles/audio/control.h
+++ b/profiles/audio/control.h
@@ -30,7 +30,6 @@ struct control *control_init_target(struct audio_device *dev,
 						struct btd_service *service);
 struct control *control_init_remote(struct audio_device *dev,
 						struct btd_service *service);
-void control_update(struct control *control, struct btd_service *service);
 void control_unregister(struct audio_device *dev);
 gboolean control_is_active(struct audio_device *dev);
 
-- 
1.8.1.4

