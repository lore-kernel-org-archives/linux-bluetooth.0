Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 10/12] profiles/gatt: Rename profile to gap.
Date: Mon, 15 Dec 2014 07:29:14 -0800
Message-Id: <1418657356-18967-11-git-send-email-armansito@chromium.org>
In-Reply-To: <1418657356-18967-1-git-send-email-armansito@chromium.org>
References: <1418657356-18967-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since this built in profile only handles the GAP service, this patch renames it
to gap.
---
 Makefile.plugins    |   4 +-
 profiles/gap/gas.c  | 213 +++++++++++++++++++++++++++++++++++++++++++++++++++
 profiles/gatt/gas.c | 216 ----------------------------------------------------
 3 files changed, 215 insertions(+), 218 deletions(-)
 create mode 100644 profiles/gap/gas.c
 delete mode 100644 profiles/gatt/gas.c

diff --git a/Makefile.plugins b/Makefile.plugins
index 0448b91..52b51c5 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -72,8 +72,8 @@ builtin_sources += profiles/health/mcap.h profiles/health/mcap.c \
 			profiles/health/hdp_util.h profiles/health/hdp_util.c
 endif
 
-builtin_modules += gatt
-builtin_sources += profiles/gatt/gas.c
+builtin_modules += gap
+builtin_sources += profiles/gap/gas.c
 
 builtin_modules += scanparam
 builtin_sources += profiles/scanparam/scan.c
