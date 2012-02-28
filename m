Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v2 2/2] client: free active transfer on session shutdown
Date: Tue, 28 Feb 2012 13:56:22 +0100
Message-Id: <1330433782-23492-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1330433782-23492-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1330433782-23492-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The currently active request should be canceled just like any other
queued transfer. Otherwise obex timeout is reported.
---
 client/session.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/client/session.c b/client/session.c
index c4645fb..42eba10 100644
--- a/client/session.c
+++ b/client/session.c
@@ -496,6 +496,14 @@ void obc_session_shutdown(struct obc_session *session)
 	err = g_error_new(OBEX_IO_ERROR, OBEX_IO_DISCONNECTED,
 						"Session closed by user");
 
+	if (session->p != NULL) {
+		if (session->p->func)
+			session->p->func(session, err, session->p->data);
+
+		pending_request_free(session->p);
+		session->p = NULL;
+	}
+
 	while ((p = g_queue_pop_head(session->queue))) {
 		if (p->func)
 			p->func(session, err, p->data);
-- 
1.7.6.5

