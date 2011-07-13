Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH obexd v3 2/2] Add adapter ReleaseSession to obex-client
Date: Wed, 13 Jul 2011 12:43:46 +0300
Message-Id: <1310550226-9656-3-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1310550226-9656-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1310550226-9656-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Release of adapter session is added to obex-client when closing OBEX
transfer.
---
 client/session.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/client/session.c b/client/session.c
index a84b74e..36475d6 100644
--- a/client/session.c
+++ b/client/session.c
@@ -285,6 +285,11 @@ static struct pending_req *send_method_call(DBusConnection *connection,
 
 	va_end(args);
 
+	if (!cb) {
+		g_dbus_send_message(connection, msg);
+		return 0;
+	}
+
 	if (!dbus_connection_send_with_reply(connection, msg, &call, -1)) {
 		error("Sending %s failed", method);
 		dbus_message_unref(msg);
@@ -313,6 +318,11 @@ void session_unref(struct session_data *session)
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

