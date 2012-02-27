Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v3 1/2] client: terminate queued transfers properly
Date: Mon, 27 Feb 2012 10:54:35 +0100
Message-Id: <1330336476-13454-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1330336476-13454-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1330336476-13454-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Previous implementation of session_terminate_transfer assumed that the
transfer being terminated would always be the active one. However, it
should be possible to cancel any queued transfer using the D-Bus api.
---
 client/session.c |   30 ++++++++++++++++++++++++++----
 1 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/client/session.c b/client/session.c
index 30b8431..417295e 100644
--- a/client/session.c
+++ b/client/session.c
@@ -769,14 +769,34 @@ static void session_process_queue(struct obc_session *session)
 	obc_session_unref(session);
 }
 
+static gint pending_transfer_cmptransfer(gconstpointer a, gconstpointer b)
+{
+	const struct pending_request *p = a;
+	const struct obc_transfer *transfer = b;
+
+	if (p->transfer == transfer)
+		return 0;
+
+	return -1;
+}
+
 static void session_terminate_transfer(struct obc_session *session,
 					struct obc_transfer *transfer,
 					GError *gerr)
 {
 	struct pending_request *p = session->p;
 
-	if (p == NULL || p->transfer != transfer)
-		return;
+	if (p == NULL || p->transfer != transfer) {
+		GList *match;
+
+		match = g_list_find_custom(session->queue->head, transfer,
+						pending_transfer_cmptransfer);
+		if (match == NULL)
+			return;
+
+		p = match->data;
+		g_queue_delete_link(session->queue, match);
+	}
 
 	obc_session_ref(session);
 
@@ -784,9 +804,11 @@ static void session_terminate_transfer(struct obc_session *session,
 		p->func(session, gerr, p->data);
 
 	pending_request_free(p);
-	session->p = NULL;
 
-	session_process_queue(session);
+	if (p == session->p) {
+		session->p = NULL;
+		session_process_queue(session);
+	}
 
 	obc_session_unref(session);
 }
-- 
1.7.6.5

