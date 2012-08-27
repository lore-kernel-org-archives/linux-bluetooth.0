Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: [RFC BlueZ 09/22] alert: Add initial support for RegisterAlert D-Bus method
Date: Mon, 27 Aug 2012 13:11:53 -0400
Message-Id: <1346087526-15107-10-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1346087526-15107-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1346087526-15107-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eder Ruiz Maria <eder.ruiz@openbossa.org>

---
 profiles/alert/server.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index 419c7fd..78c3e39 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -26,6 +26,8 @@
 #include <config.h>
 #endif
 
+#include <errno.h>
+#include <gdbus.h>
 #include <glib.h>
 #include <bluetooth/uuid.h>
 
@@ -39,6 +41,7 @@
 #include "attrib-server.h"
 #include "gatt.h"
 #include "server.h"
+#include "error.h"
 
 #define PHONE_ALERT_STATUS_SVC_UUID		0x180E
 #define ALERT_NOTIF_SVC_UUID			0x1811
@@ -53,6 +56,9 @@
 #define SUPP_NEW_ALERT_CAT_CHR_UUID	0x2A47
 #define SUPP_UNREAD_ALERT_CAT_CHR_UUID	0x2A48
 
+#define ALERT_OBJECT_PATH "/org/bluez"
+#define ALERT_INTERFACE   "org.bluez.Alert"
+
 enum {
 	ENABLE_NEW_INCOMING,
 	ENABLE_UNREAD_CAT,
@@ -68,9 +74,24 @@ enum {
 	RINGER_NORMAL,
 };
 
+static DBusConnection *connection = NULL;
 static uint8_t ringer_setting = RINGER_NORMAL;
 static uint8_t alert_status = 0;
 
+static DBusMessage *register_alert(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	const char *category;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &category,
+							DBUS_TYPE_INVALID))
+		return btd_error_invalid_args(msg);
+
+	DBG("RegisterAlert: %s", category);
+
+	return dbus_message_new_method_return(msg);
+}
+
 static uint8_t ringer_cp_write(struct attribute *a,
 						struct btd_device *device,
 						gpointer user_data)
@@ -252,8 +273,29 @@ struct btd_adapter_driver alert_server_driver = {
 	.remove = alert_server_remove,
 };
 
+static const GDBusMethodTable alert_methods[] = {
+	{ GDBUS_METHOD("RegisterAlert",
+			GDBUS_ARGS({ "category", "s" },
+				   { "agent", "o" }), NULL,
+			register_alert) },
+	{ }
+};
+
 int alert_server_init(void)
 {
+	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+	if (connection == NULL)
+		return -EIO;
+
+	if (!g_dbus_register_interface(connection, ALERT_OBJECT_PATH,
+						ALERT_INTERFACE, alert_methods,
+						NULL, NULL, NULL, NULL)) {
+
+		error("D-Bus failed to register %s interface",
+							ALERT_INTERFACE);
+		return -EIO;
+	}
+
 	btd_register_adapter_driver(&alert_server_driver);
 
 	return 0;
@@ -262,4 +304,7 @@ int alert_server_init(void)
 void alert_server_exit(void)
 {
 	btd_unregister_adapter_driver(&alert_server_driver);
+
+	dbus_connection_unref(connection);
+	connection = NULL;
 }
-- 
1.7.9.5

