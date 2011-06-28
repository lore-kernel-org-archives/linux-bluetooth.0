Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@gmail.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH obexd v2] Code clean-up: remove unnecessary brackets
Date: Tue, 28 Jun 2011 23:26:37 +0300
Message-Id: <1309292797-1390-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/session.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/client/session.c b/client/session.c
index 266d00c..825bee7 100644
--- a/client/session.c
+++ b/client/session.c
@@ -197,9 +197,8 @@ static void session_free(struct session_data *session)
 	if (session->path)
 		session_unregistered(session);
 
-	if (session->conn) {
+	if (session->conn)
 		dbus_connection_unref(session->conn);
-	}
 
 	sessions = g_slist_remove(sessions, session);
 
-- 
1.7.4.1

