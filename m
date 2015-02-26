Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] audio/avdtp: Fix style issues
Date: Thu, 26 Feb 2015 17:20:22 +0200
Message-Id: <1424964022-8887-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1424964022-8887-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1424964022-8887-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Makes code in profiles/ and android/ identical in style.
---
 profiles/audio/avdtp.c | 38 ++++++++++++++++++++++++--------------
 profiles/audio/avdtp.h |  3 ++-
 2 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 1cad010..a8444ed 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -1502,11 +1502,15 @@ static gboolean avdtp_setconf_cmd(struct avdtp *session, uint8_t transaction,
 					&stream->codec,
 					&stream->delay_reporting);
 
-	/* Verify that the Media Transport capability's length = 0. Reject otherwise */
+	/*
+	 * Verify that the Media Transport capability's length = 0.
+	 * Reject otherwise
+	 */
 	for (l = stream->caps; l != NULL; l = g_slist_next(l)) {
 		struct avdtp_service_capability *cap = l->data;
 
-		if (cap->category == AVDTP_MEDIA_TRANSPORT && cap->length != 0) {
+		if (cap->category == AVDTP_MEDIA_TRANSPORT &&
+							cap->length != 0) {
 			err = AVDTP_BAD_MEDIA_TRANSPORT_FORMAT;
 			goto failed_stream;
 		}
@@ -1578,7 +1582,7 @@ static gboolean avdtp_getconf_cmd(struct avdtp *session, uint8_t transaction,
 		goto failed;
 	}
 
-	for (l = sep->stream->caps, rsp_size = 0; l != NULL; l = g_slist_next(l)) {
+	for (l = sep->stream->caps, rsp_size = 0; l; l = g_slist_next(l)) {
 		struct avdtp_service_capability *cap = l->data;
 
 		if (rsp_size + cap->length + 2 > (int) sizeof(buf))
@@ -2042,7 +2046,8 @@ static enum avdtp_parse_result avdtp_parse_data(struct avdtp *session,
 	switch (header->packet_type) {
 	case AVDTP_PKT_TYPE_SINGLE:
 		if (size < sizeof(*single)) {
-			error("Received too small single packet (%zu bytes)", size);
+			error("Received too small single packet (%zu bytes)",
+									size);
 			return PARSE_ERROR;
 		}
 		if (session->in.active) {
@@ -2063,7 +2068,8 @@ static enum avdtp_parse_result avdtp_parse_data(struct avdtp *session,
 		break;
 	case AVDTP_PKT_TYPE_START:
 		if (size < sizeof(*start)) {
-			error("Received too small start packet (%zu bytes)", size);
+			error("Received too small start packet (%zu bytes)",
+									size);
 			return PARSE_ERROR;
 		}
 		if (session->in.active) {
@@ -2107,7 +2113,8 @@ static enum avdtp_parse_result avdtp_parse_data(struct avdtp *session,
 		break;
 	case AVDTP_PKT_TYPE_END:
 		if (size < sizeof(struct avdtp_continue_header)) {
-			error("Received too small end packet (%zu bytes)", size);
+			error("Received too small end packet (%zu bytes)",
+									size);
 			return PARSE_ERROR;
 		}
 		if (!session->in.active) {
@@ -2622,7 +2629,7 @@ static int cancel_request(struct avdtp *session, int err)
 		error("SetConfiguration: %s (%d)", strerror(err), err);
 		if (lsep && lsep->cfm && lsep->cfm->set_configuration)
 			lsep->cfm->set_configuration(session, lsep, stream,
-							&averr, lsep->user_data);
+						&averr, lsep->user_data);
 		goto failed;
 	case AVDTP_DISCOVER:
 		error("Discover: %s (%d)", strerror(err), err);
@@ -2821,9 +2828,9 @@ static gboolean avdtp_get_capabilities_resp(struct avdtp *session,
 }
 
 static gboolean avdtp_set_configuration_resp(struct avdtp *session,
-						struct avdtp_stream *stream,
-						struct avdtp_single_header *resp,
-						int size)
+					struct avdtp_stream *stream,
+					struct avdtp_single_header *resp,
+					int size)
 {
 	struct avdtp_local_sep *sep = stream->lsep;
 
@@ -2838,7 +2845,8 @@ static gboolean avdtp_set_configuration_resp(struct avdtp *session,
 
 static gboolean avdtp_reconfigure_resp(struct avdtp *session,
 					struct avdtp_stream *stream,
-					struct avdtp_single_header *resp, int size)
+					struct avdtp_single_header *resp,
+					int size)
 {
 	return TRUE;
 }
@@ -2924,7 +2932,8 @@ static gboolean avdtp_delay_report_resp(struct avdtp *session,
 	struct avdtp_local_sep *sep = stream->lsep;
 
 	if (sep->cfm && sep->cfm->delay_report)
-		sep->cfm->delay_report(session, sep, stream, NULL, sep->user_data);
+		sep->cfm->delay_report(session, sep, stream, NULL,
+							sep->user_data);
 
 	return TRUE;
 }
@@ -3280,7 +3289,8 @@ struct avdtp_service_capability *avdtp_get_codec(struct avdtp_remote_sep *sep)
 }
 
 struct avdtp_service_capability *avdtp_service_cap_new(uint8_t category,
-							void *data, int length)
+							const void *data,
+							int length)
 {
 	struct avdtp_service_capability *cap;
 
@@ -3752,7 +3762,7 @@ const char *avdtp_strerror(struct avdtp_error *err)
 	if (err->category == AVDTP_ERRNO)
 		return strerror(err->err.posix_errno);
 
-	switch(err->err.error_code) {
+	switch (err->err.error_code) {
 	case AVDTP_BAD_HEADER_FORMAT:
 		return "Bad Header Format";
 	case AVDTP_BAD_LENGTH:
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index a68dc4d..88e8cb4 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -218,7 +218,8 @@ void avdtp_unref(struct avdtp *session);
 struct avdtp *avdtp_ref(struct avdtp *session);
 
 struct avdtp_service_capability *avdtp_service_cap_new(uint8_t category,
-							void *data, int size);
+							const void *data,
+							int size);
 
 struct avdtp_service_capability *avdtp_get_codec(struct avdtp_remote_sep *sep);
 
-- 
2.1.0

