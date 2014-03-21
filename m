Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] obexd/client: Fix not sending OBEX Disconnect when disconnecting
Date: Fri, 21 Mar 2014 13:58:24 +0200
Message-Id: <1395403104-10344-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1395403104-10344-1-git-send-email-luiz.dentz@gmail.com>
References: <1395403104-10344-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Sending OBEX Disconnect command before disconnecting the transport is
mandatory.
---
 obexd/client/session.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/obexd/client/session.c b/obexd/client/session.c
index 8138b1e..cb176e4 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -240,8 +240,6 @@ static void session_free(struct obc_session *session)
 	if (session->p)
 		pending_request_free(session->p);
 
-	sessions = g_slist_remove(sessions, session);
-
 	g_free(session->path);
 	g_free(session->owner);
 	g_free(session->source);
@@ -250,6 +248,25 @@ static void session_free(struct obc_session *session)
 	g_free(session);
 }
 
+static void disconnect_complete(GObex *obex, GError *err, GObexPacket *rsp,
+							void *user_data)
+{
+	struct obc_session *session = user_data;
+
+	DBG("");
+
+	if (err)
+		error("%s", err->message);
+
+	/* Disconnect transport */
+	if (session->id > 0 && session->transport != NULL) {
+		session->transport->disconnect(session->id);
+		session->id = 0;
+	}
+
+	session_free(session);
+}
+
 void obc_session_unref(struct obc_session *session)
 {
 	int refs;
@@ -261,6 +278,19 @@ void obc_session_unref(struct obc_session *session)
 	if (refs > 0)
 		return;
 
+	sessions = g_slist_remove(sessions, session);
+
+	if (!session->obex)
+		goto disconnect;
+
+	/* Wait OBEX Disconnect to complete if command succeed otherwise
+	 * proceed with transport disconnection since there is nothing else to
+	 * be done */
+	if (g_obex_disconnect(session->obex, disconnect_complete, session,
+									NULL))
+		return;
+
+disconnect:
 	/* Disconnect transport */
 	if (session->id > 0 && session->transport != NULL) {
 		session->transport->disconnect(session->id);
-- 
1.8.5.3

