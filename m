Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [RFC 3/4] device: Add support for LEAddressType property
Date: Mon, 11 Dec 2017 11:38:36 +0100
Message-Id: <20171211103837.25150-3-szymon.janc@codecoup.pl>
In-Reply-To: <20171211103837.25150-1-szymon.janc@codecoup.pl>
References: <20171211103837.25150-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/src/device.c b/src/device.c
index 9f9c47807..02c97bdc6 100644
--- a/src/device.c
+++ b/src/device.c
@@ -727,6 +727,30 @@ static gboolean dev_property_get_address(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean property_exists_address_type(const GDBusPropertyTable *property,
+							void *user_data)
+{
+	struct btd_device *device = user_data;
+
+	return device->le ? TRUE : FALSE;
+}
+
+static gboolean property_get_address_type(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	struct btd_device *device = user_data;
+	const char *str;
+
+	if (device->bdaddr_type == BDADDR_LE_PUBLIC)
+		str = "public";
+	else
+		str = "static";
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &str);
+
+	return TRUE;
+}
+
 static gboolean dev_property_get_name(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -2607,6 +2631,8 @@ static const GDBusMethodTable device_methods[] = {
 
 static const GDBusPropertyTable device_properties[] = {
 	{ "Address", "s", dev_property_get_address },
+	{ "LEAddressType", "s", property_get_address_type, NULL,
+						property_exists_address_type },
 	{ "Name", "s", dev_property_get_name, NULL, dev_property_exists_name },
 	{ "Alias", "s", dev_property_get_alias, dev_property_set_alias },
 	{ "Class", "u", dev_property_get_class, NULL,
@@ -3850,6 +3876,8 @@ void device_update_addr(struct btd_device *device, const bdaddr_t *bdaddr,
 
 	g_dbus_emit_property_changed(dbus_conn, device->path,
 						DEVICE_INTERFACE, "Address");
+	g_dbus_emit_property_changed(dbus_conn, device->path,
+					DEVICE_INTERFACE, "LEAddressType");
 }
 
 void device_set_bredr_support(struct btd_device *device)
-- 
2.14.3

