Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix crash when acquiring a2dp stream
Date: Wed, 30 Mar 2011 15:32:04 +0300
Message-Id: <1301488324-16975-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Disconnecting l2cap before getting a response for avdtp start cause a
crash while we try to abort it:

avdtp_sep_set_state (session=0x9c210, sep=0x9ada0, state=AVDTP_STATE_IDLE)
0x000256dc in connection_lost (session=0x9c210, err=-5)
0x00025d44 in cancel_request (session=0x9c210, err=-5)
0x00026a98 in avdtp_abort (session=0x9c210, stream=0x9bee8)
0x00020e74 in a2dp_cancel (dev=<value optimized out>, id=<value optimized out>)
0x0002d5b4 in acquire_request_free (req=0x9b1a0)
0x0002d638 in media_owner_remove (owner=0x9a4a0)
0x0002da94 in media_transport_free (data=<value optimized out>)
0x000115a0 in remove_interface (data=0xa1f88, name=<value optimized out>)
0x0002e2a0 in media_transport_remove (transport=0x8fad8)
0x0002c624 in media_endpoint_clear_configuration (endpoint=0x9b098)
0x000260c8 in avdtp_sep_set_state (session=0x9c210, sep=0x9ada0, state=AVDTP_STATE_IDLE)

To fix this callbacks are called after handling the state change, so
any pending request are properly removed before state is set to idle.
---
 audio/avdtp.c     |   14 ++++++++------
 audio/transport.c |   12 +-----------
 2 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index 83b1aa2..23281ac 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -1050,11 +1050,6 @@ static void avdtp_sep_set_state(struct avdtp *session,
 	old_state = sep->state;
 	sep->state = state;
 
-	for (l = stream->callbacks; l != NULL; l = g_slist_next(l)) {
-		struct stream_callback *cb = l->data;
-		cb->cb(stream, old_state, state, err_ptr, cb->user_data);
-	}
-
 	switch (state) {
 	case AVDTP_STATE_CONFIGURED:
 		if (sep->info.type == AVDTP_SEP_TYPE_SINK)
@@ -1086,11 +1081,18 @@ static void avdtp_sep_set_state(struct avdtp *session,
 			handle_unanswered_req(session, stream);
 		/* Remove pending commands for this stream from the queue */
 		cleanup_queue(session, stream);
-		stream_free(stream);
 		break;
 	default:
 		break;
 	}
+
+	for (l = stream->callbacks; l != NULL; l = g_slist_next(l)) {
+		struct stream_callback *cb = l->data;
+		cb->cb(stream, old_state, state, err_ptr, cb->user_data);
+	}
+
+	if (state == AVDTP_STATE_IDLE)
+		stream_free(stream);
 }
 
 static void finalize_discovery(struct avdtp *session, int err)
diff --git a/audio/transport.c b/audio/transport.c
index 8ff6c85..aa3308d 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -224,15 +224,6 @@ static gboolean media_transport_set_fd(struct media_transport *transport,
 	return TRUE;
 }
 
-static gboolean remove_owner(gpointer data)
-{
-	struct media_owner *owner = data;
-
-	media_transport_remove(owner->transport, owner);
-
-	return FALSE;
-}
-
 static void a2dp_resume_complete(struct avdtp *session,
 				struct avdtp_error *err, void *user_data)
 {
@@ -279,8 +270,7 @@ static void a2dp_resume_complete(struct avdtp *session,
 	return;
 
 fail:
-	/* Let the stream state change before removing the owner */
-	g_idle_add(remove_owner, owner);
+	media_transport_remove(transport, owner);
 }
 
 static guint resume_a2dp(struct media_transport *transport,
-- 
1.7.1

