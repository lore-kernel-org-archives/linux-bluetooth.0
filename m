Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 2/3] gdbus: Fix incorrect DBusConnection reference counting
Date: Mon, 10 Feb 2014 13:14:57 -0400
Message-Id: <1392052498-9229-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1392052498-9229-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1392052498-9229-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Commit abfc2b0dd5c3e33abfdf1a815b16d492c1751c06 attempted to fix a crash
related to improper reference counting, but the main issue was that the
reference was taken only during the function call (which is usually
unnecessary for single thread), but still passed a pointer to
DBusConnection to a function that is called by the mainloop. This left a
window where the DBusConnection can be destroyed.
---
 gdbus/mainloop.c |   14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/gdbus/mainloop.c b/gdbus/mainloop.c
index 099b67f..ec52554 100644
--- a/gdbus/mainloop.c
+++ b/gdbus/mainloop.c
@@ -70,8 +70,6 @@ static gboolean message_dispatch(void *data)
 {
 	DBusConnection *conn = data;
 
-	dbus_connection_ref(conn);
-
 	/* Dispatch messages */
 	while (dbus_connection_dispatch(conn) == DBUS_DISPATCH_DATA_REMAINS);
 
@@ -84,7 +82,8 @@ static inline void queue_dispatch(DBusConnection *conn,
 						DBusDispatchStatus status)
 {
 	if (status == DBUS_DISPATCH_DATA_REMAINS)
-		g_timeout_add(DISPATCH_TIMEOUT, message_dispatch, conn);
+		g_timeout_add(DISPATCH_TIMEOUT, message_dispatch,
+						dbus_connection_ref(conn));
 }
 
 static gboolean watch_func(GIOChannel *chan, GIOCondition cond, gpointer data)
@@ -92,9 +91,6 @@ static gboolean watch_func(GIOChannel *chan, GIOCondition cond, gpointer data)
 	struct watch_info *info = data;
 	unsigned int flags = 0;
 	DBusDispatchStatus status;
-	DBusConnection *conn;
-
-	conn = dbus_connection_ref(info->conn);
 
 	if (cond & G_IO_IN)  flags |= DBUS_WATCH_READABLE;
 	if (cond & G_IO_OUT) flags |= DBUS_WATCH_WRITABLE;
@@ -103,10 +99,8 @@ static gboolean watch_func(GIOChannel *chan, GIOCondition cond, gpointer data)
 
 	dbus_watch_handle(info->watch, flags);
 
-	status = dbus_connection_get_dispatch_status(conn);
-	queue_dispatch(conn, status);
-
-	dbus_connection_unref(conn);
+	status = dbus_connection_get_dispatch_status(info->conn);
+	queue_dispatch(info->conn, status);
 
 	return TRUE;
 }
-- 
1.7.9.5

