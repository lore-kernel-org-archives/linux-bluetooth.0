Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [RFC BlueZ 15/33] adapter: Add D-Bus API for Observer GAP Role
Date: Mon, 27 Aug 2012 13:03:07 -0400
Message-Id: <1346087005-24693-16-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
References: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

Implement dummy calls for register or unregister Observer Agents.
---
 src/adapter.c      |   38 ++++++++++++++++++++++++++++++++++++++
 src/bluetooth.conf |    1 +
 2 files changed, 39 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 50779fd..36c285a 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1617,6 +1617,30 @@ static DBusMessage *unregister_agent(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
+static DBusMessage *register_service_observer(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *unregister_service_observer(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *register_manufobserver(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *unregister_manufobserver(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	return dbus_message_new_method_return(msg);
+}
+
 static const GDBusMethodTable adapter_methods[] = {
 	{ GDBUS_METHOD("GetProperties",
 			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
@@ -1658,6 +1682,20 @@ static const GDBusMethodTable adapter_methods[] = {
 	{ GDBUS_METHOD("UnregisterAgent",
 			GDBUS_ARGS({ "agent", "o" }), NULL,
 			unregister_agent) },
+	{ GDBUS_METHOD("RegisterServiceObserver",
+			GDBUS_ARGS({ "observer", "o" }, { "match_value", "q" }),
+			NULL,
+			register_service_observer) },
+	{ GDBUS_METHOD("UnregisterServiceObserver",
+			GDBUS_ARGS({ "observer", "o" }), NULL,
+			unregister_service_observer) },
+	{ GDBUS_METHOD("RegisterManufacturerObserver",
+			GDBUS_ARGS({ "observer", "o" }, { "match_value", "q" }),
+			NULL,
+			register_manufobserver) },
+	{ GDBUS_METHOD("UnregisterManufacturerObserver",
+			GDBUS_ARGS({ "observer", "o" }), NULL,
+			unregister_manufobserver) },
 	{ }
 };
 
diff --git a/src/bluetooth.conf b/src/bluetooth.conf
index 664dbd9..a2fef4f 100644
--- a/src/bluetooth.conf
+++ b/src/bluetooth.conf
@@ -14,6 +14,7 @@
     <allow send_interface="org.bluez.HandsfreeAgent"/>
     <allow send_interface="org.bluez.MediaEndpoint"/>
     <allow send_interface="org.bluez.MediaPlayer"/>
+    <allow send_interface="org.bluez.Observer"/>
     <allow send_interface="org.bluez.Watcher"/>
     <allow send_interface="org.bluez.ThermometerWatcher"/>
   </policy>
-- 
1.7.9.5

