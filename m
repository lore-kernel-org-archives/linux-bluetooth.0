Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org,
	Alvaro Silva <alvaro.silva@openbossa.org>
Subject: [PATCH BlueZ v8 7/8] tools: Add setting Value property of gatt-service
Date: Mon, 24 Mar 2014 10:30:08 -0300
Message-Id: <1395667809-17602-8-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395667809-17602-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395429403-493-1-git-send-email-claudio.takahasi@openbossa.org>
 <1395667809-17602-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alvaro Silva <alvaro.silva@openbossa.org>

This patch extends the gatt-service.c example adding a generic callback
to allow set the characteristic Value. It doesn't check for
characteristic properties yet.
---
 tools/gatt-service.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/tools/gatt-service.c b/tools/gatt-service.c
index a5a64b5..6ccaeb5 100644
--- a/tools/gatt-service.c
+++ b/tools/gatt-service.c
@@ -35,6 +35,8 @@
 #include <dbus/dbus.h>
 #include <gdbus/gdbus.h>
 
+#include "src/error.h"
+
 #define GATT_MGR_IFACE			"org.bluez.GattManager1"
 #define GATT_SERVICE_IFACE		"org.bluez.GattService1"
 #define GATT_CHR_IFACE			"org.bluez.GattCharacteristic1"
@@ -81,9 +83,38 @@ static gboolean chr_get_value(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static void chr_set_value(const GDBusPropertyTable *property,
+				DBusMessageIter *iter,
+				GDBusPendingPropertySet id, void *user_data)
+{
+	struct characteristic *chr = user_data;
+	DBusMessageIter array;
+	uint8_t *value;
+	int len;
+
+	printf("Set('Value', ...)\n");
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY) {
+		printf("Invalid value for Set('Value'...)\n");
+		g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
+		return;
+	}
+
+	dbus_message_iter_recurse(iter, &array);
+	dbus_message_iter_get_fixed_array(&array, &value, &len);
+
+	g_free(chr->value);
+	chr->value = g_memdup(value, len);
+	chr->vlen = len;
+
+	g_dbus_pending_property_success(id);
+}
+
 static const GDBusPropertyTable chr_properties[] = {
 	{ "UUID",	"s",	chr_get_uuid },
-	{ "Value", "ay", chr_get_value, NULL, NULL },
+	{ "Value", "ay", chr_get_value, chr_set_value, NULL },
 	{ }
 };
 
-- 
1.8.3.1

