Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: [PATCH obexd v0 6/6] client: Remove transfer from queue before callback
Date: Fri, 27 Apr 2012 12:33:40 +0200
Message-Id: <1335522820-11826-7-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1335522820-11826-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1335522820-11826-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is safer to remove the transfer from the internal queue (including
session->p) before calling the transfer callback. This makes sure the
callback will not manipulate the session in a way that the transfer is
removed more than once.

This was previously protected with session->p->id != 0 checks, but once
the new callbacks have been adopted in session API, this logic can be
removed.
---
 client/session.c |   20 +++++++++-----------
 1 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/client/session.c b/client/session.c
index ea717a6..bb00684 100644
--- a/client/session.c
+++ b/client/session.c
@@ -496,15 +496,16 @@ void obc_session_shutdown(struct obc_session *session)
 	err = g_error_new(OBEX_IO_ERROR, OBEX_IO_DISCONNECTED,
 						"Session closed by user");
 
-	if (session->p != NULL && session->p->id != 0) {
+	if (session->p != NULL) {
 		session_transfer_callback_t callback = session->p->func;
 
+		p = session->p;
+		session->p = NULL;
+
 		if (callback)
-			callback(session, session->p->transfer, err,
-							session->p->data);
+			callback(session, p->transfer, err, p->data);
 
-		pending_request_free(session->p);
-		session->p = NULL;
+		pending_request_free(p);
 	}
 
 	while ((p = g_queue_pop_head(session->queue))) {
@@ -843,9 +844,8 @@ static void session_terminate_transfer(struct obc_session *session,
 
 		p = match->data;
 		g_queue_delete_link(session->queue, match);
-	}
-
-	p->id = 0;
+	} else
+		session->p = NULL;
 
 	obc_session_ref(session);
 
@@ -855,10 +855,8 @@ static void session_terminate_transfer(struct obc_session *session,
 
 	pending_request_free(p);
 
-	if (p == session->p) {
-		session->p = NULL;
+	if (session->p == NULL)
 		session_process_queue(session);
-	}
 
 	obc_session_unref(session);
 }
-- 
1.7.7.6

