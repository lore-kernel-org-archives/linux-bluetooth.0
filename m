Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 2/2] client: Simplify error-handling code
Date: Fri, 18 May 2012 09:54:04 +0200
Message-Id: <1337327644-17920-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1337327644-17920-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1337327644-17920-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Refactor error-handling code to avoid duplicated code.
---
 client/manager.c |   48 ++++++++++++++++++------------------------------
 1 files changed, 18 insertions(+), 30 deletions(-)

diff --git a/client/manager.c b/client/manager.c
index 53f0d0f..b6d4afc 100644
--- a/client/manager.c
+++ b/client/manager.c
@@ -286,32 +286,26 @@ static void pull_obc_session_callback(struct obc_session *session,
 	DBusMessage *reply;
 	GError *gerr = NULL;
 
-	if (err != NULL) {
-		reply = g_dbus_create_error(data->message,
-						"org.openobex.Error.Failed",
-						"%s", err->message);
+	if (err != NULL)
 		goto fail;
-	}
 
 	pull = obc_transfer_get("text/x-vcard", NULL, data->filename, &gerr);
-	if (pull == NULL) {
-		reply = g_dbus_create_error(data->message,
-						"org.openobex.Error.Failed",
-						"%s", gerr->message);
+	if (pull == NULL)
 		goto fail;
-	}
 
 	if (!obc_session_queue(session, pull, pull_complete_callback, data,
-								&gerr)) {
-		reply = g_dbus_create_error(data->message,
-						"org.openobex.Error.Failed",
-						"%s", gerr->message);
+								&gerr))
 		goto fail;
-	}
 
 	return;
 
 fail:
+	if (err == NULL)
+		err = gerr;
+
+	reply = g_dbus_create_error(data->message,
+						"org.openobex.Error.Failed",
+						"%s", err->message);
 	g_dbus_send_message(data->connection, reply);
 	shutdown_session(session);
 	dbus_message_unref(data->message);
@@ -513,33 +507,27 @@ static void capability_obc_session_callback(struct obc_session *session,
 	DBusMessage *reply;
 	GError *gerr = NULL;
 
-	if (err != NULL) {
-		reply = g_dbus_create_error(data->message,
-					"org.openobex.Error.Failed",
-					"%s", err->message);
+	if (err != NULL)
 		goto fail;
-	}
 
 	pull = obc_transfer_get("x-obex/capability", NULL, data->filename,
 									&gerr);
-	if (pull == NULL) {
-		reply = g_dbus_create_error(data->message,
-					"org.openobex.Error.Failed",
-					"%s", gerr->message);
+	if (pull == NULL)
 		goto fail;
-	}
 
 	if (!obc_session_queue(session, pull, capabilities_complete_callback,
-								data, &gerr)) {
-		reply = g_dbus_create_error(data->message,
-					"org.openobex.Error.Failed",
-					"%s", gerr->message);
+								data, &gerr))
 		goto fail;
-	}
 
 	return;
 
 fail:
+	if (err == NULL)
+		err = gerr;
+
+	reply = g_dbus_create_error(data->message,
+					"org.openobex.Error.Failed",
+					"%s", err->message);
 	g_dbus_send_message(data->connection, reply);
 	shutdown_session(session);
 	dbus_message_unref(data->message);
-- 
1.7.7.6

