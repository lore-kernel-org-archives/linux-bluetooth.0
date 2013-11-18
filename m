Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/5] audio/AVDTP: Remove public function that are only used locally
Date: Mon, 18 Nov 2013 13:50:12 +0200
Message-Id: <1384775415-10159-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1384775415-10159-1-git-send-email-luiz.dentz@gmail.com>
References: <1384775415-10159-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 profiles/audio/avdtp.c | 30 ++++++++++++------------------
 profiles/audio/avdtp.h |  5 -----
 2 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 25b7525..de31e12 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -3183,8 +3183,8 @@ struct avdtp_service_capability *avdtp_stream_get_codec(
 	return NULL;
 }
 
-gboolean avdtp_stream_has_capability(struct avdtp_stream *stream,
-				struct avdtp_service_capability *cap)
+static gboolean avdtp_stream_has_capability(struct avdtp_stream *stream,
+					struct avdtp_service_capability *cap)
 {
 	GSList *l;
 	struct avdtp_service_capability *stream_cap;
@@ -3219,7 +3219,16 @@ gboolean avdtp_stream_has_capabilities(struct avdtp_stream *stream,
 struct avdtp_remote_sep *avdtp_stream_get_remote_sep(
 						struct avdtp_stream *stream)
 {
-	return avdtp_get_remote_sep(stream->session, stream->rseid);
+	GSList *l;
+
+	for (l = stream->session->seps; l; l = l->next) {
+		struct avdtp_remote_sep *sep = l->data;
+
+		if (sep->seid == stream->rseid)
+			return sep;
+	}
+
+	return NULL;
 }
 
 gboolean avdtp_stream_get_transport(struct avdtp_stream *stream, int *sock,
@@ -3268,21 +3277,6 @@ static int process_queue(struct avdtp *session)
 	return send_req(session, FALSE, req);
 }
 
-struct avdtp_remote_sep *avdtp_get_remote_sep(struct avdtp *session,
-						uint8_t seid)
-{
-	GSList *l;
-
-	for (l = session->seps; l; l = l->next) {
-		struct avdtp_remote_sep *sep = l->data;
-
-		if (sep->seid == seid)
-			return sep;
-	}
-
-	return NULL;
-}
-
 struct avdtp_service_capability *avdtp_get_codec(struct avdtp_remote_sep *sep)
 {
 	return sep->codec;
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index 30ade86..3c30d78 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -221,9 +221,6 @@ struct avdtp *avdtp_ref(struct avdtp *session);
 struct avdtp_service_capability *avdtp_service_cap_new(uint8_t category,
 							void *data, int size);
 
-struct avdtp_remote_sep *avdtp_get_remote_sep(struct avdtp *session,
-						uint8_t seid);
-
 struct avdtp_service_capability *avdtp_get_codec(struct avdtp_remote_sep *sep);
 
 int avdtp_discover(struct avdtp *session, avdtp_discover_cb_t cb,
@@ -243,8 +240,6 @@ gboolean avdtp_stream_get_transport(struct avdtp_stream *stream, int *sock,
 					GSList **caps);
 struct avdtp_service_capability *avdtp_stream_get_codec(
 						struct avdtp_stream *stream);
-gboolean avdtp_stream_has_capability(struct avdtp_stream *stream,
-				struct avdtp_service_capability *cap);
 gboolean avdtp_stream_has_capabilities(struct avdtp_stream *stream,
 					GSList *caps);
 struct avdtp_remote_sep *avdtp_stream_get_remote_sep(
-- 
1.8.3.1

