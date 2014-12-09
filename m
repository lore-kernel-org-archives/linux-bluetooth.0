Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 14/15] profiles/gap: Rewrite using bt_gatt_client.
Date: Mon,  8 Dec 2014 16:40:54 -0800
Message-Id: <1418085655-7304-15-git-send-email-armansito@chromium.org>
In-Reply-To: <1418085655-7304-1-git-send-email-armansito@chromium.org>
References: <1418085655-7304-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch rewrites the GAP profile to use the shared GATT stack instead
of GAttrib. The profile now also handles the Device Name characteristic.
---
 profiles/gap/gas.c | 225 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 166 insertions(+), 59 deletions(-)

diff --git a/profiles/gap/gas.c b/profiles/gap/gas.c
index a4028dd..7b28437 100644
--- a/profiles/gap/gas.c
+++ b/profiles/gap/gas.c
@@ -19,6 +19,7 @@
 #include <config.h>
 #endif
 
+#include <ctype.h>
 #include <stdbool.h>
 #include <stdlib.h>
 #include <sys/types.h>
@@ -36,30 +37,34 @@
 #include "src/profile.h"
 #include "src/service.h"
 #include "src/shared/util.h"
-#include "attrib/att.h"
-#include "attrib/gattrib.h"
-#include "src/attio.h"
-#include "attrib/gatt.h"
 #include "src/log.h"
 #include "src/textfile.h"
+#include "src/shared/att.h"
+#include "src/shared/queue.h"
+#include "src/shared/gatt-db.h"
+#include "src/shared/gatt-client.h"
+#include "src/gatt-callbacks.h"
 
 /* Generic Attribute/Access Service */
 struct gas {
 	struct btd_device *device;
-	struct att_range gap;	/* GAP Primary service range */
-	GAttrib *attrib;
-	guint attioid;
+	struct gatt_db *db;
+	struct bt_gatt_client *client;
+	uint16_t start_handle, end_handle;
+	unsigned int gatt_cb_id;
 };
 
 static GSList *devices;
 
 static void gas_free(struct gas *gas)
 {
-	if (gas->attioid)
-		btd_device_remove_attio_callback(gas->device, gas->attioid);
+	if (gas->gatt_cb_id)
+		btd_device_remove_gatt_callbacks(gas->device,
+							gas->gatt_cb_id);
 
-	g_attrib_unref(gas->attrib);
 	btd_device_unref(gas->device);
+	gatt_db_unref(gas->db);
+	bt_gatt_client_unref(gas->client);
 	g_free(gas);
 }
 
@@ -71,83 +76,193 @@ static int cmp_device(gconstpointer a, gconstpointer b)
 	return gas->device == device ? 0 : -1;
 }
 
