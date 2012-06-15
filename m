Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/9 v3] audio: Add handling of AVDTP command collision
Date: Fri, 15 Jun 2012 17:41:33 +0300
Message-Id: <1339771301-24032-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Check collision for AVDTP OPEN, CLOSE, START, SUSPEND and ABORT
commands and if they collided remove the pending request if sep
has accepted the indication.
---
v2: Fix capitalizing some acronyms
v3: Rebase and fix not using avdtp_start return in case of error

 audio/avdtp.c |   80 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index eb3f213..1287698 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -314,6 +314,7 @@ struct pending_req {
 	size_t data_size;
 	struct avdtp_stream *stream; /* Set if the request targeted a stream */
 	guint timeout;
+	gboolean collided;
 };
 
 struct avdtp_remote_sep {
@@ -1643,6 +1644,69 @@ static gboolean avdtp_reconf_cmd(struct avdtp *session, uint8_t transaction,
 					AVDTP_RECONFIGURE, &rej, sizeof(rej));
 }
 
+static void check_seid_collision(struct pending_req *req, uint8_t id)
+{
+	struct seid_req *seid = req->data;
+
+	if (seid->acp_seid == id)
+		req->collided = TRUE;
+}
+
+static void check_start_collision(struct pending_req *req, uint8_t id)
+{
+	struct start_req *start = req->data;
+	struct seid *seid = &start->first_seid;
+	int count = 1 + req->data_size - sizeof(struct start_req);
+	int i;
+
+	for (i = 0; i < count; i++, seid++) {
+		if (seid->seid == id) {
+			req->collided = TRUE;
+			return;
+		}
+	}
+}
+
+static void check_suspend_collision(struct pending_req *req, uint8_t id)
+{
+	struct suspend_req *suspend = req->data;
+	struct seid *seid = &suspend->first_seid;
+	int count = 1 + req->data_size - sizeof(struct suspend_req);
+	int i;
+
+	for (i = 0; i < count; i++, seid++) {
+		if (seid->seid == id) {
+			req->collided = TRUE;
+			return;
+		}
+	}
+}
+
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
+	switch (cmd) {
+	case AVDTP_OPEN:
+	case AVDTP_CLOSE:
+		check_seid_collision(req, stream->rseid);
+		break;
+	case AVDTP_START:
+		check_start_collision(req, stream->rseid);
+		break;
+	case AVDTP_SUSPEND:
+		check_suspend_collision(req, stream->rseid);
+		break;
+	}
+}
+
 static gboolean avdtp_open_cmd(struct avdtp *session, uint8_t transaction,
 				struct seid_req *req, unsigned int size)
 {
@@ -1674,6 +1738,8 @@ static gboolean avdtp_open_cmd(struct avdtp *session, uint8_t transaction,
 			goto failed;
 	}
 
+	avdtp_check_collision(session, AVDTP_OPEN, stream);
+
 	if (!avdtp_send(session, transaction, AVDTP_MSG_TYPE_ACCEPT,
 						AVDTP_OPEN, NULL, 0))
 		return FALSE;
@@ -1736,6 +1802,8 @@ static gboolean avdtp_start_cmd(struct avdtp *session, uint8_t transaction,
 				goto failed;
 		}
 
+		avdtp_check_collision(session, AVDTP_START, stream);
+
 		avdtp_sep_set_state(session, sep, AVDTP_STATE_STREAMING);
 	}
 
@@ -1783,6 +1851,8 @@ static gboolean avdtp_close_cmd(struct avdtp *session, uint8_t transaction,
 			goto failed;
 	}
 
+	avdtp_check_collision(session, AVDTP_CLOSE, stream);
+
 	avdtp_sep_set_state(session, sep, AVDTP_STATE_CLOSING);
 
 	if (!avdtp_send(session, transaction, AVDTP_MSG_TYPE_ACCEPT,
@@ -1842,6 +1912,8 @@ static gboolean avdtp_suspend_cmd(struct avdtp *session, uint8_t transaction,
 				goto failed;
 		}
 
+		avdtp_check_collision(session, AVDTP_SUSPEND, stream);
+
 		avdtp_sep_set_state(session, sep, AVDTP_STATE_OPEN);
 	}
 
@@ -1880,6 +1952,8 @@ static gboolean avdtp_abort_cmd(struct avdtp *session, uint8_t transaction,
 			goto failed;
 	}
 
+	avdtp_check_collision(session, AVDTP_ABORT, sep->stream);
+
 	ret = avdtp_send(session, transaction, AVDTP_MSG_TYPE_ACCEPT,
 						AVDTP_ABORT, NULL, 0);
 	if (ret)
@@ -2172,6 +2246,11 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 		if (session->streams && session->dc_timer)
 			remove_disconnect_timer(session);
 
+		if (session->req && session->req->collided) {
+			DBG("Collision detected");
+			goto next;
+		}
+
 		return TRUE;
 	}
 
@@ -2222,6 +2301,7 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 		break;
 	}
 
+next:
 	pending_req_free(session->req);
 	session->req = NULL;
 
-- 
1.7.10.2

