Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 01/13 v3] client: fix not checking session_request return
Date: Wed,  8 Feb 2012 11:43:57 +0200
Message-Id: <1328694249-22225-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In case session_request return an error proceed to the next
---
 client/session.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/client/session.c b/client/session.c
index c127974..c9df832 100644
--- a/client/session.c
+++ b/client/session.c
@@ -687,9 +687,16 @@ static void session_terminate_transfer(struct obc_session *session,
 
 	obc_session_remove_transfer(session, transfer);
 
-	if (session->pending)
-		session_request(session, session_prepare_put,
-				session->pending->data);
+	while (session->pending != NULL) {
+		struct obc_transfer *transfer = session->pending->data;
+		int err;
+
+		err = session_request(session, session_prepare_put, transfer);
+		if (err == 0)
+			break;
+
+		obc_session_remove_transfer(session, transfer);
+	}
 
 	obc_session_unref(session);
 }
-- 
1.7.7.6

