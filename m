Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/7] Add handling of avdtp command collision
Date: Mon, 22 Aug 2011 16:25:45 +0300
Message-Id: <1314019551-3471-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Check collision for avdtp open, close, start, suspend and abort
commands and if they collided remove the pending request if sep
has accepted the indication.
---
 audio/avdtp.c |   78 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 69 insertions(+), 9 deletions(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index 11f6515..5706fe2 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -314,6 +314,7 @@ struct pending_req {
 	size_t data_size;
 	struct avdtp_stream *stream; /* Set if the request targeted a stream */
 	guint timeout;
+	gboolean collided;
 };
 
 struct avdtp_remote_sep {
@@ -1631,6 +1632,55 @@ static gboolean avdtp_reconf_cmd(struct avdtp *session, uint8_t transaction,
 	return avdtp_unknown_cmd(session, transaction, AVDTP_RECONFIGURE);
 }
 
+static void avdtp_check_collision(struct avdtp *session, uint8_t cmd,
+					struct avdtp_stream *stream)
+{
+	struct pending_req *req = session->req;
+
+	if (req == NULL || (req->signal_id != cmd && cmd != AVDTP_ABORT))
+		return;
+
+	if (cmd == AVDTP_ABORT)
+		cmd = req->signal_id;
+
+	if (cmd == AVDTP_OPEN || cmd == AVDTP_CLOSE) {
+		struct seid_req *seid = session->req->data;
+
+		if (seid->acp_seid == stream->rseid)
+			req->collided = TRUE;
+	} else if (cmd == AVDTP_START) {
+		struct start_req *start = session->req->data;
+		struct seid *seid = &start->first_seid;
+		int count = 1 + session->req->data_size -
+						sizeof(struct start_req);
+		int i;
+
+		req->collided = FALSE;
+
+		for (i = 0; i < count; i++, seid++) {
+			if (seid->seid == stream->rseid) {
+				req->collided = TRUE;
+				break;
+			}
+		}
+	} else if (cmd == AVDTP_SUSPEND) {
+		struct suspend_req *suspend = session->req->data;
+		struct seid *seid = &suspend->first_seid;
+		int count = 1 + session->req->data_size -
+						sizeof(struct suspend_req);
+		int i;
+
+		req->collided = FALSE;
+
+		for (i = 0; i < count; i++, seid++) {
+			if (seid->seid == stream->rseid) {
+				req->collided = TRUE;
+				break;
+			}
+		}
+	}
+}
+
 static gboolean avdtp_open_cmd(struct avdtp *session, uint8_t transaction,
 				struct seid_req *req, unsigned int size)
 {
@@ -1662,6 +1712,8 @@ static gboolean avdtp_open_cmd(struct avdtp *session, uint8_t transaction,
 			goto failed;
 	}
 
+	avdtp_check_collision(session, AVDTP_OPEN, stream);
+
 	if (!avdtp_send(session, transaction, AVDTP_MSG_TYPE_ACCEPT,
 						AVDTP_OPEN, NULL, 0))
 		return FALSE;
@@ -1724,6 +1776,8 @@ static gboolean avdtp_start_cmd(struct avdtp *session, uint8_t transaction,
 				goto failed;
 		}
 
+		avdtp_check_collision(session, AVDTP_START, stream);
+
 		avdtp_sep_set_state(session, sep, AVDTP_STATE_STREAMING);
 	}
 
@@ -1771,6 +1825,8 @@ static gboolean avdtp_close_cmd(struct avdtp *session, uint8_t transaction,
 			goto failed;
 	}
 
+	avdtp_check_collision(session, AVDTP_CLOSE, stream);
+
 	avdtp_sep_set_state(session, sep, AVDTP_STATE_CLOSING);
 
 	if (!avdtp_send(session, transaction, AVDTP_MSG_TYPE_ACCEPT,
@@ -1830,6 +1886,8 @@ static gboolean avdtp_suspend_cmd(struct avdtp *session, uint8_t transaction,
 				goto failed;
 		}
 
+		avdtp_check_collision(session, AVDTP_SUSPEND, stream);
+
 		avdtp_sep_set_state(session, sep, AVDTP_STATE_OPEN);
 	}
 
@@ -1857,27 +1915,23 @@ static gboolean avdtp_abort_cmd(struct avdtp *session, uint8_t transaction,
 	}
 
 	sep = find_local_sep_by_seid(session->server, req->acp_seid);
-	if (!sep || !sep->stream) {
-		err = AVDTP_BAD_ACP_SEID;
-		goto failed;
-	}
+	if (!sep || !sep->stream)
+		return FALSE;
 
 	if (sep->ind && sep->ind->abort) {
 		if (!sep->ind->abort(session, sep, sep->stream, &err,
 					sep->user_data))
-			goto failed;
+			return FALSE;
 	}
 
+	avdtp_check_collision(session, AVDTP_ABORT, sep->stream);
+
 	ret = avdtp_send(session, transaction, AVDTP_MSG_TYPE_ACCEPT,
 						AVDTP_ABORT, NULL, 0);
 	if (ret)
 		avdtp_sep_set_state(session, sep, AVDTP_STATE_ABORTING);
 
 	return ret;
-
-failed:
-	return avdtp_send(session, transaction, AVDTP_MSG_TYPE_REJECT,
-					AVDTP_ABORT, &err, sizeof(err));
 }
 
 static gboolean avdtp_secctl_cmd(struct avdtp *session, uint8_t transaction,
@@ -2160,6 +2214,11 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 		if (session->streams && session->dc_timer)
 			remove_disconnect_timer(session);
 
+		if (session->req && session->req->collided) {
+			DBG("Collision detected");
+			goto next;
+		}
+
 		return TRUE;
 	}
 
@@ -2210,6 +2269,7 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 		break;
 	}
 
+next:
 	pending_req_free(session->req);
 	session->req = NULL;
 
-- 
1.7.6

