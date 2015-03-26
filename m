Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/6] android/avdtp: Fix crashes caused by re-entrant calls
Date: Thu, 26 Mar 2015 16:20:23 +0200
Message-Id: <1427379625-20412-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1427379625-20412-1-git-send-email-luiz.dentz@gmail.com>
References: <1427379625-20412-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This make sure that while processing a PDU the session callbacks are
not able to destroy the session causing crashes.
---
 android/avdtp.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/android/avdtp.c b/android/avdtp.c
index e4fd2b7..2252782 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -784,6 +784,10 @@ static void handle_unanswered_req(struct avdtp *session,
 	struct avdtp_local_sep *lsep;
 	struct avdtp_error err;
 
+	if (!session->req->timeout)
+		/* Request is in process */
+		return;
+
 	if (session->req->signal_id == AVDTP_ABORT) {
 		/* Avoid freeing the Abort request here */
 		DBG("handle_unanswered_req: Abort req, returning");
@@ -2017,6 +2021,9 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 		break;
 	}
 
+	/* Take a reference to protect against callback destroying session */
+	avdtp_ref(session);
+
 	if (session->in.message_type == AVDTP_MSG_TYPE_COMMAND) {
 		if (!avdtp_parse_cmd(session, session->in.transaction,
 					session->in.signal_id,
@@ -2031,21 +2038,25 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 			goto next;
 		}
 
+		avdtp_unref(session);
 		return TRUE;
 	}
 
 	if (session->req == NULL) {
 		error("No pending request, ignoring message");
+		avdtp_unref(session);
 		return TRUE;
 	}
 
 	if (header->transaction != session->req->transaction) {
 		error("Transaction label doesn't match");
+		avdtp_unref(session);
 		return TRUE;
 	}
 
 	if (session->in.signal_id != session->req->signal_id) {
 		error("Response signal doesn't match");
+		avdtp_unref(session);
 		return TRUE;
 	}
 
@@ -2085,7 +2096,10 @@ next:
 	pending_req_free(session->req);
 	session->req = NULL;
 
-	process_queue(session);
+	if (session->ref > 1)
+		process_queue(session);
+
+	avdtp_unref(session);
 
 	return TRUE;
 
-- 
2.1.0

