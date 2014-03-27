Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v0 1/5] gatt: Add parsing GattCharacteristic1 Flags
Date: Thu, 27 Mar 2014 10:21:11 -0300
Message-Id: <1395926475-8841-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395926475-8841-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395926475-8841-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When fetching the external application characteristics, "Flags" field
representing the characteristic supported properties should be properly
translated to a bitmask value required to create the characteristic
declarations. Ref Core SPEC page 2183, Table 3.5: Characteristic
Properties bit field.
---
 src/gatt-dbus.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 69 insertions(+), 6 deletions(-)

diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index 95d1243..4eaf562 100644
--- a/src/gatt-dbus.c
+++ b/src/gatt-dbus.c
@@ -39,6 +39,9 @@
 #include "log.h"
 
 #include "error.h"
+#include "attrib/gattrib.h"
+#include "attrib/att.h"
+#include "attrib/gatt.h"
 #include "gatt.h"
 #include "gatt-dbus.h"
 
@@ -104,6 +107,64 @@ static int proxy_path_cmp(gconstpointer a, gconstpointer b)
 	return g_strcmp0(path1, path2);
 }
 
+static uint8_t flags_string2int(const char *proper)
+{
+	uint8_t value;
+
+	/* Regular Properties: See core spec 4.1 page 2183 */
+	if (!strcmp("broadcast", proper))
+		value = GATT_CHR_PROP_BROADCAST;
+	else if (!strcmp("read", proper))
+		value = GATT_CHR_PROP_READ;
+	else if (!strcmp("write-without-response", proper))
+		value = GATT_CHR_PROP_WRITE_WITHOUT_RESP;
+	else if (!strcmp("write", proper))
+		value = GATT_CHR_PROP_WRITE;
+	else if (!strcmp("notify", proper))
+		value = GATT_CHR_PROP_NOTIFY;
+	else if (!strcmp("indicate", proper))
+		value = GATT_CHR_PROP_INDICATE;
+	else if (!strcmp("authenticated-signed-writes", proper))
+		value = GATT_CHR_PROP_AUTH;
+	else
+		value = 0;
+
+	/* TODO: Extended properties. Ref core spec 4.1 page 2185  */
+
+	return value;
+}
+
+static uint8_t flags_get_bitmask(DBusMessageIter *iter)
+{
+	DBusMessageIter istr;
+	uint8_t propmask = 0, prop;
+	const char *str;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
+		goto fail;
+
+	dbus_message_iter_recurse(iter, &istr);
+
+	do {
+		if (dbus_message_iter_get_arg_type(&istr) != DBUS_TYPE_STRING)
+			goto fail;
+
+		dbus_message_iter_get_basic(&istr, &str);
+		prop = flags_string2int(str);
+		if (!prop)
+			goto fail;
+
+		propmask |= prop;
+	} while (dbus_message_iter_next(&istr));
+
+	return propmask;
+
+fail:
+	error("Characteristic Flags: Invalid argument!");
+
+	return 0;
+}
+
 static void proxy_added(GDBusProxy *proxy, void *user_data)
 {
 	struct external_app *eapp = user_data;
@@ -303,6 +364,7 @@ static int register_external_characteristics(GSList *proxies)
 		bt_uuid_t uuid;
 		struct btd_attribute *attr;
 		GDBusProxy *proxy = list->data;
+		uint8_t propmask = 0;
 
 		if (!g_dbus_proxy_get_property(proxy, "UUID", &iter))
 			return -EINVAL;
@@ -315,13 +377,14 @@ static int register_external_characteristics(GSList *proxies)
 		if (bt_string_to_uuid(&uuid, str) < 0)
 			return -EINVAL;
 
-		/*
-		 * TODO: Missing Flags/property
-		 * Add properties according to Core SPEC 4.1 page 2183.
-		 * Reference table 3.5: Characteristic Properties bit field.
-		 */
+		if (!g_dbus_proxy_get_property(proxy, "Flags", &iter))
+			return -EINVAL;
+
+		propmask = flags_get_bitmask(&iter);
+		if (!propmask)
+			return -EINVAL;
 
-		attr = btd_gatt_add_char(&uuid, 0x00, proxy_read_cb,
+		attr = btd_gatt_add_char(&uuid, propmask, proxy_read_cb,
 							proxy_write_cb);
 		if (!attr)
 			return -EINVAL;
-- 
1.8.3.1

