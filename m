Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/7] convert error to btd_error_not_connected()
Date: Wed,  8 Dec 2010 18:25:59 -0200
Message-Id: <1291839961-14940-5-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1291839961-14940-4-git-send-email-padovan@profusion.mobi>
References: <1291839961-14940-1-git-send-email-padovan@profusion.mobi>
 <1291839961-14940-2-git-send-email-padovan@profusion.mobi>
 <1291839961-14940-3-git-send-email-padovan@profusion.mobi>
 <1291839961-14940-4-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 network/connection.c |    8 +-------
 serial/port.c        |    2 +-
 src/device.c         |    4 +---
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/network/connection.c b/network/connection.c
index 37a7511..d24d96c 100644
--- a/network/connection.c
+++ b/network/connection.c
@@ -123,12 +123,6 @@ static inline DBusMessage *already_connected(DBusMessage *msg)
 						"Device already connected");
 }
 
-static inline DBusMessage *not_connected(DBusMessage *msg)
-{
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-						"Device not connected");
-}
-
 static inline DBusMessage *not_permited(DBusMessage *msg)
 {
 	return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
@@ -460,7 +454,7 @@ static DBusMessage *connection_disconnect(DBusConnection *conn,
 		return connection_cancel(conn, msg, nc);
 	}
 
-	return not_connected(msg);
+	return btd_error_not_connected(msg);
 }
 
 static DBusMessage *connection_get_properties(DBusConnection *conn,
diff --git a/serial/port.c b/serial/port.c
index 1d0bfc1..0d1e600 100644
--- a/serial/port.c
+++ b/serial/port.c
@@ -533,7 +533,7 @@ static DBusMessage *port_disconnect(DBusConnection *conn,
 		return btd_error_does_not_exist(msg);
 
 	if (!port->listener_id)
-		return failed(msg, "Not connected");
+		return btd_error_not_connected(msg);
 
 	owner = dbus_message_get_sender(port->msg);
 	caller = dbus_message_get_sender(msg);
diff --git a/src/device.c b/src/device.c
index cc8131b..91b9d23 100644
--- a/src/device.c
+++ b/src/device.c
@@ -799,9 +799,7 @@ static DBusMessage *disconnect(DBusConnection *conn, DBusMessage *msg,
 	struct btd_device *device = user_data;
 
 	if (!device->handle)
-		return g_dbus_create_error(msg,
-				ERROR_INTERFACE ".NotConnected",
-				"Device is not connected");
+		return btd_error_not_connected(msg);
 
 	device_request_disconnect(device, msg);
 
-- 
1.7.3.2

