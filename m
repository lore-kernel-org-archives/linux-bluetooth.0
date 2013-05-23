Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: deymo@chromium.org, Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v0 2/4] control: Remove unused parameter
Date: Thu, 23 May 2013 11:28:27 +0200
Message-Id: <1369301309-25189-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1369301309-25189-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1369301309-25189-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The functions control_xxx_connected() are just used to report successful
connections and therefore the second parameter can be removed.
---
 profiles/audio/avrcp.c   | 4 ++--
 profiles/audio/control.c | 8 ++++----
 profiles/audio/control.h | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 65ce314..e9d352c 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2761,7 +2761,7 @@ static void session_tg_init_control(struct avrcp *session)
 		avrcp_register_notification(session,
 						AVRCP_EVENT_VOLUME_CHANGED);
 
-	control_remote_connected(session->dev->control, 0);
+	control_remote_connected(session->dev->control);
 }
 
 static void session_ct_init_browsing(struct avrcp *session)
@@ -2787,7 +2787,7 @@ static void session_ct_init_control(struct avrcp *session)
 	if (session->version >= 0x0104)
 		session->supported_events = (1 << AVRCP_EVENT_VOLUME_CHANGED);
 
-	control_target_connected(session->dev->control, 0);
+	control_target_connected(session->dev->control);
 
 	player = create_ct_player(session, 0);
 	if (player == NULL)
diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index 2630850..f17e271 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -68,14 +68,14 @@ struct control {
 	unsigned int avctp_id;
 };
 
-void control_target_connected(struct control *control, int err)
+void control_target_connected(struct control *control)
 {
-	btd_service_connecting_complete(control->target, err);
+	btd_service_connecting_complete(control->target, 0);
 }
 
-void control_remote_connected(struct control *control, int err)
+void control_remote_connected(struct control *control)
 {
-	btd_service_connecting_complete(control->remote, err);
+	btd_service_connecting_complete(control->remote, 0);
 }
 
 void control_disconnected(struct control *control)
diff --git a/profiles/audio/control.h b/profiles/audio/control.h
index a3e44a3..c0c5ac3 100644
--- a/profiles/audio/control.h
+++ b/profiles/audio/control.h
@@ -35,6 +35,6 @@ gboolean control_is_active(struct audio_device *dev);
 int control_connect(struct audio_device *dev);
 int control_disconnect(struct audio_device *dev);
 
-void control_target_connected(struct control *control, int err);
-void control_remote_connected(struct control *control, int err);
+void control_target_connected(struct control *control);
+void control_remote_connected(struct control *control);
 void control_disconnected(struct control *control);
-- 
1.8.1.4

