Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 20/25] broadcaster: Add SetService/ManufacturerData() D-Bus method
Date: Fri, 21 Dec 2012 16:26:47 -0400
Message-Id: <1356121612-15172-21-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
References: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

For SetServiceData(), receive the service UUID with advertising data
that will be set in device.

For SetManufacturerData(), receive the Company Identifier Code with
advertising data that will be set in device.
---
 src/adapter.c |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 90aab94..60c0697 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1416,12 +1416,46 @@ void adapter_set_controller_data_failed(struct btd_adapter *adapter)
 static DBusMessage *set_service_data(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
+	struct btd_adapter *adapter = data;
+	const char *sender;
+	uint16_t uuid;
+	uint8_t *sdata;
+	int ssize;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_UINT16, &uuid,
+						DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE,
+						&sdata, &ssize,
+						DBUS_TYPE_INVALID))
+		return btd_error_invalid_args(msg);
+
+	sender = dbus_message_get_sender(msg);
+
+	DBG("Service Data Broadcaster registered for hci%d at %s",
+						adapter->dev_id, sender);
+
 	return dbus_message_new_method_return(msg);
 }
 
 static DBusMessage *set_manufacturer_data(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
+	struct btd_adapter *adapter = data;
+	const char *sender;
+	uint16_t company_id;
+	uint8_t *mdata;
+	int msize;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_UINT16, &company_id,
+						DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE,
+						&mdata, &msize,
+						DBUS_TYPE_INVALID))
+		return btd_error_invalid_args(msg);
+
+	sender = dbus_message_get_sender(msg);
+
+	DBG("Manufacturer Specific Data Broadcaster registered for hci%d at %s",
+						adapter->dev_id, sender);
+
 	return dbus_message_new_method_return(msg);
 }
 
-- 
1.7.9.5

