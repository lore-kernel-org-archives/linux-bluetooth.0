Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: deymo@chromium.org, Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v0 1/4] avrcp: Fix missing reply to profile connect
Date: Thu, 23 May 2013 11:28:26 +0200
Message-Id: <1369301309-25189-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1369301309-25189-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1369301309-25189-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The way control.c and avrcp.c interact makes some assumptions that can
be error-prone, specially since AVRCP connection-tracking was split per
role (bfe5f617940081844430871438410f956bbff78d).

During locally-initiated profile connection, control.c requires an AVCTP
session which indirectly initiates an AVRCP session. This AVRCP session
tries to guess the profile role (target vs remote) based on context
information (see avrcp.c:session_create()).

The problem is this "guess" might not always match the role originally
triggering the connection, and therefore the core never receives the
expected replies (state updates).

The proposed solution is to remove the role information in the
avrcp.c->control.c reporting of disconnections. After all, if the AVRCP
session is destroyed, neither of the roles can remain connected.

The issue has been reported by Alex Deymo with the traces below. It can
be observed that session_tg_destroy() gets called but the service state
is not updated, which is presumably due to the fact that the assumed
AVRCP role is wrong.

bluetoothd[22474]: src/device.c:connect_profiles() /org/bluez/hci0/dev_00_0C_8A_XX_XX_XX (all), client :1.642
bluetoothd[22474]: src/service.c:change_state() 0x638e4b0: device 00:0C:8A:XX:XX:XX profile audio-sink state changed: disconnected -> connecting (0)
bluetoothd[22474]: profiles/audio/manager.c:a2dp_sink_connect() path /org/bluez/hci0/dev_00_0C_8A_XX_XX_XX
bluetoothd[22474]: profiles/audio/avdtp.c:avdtp_ref() 0x64b56a0: ref=1
bluetoothd[22474]: profiles/audio/sink.c:sink_set_state() State changed /org/bluez/hci0/dev_00_0C_8A_XX_XX_XX: SINK_STATE_DISCONNECTED -> SINK_STATE_CONNECTING
bluetoothd[22474]: profiles/audio/sink.c:sink_connect() stream creation in progress
bluetoothd[22474]: src/adapter.c:connect_failed_callback() hci0 00:0C:8A:XX:XX:XX status 4
bluetoothd[22474]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 00:0C:8A:XX:XX:XX type 0 status 0x4
bluetoothd[22474]: src/device.c:device_bonding_complete() bonding (nil) status 0x04
bluetoothd[22474]: src/device.c:device_bonding_failed() status 4
bluetoothd[22474]: src/adapter.c:resume_discovery()
bluetoothd[22474]: connect error: Host is down (112)
bluetoothd[22474]: profiles/audio/avdtp.c:connection_lost() Disconnected from 00:0C:8A:XX:XX:XX
bluetoothd[22474]: profiles/audio/avdtp.c:avdtp_unref() 0x64b56a0: ref=0
bluetoothd[22474]: src/service.c:change_state() 0x638e4b0: device 00:0C:8A:XX:XX:XX profile audio-sink state changed: connecting -> disconnected (-5)
bluetoothd[22474]: src/device.c:device_profile_connected() audio-sink Input/output error (5)
bluetoothd[22474]: src/service.c:change_state() 0x639e740: device 00:0C:8A:XX:XX:XX profile audio-avrcp-target state changed: disconnected -> connecting (0)
bluetoothd[22474]: profiles/audio/manager.c:avrcp_target_connect() path /org/bluez/hci0/dev_00_0C_8A_XX_XX_XX
bluetoothd[22474]: profiles/audio/avctp.c:avctp_set_state() AVCTP Connecting
bluetoothd[22474]: profiles/audio/sink.c:sink_set_state() State changed /org/bluez/hci0/dev_00_0C_8A_XX_XX_XX: SINK_STATE_CONNECTING -> SINK_STATE_DISCONNECTED
bluetoothd[22474]: profiles/audio/avrcp.c:session_tg_destroy() 0x64d7ae0
bluetoothd[22474]: profiles/audio/avctp.c:avctp_set_state() AVCTP Disconnected
bluetoothd[22474]: profiles/audio/avdtp.c:avdtp_free() 0x64b56a0
bluetoothd[22474]: src/adapter.c:connect_failed_callback() hci0 00:0C:8A:XX:XX:XX status 2
bluetoothd[22474]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 00:0C:8A:XX:XX:XX type 0 status 0x2
bluetoothd[22474]: src/device.c:device_bonding_complete() bonding (nil) status 0x02
bluetoothd[22474]: src/device.c:device_bonding_failed() status 2
bluetoothd[22474]: src/adapter.c:resume_discovery()
---
 profiles/audio/avrcp.c   | 11 +----------
 profiles/audio/control.c | 23 ++++++++++++++++-------
 profiles/audio/control.h |  3 +--
 3 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 4558407..65ce314 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2826,11 +2826,6 @@ static void session_tg_destroy(struct avrcp *session)
 	if (player != NULL)
 		player->sessions = g_slist_remove(player->sessions, session);
 
