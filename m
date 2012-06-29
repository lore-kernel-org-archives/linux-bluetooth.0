Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] AVDTP: Fix disconnecting when acting as sink
Date: Fri, 29 Jun 2012 14:02:25 +0300
Message-Id: <1340967745-17458-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1340967745-17458-1-git-send-email-luiz.dentz@gmail.com>
References: <1340967745-17458-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Usually after pairing the source will attempt to connect and create a
stream, but it may never send AVDTP_START command as it is not
playing anything. In the meantime the local endpoint may attempt to
acquire the transport, but since it was the remote side that opened the
stream instead of sending AVDTP_START the code now wait and eventually
timeout.

To fix this now instead of just waiting the remote to send AVDTP_START
the code will attempt to send the command if nothing is received after
a small timeout (1s).
---
 audio/avdtp.c |   42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index ffc3f70..e9d0567 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -93,6 +93,7 @@
 #define ABORT_TIMEOUT 2
 #define DISCONNECT_TIMEOUT 1
 #define STREAM_TIMEOUT 20
+#define START_TIMEOUT 1
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 
@@ -376,7 +377,7 @@ struct avdtp_stream {
 	gboolean open_acp;	/* If we are in ACT role for Open */
 	gboolean close_int;	/* If we are in INT role for Close */
 	gboolean abort_int;	/* If we are in INT role for Abort */
-	guint idle_timer;
+	guint start_timer;	/* Wait START command timer */
 	gboolean delay_reporting;
 	uint16_t delay;		/* AVDTP 1.3 Delay Reporting feature */
 	gboolean starting;	/* only valid while sep state == OPEN */
@@ -1054,23 +1055,23 @@ static void avdtp_sep_set_state(struct avdtp *session,
 		stream->starting = FALSE;
 		break;
 	case AVDTP_STATE_STREAMING:
-		if (stream->idle_timer) {
-			g_source_remove(stream->idle_timer);
-			stream->idle_timer = 0;
+		if (stream->start_timer) {
+			g_source_remove(stream->start_timer);
+			stream->start_timer = 0;
 		}
 		stream->open_acp = FALSE;
 		break;
 	case AVDTP_STATE_CLOSING:
 	case AVDTP_STATE_ABORTING:
-		if (stream->idle_timer) {
-			g_source_remove(stream->idle_timer);
-			stream->idle_timer = 0;
+		if (stream->start_timer) {
+			g_source_remove(stream->start_timer);
+			stream->start_timer = 0;
 		}
 		break;
 	case AVDTP_STATE_IDLE:
-		if (stream->idle_timer) {
-			g_source_remove(stream->idle_timer);
-			stream->idle_timer = 0;
+		if (stream->start_timer) {
+			g_source_remove(stream->start_timer);
+			stream->start_timer = 0;
 		}
 		if (session->pending_open == stream)
 			handle_transport_connect(session, NULL, 0, 0);
@@ -3621,6 +3622,19 @@ int avdtp_open(struct avdtp *session, struct avdtp_stream *stream)
 							&req, sizeof(req));
 }
 
+static gboolean start_timeout(gpointer user_data)
+{
+	struct avdtp_stream *stream = user_data;
+	struct avdtp *session = stream->session;
+
+	if (avdtp_start(session, stream) < 0)
+		error("wait_timeout: avdtp_start failed");
+
+	stream->start_timer = 0;
+
+	return FALSE;
+}
+
 int avdtp_start(struct avdtp *session, struct avdtp_stream *stream)
 {
 	struct start_req req;
@@ -3637,7 +3651,13 @@ int avdtp_start(struct avdtp *session, struct avdtp_stream *stream)
 	 *  to start the streaming via GAVDP_START.
 	 */
 	if (stream->open_acp) {
-		stream->starting = TRUE;
+		/* If timer already active wait it */
+		if (stream->start_timer)
+			return 0;
+
+		stream->start_timer = g_timeout_add_seconds(START_TIMEOUT,
+								start_timeout,
+								stream);
 		return 0;
 	}
 
-- 
1.7.10.2

