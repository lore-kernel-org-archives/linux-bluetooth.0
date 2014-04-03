Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] gatt: Add API for creating services
Date: Thu,  3 Apr 2014 11:43:53 +0200
Message-Id: <1396518234-8375-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will allow to construct services, which can be later started
stopped and removed. Function for creating services will reserve
handles for service's attributes. Start service will put service
and attributes to local database. Stop method will remove it,
Remove method will completely remove service and free handles.
---
 src/gatt.c | 38 ++++++++++++++++++++++++++++++++++
 src/gatt.h | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)

diff --git a/src/gatt.c b/src/gatt.c
index bfd083a..7260ffa 100644
--- a/src/gatt.c
+++ b/src/gatt.c
@@ -27,6 +27,7 @@
 
 #include <glib.h>
 
+#include <stdbool.h>
 #include "log.h"
 #include "lib/uuid.h"
 #include "attrib/att.h"
@@ -263,6 +264,43 @@ uint16_t btd_gatt_add_char_desc(const bt_uuid_t *uuid,
 	return attr->handle;
 }
 
+uint16_t btd_gatt_create_service(const bt_uuid_t *uuid, uint16_t num_handles)
+{
+	return 0;
+}
+
+uint16_t btd_gatt_add_char_desc_to_service(uint16_t service_handle,
+						const bt_uuid_t *uuid,
+						btd_attr_read_t read_cb,
+						btd_attr_write_t write_cb)
+{
+	return 0;
+}
+
+uint16_t btd_gatt_add_char_to_service(uint16_t service_handle,
+						const bt_uuid_t *uuid,
+						uint8_t properties,
+						btd_attr_read_t read_cb,
+						btd_attr_write_t write_cb)
+{
+	return 0;
+}
+
+bool btd_gatt_remove_service(uint16_t service_handle)
+{
+	return false;
+}
+
+bool btd_gatt_start_service(uint16_t service_handle)
+{
+	return false;
+}
+
+bool btd_gatt_stop_service(uint16_t service_handle)
+{
+	return false;
+}
+
 void gatt_init(void)
 {
 	DBG("Starting GATT server");
diff --git a/src/gatt.h b/src/gatt.h
index 413492d..a7566cb 100644
--- a/src/gatt.h
+++ b/src/gatt.h
@@ -112,3 +112,73 @@ uint16_t btd_gatt_add_char(const bt_uuid_t *uuid,
 uint16_t btd_gatt_add_char_desc(const bt_uuid_t *uuid,
 						btd_attr_read_t read_cb,
 						btd_attr_write_t write_cb);
+
+/*
+ * btd_gatt_create_service - Start creating service
+ * @uuid:		Service UUID.
+ * @num_handles:	number of handles to reserve for service
+ *
+ * Returns handle of new created service.
+ */
+uint16_t btd_gatt_create_service(const bt_uuid_t *uuid, uint16_t num_handles);
+
+/*
+ * btd_gatt_add_char - Add a characteristic (declaration and value attributes)
+ * to newly created service.
+ * @service-handle:	Service handle
+ * @uuid:		Characteristic UUID (16-bits or 128-bits).
+ * @properties:		Characteristic properties. See Core SPEC 4.1 page 2183.
+ * @read_cb:		Callback used to provide the characteristic value.
+ * @write_cb:		Callback called to notify the implementation that a new value
+ *			is available.
+ *
+ * Returns handle to attribute. In case of error, 0 is returned.
+ */
+uint16_t btd_gatt_add_char_to_service(uint16_t service_handle,
+						const bt_uuid_t *uuid,
+						uint8_t properties,
+						btd_attr_read_t read_cb,
+						btd_attr_write_t write_cb);
+
+/*
+ * btd_gatt_add_char_desc_to _service - Add a characteristic descriptor to
+ * newly created service
+ * @service-handle:	Service handle
+ * @uuid:		Characteristic Descriptor UUID (16-bits or 128-bits).
+ * @read_cb:		Callback that should be called once the characteristic
+ *			descriptor attribute is read.
+ * @write_cb:		Callback that should be called once the characteristic
+ *			descriptor attribute is written.
+ *
+ * Returns handle to attribute. In case of error, 0 is returned.
+ */
+uint16_t btd_gatt_add_char_desc_to_service(uint16_t service_handle,
+						const bt_uuid_t *uuid,
+						btd_attr_read_t read_cb,
+						btd_attr_write_t write_cb);
+
+/*
+ * btd_gatt_remove_service - remove service with given handle
+ * @service_handle - Service handle
+ *
+ * Return true if service was removed. In case of error false will be returned
+ */
+bool btd_gatt_remove_service(uint16_t service_handle);
+
+/*
+ * btd_gatt_start_service - Add service declaration and its attributes to local
+ * database
+ * @service_handle - Service handle
+ *
+ * Return true if service was started. In case of error false will be returned
+ */
+bool btd_gatt_start_service(uint16_t service_handle);
+
+/*
+ * btd_gatt_stop_service - Remove service declaration and its attributes from
+ * local database
+ * @service_handle - Service handle
+ *
+ * Return true if service was stopped. In case of error false will be returned
+ */
+bool btd_gatt_stop_service(uint16_t service_handle);
-- 
1.8.5.3

