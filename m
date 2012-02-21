Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v2 5/8] client: terminate queued transfers properly
Date: Tue, 21 Feb 2012 14:57:09 +0100
Message-Id: <1329832632-3681-6-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1329832632-3681-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1329832632-3681-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Previous implementation of session_terminate_transfer assumed that the
transfer being terminated would always be the active one. However, it
should be possible to cancel any queued transfer using the D-Bus api.
---
 client/session.c |   27 +++++++++++++++++++++++----
 1 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/client/session.c b/client/session.c
index 7f387d4..3429f0a 100644
--- a/client/session.c
+++ b/client/session.c
@@ -764,14 +764,31 @@ static void session_process_queue(struct obc_session *session)
 	obc_session_unref(session);
 }
 
+static gint pending_transfer_cmptransfer(gconstpointer a, gconstpointer b)
+{
+	const struct pending_request *p = a;
+	const struct obc_transfer *transfer = b;
+
+	return p->transfer < transfer ? -1 : (p->transfer > transfer ? 1 : 0);
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
 
@@ -779,9 +796,11 @@ static void session_terminate_transfer(struct obc_session *session,
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

