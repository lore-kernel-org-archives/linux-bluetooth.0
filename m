Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v2 4/4] client: simplify obc_session_pull
Date: Wed,  7 Mar 2012 15:50:29 +0100
Message-Id: <1331131829-28509-5-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1331131829-28509-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1331131829-28509-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Functions obc_session_get and obc_session_pull nearly share the same
code, so the later can be achieved by just calling the first one.

The session api is not modified in this patch.
---
 client/session.c |   22 +---------------------
 1 files changed, 1 insertions(+), 21 deletions(-)

diff --git a/client/session.c b/client/session.c
index e130427..a9883c7 100644
--- a/client/session.c
+++ b/client/session.c
@@ -1005,27 +1005,7 @@ int obc_session_pull(struct obc_session *session,
 				const char *type, const char *targetfile,
 				session_callback_t function, void *user_data)
 {
-	struct obc_transfer *transfer;
-	const char *agent;
-
-	if (session->obex == NULL)
-		return -ENOTCONN;
-
-	if (session->agent != NULL)
-		agent = obc_agent_get_name(session->agent);
-	else
-		agent = NULL;
-
-	transfer = obc_transfer_register(session->conn, session->obex,
-								agent,
-								targetfile,
-								NULL, type,
-								NULL);
-	if (transfer == NULL) {
-		return -EIO;
-	}
-
-	return session_request(session, transfer, session_prepare_get,
+	return obc_session_get(session, type, NULL, targetfile, NULL, 0,
 							function, user_data);
 }
 
-- 
1.7.6.5

