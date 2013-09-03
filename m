Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 10/10 v3] obexd: Make use of g_dbus_send_message*
Date: Tue,  3 Sep 2013 14:21:19 +0300
Message-Id: <1378207279-14557-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1378207279-14557-1-git-send-email-luiz.dentz@gmail.com>
References: <1378207279-14557-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This replaces dbus_connection_send* with g_dbus_send_message* which do
not alter message order.
---
 obexd/plugins/bluetooth.c     | 2 +-
 obexd/plugins/pcsuite.c       | 5 ++---
 obexd/plugins/syncevolution.c | 6 +++---
 obexd/src/manager.c           | 3 +--
 4 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/obexd/plugins/bluetooth.c b/obexd/plugins/bluetooth.c
index e4d518e..10f5e4f 100644
--- a/obexd/plugins/bluetooth.c
+++ b/obexd/plugins/bluetooth.c
@@ -317,7 +317,7 @@ static int register_profile(struct bluetooth_profile *profile)
 	}
 	dbus_message_iter_close_container(&iter, &opt);
 
-	if (!dbus_connection_send_with_reply(connection, msg, &call, -1)) {
+	if (!g_dbus_send_message_with_reply(connection, msg, &call, -1)) {
 		ret = -1;
 		unregister_profile(profile);
 		goto failed;
diff --git a/obexd/plugins/pcsuite.c b/obexd/plugins/pcsuite.c
index 4ce2fe4..6460aa9 100644
--- a/obexd/plugins/pcsuite.c
+++ b/obexd/plugins/pcsuite.c
@@ -351,7 +351,7 @@ static gboolean send_backup_dbus_message(const char *oper,
 					DBUS_TYPE_INVALID);
 
 	if (strcmp(oper, "open") == 0) {
-		ret = dbus_connection_send_with_reply(conn, msg, &pending_call,
+		ret = g_dbus_send_message_with_reply(conn, msg, &pending_call,
 							BACKUP_DBUS_TIMEOUT);
 		dbus_message_unref(msg);
 		if (ret) {
@@ -363,8 +363,7 @@ static gboolean send_backup_dbus_message(const char *oper,
 		} else
 			dbus_connection_unref(conn);
 	} else {
-		ret = dbus_connection_send(conn, msg, NULL);
-		dbus_message_unref(msg);
+		g_dbus_send_message(conn, msg);
 		dbus_connection_unref(conn);
 	}
 
diff --git a/obexd/plugins/syncevolution.c b/obexd/plugins/syncevolution.c
index 2d25d28..edc00c8 100644
--- a/obexd/plugins/syncevolution.c
+++ b/obexd/plugins/syncevolution.c
@@ -314,7 +314,7 @@ static int synce_close(void *object)
 	dbus_message_append_args(msg, DBUS_TYPE_BOOLEAN, &normal,
 				DBUS_TYPE_STRING, &error, DBUS_TYPE_INVALID);
 
-	dbus_connection_send_with_reply(context->dbus_conn, msg, &call, -1);
+	g_dbus_send_message_with_reply(context->dbus_conn, msg, &call, -1);
 	dbus_pending_call_set_notify(call, close_cb, NULL, NULL);
 	dbus_message_unref(msg);
 	dbus_pending_call_unref(call);
@@ -380,7 +380,7 @@ static ssize_t synce_read(void *object, void *buf, size_t count)
 	dbus_message_append_args(msg, DBUS_TYPE_BOOLEAN, &authenticate,
 			DBUS_TYPE_STRING, &session, DBUS_TYPE_INVALID);
 
-	if (!dbus_connection_send_with_reply(conn, msg, &call, -1)) {
+	if (!g_dbus_send_message_with_reply(conn, msg, &call, -1)) {
 		error("D-Bus call to %s failed.", SYNCE_SERVER_INTERFACE);
 		dbus_message_unref(msg);
 		return -EPERM;
@@ -424,7 +424,7 @@ static ssize_t synce_write(void *object, const void *buf, size_t count)
 	dbus_message_append_args(msg, DBUS_TYPE_STRING, &type,
 						DBUS_TYPE_INVALID);
 
-	if (!dbus_connection_send_with_reply(context->dbus_conn, msg,
+	if (!g_dbus_send_message_with_reply(context->dbus_conn, msg,
 								&call, -1)) {
 		error("D-Bus call to %s failed.", SYNCE_CONN_INTERFACE);
 		dbus_message_unref(msg);
diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index dbfbef8..f64b7b9 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -776,8 +776,7 @@ int manager_request_authorization(struct obex_transfer *transfer, int32_t time,
 	dbus_message_append_args(msg, DBUS_TYPE_OBJECT_PATH, &transfer->path,
 							DBUS_TYPE_INVALID);
 
-	if (!dbus_connection_send_with_reply(connection,
-					msg, &call, TIMEOUT)) {
+	if (!g_dbus_send_message_with_reply(connection, msg, &call, TIMEOUT)) {
 		dbus_message_unref(msg);
 		return -EPERM;
 	}
-- 
1.8.3.1

