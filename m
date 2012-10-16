Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] avdtp: Fix crash on connection lost
Date: Tue, 16 Oct 2012 14:37:16 +0200
Message-ID: <1350391036-29997-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix avdtp session reference counting. avdtp_unref has a special
case when ref==1 and due to nested calls session could be free in
consecutive call resulting in accesing already freed memory.

Instead of having extra free lock keep extra local reference. This also
make avdtp_unref easier to undertand as there is no double ref
decrement inside one unref call.

avdtp_unref will set session state to disconnected when reference count
drops to 1 so there is no need to explicite set it in connection_lost.

bluetoothd[29474]: audio/avdtp.c:avdtp_ref() 0x555555856aa0: ref=2
bluetoothd[29474]: audio/source.c:source_connect() stream creation in progress
bluetoothd[29474]: src/mgmt.c:mgmt_event() cond 1
bluetoothd[29474]: src/mgmt.c:mgmt_event() Received 31 bytes from management socket
bluetoothd[29474]: src/mgmt.c:mgmt_device_connected() hci0 device 84:00:D2:DB:F7:8C connected eir_len 12
bluetoothd[29474]: src/adapter.c:adapter_get_device() 84:00:D2:DB:F7:8C
bluetoothd[29474]: src/mgmt.c:mgmt_event() cond 1
bluetoothd[29474]: src/mgmt.c:mgmt_event() Received 14 bytes from management socket
bluetoothd[29474]: src/mgmt.c:mgmt_auth_failed() hci0 auth failed status 6
bluetoothd[29474]: src/device.c:device_bonding_complete() bonding (nil) status 0x06
bluetoothd[29474]: connect error: Invalid exchange (52)
bluetoothd[29474]: audio/avdtp.c:connection_lost() Disconnected from 84:00:D2:DB:F7:8C
bluetoothd[29474]: audio/avdtp.c:avdtp_unref() 0x555555856aa0: ref=1
bluetoothd[29474]: audio/avdtp.c:avdtp_unref() 0x555555856aa0: ref=0
bluetoothd[29474]: audio/avdtp.c:avdtp_unref() 0x555555856aa0: freeing session and removing from list
bluetoothd[29474]: audio/avdtp.c:avdtp_unref() 0x555555856aa0: freeing session and removing from list

Program received signal SIGSEGV, Segmentation fault.
avdtp_unref (session=0x555555856aa0) at audio/avdtp.c:1239
1239            server->sessions = g_slist_remove(server->sessions, session);

---
 audio/avdtp.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index bd91cb6..4109be9 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -388,7 +388,6 @@ struct avdtp_stream {
 
 struct avdtp {
 	int ref;
-	int free_lock;
 
 	uint16_t version;
 
@@ -1158,14 +1157,14 @@ static void connection_lost(struct avdtp *session, int err)
 	if (err != EACCES)
 		avdtp_cancel_authorization(session);
 
-	session->free_lock = 1;
+	avdtp_ref(session);
 
 	finalize_discovery(session, err);
 
 	g_slist_foreach(session->streams, (GFunc) release_stream, session);
 	session->streams = NULL;
 
-	session->free_lock = 0;
+	avdtp_unref(session);
 
 	if (session->io) {
 		g_io_channel_shutdown(session->io, FALSE, NULL);
@@ -1173,8 +1172,6 @@ static void connection_lost(struct avdtp *session, int err)
 		session->io = NULL;
 	}
 
-	avdtp_set_state(session, AVDTP_SESSION_STATE_DISCONNECTED);
-
 	if (session->io_id) {
 		g_source_remove(session->io_id);
 		session->io_id = 0;
@@ -1221,9 +1218,6 @@ void avdtp_unref(struct avdtp *session)
 
 		if (session->io)
 			set_disconnect_timer(session);
-		else if (!session->free_lock) /* Drop the local ref if we
-						 aren't connected */
-			session->ref--;
 	}
 
 	if (session->ref > 0)
-- 
1.7.9.5

