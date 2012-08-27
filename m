Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [RFC BlueZ 25/33] adapter: Add D-Bus API for Broadcaster GAP Role
Date: Mon, 27 Aug 2012 13:03:17 -0400
Message-Id: <1346087005-24693-26-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
References: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

Implement dummy calls for register or unregister Broadcaster.
---
 src/adapter.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index cd0a1b4..61abb34 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1869,6 +1869,24 @@ static DBusMessage *unregister_manufobserver(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
+static DBusMessage *set_service_data(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *set_manufacturer_data(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *clear_broadcast_data(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	return dbus_message_new_method_return(msg);
+}
+
 static const GDBusMethodTable adapter_methods[] = {
 	{ GDBUS_METHOD("GetProperties",
 			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
@@ -1924,6 +1942,14 @@ static const GDBusMethodTable adapter_methods[] = {
 	{ GDBUS_METHOD("UnregisterManufacturerObserver",
 			GDBUS_ARGS({ "observer", "o" }), NULL,
 			unregister_manufobserver) },
+	{ GDBUS_METHOD("SetServiceData", GDBUS_ARGS({ "uuid", "q" },
+					{ "data", "ay" }), NULL,
+			set_service_data) },
+	{ GDBUS_METHOD("SetManufacturerData", GDBUS_ARGS({ "company_id", "q" },
+					{ "data", "ay" }), NULL,
+			set_manufacturer_data) },
+	{ GDBUS_METHOD("ClearBroadcastData", NULL, NULL,
+			clear_broadcast_data) },
 	{ }
 };
 
-- 
1.7.9.5

