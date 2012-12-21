Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 11/25] adapter: Add D-Bus API for Observer GAP Role
Date: Fri, 21 Dec 2012 16:26:38 -0400
Message-Id: <1356121612-15172-12-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
References: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

Implement dummy calls for register or unregister Observer Agents.
---
 src/adapter.c      |   38 ++++++++++++++++++++++++++++++++++++++
 src/bluetooth.conf |    1 +
 2 files changed, 39 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index d741ae1..34dad6e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1154,6 +1154,30 @@ static DBusMessage *remove_device(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
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
+static DBusMessage *register_manuf_observer(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *unregister_manuf_observer(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	return dbus_message_new_method_return(msg);
+}
+
 void adapter_set_controller_data_failed(struct btd_adapter *adapter)
 {
 }
@@ -1166,6 +1190,20 @@ static const GDBusMethodTable adapter_methods[] = {
 	{ GDBUS_ASYNC_METHOD("RemoveDevice",
 			GDBUS_ARGS({ "device", "o" }), NULL,
 			remove_device) },
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
+			register_manuf_observer) },
+	{ GDBUS_METHOD("UnregisterManufacturerObserver",
+			GDBUS_ARGS({ "observer", "o" }), NULL,
+			unregister_manuf_observer) },
 	{ }
 };
 
diff --git a/src/bluetooth.conf b/src/bluetooth.conf
index 0495200..e8176ed 100644
--- a/src/bluetooth.conf
+++ b/src/bluetooth.conf
@@ -15,6 +15,7 @@
     <allow send_interface="org.bluez.MediaPlayer1"/>
     <allow send_interface="org.bluez.ThermometerWatcher1"/>
     <allow send_interface="org.bluez.AlertAgent1"/>
+    <allow send_interface="org.bluez.Observer1"/>
     <allow send_interface="org.bluez.Profile1"/>
     <allow send_interface="org.bluez.HeartRateWatcher1"/>
     <allow send_interface="org.bluez.CyclingSpeedWatcher1"/>
-- 
1.7.9.5

