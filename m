Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v2 1/2] client: fix unreported canceled transfers
Date: Tue, 28 Feb 2012 13:56:21 +0100
Message-Id: <1330433782-23492-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

A session can be shut down from D-Bus, and therefore the pending
transfer callbacks must be reported.
---
 client/session.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/client/session.c b/client/session.c
index 417295e..c4645fb 100644
--- a/client/session.c
+++ b/client/session.c
@@ -485,12 +485,25 @@ proceed:
 
 void obc_session_shutdown(struct obc_session *session)
 {
+	struct pending_request *p;
+	GError *err;
+
 	DBG("%p", session);
 
 	obc_session_ref(session);
 
 	/* Unregister any pending transfer */
-	g_queue_foreach(session->queue, (GFunc) pending_request_free, NULL);
+	err = g_error_new(OBEX_IO_ERROR, OBEX_IO_DISCONNECTED,
+						"Session closed by user");
+
+	while ((p = g_queue_pop_head(session->queue))) {
+		if (p->func)
+			p->func(session, err, p->data);
+
+		pending_request_free(p);
+	}
+
+	g_error_free(err);
 
 	/* Unregister interfaces */
 	if (session->path)
-- 
1.7.6.5

