Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/9] obexd: Use process callback to queue transfers
Date: Tue, 28 May 2013 14:37:07 +0200
Message-Id: <1369744633-8980-4-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1369744633-8980-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1369744633-8980-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

This generalizes the existing queuing of transfers by using the
process callback of pending_request.
---
 obexd/client/session.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/obexd/client/session.c b/obexd/client/session.c
index e652a49..6c2ecb7 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -679,6 +679,15 @@ static void session_queue_add(struct pending_request *p)
 					session_queue_complete, p->session);
 }
 
+static int session_process_transfer(struct pending_request *p, GError **err)
+{
+	if (obc_transfer_start(p->transfer, p->session->obex, err)) {
+		p->session->p = p;
+		return 0;
+	}
+	return -1;
+}
+
 guint obc_session_queue(struct obc_session *session,
 				struct obc_transfer *transfer,
 				session_callback_t func, void *user_data,
@@ -701,7 +710,8 @@ guint obc_session_queue(struct obc_session *session,
 
 	obc_transfer_set_callback(transfer, transfer_complete, session);
 
-	p = pending_request_new(session, NULL, NULL, transfer, func, user_data);
+	p = pending_request_new(session, session_process_transfer, NULL,
+						transfer, func, user_data);
 	session_queue_add(p);
 	return p->id;
 }
@@ -721,12 +731,8 @@ static void session_process_queue(struct obc_session *session)
 	while ((p = g_queue_pop_head(session->queue))) {
 		GError *gerr = NULL;
 
-		DBG("Transfer(%p) started", p->transfer);
-
-		if (obc_transfer_start(p->transfer, session->obex, &gerr)) {
-			session->p = p;
+		if (p->process(p, &gerr) == 0)
 			break;
-		}
 
 		if (p->func)
 			p->func(session, p->transfer, gerr, p->data);
-- 
1.8.2.3

