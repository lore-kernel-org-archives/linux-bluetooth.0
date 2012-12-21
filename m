Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 3/4] obexd: Simplify org.bluez.Error.InvalidArguments handling
Date: Fri, 21 Dec 2012 12:25:02 -0400
Message-Id: <1356107103-18039-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1356107103-18039-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1356107103-18039-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use a helper function to void code duplication.
---
 obexd/plugins/bluetooth.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/obexd/plugins/bluetooth.c b/obexd/plugins/bluetooth.c
index 8985c83..e28a94f 100644
--- a/obexd/plugins/bluetooth.c
+++ b/obexd/plugins/bluetooth.c
@@ -104,6 +104,12 @@ drop:
 	return;
 }
 
+static DBusMessage *invalid_args(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg, "org.bluez.Error.InvalidArguments",
+					"Invalid arguments in method call");
+}
+
 static DBusMessage *profile_new_connection(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
@@ -115,26 +121,20 @@ static DBusMessage *profile_new_connection(DBusConnection *conn,
 	dbus_message_iter_init(msg, &args);
 
 	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_OBJECT_PATH)
-		return g_dbus_create_error(msg,
-					"org.bluez.Error.InvalidArguments",
-					"Invalid arguments in method call");
+		return invalid_args(msg);
 
 	dbus_message_iter_get_basic(&args, &device);
 
 	dbus_message_iter_next(&args);
 
 	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_UNIX_FD)
-		return g_dbus_create_error(msg,
-					"org.bluez.Error.InvalidArguments",
-					"Invalid arguments in method call");
+		return invalid_args(msg);
 
 	dbus_message_iter_get_basic(&args, &fd);
 
 	io = g_io_channel_unix_new(fd);
 	if (io == NULL)
-		return g_dbus_create_error(msg,
-					"org.bluez.Error.InvalidArguments",
-					"Invalid arguments in method call");
+		return invalid_args(msg);
 
 	DBG("device %s", device);
 
-- 
1.7.9.5

