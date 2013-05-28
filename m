Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/9] obexd: Add session_queue_add
Date: Tue, 28 May 2013 14:37:06 +0200
Message-Id: <1369744633-8980-3-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1369744633-8980-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1369744633-8980-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

Add helper function session_queue_add that appends a pending_request to
the session's command queue.
---
 obexd/client/session.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/obexd/client/session.c b/obexd/client/session.c
index 1b02403..e652a49 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -670,6 +670,15 @@ static gboolean session_queue_complete(gpointer data)
 	return FALSE;
 }
 
+static void session_queue_add(struct pending_request *p)
+{
+	g_queue_push_tail(p->session->queue, p);
+
+	if (p->session->queue_complete_id == 0)
+		p->session->queue_complete_id = g_idle_add(
+					session_queue_complete, p->session);
+}
+
 guint obc_session_queue(struct obc_session *session,
 				struct obc_transfer *transfer,
 				session_callback_t func, void *user_data,
@@ -693,12 +702,7 @@ guint obc_session_queue(struct obc_session *session,
 	obc_transfer_set_callback(transfer, transfer_complete, session);
 
 	p = pending_request_new(session, NULL, NULL, transfer, func, user_data);
-	g_queue_push_tail(session->queue, p);
-
-	if (session->queue_complete_id == 0)
-		session->queue_complete_id = g_idle_add(
-					session_queue_complete, session);
-
+	session_queue_add(p);
 	return p->id;
 }
 
-- 
1.8.2.3

