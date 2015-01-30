Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH ] obexd/client: clear pending transfers if fails
Date: Fri, 30 Jan 2015 16:37:12 +0530
Message-id: <1422616032-14968-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case of obex transfer fails, clear all pending
transfers in the session.
---
 obexd/client/session.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/obexd/client/session.c b/obexd/client/session.c
index d2ae4fd..512d6b7 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -901,8 +901,12 @@ static void session_terminate_transfer(struct obc_session *session,
 
 	pending_request_free(p);
 
-	if (session->p == NULL)
-		session_process_queue(session);
+	if (session->p == NULL) {
+		if (gerr != NULL)
+			obc_session_shutdown(session);
+		else
+			session_process_queue(session);
+	}
 
 	obc_session_unref(session);
 }
-- 
1.9.1

