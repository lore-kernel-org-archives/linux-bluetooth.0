Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v3 24/27] control: Bypass manager for connect state changes
Date: Fri, 26 Apr 2013 08:17:20 +0200
Message-Id: <1366957043-2383-25-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Move the code to propagate the AVRCP->core state changes from manager.c
to control.c.
---
 profiles/audio/avrcp.c   | 16 ++++++++--------
 profiles/audio/control.c | 32 ++++++++++++++++++++++++++++++++
 profiles/audio/control.h |  5 +++++
 profiles/audio/manager.c | 20 --------------------
 profiles/audio/manager.h |  4 ----
 5 files changed, 45 insertions(+), 32 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 512b018..b7de051 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2668,7 +2668,7 @@ static void session_tg_init_control(struct avrcp *session)
 		avrcp_register_notification(session,
 						AVRCP_EVENT_VOLUME_CHANGED);
 
-	audio_controller_connected(session->dev->btd_dev, 0);
+	control_remote_connected(session->dev->control, 0);
 }
 
 static void session_ct_init_browsing(struct avrcp *session)
@@ -2694,7 +2694,7 @@ static void session_ct_init_control(struct avrcp *session)
 	if (session->version >= 0x0104)
 		session->supported_events = (1 << AVRCP_EVENT_VOLUME_CHANGED);
 
-	audio_target_connected(session->dev->btd_dev, 0);
+	control_target_connected(session->dev->control, 0);
 
 	player = create_ct_player(session, 0);
 	if (player == NULL)
@@ -2731,9 +2731,9 @@ static void session_tg_destroy(struct avrcp *session)
 		player->sessions = g_slist_remove(player->sessions, session);
 
 	if (session->control_id == 0)
-		audio_controller_connected(session->dev->btd_dev, -EIO);
-
-	audio_controller_disconnected(session->dev->btd_dev, 0);
+		control_remote_connected(session->dev->control, -EIO);
+	else
+		control_remote_disconnected(session->dev->control, 0);
 
 	session_destroy(session);
 }
@@ -2745,9 +2745,9 @@ static void session_ct_destroy(struct avrcp *session)
 	g_slist_free_full(session->players, player_destroy);
 
 	if (session->control_id == 0)
-		audio_target_connected(session->dev->btd_dev, -EIO);
-
-	audio_target_disconnected(session->dev->btd_dev, 0);
+		control_target_connected(session->dev->control, -EIO);
+	else
+		control_target_disconnected(session->dev->control, 0);
 
 	session_destroy(session);
 }
diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index 10cd1de..bb3f812 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -68,6 +68,38 @@ struct control {
 	unsigned int avctp_id;
 };
 
+void control_target_connected(struct control *control, int err)
+{
+	struct btd_device *device = btd_service_get_device(control->target);
+	struct btd_profile *profile = btd_service_get_profile(control->target);
+
+	device_profile_connected(device, profile, err);
+}
+
+void control_target_disconnected(struct control *control, int err)
+{
+	struct btd_device *device = btd_service_get_device(control->target);
+	struct btd_profile *profile = btd_service_get_profile(control->target);
+
+	device_profile_disconnected(device, profile, err);
+}
+
+void control_remote_connected(struct control *control, int err)
+{
+	struct btd_device *device = btd_service_get_device(control->remote);
+	struct btd_profile *profile = btd_service_get_profile(control->remote);
+
+	device_profile_connected(device, profile, err);
+}
+
+void control_remote_disconnected(struct control *control, int err)
+{
+	struct btd_device *device = btd_service_get_device(control->remote);
+	struct btd_profile *profile = btd_service_get_profile(control->remote);
+
+	device_profile_disconnected(device, profile, err);
+}
+
 static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 							avctp_state_t new_state)
 {
diff --git a/profiles/audio/control.h b/profiles/audio/control.h
index 0176b54..0a0f208 100644
--- a/profiles/audio/control.h
+++ b/profiles/audio/control.h
@@ -34,3 +34,8 @@ gboolean control_is_active(struct audio_device *dev);
 
 int control_connect(struct audio_device *dev);
 int control_disconnect(struct audio_device *dev);
+
+void control_target_connected(struct control *control, int err);
+void control_target_disconnected(struct control *control, int err);
+void control_remote_connected(struct control *control, int err);
+void control_remote_disconnected(struct control *control, int err);
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index e886e12..901f94f 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -421,26 +421,6 @@ void audio_source_disconnected(struct btd_device *dev, int err)
 	device_profile_disconnected(dev, &a2dp_source_profile, err);
 }
 
-void audio_target_connected(struct btd_device *dev, int err)
-{
-	device_profile_connected(dev, &avrcp_target_profile, err);
-}
-
-void audio_target_disconnected(struct btd_device *dev, int err)
-{
-	device_profile_disconnected(dev, &avrcp_target_profile, err);
-}
-
-void audio_controller_connected(struct btd_device *dev, int err)
-{
-	device_profile_connected(dev, &avrcp_remote_profile, err);
-}
-
-void audio_controller_disconnected(struct btd_device *dev, int err)
-{
-	device_profile_disconnected(dev, &avrcp_remote_profile, err);
-}
-
 int audio_manager_init(GKeyFile *conf)
 {
 	if (conf)
diff --git a/profiles/audio/manager.h b/profiles/audio/manager.h
index 9b5af5f..2567e46 100644
--- a/profiles/audio/manager.h
+++ b/profiles/audio/manager.h
@@ -33,10 +33,6 @@ void audio_sink_connected(struct btd_device *dev, int err);
 void audio_sink_disconnected(struct btd_device *dev, int err);
 void audio_source_connected(struct btd_device *dev, int err);
 void audio_source_disconnected(struct btd_device *dev, int err);
-void audio_target_connected(struct btd_device *dev, int err);
-void audio_target_disconnected(struct btd_device *dev, int err);
-void audio_controller_connected(struct btd_device *dev, int err);
-void audio_controller_disconnected(struct btd_device *dev, int err);
 
 int audio_manager_init(GKeyFile *config);
 void audio_manager_exit(void);
-- 
1.8.1.4

