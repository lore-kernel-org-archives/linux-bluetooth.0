Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 2/2] gdbus: Fix using NULL DBusPendingCall when disconnected from D-Bus
Date: Sat,  4 May 2013 15:39:43 -0400
Message-Id: <1367696383-14831-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1367696383-14831-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1367696383-14831-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From D-Bus documentation for dbus_connection_send_with_reply():

"Warning: if the connection is disconnected or you try to send Unix file
descriptors on a connection that does not support them, the
DBusPendingCall will be set to NULL, so be careful with this."

Fix these errors when killing D-Bus daemon with the client still
running:

process 5712: arguments to dbus_pending_call_set_notify() were
incorrect, assertion "pending != NULL" failed in file
../../dbus/dbus-pending-call.c line 596.
This is normally a bug in some application using the D-Bus library.
process 5712: arguments to dbus_pending_call_unref() were incorrect,
assertion "pending != NULL" failed in file
../../dbus/dbus-pending-call.c line 572.
This is normally a bug in some application using the D-Bus library.
---
 gdbus/client.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/gdbus/client.c b/gdbus/client.c
index a21b66a..f700b7e 100644
--- a/gdbus/client.c
+++ b/gdbus/client.c
@@ -105,6 +105,11 @@ static gboolean modify_match(DBusConnection *conn, const char *member,
 		return FALSE;
 	}
 
+	if (call == NULL) {
+		dbus_message_unref(msg);
+		return FALSE;
+	}
+
 	dbus_pending_call_set_notify(call, modify_match_reply, NULL, NULL);
 	dbus_pending_call_unref(call);
 
-- 
1.7.9.5

