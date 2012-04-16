Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd] client: Fix regression when calling obc_session_shutdown within callback
Date: Mon, 16 Apr 2012 13:40:07 +0300
Message-Id: <1334572807-2578-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Commit c07ddfbd019d3545cce2d7ec694143cdc55a2167 introduced the freeing of
the active pending request on obc_session_shutdown without checking if
the request was already processed/terminated.
---
 client/session.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/client/session.c b/client/session.c
index 51acbfa..868eb9f 100644
--- a/client/session.c
+++ b/client/session.c
@@ -494,7 +494,7 @@ void obc_session_shutdown(struct obc_session *session)
 	err = g_error_new(OBEX_IO_ERROR, OBEX_IO_DISCONNECTED,
 						"Session closed by user");
 
-	if (session->p != NULL) {
+	if (session->p != NULL && session->p->id != 0) {
 		if (session->p->func)
 			session->p->func(session, err, session->p->data);
 
@@ -821,6 +821,8 @@ static void session_terminate_transfer(struct obc_session *session,
 		g_queue_delete_link(session->queue, match);
 	}
 
+	p->id = 0;
+
 	obc_session_ref(session);
 
 	if (p->func)
-- 
1.7.7.6

