Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@gmail.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH obexd v2 4/4] Add adapter ReleaseSession to obex-client
Date: Wed, 29 Jun 2011 00:40:42 +0300
Message-Id: <1309297242-4154-5-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1309297242-4154-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1309297242-4154-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Release of adapter session is added to obex-client when closing OBEX
transfer.
---
 client/session.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/client/session.c b/client/session.c
index 4b8cf09..a2a3b2d 100644
--- a/client/session.c
+++ b/client/session.c
@@ -284,6 +284,11 @@ static struct pending_req *send_method_call(DBusConnection *connection,
 
 	va_end(args);
 
+	if (!cb) {
+		g_dbus_send_message(connection, msg);
+		return 0;
+	}
+
 	if (!dbus_connection_send_with_reply(connection, msg, &call, -1)) {
 		error("Sending %s failed", method);
 		dbus_message_unref(msg);
@@ -312,6 +317,11 @@ void session_unref(struct session_data *session)
 	if (ret == FALSE)
 		return;
 
+	send_method_call(session->conn_system,
+				BT_BUS_NAME, session->adapter,
+				BT_ADAPTER_IFACE, "ReleaseSession",
+				NULL, NULL,
+				DBUS_TYPE_INVALID);
 	session_free(session);
 }
 
-- 
1.7.4.1

