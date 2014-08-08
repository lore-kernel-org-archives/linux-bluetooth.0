Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/2] android/a2dp: Improve avdtp_close function
Date: Fri,  8 Aug 2014 15:42:33 +0200
Message-Id: <1407505354-23072-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch avdtp_close does avdtp_abort under the hood in case
stream is not yet in OPEN state.
---
 android/avdtp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/android/avdtp.c b/android/avdtp.c
index 89f4860..85ef94b 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -3244,14 +3244,15 @@ int avdtp_close(struct avdtp *session, struct avdtp_stream *stream,
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
 
-- 
1.8.4

