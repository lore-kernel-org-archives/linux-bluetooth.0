Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, Alex Deymo <deymo@chromium.org>
Subject: [PATCH] audio: Don't create an avctp session on avrcp disconnect
Date: Thu,  2 May 2013 15:04:25 -0700
Message-Id: <1367532265-26766-1-git-send-email-deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If a paired and connected audio device is disconnected, the
avrcp_disconnect() could create a new avctp session that will keep
a reference to the corresponding btd_device, preventing it to be
removed as explained below. This fix prevents avrcp_disconnect()
to create a new and disconnected avctp session when it doesn't
exists.

Calling org.bluez.Device1.Disconnect on an audio device like the
"Monster ClarityHD" will cause first a a2dp_sink_disconnect() call,
and then a sink_disconnect() call.
This will change the state of the existing avdtp session to
AVCTP_STATE_DISCONNECTED triggering a series of callback calls.
Among those, the avdtp_set_state() function will call the registered
avdtp_callbacks, including avdtp_state_callback() which in turns
updates the disconnected state using sink_set_state(). This function
will call the registered sink_callbacks, including device_sink_cb().

By this point, the device_sink_cb() will attempt a avrcp_disconnect()
over a session that was already disconnected before by the device's
diconnect_cb(). This new avrcp_disconnect() causes the avctp_get() to
create a new avctp session that holds a reference to the disconnecting
btd_device.

Steps to reproduce using bluetoothctl:
1. Pair and Connect a Monter ClarityHD audio device.
2. Play some music on it.
3. Disconnect the device.
4. Remove the device.
The "remove" command succeeds, but bluetoothd does not sends a removal
signal ([DEL] message) for that device.
---
 profiles/audio/avctp.c   | 13 ++++++++-----
 profiles/audio/avctp.h   |  2 +-
 profiles/audio/avrcp.c   |  2 +-
 profiles/audio/control.c |  2 +-
 4 files changed, 11 insertions(+), 8 deletions(-)

Some extra debug output after calling disconnect (step 3):

bluetoothd[3590]: profiles/audio/manager.c:a2dp_sink_disconnect() path /org/bluez/hci0/dev_10_B7_F6_01_31_ED
bluetoothd[3590]: profiles/audio/sink.c:sink_disconnect() shutdown=0
bluetoothd[3590]: profiles/audio/sink.c:sink_disconnect() will call avdtp_close
bluetoothd[3590]: profiles/audio/device.c:disconnect_cb() will call avrcp_disconnect
bluetoothd[3590]: profiles/audio/avrcp.c:avrcp_disconnect() will call avctp_get
bluetoothd[3590]: profiles/audio/avctp.c:avctp_get() will call avctp_get_internal
bluetoothd[3590]: profiles/audio/avrcp.c:state_changed() old_state=AVCTP_STATE_CONNECTED new_state=AVCTP_STATE_DISCONNECTED
bluetoothd[3590]: profiles/audio/avrcp.c:session_tg_destroy() 0x7f6487282840
bluetoothd[3590]: src/device.c:device_profile_connected() audio-avrcp-control Input/output error (5)
bluetoothd[3590]: profiles/audio/control.c:state_changed() old_state=AVCTP_STATE_CONNECTED  new_state=AVCTP_STATE_DISCONNECTED
bluetoothd[3590]: profiles/audio/avctp.c:avctp_set_state() AVCTP Disconnected
bluetoothd[3590]: profiles/audio/avctp.c:avctp_disconnected() will call btd_device_unref
bluetoothd[3590]: src/device.c:btd_device_unref() device=10:B7:F6:01:31:ED ref=3
bluetoothd[3590]: profiles/audio/sink.c:sink_disconnect() shutdown=1
bluetoothd[3590]: profiles/audio/sink.c:sink_disconnect() will call avdtp_close
bluetoothd[3590]: avdtp_close: rejecting since close is already initiated
bluetoothd[3590]: profiles/audio/avdtp.c:session_cb() 
bluetoothd[3590]: profiles/audio/avdtp.c:avdtp_parse_resp() CLOSE request succeeded
bluetoothd[3590]: profiles/audio/avdtp.c:avdtp_sep_set_state() stream state changed: OPEN -> CLOSING
bluetoothd[3590]: profiles/audio/a2dp.c:close_cfm() Source 0x7f6487279600: Close_Cfm
bluetoothd[3590]: profiles/audio/avdtp.c:avdtp_sep_set_state() stream state changed: CLOSING -> IDLE
bluetoothd[3590]: profiles/audio/avdtp.c:avdtp_unref() 0x7f648727d480: ref=1
bluetoothd[3590]: profiles/audio/avdtp.c:avdtp_unref() 0x7f648727d480: ref=0
bluetoothd[3590]: profiles/audio/avdtp.c:connection_lost() Disconnected from 10:B7:F6:01:31:ED
bluetoothd[3590]: profiles/audio/avdtp.c:connection_lost() will call avdtp_set_state(0x7f648727d480, AVDTP_SESSION_STATE_DISCONNECTED)
bluetoothd[3590]: profiles/audio/avdtp.c:avdtp_set_state() Calling callback cb=0x7f6486003810, dev=0x7f648727fa60, session=0x7f648727d480
bluetoothd[3590]: profiles/audio/avdtp.c:avdtp_set_state() Calling callback cb=0x7f64860049d0, dev=0x7f648727fa60, session=0x7f648727d480
bluetoothd[3590]: profiles/audio/sink.c:sink_set_state() State changed /org/bluez/hci0/dev_10_B7_F6_01_31_ED: SINK_STATE_CONNECTED -> SINK_STATE_DISCONNECTED
bluetoothd[3590]: profiles/audio/device.c:device_sink_cb() will call avrcp_disconnect
bluetoothd[3590]: profiles/audio/avrcp.c:avrcp_disconnect() will call avctp_get
bluetoothd[3590]: profiles/audio/avctp.c:avctp_get() will call avctp_get_internal
bluetoothd[3590]: profiles/audio/avctp.c:avctp_get_internal() will call btd_device_ref , session=0x7f648727f700
bluetoothd[3590]: src/device.c:btd_device_ref() device=10:B7:F6:01:31:ED ref=4
bluetoothd[3590]: profiles/audio/avdtp.c:connection_lost() will call btd_device_unref
bluetoothd[3590]: src/device.c:btd_device_unref() device=10:B7:F6:01:31:ED ref=3
bluetoothd[3590]: profiles/audio/avdtp.c:avdtp_free() 0x7f648727d480
bluetoothd[3590]: src/adapter.c:dev_disconnected() Device 10:B7:F6:01:31:ED disconnected, reason 2
bluetoothd[3590]: src/adapter.c:adapter_remove_connection() 
bluetoothd[3590]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 10:B7:F6:01:31:ED type 0 status 0xe
bluetoothd[3590]: src/device.c:device_bonding_complete() bonding (nil) status 0x0e
bluetoothd[3590]: src/device.c:device_bonding_failed() status 14
bluetoothd[3590]: src/adapter.c:resume_discovery() 



diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 21aeb6f..c521e22 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -1205,7 +1205,7 @@ static struct avctp *find_session(GSList *list, struct btd_device *device)
 	return NULL;
 }
 
-static struct avctp *avctp_get_internal(struct btd_device *device)
+static struct avctp *avctp_get_internal(struct btd_device *device, bool create)
 {
 	struct avctp_server *server;
 	struct avctp *session;
@@ -1218,6 +1218,9 @@ static struct avctp *avctp_get_internal(struct btd_device *device)
 	if (session)
 		return session;
 
+	if (!create)
+		return NULL;
+
 	session = g_new0(struct avctp, 1);
 
 	session->server = server;
@@ -1312,7 +1315,7 @@ static void avctp_confirm_cb(GIOChannel *chan, gpointer data)
 	if (!device)
 		return;
 
-	session = avctp_get_internal(device);
+	session = avctp_get_internal(device, TRUE);
 	if (session == NULL)
 		return;
 
@@ -1819,7 +1822,7 @@ struct avctp *avctp_connect(struct audio_device *device)
 	GError *err = NULL;
 	GIOChannel *io;
 
-	session = avctp_get_internal(device->btd_dev);
+	session = avctp_get_internal(device->btd_dev, TRUE);
 	if (!session)
 		return NULL;
 
@@ -1892,7 +1895,7 @@ void avctp_disconnect(struct avctp *session)
 	avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
 }
 
-struct avctp *avctp_get(struct audio_device *device)
+struct avctp *avctp_get(struct audio_device *device, bool create)
 {
-	return avctp_get_internal(device->btd_dev);
+	return avctp_get_internal(device->btd_dev, create);
 }
diff --git a/profiles/audio/avctp.h b/profiles/audio/avctp.h
index 648e982..14b0a21 100644
--- a/profiles/audio/avctp.h
+++ b/profiles/audio/avctp.h
@@ -116,7 +116,7 @@ int avctp_register(struct btd_adapter *adapter, gboolean master);
 void avctp_unregister(struct btd_adapter *adapter);
 
 struct avctp *avctp_connect(struct audio_device *device);
-struct avctp *avctp_get(struct audio_device *device);
+struct avctp *avctp_get(struct audio_device *device, bool create);
 int avctp_connect_browsing(struct avctp *session);
 void avctp_disconnect(struct avctp *session);
 
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index b7de051..b5f98d9 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2867,7 +2867,7 @@ void avrcp_disconnect(struct audio_device *dev)
 {
 	struct avctp *session;
 
-	session = avctp_get(dev);
+	session = avctp_get(dev, FALSE);
 	if (!session)
 		return;
 
diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index cdba385..b3789ed 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -107,7 +107,7 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 		if (control->session)
 			break;
 
-		control->session = avctp_get(dev);
+		control->session = avctp_get(dev, TRUE);
 
 		break;
 	case AVCTP_STATE_CONNECTED:
-- 
1.8.2.1

