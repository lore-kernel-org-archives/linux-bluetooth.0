Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 4/6] audio/avdtp: Add stream related debugs
Date: Tue, 24 Feb 2015 14:26:47 +0200
Message-Id: <1424780809-23449-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1424780809-23449-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1424780809-23449-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 profiles/audio/avdtp.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index aaaf3b2..0296700 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -969,7 +969,7 @@ static void avdtp_sep_set_state(struct avdtp *session,
 		err_ptr = &err;
 	} else {
 		err_ptr = NULL;
-		DBG("stream state changed: %s -> %s",
+		DBG("stream %p state changed: %s -> %s", stream,
 				avdtp_statestr(sep->state),
 				avdtp_statestr(state));
 	}
@@ -1025,6 +1025,8 @@ static void avdtp_sep_set_state(struct avdtp *session,
 	if (state == AVDTP_STATE_IDLE &&
 				g_slist_find(session->streams, stream)) {
 		session->streams = g_slist_remove(session->streams, stream);
+
+		DBG("stream %p removed from session %p", stream, session);
 		stream_free(stream);
 	}
 }
@@ -1428,6 +1430,8 @@ static void setconf_cb(struct avdtp *session, struct avdtp_stream *stream,
 	sep->info.inuse = 1;
 	session->streams = g_slist_append(session->streams, stream);
 
+	DBG("stream %p added to session %p", stream, session);
+
 	avdtp_sep_set_state(session, sep, AVDTP_STATE_CONFIGURED);
 }
 
@@ -1530,6 +1534,8 @@ static gboolean avdtp_setconf_cmd(struct avdtp *session, uint8_t transaction,
 		sep->info.inuse = 1;
 		session->streams = g_slist_append(session->streams, stream);
 
+		DBG("stream %p added to session %p", stream, session);
+
 		avdtp_sep_set_state(session, sep, AVDTP_STATE_CONFIGURED);
 	}
 
@@ -3352,7 +3358,7 @@ int avdtp_set_configuration(struct avdtp *session,
 	if (!(lsep && rsep))
 		return -EINVAL;
 
-	DBG("%p: int_seid=%u, acp_seid=%u", session,
+	DBG("session %p: int_seid=%u, acp_seid=%u", session,
 			lsep->info.seid, rsep->seid);
 
 	new_stream = g_new0(struct avdtp_stream, 1);
@@ -3360,6 +3366,8 @@ int avdtp_set_configuration(struct avdtp *session,
 	new_stream->lsep = lsep;
 	new_stream->rseid = rsep->seid;
 
+	DBG("new_stream %p session %p", new_stream, session);
+
 	if (rsep->delay_reporting && lsep->delay_reporting) {
 		struct avdtp_service_capability *delay_reporting;
 
@@ -3399,6 +3407,9 @@ int avdtp_set_configuration(struct avdtp *session,
 		lsep->stream = new_stream;
 		rsep->stream = new_stream;
 		session->streams = g_slist_append(session->streams, new_stream);
+
+		DBG("stream %p added to session %p", new_stream, session);
+
 		if (stream)
 			*stream = new_stream;
 	}
@@ -3445,11 +3456,15 @@ int avdtp_start(struct avdtp *session, struct avdtp_stream *stream)
 	struct start_req req;
 	int ret;
 
-	if (!g_slist_find(session->streams, stream))
+	if (!g_slist_find(session->streams, stream)) {
+		DBG("Cannot find stream %p in session %p", stream, session);
 		return -EINVAL;
+	}
 
-	if (stream->lsep->state != AVDTP_STATE_OPEN)
+	if (stream->lsep->state != AVDTP_STATE_OPEN) {
+		DBG("Wrong stream state %d", stream->lsep->state);
 		return -EINVAL;
+	}
 
 	/* Recommendation 12:
 	 *  If the RD has configured and opened a stream it is also responsible
-- 
2.1.0

