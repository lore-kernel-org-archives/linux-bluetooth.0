Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] audio: Remove unused function
Date: Thu, 04 Oct 2012 22:14:06 +0900
Message-id: <1349356447-8369-3-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1349356447-8369-1-git-send-email-chanyeol.park@samsung.com>
References: <1349356447-8369-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

---
 audio/avdtp.c |   39 ---------------------------------------
 audio/avdtp.h |    2 --
 2 files changed, 41 deletions(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index 7db3c02..54b3d08 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -3581,45 +3581,6 @@ int avdtp_set_configuration(struct avdtp *session,
 	return err;
 }
 
-int avdtp_reconfigure(struct avdtp *session, GSList *caps,
-			struct avdtp_stream *stream)
-{
-	struct reconf_req *req;
-	unsigned char *ptr;
-	int caps_len, err;
-	GSList *l;
-	struct avdtp_service_capability *cap;
-
-	if (!g_slist_find(session->streams, stream))
-		return -EINVAL;
-
-	if (stream->lsep->state != AVDTP_STATE_OPEN)
-		return -EINVAL;
-
-	/* Calculate total size of request */
-	for (l = caps, caps_len = 0; l != NULL; l = g_slist_next(l)) {
-		cap = l->data;
-		caps_len += cap->length + 2;
-	}
-
-	req = g_malloc0(sizeof(struct reconf_req) + caps_len);
-
-	req->acp_seid = stream->rseid;
-
-	/* Copy the capabilities into the request */
-	for (l = caps, ptr = req->caps; l != NULL; l = g_slist_next(l)) {
-		cap = l->data;
-		memcpy(ptr, cap, cap->length + 2);
-		ptr += cap->length + 2;
-	}
-
-	err = send_request(session, FALSE, stream, AVDTP_RECONFIGURE, req,
-						sizeof(*req) + caps_len);
-	g_free(req);
-
-	return err;
-}
-
 int avdtp_open(struct avdtp *session, struct avdtp_stream *stream)
 {
 	struct seid_req req;
diff --git a/audio/avdtp.h b/audio/avdtp.h
index e294ded..7b330b9 100644
--- a/audio/avdtp.h
+++ b/audio/avdtp.h
@@ -274,8 +274,6 @@ int avdtp_get_configuration(struct avdtp *session,
 				struct avdtp_stream *stream);
 
 int avdtp_open(struct avdtp *session, struct avdtp_stream *stream);
-int avdtp_reconfigure(struct avdtp *session, GSList *caps,
-			struct avdtp_stream *stream);
 int avdtp_start(struct avdtp *session, struct avdtp_stream *stream);
 int avdtp_suspend(struct avdtp *session, struct avdtp_stream *stream);
 int avdtp_close(struct avdtp *session, struct avdtp_stream *stream,
-- 
1.7.9.5

