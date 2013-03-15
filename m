Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] audio: Track connections to AVRCP roles separately
Date: Fri, 15 Mar 2013 13:46:30 -0300
Message-Id: <1363365990-1901-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Currently the code assumes when one role connects the other must be
connected as well which is bogus and can create problems.
---
 profiles/audio/avrcp.c   | 14 ++++++++++++++
 profiles/audio/control.c |  9 ---------
 profiles/audio/manager.c | 14 +++++++++++---
 profiles/audio/manager.h |  6 ++++--
 4 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 409cf5b..94616c0 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2667,6 +2667,8 @@ static void session_tg_init_control(struct avrcp *session)
 	if (session->version >= 0x0104)
 		avrcp_register_notification(session,
 						AVRCP_EVENT_VOLUME_CHANGED);
+
+	audio_remote_connected(session->dev->btd_dev, 0);
 }
 
 static void session_ct_init_browsing(struct avrcp *session)
@@ -2692,6 +2694,8 @@ static void session_ct_init_control(struct avrcp *session)
 	if (session->version >= 0x0104)
 		session->supported_events = (1 << AVRCP_EVENT_VOLUME_CHANGED);
 
+	audio_target_connected(session->dev->btd_dev, 0);
+
 	player = create_ct_player(session, 0);
 	if (player == NULL)
 		return;
@@ -2726,6 +2730,11 @@ static void session_tg_destroy(struct avrcp *session)
 	if (player != NULL)
 		player->sessions = g_slist_remove(player->sessions, session);
 
+	if (session->control_id == 0)
+		audio_remote_connected(session->dev->btd_dev, -EIO);
+
+	audio_remote_disconnected(session->dev->btd_dev, 0);
+
 	session_destroy(session);
 }
 
@@ -2735,6 +2744,11 @@ static void session_ct_destroy(struct avrcp *session)
 
 	g_slist_free_full(session->players, player_destroy);
 
+	if (session->control_id == 0)
+		audio_target_connected(session->dev->btd_dev, -EIO);
+
+	audio_target_disconnected(session->dev->btd_dev, 0);
+
 	session_destroy(session);
 }
 
diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index 7e4ed42..6086bde 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -76,13 +76,6 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 	case AVCTP_STATE_DISCONNECTED:
 		control->session = NULL;
 
-		if (old_state != AVCTP_STATE_CONNECTED) {
-			audio_control_connected(dev->btd_dev, -EIO);
-			break;
-		}
-
-		audio_control_disconnected(dev->btd_dev, 0);
-
 		g_dbus_emit_property_changed(conn, path,
 					AUDIO_CONTROL_INTERFACE, "Connected");
 
@@ -95,8 +88,6 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 
 		break;
 	case AVCTP_STATE_CONNECTED:
-		audio_control_connected(dev->btd_dev, 0);
-
 		g_dbus_emit_property_changed(conn, path,
 					AUDIO_CONTROL_INTERFACE, "Connected");
 		break;
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 64665d7..b8b51d3 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -419,15 +419,23 @@ void audio_source_disconnected(struct btd_device *dev, int err)
 	device_profile_disconnected(dev, &a2dp_source_profile, err);
 }
 
-void audio_control_connected(struct btd_device *dev, int err)
+void audio_target_connected(struct btd_device *dev, int err)
 {
 	device_profile_connected(dev, &avrcp_target_profile, err);
-	device_profile_connected(dev, &avrcp_remote_profile, err);
 }
 
-void audio_control_disconnected(struct btd_device *dev, int err)
+void audio_target_disconnected(struct btd_device *dev, int err)
 {
 	device_profile_disconnected(dev, &avrcp_target_profile, err);
+}
+
+void audio_remote_connected(struct btd_device *dev, int err)
+{
+	device_profile_connected(dev, &avrcp_remote_profile, err);
+}
+
+void audio_remote_disconnected(struct btd_device *dev, int err)
+{
 	device_profile_disconnected(dev, &avrcp_remote_profile, err);
 }
 
diff --git a/profiles/audio/manager.h b/profiles/audio/manager.h
index 9e5ac94..a42b7da 100644
--- a/profiles/audio/manager.h
+++ b/profiles/audio/manager.h
@@ -33,8 +33,10 @@ void audio_sink_connected(struct btd_device *dev, int err);
 void audio_sink_disconnected(struct btd_device *dev, int err);
 void audio_source_connected(struct btd_device *dev, int err);
 void audio_source_disconnected(struct btd_device *dev, int err);
-void audio_control_connected(struct btd_device *dev, int err);
-void audio_control_disconnected(struct btd_device *dev, int err);
+void audio_target_connected(struct btd_device *dev, int err);
+void audio_target_disconnected(struct btd_device *dev, int err);
+void audio_remote_connected(struct btd_device *dev, int err);
+void audio_remote_disconnected(struct btd_device *dev, int err);
 
 int audio_manager_init(GKeyFile *config);
 void audio_manager_exit(void);
-- 
1.8.1.4

