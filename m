Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 15/20] audio/avdtp: Add error checks and style fixes
Date: Fri, 27 Feb 2015 17:03:03 +0200
Message-Id: <1425049388-18333-16-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1425049388-18333-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1425049388-18333-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

The patch adds error checks and fixes several style issues fixed in
android code base.
---
 profiles/audio/avdtp.c | 48 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index c396e8f..aa1fec5 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -1134,6 +1134,9 @@ void avdtp_free(void *data)
 	g_slist_free_full(session->seps, sep_free);
 	g_slist_free_full(session->disconnect, g_free);
 
+	/* Free copy of the SEP list */
+	session->lseps = NULL;
+
 	g_free(session->buf);
 
 	btd_device_unref(session->device);
@@ -1228,6 +1231,7 @@ void avdtp_unref(struct avdtp *session)
 struct avdtp *avdtp_ref(struct avdtp *session)
 {
 	session->ref++;
+
 	DBG("%p: ref=%d", session, session->ref);
 	if (session->dc_timer)
 		remove_disconnect_timer(session);
@@ -2166,8 +2170,11 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 
 	DBG("");
 
-	if (cond & G_IO_NVAL)
+	if (cond & G_IO_NVAL) {
+		session->io_id = 0;
+
 		return FALSE;
+	}
 
 	header = (void *) session->buf;
 
@@ -2268,6 +2275,7 @@ next:
 	return TRUE;
 
 failed:
+	session->io_id = 0;
 	connection_lost(session, EIO);
 
 	return FALSE;
@@ -2747,6 +2755,11 @@ static int send_request(struct avdtp *session, gboolean priority,
 {
 	struct pending_req *req;
 
+	if (size > 0 && !buffer) {
+		DBG("Invalid buffer %p", buffer);
+		return -EINVAL;
+	}
+
 	if (stream && stream->abort_int && signal_id != AVDTP_ABORT) {
 		DBG("Unable to send requests while aborting");
 		return -EINVAL;
@@ -2754,11 +2767,14 @@ static int send_request(struct avdtp *session, gboolean priority,
 
 	req = g_new0(struct pending_req, 1);
 	req->signal_id = signal_id;
-	req->data = g_malloc(size);
-	memcpy(req->data, buffer, size);
 	req->data_size = size;
 	req->stream = stream;
 
+	if (size > 0) {
+		req->data = g_malloc(size);
+		memcpy(req->data, buffer, size);
+	}
+
 	return send_req(session, priority, req);
 }
 
@@ -2900,14 +2916,14 @@ static gboolean avdtp_start_resp(struct avdtp *session,
 {
 	struct avdtp_local_sep *sep = stream->lsep;
 
-	if (sep->cfm && sep->cfm->start)
-		sep->cfm->start(session, sep, stream, NULL, sep->user_data);
-
 	/* We might be in STREAMING already if both sides send START_CMD at the
 	 * same time and the one in SNK role doesn't reject it as it should */
 	if (sep->state != AVDTP_STATE_STREAMING)
 		avdtp_sep_set_state(session, sep, AVDTP_STATE_STREAMING);
 
+	if (sep->cfm && sep->cfm->start)
+		sep->cfm->start(session, sep, stream, NULL, sep->user_data);
+
 	return TRUE;
 }
 
@@ -3323,13 +3339,19 @@ struct avdtp_service_capability *avdtp_service_cap_new(uint8_t category,
 {
 	struct avdtp_service_capability *cap;
 
-	if (category < AVDTP_MEDIA_TRANSPORT || category > AVDTP_DELAY_REPORTING)
+	if (category < AVDTP_MEDIA_TRANSPORT ||
+					category > AVDTP_DELAY_REPORTING)
+		return NULL;
+
+	if (length > 0 && !data)
 		return NULL;
 
 	cap = g_malloc(sizeof(struct avdtp_service_capability) + length);
 	cap->category = category;
 	cap->length = length;
-	memcpy(cap->data, data, length);
+
+	if (length > 0)
+		memcpy(cap->data, data, length);
 
 	return cap;
 }
@@ -3613,14 +3635,15 @@ int avdtp_close(struct avdtp *session, struct avdtp_stream *stream,
 	if (!g_slist_find(session->streams, stream))
 		return -EINVAL;
 
-	if (stream->lsep->state < AVDTP_STATE_OPEN)
-		return -EINVAL;
-
 	if (stream->close_int == TRUE) {
 		error("avdtp_close: rejecting since close is already initiated");
 		return -EINVAL;
 	}
 
+	/* If stream is not yet in the OPEN state, let's use ABORT_CMD */
+	if (stream->lsep->state < AVDTP_STATE_OPEN)
+		return avdtp_abort(session, stream);
+
 	if (immediate && session->req && stream == session->req->stream)
 		return avdtp_abort(session, stream);
 
@@ -3663,7 +3686,8 @@ int avdtp_abort(struct avdtp *session, struct avdtp_stream *stream)
 	if (stream->lsep->state == AVDTP_STATE_ABORTING)
 		return -EINVAL;
 
-	if (session->req && stream == session->req->stream)
+	if (session->req && session->req->timeout > 0 &&
+						stream == session->req->stream)
 		return cancel_request(session, ECANCELED);
 
 	memset(&req, 0, sizeof(req));
-- 
2.1.0

