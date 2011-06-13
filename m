Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH v2 4/4] Fix invalid memory access issues in avdtp module
Date: Mon, 13 Jun 2011 12:50:56 +0200
Message-Id: <1307962256-15571-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changing stream state from STREAMING to IDLE can be associated with side
effects under some circumstances (such as terminating bluetoothd during
music is streamed). In this case, after connection is lost, stream state
changes from STREAMING to IDLE - "avdtp_sep_set_state" is triggered which
invokes callback called "stream_state_changed" which internally invokes
"avdtp_sep_set_state" (state of stream doesn't change and stays as IDLE)
second time and then stream object is freed by "stream_free"
at the end of "avdtp_sep_set_state". After returning from callback,
first triggered "avdtp_sep_set_state" attempts to free stream object
again ("if (state == AVDTP_STATE_IDLE)" condition is still satisfied)
and it leads to invalid read/write/free issues (reported by valgrind)
in "stream free" body, since "stream" is "alias" pointer to stream object
which is already out of date (memory for stream object has been already
freed).

This patch prevents from this special case by freeing stream object only
when it is present on streams list and removing from this list when
stream object would be freed.
---
 audio/avdtp.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index c49dee9..19c9fd1 100644
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
@@ -1105,8 +1104,11 @@ static void avdtp_sep_set_state(struct avdtp *session,
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