-	if (session->control_id == 0)
-		control_remote_connected(session->dev->control, -EIO);
-	else
-		control_remote_disconnected(session->dev->control, 0);
-
 	session_destroy(session);
 }
 
@@ -2840,11 +2835,6 @@ static void session_ct_destroy(struct avrcp *session)
 
 	g_slist_free_full(session->players, player_destroy);
 
-	if (session->control_id == 0)
-		control_target_connected(session->dev->control, -EIO);
-	else
-		control_target_disconnected(session->dev->control, 0);
-
 	session_destroy(session);
 }
 
@@ -2922,6 +2912,7 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 			break;
 
 		session->destroy(session);
+		control_disconnected(dev->control);
 
 		break;
 	case AVCTP_STATE_CONNECTING:
diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index cdba385..2630850 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -73,19 +73,28 @@ void control_target_connected(struct control *control, int err)
 	btd_service_connecting_complete(control->target, err);
 }
 
-void control_target_disconnected(struct control *control, int err)
-{
-	btd_service_disconnecting_complete(control->target, err);
-}
-
 void control_remote_connected(struct control *control, int err)
 {
 	btd_service_connecting_complete(control->remote, err);
 }
 
-void control_remote_disconnected(struct control *control, int err)
+void control_disconnected(struct control *control)
 {
-	btd_service_disconnecting_complete(control->remote, err);
+	if (control->remote != NULL) {
+		if (btd_service_get_state(control->remote) ==
+						BTD_SERVICE_STATE_CONNECTING)
+			btd_service_connecting_complete(control->remote, -EIO);
+		else
+			btd_service_disconnecting_complete(control->remote, 0);
+	}
+
+	if (control->target != NULL) {
+		if (btd_service_get_state(control->target) ==
+						BTD_SERVICE_STATE_CONNECTING)
+			btd_service_connecting_complete(control->target, -EIO);
+		else
+			btd_service_disconnecting_complete(control->target, 0);
+	}
 }
 
 static void state_changed(struct audio_device *dev, avctp_state_t old_state,
diff --git a/profiles/audio/control.h b/profiles/audio/control.h
index 0a0f208..a3e44a3 100644
--- a/profiles/audio/control.h
+++ b/profiles/audio/control.h
@@ -36,6 +36,5 @@ int control_connect(struct audio_device *dev);
 int control_disconnect(struct audio_device *dev);
 
 void control_target_connected(struct control *control, int err);
-void control_target_disconnected(struct control *control, int err);
 void control_remote_connected(struct control *control, int err);
-void control_remote_disconnected(struct control *control, int err);
+void control_disconnected(struct control *control);
-- 
1.8.1.4

