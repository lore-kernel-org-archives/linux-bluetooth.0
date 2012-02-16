Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v3 1/6] client: fix memory leak in obc_session_put
Date: Thu, 16 Feb 2012 15:00:29 +0100
Message-Id: <1329400834-8400-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1329400834-8400-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1329400834-8400-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

obc_session_put takes ownership of the given buffer, but did not free
the memory in case of error.
---
 client/session.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/client/session.c b/client/session.c
index 0fa8efc..28516b2 100644
--- a/client/session.c
+++ b/client/session.c
@@ -1017,8 +1017,10 @@ int obc_session_put(struct obc_session *session, char *buf, const char *targetna
 	struct obc_transfer *transfer;
 	const char *agent;
 
-	if (session->obex == NULL)
+	if (session->obex == NULL) {
+		g_free(buf);
 		return -ENOTCONN;
+	}
 
 	agent = obc_agent_get_name(session->agent);
 
@@ -1026,8 +1028,10 @@ int obc_session_put(struct obc_session *session, char *buf, const char *targetna
 							agent, NULL,
 							targetname, NULL,
 							NULL);
-	if (transfer == NULL)
+	if (transfer == NULL) {
+		g_free(buf);
 		return -EIO;
+	}
 
 	obc_transfer_set_buffer(transfer, buf);
 
-- 
1.7.6.5

