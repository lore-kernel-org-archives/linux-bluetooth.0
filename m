Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] audio/avdtp: Fix crash on outgoing connection failure
Date: Fri, 25 Mar 2016 16:11:33 +0100
Message-Id: <1458918693-19655-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix double free if outgoing connection failed. This was due to
connection_lost() being called from avdtp_unref which could result
in another call to connection_lost when session ref is already 0.

Fix this in similar way pairing agent is handled: takes extra reference
before calling callbacks and unref it before exit. Then only unref is
suppose to free session.

connect error: Host is down (112)
profiles/audio/avdtp.c:connection_lost() Disconnected from 00:0C:8A:FB:D4:16
profiles/audio/a2dp.c:discover_cb() err 0xfff000240
profiles/audio/avdtp.c:avdtp_unref() 0x85a88f0: ref=1
src/service.c:change_state() 0x7f7c710: device 00:0C:8A:FB:D4:16 profile
    a2dp-sink state changed: connecting -> disconnected (-11)
src/device.c:device_profile_connected() a2dp-sink Resource temporarily
    unavailable (11)
src/device.c:device_profile_connected() returning response to :1.37
profiles/audio/a2dp.c:setup_unref() 0x85b0380: ref=0
profiles/audio/a2dp.c:setup_free() 0x85b0380
profiles/audio/avdtp.c:avdtp_unref() 0x85a88f0: ref=0
profiles/audio/avdtp.c:connection_lost() Disconnected from 00:0C:8A:FB:D4:16
profiles/audio/a2dp.c:discover_cb() err 0xfff000170
profiles/audio/sink.c:sink_set_state() State changed  /org/bluez/hci0/
    dev_00_0C_8A_FB_D4_16: SINK_STATE_CONNECTING -> SINK_STATE_DISCONNECTED
profiles/audio/a2dp.c:channel_remove() chan 0x85a8780
profiles/audio/avdtp.c:avdtp_free() 0x85a88f0
 Invalid free() / delete / delete[] / realloc()
    at 0x4C29CF0: free (vg_replace_malloc.c:530)
    by 0x50CE5ED: g_free (in /usr/lib64/libglib-2.0.so.0.4600.2)
    by 0x4177E3: finalize_discovery (avdtp.c:1039)
    by 0x41789A: connection_lost (avdtp.c:1114)
    by 0x41A7FD: avdtp_connect_cb (avdtp.c:2339)
    by 0x44CBFB: connect_cb (btio.c:232)
    by 0x50C8E39: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.4600.2)
    by 0x50C91CF: ??? (in /usr/lib64/libglib-2.0.so.0.4600.2)
    by 0x50C94F1: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.4600.2)
    by 0x40B7B7: main (main.c:687)
  Address 0x85b4c30 is 0 bytes inside a block of size 24 free'd
    at 0x4C29CF0: free (vg_replace_malloc.c:530)
    by 0x50CE5ED: g_free (in /usr/lib64/libglib-2.0.so.0.4600.2)
    by 0x4177E3: finalize_discovery (avdtp.c:1039)
    by 0x41789A: connection_lost (avdtp.c:1114)
    by 0x413EE2: setup_free (a2dp.c:163)
    by 0x413EE2: setup_unref (a2dp.c:178)
    by 0x413F5F: setup_cb_free (a2dp.c:201)
    by 0x41638D: finalize_discover (a2dp.c:346)
    by 0x41638D: discover_cb (a2dp.c:1855)
    by 0x4177DB: finalize_discovery (avdtp.c:1037)
    by 0x41789A: connection_lost (avdtp.c:1114)
    by 0x41A7FD: avdtp_connect_cb (avdtp.c:2339)
    by 0x44CBFB: connect_cb (btio.c:232)
    by 0x50C8E39: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.4600.2)
  Block was alloc'd at
    at 0x4C2A988: calloc (vg_replace_malloc.c:711)
    by 0x50CE530: g_malloc0 (in /usr/lib64/libglib-2.0.so.0.4600.2)
    by 0x4190FB: avdtp_discover (avdtp.c:3186)
    by 0x416C19: a2dp_discover (a2dp.c:1872)
    by 0x413642: sink_setup_stream (sink.c:265)
    by 0x4136C4: sink_connect (sink.c:294)
    by 0x470165: btd_service_connect (service.c:238)
    by 0x47583C: connect_next.isra.18 (device.c:1455)
    by 0x478500: connect_profiles (device.c:1710)
    by 0x48EC4A: process_message.isra.5 (object.c:259)
    by 0x53DD1A2: ??? (in /usr/lib64/libdbus-1.so.3.14.6)
    by 0x53CE733: dbus_connection_dispatch (in /usr/lib64/libdbus-1.so.3.14.6)
---
 profiles/audio/avdtp.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 4f663d4..4f51b0d 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -1105,6 +1105,8 @@ static void connection_lost(struct avdtp *session, int err)
 {
 	char address[18];
 
+	session = avdtp_ref(session);
+
 	ba2str(device_get_address(session->device), address);
 	DBG("Disconnected from %s", address);
 
@@ -1115,10 +1117,7 @@ static void connection_lost(struct avdtp *session, int err)
 
 	avdtp_set_state(session, AVDTP_SESSION_STATE_DISCONNECTED);
 
-	if (session->ref > 0)
-		return;
-
-	avdtp_free(session);
+	avdtp_unref(session);
 }
 
 static gboolean disconnect_timeout(gpointer user_data)
@@ -1171,12 +1170,18 @@ void avdtp_unref(struct avdtp *session)
 	if (session->ref > 0)
 		return;
 
-	if (session->state == AVDTP_SESSION_STATE_CONNECTED) {
+	switch(session->state) {
+	case AVDTP_SESSION_STATE_CONNECTED:
 		set_disconnect_timer(session);
-		return;
+		break;
+	case AVDTP_SESSION_STATE_CONNECTING:
+		connection_lost(session, ECONNABORTED);
+		break;
+	case AVDTP_SESSION_STATE_DISCONNECTED:
+	default:
+		avdtp_free(session);
+		break;
 	}
-
-	connection_lost(session, ECONNABORTED);
 }
 
 struct avdtp *avdtp_ref(struct avdtp *session)
-- 
2.6.2

