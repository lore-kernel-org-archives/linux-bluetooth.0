Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH 3/3] Fix invalid memory access issues in avdtp module
Date: Fri, 10 Jun 2011 15:34:10 +0200
Message-Id: <1307712850-1934-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changing stream state from STREAMING to IDLE can be associated with side
effects under some circumstances (such as terminating bluetoothd during
music is streamed). In this case, after connection is lost, stream state
changes from STREAMING to IDLE - "avdtp_sep_set_state" is triggered which
invokes callback called "stream_state_changed" which internally invokes
"avdtp_sep_set_state" (state of stream doesn't change and stays as IDLE)
second time and then stream object is freed by "stream_free" at the end
of "avdtp_sep_set_state". After returning from callback
"stream_state_changed", first triggered "avdtp_sep_set_state" attempts
to free stream object again ("if (state == AVDTP_STATE_IDLE)" condition
is still satisfied) and it leads to invalid read/write/free issues
(reported by valgrind) in "stream free" body, since "stream" is "alias"
pointer to stream object which is already out of date (memory for stream
object has been already freed). Moreover freeing stream object also
discards its callback list so after finishing iteration on this list
(in "avdtp_sep_set_state") "l" pointer is out of date and getting
"l->next" pointer (returned by "g_slist_next(l)") leads to invalid read
issue.

This patch prevents from this special case by freeing stream object only
when it is present on streams list and removing from this list when
stream object would be freed. Additionally to avoid issue with callback
list loop for this has been modified and "while" used instead of "for"
loop variant.
---
 audio/avdtp.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index 6018c37..19c9fd1 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -1086,7 +1086,6 @@ static void avdtp_sep_set_state(struct avdtp *session,
 			g_source_remove(stream->idle_timer);
 			stream->idle_timer = 0;
 		}
-		session->streams = g_slist_remove(session->streams, stream);
 		if (session->pending_open == stream)
 			handle_transport_connect(session, NULL, 0, 0);
 		if (session->req && session->req->stream == stream)
@@ -1098,13 +1097,18 @@ static void avdtp_sep_set_state(struct avdtp *session,
 		break;
 	}
 
-	for (l = stream->callbacks; l != NULL; l = g_slist_next(l)) {
+	l = stream->callbacks;
+	while (l != NULL) {
 		struct stream_callback *cb = l->data;
+		l = g_slist_next(l);
 		cb->cb(stream, old_state, state, err_ptr, cb->user_data);
 	}
 
-	if (state == AVDTP_STATE_IDLE)
+	if (state == AVDTP_STATE_IDLE &&
+				g_slist_find(session->streams, stream)) {
+		session->streams = g_slist_remove(session->streams, stream);
 		stream_free(stream);
+	}
 }
 
 static void finalize_discovery(struct avdtp *session, int err)
-- 
1.6.3.3

