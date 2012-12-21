Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 18/25] adapter: Add D-Bus API for Broadcaster GAP Role
Date: Fri, 21 Dec 2012 16:26:45 -0400
Message-Id: <1356121612-15172-19-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
References: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

Implement dummy calls for register or unregister Broadcaster.
---
 src/adapter.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 4fc4fa9..90aab94 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1413,6 +1413,24 @@ void adapter_set_controller_data_failed(struct btd_adapter *adapter)
 {
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
 	{ GDBUS_METHOD("StartDiscovery", NULL, NULL,
 			adapter_start_discovery) },
@@ -1435,6 +1453,15 @@ static const GDBusMethodTable adapter_methods[] = {
 	{ GDBUS_METHOD("UnregisterManufacturerObserver",
 			GDBUS_ARGS({ "observer", "o" }), NULL,
 			unregister_manuf_observer) },
+	{ GDBUS_ASYNC_METHOD("SetServiceData", GDBUS_ARGS({ "uuid", "q" },
+			{ "data", "ay" }), NULL,
+			set_service_data) },
+	{ GDBUS_ASYNC_METHOD("SetManufacturerData",
+			GDBUS_ARGS({ "company_id", "q" },
+			{ "data", "ay" }), NULL,
+			set_manufacturer_data) },
+	{ GDBUS_METHOD("ClearBroadcastData", NULL, NULL,
+			clear_broadcast_data) },
 	{ }
 };
 
-- 
1.7.9.5

