Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd 4/9] client: remove unnecessary code
Date: Tue, 21 Feb 2012 09:46:18 +0100
Message-Id: <1329813983-26707-5-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1329813983-26707-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1329813983-26707-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

No pending requests will exist when session_free is reached, given that
pending transfes always hold a reference to the session.
---
 client/session.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/client/session.c b/client/session.c
index e113d1f..160e015 100644
--- a/client/session.c
+++ b/client/session.c
@@ -179,11 +179,8 @@ static void session_free(struct obc_session *session)
 		obc_agent_free(session->agent);
 	}
 
-	if (session->queue) {
-		g_queue_foreach(session->queue, (GFunc) pending_request_free,
-									NULL);
+	if (session->queue)
 		g_queue_free(session->queue);
-	}
 
 	if (session->watch)
 		g_dbus_remove_watch(session->conn, session->watch);
@@ -200,9 +197,6 @@ static void session_free(struct obc_session *session)
 	if (session->conn)
 		dbus_connection_unref(session->conn);
 
-	if (session->p)
-		pending_request_free(session->p);
-
 	sessions = g_slist_remove(sessions, session);
 
 	g_free(session->path);
-- 
1.7.6.5

