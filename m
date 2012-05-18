Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 1/2] client: Fix NULL dereference in case of error
Date: Fri, 18 May 2012 09:54:03 +0200
Message-Id: <1337327644-17920-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

obc_session_queue assumes that the given transfer is not NULL, so this
must be checked explicitly.
---
 client/manager.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/client/manager.c b/client/manager.c
index 9f26cb0..53f0d0f 100644
--- a/client/manager.c
+++ b/client/manager.c
@@ -294,13 +294,18 @@ static void pull_obc_session_callback(struct obc_session *session,
 	}
 
 	pull = obc_transfer_get("text/x-vcard", NULL, data->filename, &gerr);
+	if (pull == NULL) {
+		reply = g_dbus_create_error(data->message,
+						"org.openobex.Error.Failed",
+						"%s", gerr->message);
+		goto fail;
+	}
 
 	if (!obc_session_queue(session, pull, pull_complete_callback, data,
 								&gerr)) {
 		reply = g_dbus_create_error(data->message,
 						"org.openobex.Error.Failed",
 						"%s", gerr->message);
-		g_error_free(gerr);
 		goto fail;
 	}
 
@@ -311,6 +316,7 @@ fail:
 	shutdown_session(session);
 	dbus_message_unref(data->message);
 	dbus_connection_unref(data->connection);
+	g_clear_error(&gerr);
 	g_free(data->filename);
 	g_free(data->sender);
 	g_free(data);
@@ -516,13 +522,18 @@ static void capability_obc_session_callback(struct obc_session *session,
 
 	pull = obc_transfer_get("x-obex/capability", NULL, data->filename,
 									&gerr);
+	if (pull == NULL) {
+		reply = g_dbus_create_error(data->message,
+					"org.openobex.Error.Failed",
+					"%s", gerr->message);
+		goto fail;
+	}
 
 	if (!obc_session_queue(session, pull, capabilities_complete_callback,
 								data, &gerr)) {
 		reply = g_dbus_create_error(data->message,
 					"org.openobex.Error.Failed",
 					"%s", gerr->message);
-		g_error_free(gerr);
 		goto fail;
 	}
 
@@ -533,6 +544,7 @@ fail:
 	shutdown_session(session);
 	dbus_message_unref(data->message);
 	dbus_connection_unref(data->connection);
+	g_clear_error(&gerr);
 	g_free(data->sender);
 	g_free(data);
 }
-- 
1.7.7.6

