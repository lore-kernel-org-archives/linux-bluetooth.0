Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd 6/9] client: terminate queued transfers properly
Date: Tue, 21 Feb 2012 09:46:20 +0100
Message-Id: <1329813983-26707-7-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1329813983-26707-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1329813983-26707-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Previous implementation of session_terminate_transfer assumed that the
transfer being terminated would always be the active one. However, it
should be possible to cancel any queued transfer using the D-Bus api.
---
 client/session.c |   32 ++++++++++++++++++++++++--------
 1 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/client/session.c b/client/session.c
index eaabcf9..50a6a5d 100644
--- a/client/session.c
+++ b/client/session.c
@@ -762,18 +762,34 @@ static void session_terminate_transfer(struct obc_session *session,
 {
 	struct pending_request *p = session->p;
 
-	if (p == NULL || p->transfer != transfer)
-		return;
-
 	obc_session_ref(session);
 
-	if (p->func)
-		p->func(session, gerr, p->data);
+	if (p != NULL && p->transfer == transfer) {
+		if (p->func)
+			p->func(session, gerr, p->data);
 
-	pending_request_free(p);
-	session->p = NULL;
+		pending_request_free(p);
+		session->p = NULL;
 
-	session_process_queue(session);
+		session_process_queue(session);
+	} else {
+		GList *l;
+
+		for (l = session->queue->head; l; l = l->next) {
+			p = l->data;
+
+			if (p->transfer != transfer)
+				continue;
+
+			g_queue_delete_link(session->queue, l);
+
+			if (p->func)
+				p->func(session, gerr, p->data);
+
+			pending_request_free(p);
+			break;
+		}
+	}
 
 	obc_session_unref(session);
 }
-- 
1.7.6.5