diff --git a/profiles/gap/gas.c b/profiles/gap/gas.c
new file mode 100644
index 0000000..a4028dd
--- /dev/null
+++ b/profiles/gap/gas.c
@@ -0,0 +1,213 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012  Instituto Nokia de Tecnologia - INdT
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdbool.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include "btio/btio.h"
+#include "lib/uuid.h"
+#include "src/plugin.h"
+#include "src/adapter.h"
+#include "src/device.h"
+#include "src/profile.h"
+#include "src/service.h"
+#include "src/shared/util.h"
+#include "attrib/att.h"
+#include "attrib/gattrib.h"
+#include "src/attio.h"
+#include "attrib/gatt.h"
+#include "src/log.h"
+#include "src/textfile.h"
+
+/* Generic Attribute/Access Service */
+struct gas {
+	struct btd_device *device;
+	struct att_range gap;	/* GAP Primary service range */
+	GAttrib *attrib;
+	guint attioid;
+};
+
+static GSList *devices;
+
+static void gas_free(struct gas *gas)
+{
+	if (gas->attioid)
+		btd_device_remove_attio_callback(gas->device, gas->attioid);
+
+	g_attrib_unref(gas->attrib);
+	btd_device_unref(gas->device);
+	g_free(gas);
+}
+
+static int cmp_device(gconstpointer a, gconstpointer b)
+{
+	const struct gas *gas = a;
+	const struct btd_device *device = b;
+
+	return gas->device == device ? 0 : -1;
+}
+
+static void gap_appearance_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
+{
+	struct gas *gas = user_data;
+	struct att_data_list *list =  NULL;
+	uint16_t app;
+	uint8_t *atval;
+
+	if (status != 0) {
+		error("Read characteristics by UUID failed: %s",
+				att_ecode2str(status));
+		return;
+	}
+
+	list = dec_read_by_type_resp(pdu, plen);
+	if (list == NULL)
+		return;
+
+	if (list->len != 4) {
+		error("GAP Appearance value: invalid data");
+		goto done;
+	}
+
+	atval = list->data[0] + 2; /* skip handle value */
+	app = get_le16(atval);
+
+	DBG("GAP Appearance: 0x%04x", app);
+
+	device_set_appearance(gas->device, app);
+
+done:
+	att_data_list_free(list);
+}
+
+static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
+{
+	struct gas *gas = user_data;
+	uint16_t app;
+
+	gas->attrib = g_attrib_ref(attrib);
+
+	if (device_get_appearance(gas->device, &app) < 0) {
+		bt_uuid_t uuid;
+
+		bt_uuid16_create(&uuid, GATT_CHARAC_APPEARANCE);
+
+		gatt_read_char_by_uuid(gas->attrib, gas->gap.start,
+						gas->gap.end, &uuid,
+						gap_appearance_cb, gas);
+	}
+
+	/* TODO: Read other GAP characteristics - See Core spec page 1739 */
+}
+
+static void attio_disconnected_cb(gpointer user_data)
+{
+	struct gas *gas = user_data;
+
+	g_attrib_unref(gas->attrib);
+	gas->attrib = NULL;
+}
+
+static int gas_register(struct btd_device *device, struct att_range *gap)
+{
+	struct gas *gas;
+
+	gas = g_new0(struct gas, 1);
+	gas->gap.start = gap->start;
+	gas->gap.end = gap->end;
+
+	gas->device = btd_device_ref(device);
+
+	devices = g_slist_append(devices, gas);
+
+	gas->attioid = btd_device_add_attio_callback(device,
+						attio_connected_cb,
+						attio_disconnected_cb, gas);
+
+	return 0;
+}
+
+static void gas_unregister(struct btd_device *device)
+{
+	struct gas *gas;
+	GSList *l;
+
+	l = g_slist_find_custom(devices, device, cmp_device);
+	if (l == NULL)
+		return;
+
+	gas = l->data;
+	devices = g_slist_remove(devices, gas);
+	gas_free(gas);
+}
+
+static int gap_driver_probe(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct gatt_primary *gap;
+
+	gap = btd_device_get_primary(device, GAP_UUID);
+
+	if (gap == NULL) {
+		error("GAP service is mandatory");
+		return -EINVAL;
+	}
+
+	return gas_register(device, &gap->range);
+}
+
+static void gap_driver_remove(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+
+	gas_unregister(device);
+}
+
+static struct btd_profile gap_profile = {
+	.name		= "gap-profile",
+	.remote_uuid	= GAP_UUID,
+	.device_probe	= gap_driver_probe,
+	.device_remove	= gap_driver_remove
+};
+
+static int gap_init(void)
+{
+	devices = NULL;
+
+	btd_profile_register(&gap_profile);
+
+	return 0;
+}
+
+static void gap_exit(void)
+{
+	btd_profile_unregister(&gap_profile);
+}
+
+BLUETOOTH_PLUGIN_DEFINE(gap, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+							gap_init, gap_exit)
diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
deleted file mode 100644
index 9d5d31e..0000000
--- a/profiles/gatt/gas.c
+++ /dev/null
@@ -1,216 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2012  Instituto Nokia de Tecnologia - INdT
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <stdbool.h>
-#include <stdlib.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <errno.h>
-
-#include <glib.h>
-
-#include "btio/btio.h"
-#include "lib/uuid.h"
-#include "src/plugin.h"
-#include "src/adapter.h"
-#include "src/device.h"
-#include "src/profile.h"
-#include "src/service.h"
-#include "src/shared/util.h"
-#include "attrib/att.h"
-#include "attrib/gattrib.h"
-#include "src/attio.h"
-#include "attrib/gatt.h"
-#include "src/log.h"
-#include "src/textfile.h"
-
-/* Generic Attribute/Access Service */
-struct gas {
-	struct btd_device *device;
-	struct att_range gap;	/* GAP Primary service range */
-	GAttrib *attrib;
-	guint attioid;
-};
-
-static GSList *devices = NULL;
-
-static void gas_free(struct gas *gas)
-{
-	if (gas->attioid)
-		btd_device_remove_attio_callback(gas->device, gas->attioid);
-
-	g_attrib_unref(gas->attrib);
-	btd_device_unref(gas->device);
-	g_free(gas);
-}
-
-static int cmp_device(gconstpointer a, gconstpointer b)
-{
-	const struct gas *gas = a;
-	const struct btd_device *device = b;
-
-	return (gas->device == device ? 0 : -1);
-}
-
-static void gap_appearance_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
-{
-	struct gas *gas = user_data;
-	struct att_data_list *list =  NULL;
-	uint16_t app;
-	uint8_t *atval;
-
-	if (status != 0) {
-		error("Read characteristics by UUID failed: %s",
-				att_ecode2str(status));
-		return;
-	}
-
-	list = dec_read_by_type_resp(pdu, plen);
-	if (list == NULL)
-		return;
-
-	if (list->len != 4) {
-		error("GAP Appearance value: invalid data");
-		goto done;
-	}
-
-	atval = list->data[0] + 2; /* skip handle value */
-	app = get_le16(atval);
-
-	DBG("GAP Appearance: 0x%04x", app);
-
-	device_set_appearance(gas->device, app);
-
-done:
-	att_data_list_free(list);
-}
-
-static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
-{
-	struct gas *gas = user_data;
-	uint16_t app;
-
-	gas->attrib = g_attrib_ref(attrib);
-
-	if (device_get_appearance(gas->device, &app) < 0) {
-		bt_uuid_t uuid;
-
-		bt_uuid16_create(&uuid, GATT_CHARAC_APPEARANCE);
-
-		gatt_read_char_by_uuid(gas->attrib, gas->gap.start,
-						gas->gap.end, &uuid,
-						gap_appearance_cb, gas);
-	}
-
-	/* TODO: Read other GAP characteristics - See Core spec page 1739 */
-}
-
-static void attio_disconnected_cb(gpointer user_data)
-{
-	struct gas *gas = user_data;
-
-	g_attrib_unref(gas->attrib);
-	gas->attrib = NULL;
-}
-
-static int gas_register(struct btd_device *device, struct att_range *gap)
-{
-	struct gas *gas;
-
-	gas = g_new0(struct gas, 1);
-	gas->gap.start = gap->start;
-	gas->gap.end = gap->end;
-
-	gas->device = btd_device_ref(device);
-
-	devices = g_slist_append(devices, gas);
-
-	gas->attioid = btd_device_add_attio_callback(device,
-						attio_connected_cb,
-						attio_disconnected_cb, gas);
-
-	return 0;
-}
-
-static void gas_unregister(struct btd_device *device)
-{
-	struct gas *gas;
-	GSList *l;
-
-	l = g_slist_find_custom(devices, device, cmp_device);
-	if (l == NULL)
-		return;
-
-	gas = l->data;
-	devices = g_slist_remove(devices, gas);
-	gas_free(gas);
-}
-
-static int gatt_driver_probe(struct btd_service *service)
-{
-	struct btd_device *device = btd_service_get_device(service);
-	struct gatt_primary *gap;
-
-	gap = btd_device_get_primary(device, GAP_UUID);
-
-	if (gap == NULL) {
-		error("GAP service is mandatory");
-		return -EINVAL;
-	}
-
-	return gas_register(device, &gap->range);
-}
-
-static void gatt_driver_remove(struct btd_service *service)
-{
-	struct btd_device *device = btd_service_get_device(service);
-
-	gas_unregister(device);
-}
-
-static struct btd_profile gatt_profile = {
-	.name		= "gap-gatt-profile",
-	.remote_uuid	= GATT_UUID,
-	.device_probe	= gatt_driver_probe,
-	.device_remove	= gatt_driver_remove
-};
-
-static int gatt_init(void)
-{
-	btd_profile_register(&gatt_profile);
-
-	return 0;
-}
-
-static void gatt_exit(void)
-{
-	btd_profile_unregister(&gatt_profile);
-}
-
-BLUETOOTH_PLUGIN_DEFINE(gatt, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
-					gatt_init, gatt_exit)
-- 
2.2.0.rc0.207.ga3a616c

