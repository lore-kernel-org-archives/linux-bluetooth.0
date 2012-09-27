Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH v2 BlueZ 08/27] alert: Initial Alert Notification
Date: Thu, 27 Sep 2012 14:36:17 -0400
Message-Id: <1348770996-12236-9-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1348770996-12236-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1348509661-15967-1-git-send-email-anderson.lizardo@openbossa.org>
 <1348770996-12236-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Initial implementation for Alert Notification Profile (ANP).
---
 profiles/alert/server.c |  154 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index 90536d5..c0434a4 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -27,9 +27,12 @@
 #endif
 
 #include <stdbool.h>
+#include <errno.h>
+#include <gdbus.h>
 #include <glib.h>
 #include <bluetooth/uuid.h>
 
+#include "dbus-common.h"
 #include "att.h"
 #include "adapter.h"
 #include "device.h"
@@ -41,13 +44,33 @@
 #include "gatt.h"
 #include "server.h"
 #include "profile.h"
+#include "error.h"
 
 #define PHONE_ALERT_STATUS_SVC_UUID		0x180E
+#define ALERT_NOTIF_SVC_UUID			0x1811
 
 #define ALERT_STATUS_CHR_UUID		0x2A3F
 #define RINGER_CP_CHR_UUID		0x2A40
 #define RINGER_SETTING_CHR_UUID		0x2A41
 
+#define ALERT_NOTIF_CP_CHR_UUID		0x2A44
+#define UNREAD_ALERT_CHR_UUID		0x2A45
+#define NEW_ALERT_CHR_UUID		0x2A46
+#define SUPP_NEW_ALERT_CAT_CHR_UUID	0x2A47
+#define SUPP_UNREAD_ALERT_CAT_CHR_UUID	0x2A48
+
+#define ALERT_OBJECT_PATH "/org/bluez"
+#define ALERT_INTERFACE   "org.bluez.Alert"
+
+enum {
+	ENABLE_NEW_INCOMING,
+	ENABLE_UNREAD_CAT,
+	DISABLE_NEW_INCOMING,
+	DISABLE_UNREAD_CAT,
+	NOTIFY_NEW_INCOMING,
+	NOTIFY_UNREAD_CAT,
+};
+
 /* Ringer Setting characteristic values */
 enum {
 	RINGER_SILENT,
@@ -57,6 +80,20 @@ enum {
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
@@ -124,10 +161,107 @@ static void register_phone_alert_service(struct btd_adapter *adapter)
 			GATT_OPT_INVALID);
 }
 
+static uint8_t supp_new_alert_cat_read(struct attribute *a,
+						struct btd_device *device,
+						gpointer user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	uint8_t value[] = {0x00, 0x00};
+
+	DBG("a = %p", a);
+
+	if (a->data == NULL)
+		attrib_db_update(adapter, a->handle, NULL, value, sizeof(value),
+									NULL);
+
+	return 0;
+}
+
+static uint8_t supp_unread_alert_cat_read(struct attribute *a,
+						struct btd_device *device,
+						gpointer user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	uint8_t value[] = {0x00, 0x00};
+
+	DBG("a = %p", a);
+
+	if (a->data == NULL)
+		attrib_db_update(adapter, a->handle, NULL, value, sizeof(value),
+									NULL);
+
+	return 0;
+}
+
+static uint8_t alert_notif_cp_write(struct attribute *a,
+						struct btd_device *device,
+						gpointer user_data)
+{
+	DBG("a = %p", a);
+
+	switch (a->data[0]) {
+	case ENABLE_NEW_INCOMING:
+		DBG("ENABLE_NEW_INCOMING: 0x%02x", a->data[1]);
+		break;
+	case ENABLE_UNREAD_CAT:
+		DBG("ENABLE_UNREAD_CAT: 0x%02x", a->data[1]);
+		break;
+	case DISABLE_NEW_INCOMING:
+		DBG("DISABLE_NEW_INCOMING: 0x%02x", a->data[1]);
+		break;
+	case DISABLE_UNREAD_CAT:
+		DBG("DISABLE_UNREAD_CAT: 0x%02x", a->data[1]);
+		break;
+	case NOTIFY_NEW_INCOMING:
+		DBG("NOTIFY_NEW_INCOMING: 0x%02x", a->data[1]);
+		break;
+	case NOTIFY_UNREAD_CAT:
+		DBG("NOTIFY_UNREAD_CAT: 0x%02x", a->data[1]);
+		break;
+	default:
+		DBG("0x%02x 0x%02x", a->data[0], a->data[1]);
+	}
+
+	return 0;
+}
+
+static void register_alert_notif_service(struct btd_adapter *adapter)
+{
+	bt_uuid_t uuid;
+
+	bt_uuid16_create(&uuid, ALERT_NOTIF_SVC_UUID);
+
+	/* Alert Notification Service */
+	gatt_service_add(adapter, GATT_PRIM_SVC_UUID, &uuid,
+			/* Supported New Alert Category */
+			GATT_OPT_CHR_UUID, SUPP_NEW_ALERT_CAT_CHR_UUID,
+			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ,
+			GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
+			supp_new_alert_cat_read, adapter,
+			/* New Alert */
+			GATT_OPT_CHR_UUID, NEW_ALERT_CHR_UUID,
+			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_NOTIFY,
+			/* Supported Unread Alert Category */
+			GATT_OPT_CHR_UUID, SUPP_UNREAD_ALERT_CAT_CHR_UUID,
+			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ,
+			GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
+			supp_unread_alert_cat_read, adapter,
+			/* Unread Alert Status */
+			GATT_OPT_CHR_UUID, UNREAD_ALERT_CHR_UUID,
+			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_NOTIFY,
+			/* Alert Notification Control Point */
+			GATT_OPT_CHR_UUID, ALERT_NOTIF_CP_CHR_UUID,
+			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_WRITE,
+			GATT_OPT_CHR_VALUE_CB, ATTRIB_WRITE,
+			alert_notif_cp_write, NULL,
+			GATT_OPT_INVALID);
+}
+
 static int alert_server_probe(struct btd_profile *p,
 						struct btd_adapter *adapter)
 {
 	register_phone_alert_service(adapter);
+	register_alert_notif_service(adapter);
 
 	return 0;
 }
@@ -143,8 +277,25 @@ static struct btd_profile alert_profile = {
 	.adapter_remove = alert_server_remove,
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
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+					ALERT_OBJECT_PATH, ALERT_INTERFACE,
+					alert_methods, NULL, NULL, NULL,
+					NULL)) {
+		error("D-Bus failed to register %s interface",
+							ALERT_INTERFACE);
+		return -EIO;
+	}
+
 	btd_profile_register(&alert_profile);
 
 	return 0;
@@ -153,4 +304,7 @@ int alert_server_init(void)
 void alert_server_exit(void)
 {
 	btd_profile_unregister(&alert_profile);
+
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+					ALERT_OBJECT_PATH, ALERT_INTERFACE);
 }
-- 
1.7.9.5

