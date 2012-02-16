Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v3 2/6] client: fix unreported error case
Date: Thu, 16 Feb 2012 15:00:30 +0100
Message-Id: <1329400834-8400-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1329400834-8400-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1329400834-8400-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The authorization request of a queued transfer could fail, and this
needs to be reported to the transfer initiator. Otherwise it would
likely result in D-Bus timeouts.
---
 client/session.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/client/session.c b/client/session.c
index 28516b2..4d49fc4 100644
--- a/client/session.c
+++ b/client/session.c
@@ -735,17 +735,31 @@ static void session_process_queue(struct obc_session *session)
 	if (session->queue == NULL || g_queue_is_empty(session->queue))
 		return;
 
+	obc_session_ref(session);
+
 	while ((p = g_queue_pop_head(session->queue))) {
 		int err;
 
 		err = pending_request_auth(p);
 		if (err == 0) {
 			session->p = p;
+			obc_session_unref(session);
 			return;
 		}
 
+		if (p->func) {
+			GError *gerr = NULL;
+
+			g_set_error(&gerr, OBEX_IO_ERROR, err,
+							"Authorization failed");
+			p->func(session, gerr, p->data);
+			g_error_free(gerr);
+		}
+
 		pending_request_free(p);
 	}
+
+	obc_session_unref(session);
 }
 
 static void session_terminate_transfer(struct obc_session *session,
-- 
1.7.6.5

