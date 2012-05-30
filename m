Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v3 13/14] client: Make FileTransfer.PutFile asynchronous
Date: Wed, 30 May 2012 17:50:22 +0200
Message-Id: <1338393023-29941-14-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1338393023-29941-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1338393023-29941-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

There is no reason to have inconsistent behavior between GetFile and
PutFile, in FileTransfer D-Bus API.

Before this change, PutFile reported success immediately after queueing
the transfer, even though the D-Bus signature includes the async flag.
---
 client/ftp.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/client/ftp.c b/client/ftp.c
index 9b2c51d..8c72413 100644
--- a/client/ftp.c
+++ b/client/ftp.c
@@ -143,7 +143,7 @@ static const GMarkupParser parser = {
 	NULL
 };
 
-static void get_file_callback(struct obc_session *session,
+static void transfer_callback(struct obc_session *session,
 						struct obc_transfer *transfer,
 						GError *err, void *user_data)
 {
@@ -270,8 +270,8 @@ static DBusMessage *get_file(DBusConnection *connection,
 	if (transfer == NULL)
 		goto fail;
 
-	if (obc_session_queue(session, transfer, get_file_callback, message,
-								&err)) {
+	if (obc_session_queue(session, transfer, transfer_callback, message,
+									&err)) {
 		dbus_message_ref(message);
 		return NULL;
 	}
@@ -306,8 +306,11 @@ static DBusMessage *put_file(DBusConnection *connection,
 	if (transfer == NULL)
 		goto fail;
 
-	if (obc_session_queue(session, transfer, NULL, NULL, &err))
-		return dbus_message_new_method_return(message);
+	if (obc_session_queue(session, transfer, transfer_callback, message,
+									&err)) {
+		dbus_message_ref(message);
+		return NULL;
+	}
 
 fail:
 	reply = g_dbus_create_error(message, "org.openobex.Error.Failed", "%s",
-- 
1.7.7.6

