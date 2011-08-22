Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/7] Wait remote side to send AVDTP_START when acting as acceptor
Date: Mon, 22 Aug 2011 16:25:50 +0300
Message-Id: <1314019551-3471-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1314019551-3471-1-git-send-email-luiz.dentz@gmail.com>
References: <1314019551-3471-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Some devices like Sony Ericsson MW600 reject AVDTP_START if it was the
initiator of the connection, apparently it follows recommendation 12 of
simultaneous use of HFP, A2DP and AVRCP profiles white paper which says:

  "If the RD has configured and opened a stream it is also responsible to
  start the streaming via GAVDP_START."

If the client is fast enough and try to acquire the transport this cause
an error, so instead of sending AVDTP_START the code now checks if it is
the acceptor of the stream and wait the remote side to send the command.
---
 audio/avdtp.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index 5706fe2..93b7880 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -1068,12 +1068,19 @@ static void avdtp_sep_set_state(struct avdtp *session,
 		break;
 	case AVDTP_STATE_OPEN:
 		stream->starting = FALSE;
-		if (old_state > AVDTP_STATE_OPEN && session->auto_dc)
+		if ((old_state > AVDTP_STATE_OPEN && session->auto_dc) ||
+							stream->open_acp)
 			stream->idle_timer = g_timeout_add_seconds(STREAM_TIMEOUT,
 								stream_timeout,
 								stream);
 		break;
 	case AVDTP_STATE_STREAMING:
+		if (stream->idle_timer) {
+			g_source_remove(stream->idle_timer);
+			stream->idle_timer = 0;
+		}
+		stream->open_acp = FALSE;
+		break;
 	case AVDTP_STATE_CLOSING:
 	case AVDTP_STATE_ABORTING:
 		if (stream->idle_timer) {
@@ -3626,6 +3633,15 @@ int avdtp_start(struct avdtp *session, struct avdtp_stream *stream)
 	if (stream->lsep->state != AVDTP_STATE_OPEN)
 		return -EINVAL;
 
+	/* Recommendation 12:
+	 *  If the RD has configured and opened a stream it is also responsible
+	 *  to start the streaming via GAVDP_START.
+	 */
+	if (stream->open_acp) {
+		stream->starting = TRUE;
+		return 0;
+	}
+
 	if (stream->close_int == TRUE) {
 		error("avdtp_start: rejecting start since close is initiated");
 		return -EINVAL;
-- 
1.7.6

