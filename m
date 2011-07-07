Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Thu, 7 Jul 2011 10:51:34 -0400
Subject: [PATCH] Audio: fix race condition when starting a stream
Message-ID: <1310050294.5639.1.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The AVDTP spec allows for a race condition between remote and local
device when issuing an AVDTP_START cmd on a stream in the OPEN state.

However, the internal state must continue to be consistent. For example,
suppose that avdtp_start() has been called while in the OPEN state and
a AVDTP_START cmd is sent.  Now before we have received a response (and
thus entered the STREAMING state), we *receive* a START cmd. Prior to
this fix, since the sep is still in the OPEN state, we would accept
the new START cmd. This will leads us to send both a Start_Ind and
Start_Cfm - not good.

Now, we track this transitional state (starting == TRUE).

NB - 'starting' is only in a valid state while the sep is in the
OPEN state. 'starting' is reset when we return to the OPEN state.
---
 audio/avdtp.c |   29 +++++++++++++++++++++++++----
 1 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index 44df636..c12f5a3 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -378,6 +378,7 @@ struct avdtp_stream {
 	guint idle_timer;
 	gboolean delay_reporting;
 	uint16_t delay;		/* AVDTP 1.3 Delay Reporting feature */
+	gboolean starting;	/* only valid while sep state == OPEN */
 };
 
 /* Structure describing an AVDTP connection between two devices */
@@ -1068,6 +1069,7 @@ static void avdtp_sep_set_state(struct avdtp *session,
 			avdtp_delay_report(session, stream, stream->delay);
 		break;
 	case AVDTP_STATE_OPEN:
+		stream->starting = FALSE;
 		if (old_state > AVDTP_STATE_OPEN && session->auto_dc)
 			stream->idle_timer = g_timeout_add_seconds(STREAM_TIMEOUT,
 								stream_timeout,
@@ -1712,10 +1714,13 @@ static gboolean avdtp_start_cmd(struct avdtp *session, uint8_t transaction,
 
 		stream = sep->stream;
 
-		if (sep->state != AVDTP_STATE_OPEN) {
+		/* Also reject start cmd if we already initiated start */
+		if (sep->state != AVDTP_STATE_OPEN ||
+				stream->starting == TRUE) {
 			err = AVDTP_BAD_STATE;
 			goto failed;
 		}
+		stream->starting = TRUE;
 
 		if (sep->ind && sep->ind->start) {
 			if (!sep->ind->start(session, sep, stream, &err,
@@ -1730,6 +1735,7 @@ static gboolean avdtp_start_cmd(struct avdtp *session, uint8_t transaction,
 						AVDTP_START, NULL, 0);
 
 failed:
+	DBG("Rejecting (%d)", err);
 	memset(&rej, 0, sizeof(rej));
 	rej.acp_seid = failed_seid;
 	rej.error = err;
@@ -2584,9 +2590,12 @@ static int cancel_request(struct avdtp *session, int err)
 		break;
 	case AVDTP_START:
 		error("Start: %s (%d)", strerror(err), err);
-		if (lsep && lsep->cfm && lsep->cfm->start)
+		if (lsep && lsep->cfm && lsep->cfm->start) {
 			lsep->cfm->start(session, lsep, stream, &averr,
 						lsep->user_data);
+			if (stream)
+				stream->starting = FALSE;
+		}
 		break;
 	case AVDTP_SUSPEND:
 		error("Suspend: %s (%d)", strerror(err), err);
@@ -3092,9 +3101,11 @@ static gboolean avdtp_parse_rej(struct avdtp *session,
 			return FALSE;
 		error("START request rejected: %s (%d)",
 				avdtp_strerror(&err), err.err.error_code);
-		if (sep && sep->cfm && sep->cfm->start)
+		if (sep && sep->cfm && sep->cfm->start) {
 			sep->cfm->start(session, sep, stream, &err,
 					sep->user_data);
+			stream->starting = FALSE;
+		}
 		return TRUE;
 	case AVDTP_SUSPEND:
 		if (!stream_rej_to_err(buf, size, &err, &acp_seid))
@@ -3552,6 +3563,7 @@ int avdtp_open(struct avdtp *session, struct avdtp_stream *stream)
 int avdtp_start(struct avdtp *session, struct avdtp_stream *stream)
 {
 	struct start_req req;
+	int ret;
 
 	if (!g_slist_find(session->streams, stream))
 		return -EINVAL;
@@ -3564,11 +3576,20 @@ int avdtp_start(struct avdtp *session, struct avdtp_stream *stream)
 		return -EINVAL;
 	}
 
+	if (stream->starting == TRUE) {
+		DBG("stream already started");
+		return -EINVAL;
+	}
+
 	memset(&req, 0, sizeof(req));
 	req.first_seid.seid = stream->rseid;
 
-	return send_request(session, FALSE, stream, AVDTP_START,
+	ret = send_request(session, FALSE, stream, AVDTP_START,
 							&req, sizeof(req));
+	if (ret == 0)
+		stream->starting = TRUE;
+
+	return ret;
 }
 
 int avdtp_close(struct avdtp *session, struct avdtp_stream *stream,
-- 
1.7.4.1

