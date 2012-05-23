Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 09/12] avctp: Fix NULL check after dereference
Date: Wed, 23 May 2012 21:27:29 +0530
Message-id: <1337788652-23697-10-git-send-email-s.syam@samsung.com>
In-reply-to: <1337788652-23697-1-git-send-email-s.syam@samsung.com>
References: <1337788652-23697-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Check for session != NULL has to be done before accessing session.
---
 audio/avctp.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index d98d097..1bc2a1d 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -320,7 +320,7 @@ static struct avctp_pdu_handler *find_handler(GSList *list, uint8_t opcode)
 
 static void avctp_disconnected(struct avctp *session)
 {
-	struct avctp_server *server = session->server;
+	struct avctp_server *server;
 
 	if (!session)
 		return;
@@ -356,6 +356,7 @@ static void avctp_disconnected(struct avctp *session)
 		session->uinput = -1;
 	}
 
+	server = session->server;
 	server->sessions = g_slist_remove(server->sessions, session);
 	g_slist_free_full(session->handlers, g_free);
 	g_free(session);
-- 
1.7.4.1

