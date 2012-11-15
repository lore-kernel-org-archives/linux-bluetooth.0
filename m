Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/8] device: Retrieve class from storage
Date: Thu, 15 Nov 2012 18:31:37 +0100
Message-Id: <1353000701-16605-4-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1353000701-16605-1-git-send-email-frederic.danis@linux.intel.com>
References: <1353000701-16605-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When device class is updated, save it and emit property changed signal.
---
 src/device.c |   60 ++++++++++++++++++++++++++++++++++++++--------------------
 src/device.h |    1 +
 2 files changed, 41 insertions(+), 20 deletions(-)

diff --git a/src/device.c b/src/device.c
index 5969f15..d4d649b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -149,6 +149,7 @@ struct btd_device {
 	GSList		*eir_uuids;
 	char		name[MAX_NAME_LENGTH + 1];
 	char		*alias;
+	uint32_t	class;
 	uint16_t	vendor_src;
 	uint16_t	vendor;
 	uint16_t	product;
@@ -211,6 +212,7 @@ static gboolean store_device_info_cb(gpointer user_data)
 	char adapter_addr[18];
 	char device_addr[18];
 	char *str;
+	char class[9];
 	gsize length = 0;
 
 	device->store_id = 0;
@@ -223,6 +225,11 @@ static gboolean store_device_info_cb(gpointer user_data)
 		g_key_file_set_string(key_file, "General", "Alias",
 								device->alias);
 
+	if (device->class) {
+		sprintf(class, "0x%6.6x", device->class);
+		g_key_file_set_string(key_file, "General", "Class", class);
+	}
+
 	g_key_file_set_boolean(key_file, "General", "Trusted",
 							device->trusted);
 
@@ -470,35 +477,23 @@ static void dev_property_set_alias(const GDBusPropertyTable *property,
 	set_alias(id, alias, data);
 }
 
-static gboolean get_class(const GDBusPropertyTable *property, void *data,
-							uint32_t *class)
-{
-	struct btd_device *device = data;
-
-	if (read_remote_class(adapter_get_address(device->adapter),
-						&device->bdaddr, class) == 0)
-		return TRUE;
-
-	return FALSE;
-}
-
 static gboolean dev_property_exists_class(const GDBusPropertyTable *property,
 								void *data)
 {
-	uint32_t class;
+	struct btd_device *device = data;
 
-	return get_class(property, data, &class);
+	return device->class != 0;
 }
 
 static gboolean dev_property_get_class(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
-	uint32_t class;
+	struct btd_device *device = data;
 
-	if (!get_class(property, data, &class))
+	if (device->class == 0)
 		return FALSE;
 
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32, &class);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32, &device->class);
 
 	return TRUE;
 }
@@ -542,12 +537,12 @@ static gboolean dev_property_get_appearance(const GDBusPropertyTable *property,
 
 static const char *get_icon(const GDBusPropertyTable *property, void *data)
 {
+	struct btd_device *device = data;
 	const char *icon = NULL;
-	uint32_t class;
 	uint16_t appearance;
 
-	if (get_class(property, data, &class))
-		icon = class_to_icon(class);
+	if (device->class != 0)
+		icon = class_to_icon(device->class);
 	else if (get_appearance(property, data, &appearance))
 		icon = gap_appearance_to_icon(appearance);
 
@@ -1745,6 +1740,16 @@ static void load_info(struct btd_device *device, const gchar *local,
 	device->alias = g_key_file_get_string(key_file, "General", "Alias",
 									NULL);
 
+	/* Load class */
+	str = g_key_file_get_string(key_file, "General", "Class", NULL);
+	if (str) {
+		uint32_t class;
+
+		if (sscanf(str, "%x", &class) == 1)
+			device->class = class;
+		g_free(str);
+	}
+
 	/* Load trust */
 	device->trusted = g_key_file_get_boolean(key_file, "General",
 							"Trusted", NULL);
@@ -1849,6 +1854,21 @@ bool device_name_known(struct btd_device *device)
 	return device->name[0] != '\0';
 }
 
+void device_set_class(struct btd_device *device, uint32_t class)
+{
+	if (device->class == class)
+		return;
+
+	DBG("%s 0x%06X", device->path, class);
+
+	device->class = class;
+
+	store_device_info(device);
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), device->path,
+						DEVICE_INTERFACE, "Class");
+}
+
 uint16_t btd_device_get_vendor(struct btd_device *device)
 {
 	return device->vendor;
diff --git a/src/device.h b/src/device.h
index ea646a8..3715698 100644
--- a/src/device.h
+++ b/src/device.h
@@ -32,6 +32,7 @@ struct btd_device *device_create(struct btd_adapter *adapter,
 void device_set_name(struct btd_device *device, const char *name);
 void device_get_name(struct btd_device *device, char *name, size_t len);
 bool device_name_known(struct btd_device *device);
+void device_set_class(struct btd_device *device, uint32_t class);
 uint16_t btd_device_get_vendor(struct btd_device *device);
 uint16_t btd_device_get_vendor_src(struct btd_device *device);
 uint16_t btd_device_get_product(struct btd_device *device);
-- 
1.7.9.5