-static void gap_appearance_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
+static char *name2utf8(const uint8_t *name, uint8_t len)
+{
+	char utf8_name[HCI_MAX_NAME_LENGTH + 2];
+	int i;
+
+	if (g_utf8_validate((const char *) name, len, NULL))
+		return g_strndup((char *) name, len);
+
+	memset(utf8_name, 0, sizeof(utf8_name));
+	strncpy(utf8_name, (char *) name, len);
+
+	/* Assume ASCII, and replace all non-ASCII with spaces */
+	for (i = 0; utf8_name[i] != '\0'; i++) {
+		if (!isascii(utf8_name[i]))
+			utf8_name[i] = ' ';
+	}
+
+	/* Remove leading and trailing whitespace characters */
+	g_strstrip(utf8_name);
+
+	return g_strdup(utf8_name);
+}
+
+static void read_device_name_cb(bool success, uint8_t att_ecode,
+					const uint8_t *value, uint16_t length,
+					void *user_data)
 {
 	struct gas *gas = user_data;
-	struct att_data_list *list =  NULL;
-	uint16_t app;
-	uint8_t *atval;
+	char *name = name2utf8(value, length);
 
-	if (status != 0) {
-		error("Read characteristics by UUID failed: %s",
-				att_ecode2str(status));
+	DBG("GAP Device Name: %s", name);
+
+	btd_device_device_set_name(gas->device, name);
+}
+
+static void handle_device_name(struct gas *gas, uint16_t value_handle)
+{
+	if (!bt_gatt_client_read_long_value(gas->client, value_handle, 0,
+						read_device_name_cb, gas, NULL))
+		DBG("Failed to send request to read device name");
+}
+
+static void read_appearance_cb(bool success, uint8_t att_ecode,
+					const uint8_t *value, uint16_t length,
+					void *user_data)
+{
+	struct gas *gas = user_data;
+	uint16_t appearance;
+
+	if (!success) {
+		DBG("Reading appearance failed with ATT error: %u", att_ecode);
 		return;
 	}
 
-	list = dec_read_by_type_resp(pdu, plen);
-	if (list == NULL)
+	/* The appearance value is a 16-bit unsigned integer */
+	if (length != 2) {
+		DBG("Malformed appearance value");
 		return;
-
-	if (list->len != 4) {
-		error("GAP Appearance value: invalid data");
-		goto done;
 	}
 
-	atval = list->data[0] + 2; /* skip handle value */
-	app = get_le16(atval);
+	appearance = get_le16(value);
 
-	DBG("GAP Appearance: 0x%04x", app);
+	DBG("GAP Appearance: 0x%04x", appearance);
 
-	device_set_appearance(gas->device, app);
+	device_set_appearance(gas->device, appearance);
+}
 
-done:
-	att_data_list_free(list);
+static void handle_appearance(struct gas *gas, uint16_t value_handle)
+{
+	if (!bt_gatt_client_read_value(gas->client, value_handle,
+						read_appearance_cb, gas, NULL))
+		DBG("Failed to send request to read appearance");
 }
 
-static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
+static bool uuid_cmp(uint16_t u16, const bt_uuid_t *uuid)
+{
+	bt_uuid_t lhs;
+
+	bt_uuid16_create(&lhs, u16);
+
+	return bt_uuid_cmp(&lhs, uuid) == 0;
+}
+
+static void handle_characteristic(struct gatt_db_attribute *attr,
+								void *user_data)
 {
 	struct gas *gas = user_data;
-	uint16_t app;
+	uint16_t value_handle;
+	bt_uuid_t uuid;
+
+	if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle, NULL,
+								&uuid)) {
+		error("Failed to obtain characteristic data");
+		return;
+	}
 
-	gas->attrib = g_attrib_ref(attrib);
+	if (uuid_cmp(GATT_CHARAC_DEVICE_NAME, &uuid))
+		handle_device_name(gas, value_handle);
+	else if (uuid_cmp(GATT_CHARAC_APPEARANCE, &uuid))
+		handle_appearance(gas, value_handle);
+	else {
+		char uuid_str[MAX_LEN_UUID_STR];
 
-	if (device_get_appearance(gas->device, &app) < 0) {
-		bt_uuid_t uuid;
+		/* TODO: Support peripheral privacy feature */
 
-		bt_uuid16_create(&uuid, GATT_CHARAC_APPEARANCE);
+		bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
+		DBG("Unsupported characteristic: %s", uuid_str);
+	}
+}
+
+static void handle_service(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct gas *gas = user_data;
 
-		gatt_read_char_by_uuid(gas->attrib, gas->gap.start,
-						gas->gap.end, &uuid,
-						gap_appearance_cb, gas);
+	if (gas->start_handle) {
+		error("More than one GAP service exists on device");
+		return;
 	}
 
-	/* TODO: Read other GAP characteristics - See Core spec page 1739 */
+	gatt_db_attribute_get_service_handles(attr, &gas->start_handle,
+							&gas->end_handle);
+	gatt_db_service_foreach_char(attr, handle_characteristic, gas);
 }
 
-static void attio_disconnected_cb(gpointer user_data)
+static void handle_gap_service(struct gas *gas)
+{
+	bt_uuid_t uuid;
+
+	bt_string_to_uuid(&uuid, GAP_UUID);
+
+	gatt_db_foreach_service(gas->db, &uuid, handle_service, gas);
+}
+
+static void gatt_client_ready_cb(struct bt_gatt_client *client,
+					struct gatt_db *db, void *user_data)
 {
 	struct gas *gas = user_data;
 
-	g_attrib_unref(gas->attrib);
-	gas->attrib = NULL;
+	gas->client = bt_gatt_client_ref(client);
+	gas->db = gatt_db_ref(db);
+
+	handle_gap_service(gas);
 }
 
-static int gas_register(struct btd_device *device, struct att_range *gap)
+static void gatt_client_disconn_cb(void *user_data)
+{
+	struct gas *gas = user_data;
+
+	gatt_db_unref(gas->db);
+	bt_gatt_client_unref(gas->client);
+
+	gas->db = NULL;
+	gas->client = NULL;
+}
+
+static int gas_register(struct btd_device *device)
 {
 	struct gas *gas;
+	GSList *l;
+
+	/*
+	 * There can't be more than one instance of the GAP service on the same
+	 * device.
+	 */
+	l = g_slist_find_custom(devices, device, cmp_device);
+	if (l)
+		return 0;
 
 	gas = g_new0(struct gas, 1);
-	gas->gap.start = gap->start;
-	gas->gap.end = gap->end;
 
 	gas->device = btd_device_ref(device);
-
 	devices = g_slist_append(devices, gas);
 
-	gas->attioid = btd_device_add_attio_callback(device,
-						attio_connected_cb,
-						attio_disconnected_cb, gas);
+	/*
+	 * Simply register the callbacks. We will perform initialization during
+	 * the ready callback once the gatt-client has been initialized for this
+	 * device.
+	 *
+	 * Here we don't register the service removed handler since the
+	 * GAP service is mandatory and should not get removed while the device
+	 * is connected.
+	 */
+	gas->gatt_cb_id = btd_device_add_gatt_callbacks(device,
+							gatt_client_ready_cb,
+							NULL,
+							gatt_client_disconn_cb,
+							gas);
 
 	return 0;
 }
@@ -169,16 +284,8 @@ static void gas_unregister(struct btd_device *device)
 static int gap_driver_probe(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
-	struct gatt_primary *gap;
-
-	gap = btd_device_get_primary(device, GAP_UUID);
-
-	if (gap == NULL) {
-		error("GAP service is mandatory");
-		return -EINVAL;
-	}
 
-	return gas_register(device, &gap->range);
+	return gas_register(device);
 }
 
 static void gap_driver_remove(struct btd_service *service)
-- 
2.2.0.rc0.207.ga3a616c

