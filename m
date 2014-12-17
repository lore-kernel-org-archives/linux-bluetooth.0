Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v4 10/10] profiles/gap: Rewrite using bt_gatt_client.
Date: Tue, 16 Dec 2014 18:07:18 -0800
Message-Id: <1418782038-10999-11-git-send-email-armansito@chromium.org>
In-Reply-To: <1418782038-10999-1-git-send-email-armansito@chromium.org>
References: <1418782038-10999-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch rewrites the GAP profile to use the shared GATT stack instead
of GAttrib. The profile now also handles the Device Name characteristic.
---
 profiles/gap/gas.c | 269 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 197 insertions(+), 72 deletions(-)

diff --git a/profiles/gap/gas.c b/profiles/gap/gas.c
index a4028dd..5702e47 100644
--- a/profiles/gap/gas.c
+++ b/profiles/gap/gas.c
@@ -19,6 +19,7 @@
 #include <config.h>
 #endif
 
+#include <ctype.h>
 #include <stdbool.h>
 #include <stdlib.h>
 #include <sys/types.h>
@@ -28,38 +29,34 @@
 
 #include <glib.h>
 
-#include "btio/btio.h"
 #include "lib/uuid.h"
+#include "src/shared/util.h"
+#include "src/shared/att.h"
+#include "src/shared/queue.h"
+#include "src/shared/gatt-db.h"
+#include "src/shared/gatt-client.h"
 #include "src/plugin.h"
 #include "src/adapter.h"
 #include "src/device.h"
 #include "src/profile.h"
 #include "src/service.h"
-#include "src/shared/util.h"
-#include "attrib/att.h"
-#include "attrib/gattrib.h"
-#include "src/attio.h"
-#include "attrib/gatt.h"
 #include "src/log.h"
-#include "src/textfile.h"
 
 /* Generic Attribute/Access Service */
 struct gas {
 	struct btd_device *device;
-	struct att_range gap;	/* GAP Primary service range */
-	GAttrib *attrib;
-	guint attioid;
+	struct gatt_db *db;
+	struct bt_gatt_client *client;
+	uint16_t start_handle, end_handle;
 };
 
 static GSList *devices;
 
 static void gas_free(struct gas *gas)
 {
-	if (gas->attioid)
-		btd_device_remove_attio_callback(gas->device, gas->attioid);
-
-	g_attrib_unref(gas->attrib);
 	btd_device_unref(gas->device);
+	gatt_db_unref(gas->db);
+	bt_gatt_client_unref(gas->client);
 	g_free(gas);
 }
 
@@ -71,128 +68,256 @@ static int cmp_device(gconstpointer a, gconstpointer b)
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
+
+	DBG("GAP Device Name: %s", name);
+
+	btd_device_device_set_name(gas->device, name);
+}
 
-	if (status != 0) {
-		error("Read characteristics by UUID failed: %s",
-				att_ecode2str(status));
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
 {
-	struct gas *gas = user_data;
-	uint16_t app;
+	bt_uuid_t lhs;
 
-	gas->attrib = g_attrib_ref(attrib);
+	bt_uuid16_create(&lhs, u16);
 
-	if (device_get_appearance(gas->device, &app) < 0) {
-		bt_uuid_t uuid;
+	return bt_uuid_cmp(&lhs, uuid) == 0;
+}
 
-		bt_uuid16_create(&uuid, GATT_CHARAC_APPEARANCE);
+static void handle_characteristic(struct gatt_db_attribute *attr,
+								void *user_data)
+{
+	struct gas *gas = user_data;
+	uint16_t value_handle;
+	bt_uuid_t uuid;
 
-		gatt_read_char_by_uuid(gas->attrib, gas->gap.start,
-						gas->gap.end, &uuid,
-						gap_appearance_cb, gas);
+	if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle, NULL,
+								&uuid)) {
+		error("Failed to obtain characteristic data");
+		return;
 	}
 
-	/* TODO: Read other GAP characteristics - See Core spec page 1739 */
+	if (uuid_cmp(GATT_CHARAC_DEVICE_NAME, &uuid))
+		handle_device_name(gas, value_handle);
+	else if (uuid_cmp(GATT_CHARAC_APPEARANCE, &uuid))
+		handle_appearance(gas, value_handle);
+	else {
+		char uuid_str[MAX_LEN_UUID_STR];
+
+		/* TODO: Support peripheral privacy feature */
+
+		bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
+		DBG("Unsupported characteristic: %s", uuid_str);
+	}
 }
 
-static void attio_disconnected_cb(gpointer user_data)
+static void handle_gap_service(struct gas *gas)
 {
-	struct gas *gas = user_data;
+	struct gatt_db_attribute *attr;
 
-	g_attrib_unref(gas->attrib);
-	gas->attrib = NULL;
+	attr = gatt_db_get_attribute(gas->db, gas->start_handle);
+	if (!attr) {
+		error("Service with handle 0x%04x not found in db",
+							gas->start_handle);
+		return;
+	}
+
+	gatt_db_service_foreach_char(attr, handle_characteristic, gas);
 }
 
-static int gas_register(struct btd_device *device, struct att_range *gap)
+static int gap_driver_probe(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	struct gas *gas;
+	uint16_t start_handle, end_handle;
+	GSList *l;
+	char addr[18];
+
+	if (!btd_service_get_gatt_handles(service, &start_handle, &end_handle))
+		return -1;
+
+	ba2str(device_get_address(device), addr);
+	DBG("GAP profile probe (%s): start: 0x%04x, end 0x%04x", addr,
+						start_handle, end_handle);
+
+	/*
+	 * There can't be more than one instance of the GAP service on the same
+	 * device.
+	 */
+	l = g_slist_find_custom(devices, device, cmp_device);
+	if (l) {
+		error("More than one GAP service exists on device");
+		return -1;
+	}
 
 	gas = g_new0(struct gas, 1);
-	gas->gap.start = gap->start;
-	gas->gap.end = gap->end;
 
 	gas->device = btd_device_ref(device);
-
+	gas->start_handle = start_handle;
+	gas->end_handle = end_handle;
 	devices = g_slist_append(devices, gas);
 
-	gas->attioid = btd_device_add_attio_callback(device,
-						attio_connected_cb,
-						attio_disconnected_cb, gas);
-
 	return 0;
 }
 
-static void gas_unregister(struct btd_device *device)
+static void gap_driver_remove(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	struct gas *gas;
+	uint16_t start_handle, end_handle;
 	GSList *l;
+	char addr[18];
+
+	if (!btd_service_get_gatt_handles(service, &start_handle,
+								&end_handle)) {
+		error("Removed service is not a GATT service");
+		return;
+	}
+
+	ba2str(device_get_address(device), addr);
+	DBG("GAP profile remove (%s): start: 0x%04x, end 0x%04x", addr,
+						start_handle, end_handle);
 
 	l = g_slist_find_custom(devices, device, cmp_device);
-	if (l == NULL)
+	if (!l) {
+		error("GAP service not handled by profile");
 		return;
+	}
 
 	gas = l->data;
+
+	if (gas->start_handle != start_handle ||
+						gas->end_handle != end_handle) {
+		error("Removed unknown GAP service");
+		return;
+	}
+
 	devices = g_slist_remove(devices, gas);
 	gas_free(gas);
 }
 
-static int gap_driver_probe(struct btd_service *service)
+static int gap_driver_accept(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
-	struct gatt_primary *gap;
+	struct gatt_db *db = btd_device_get_gatt_db(device);
+	struct bt_gatt_client *client = btd_device_get_gatt_client(device);
+	struct gas *gas;
+	uint16_t start_handle, end_handle;
+	GSList *l;
+	char addr[18];
 
-	gap = btd_device_get_primary(device, GAP_UUID);
+	if (!btd_service_get_gatt_handles(service, &start_handle,
+								&end_handle)) {
+		error("Service is not a GATT service");
+		return -1;
+	}
+
+	ba2str(device_get_address(device), addr);
+	DBG("GAP profile accept (%s): start: 0x%04x, end 0x%04x", addr,
+						start_handle, end_handle);
 
-	if (gap == NULL) {
-		error("GAP service is mandatory");
-		return -EINVAL;
+	l = g_slist_find_custom(devices, device, cmp_device);
+	if (!l) {
+		error("GAP service not handled by profile");
+		return -1;
 	}
 
-	return gas_register(device, &gap->range);
-}
+	gas = l->data;
 
-static void gap_driver_remove(struct btd_service *service)
-{
-	struct btd_device *device = btd_service_get_device(service);
+	if (gas->start_handle != start_handle ||
+						gas->end_handle != end_handle) {
+		error("Accepting unknown GAP service");
+		return -1;
+	}
 
-	gas_unregister(device);
+	/* Clean-up any old client/db and acquire the new ones */
+	gatt_db_unref(gas->db);
+	bt_gatt_client_unref(gas->client);
+	gas->db = NULL;
+	gas->client = NULL;
+
+	gas->db = gatt_db_ref(db);
+	gas->client = bt_gatt_client_ref(client);
+
+	/* Handle the service */
+	handle_gap_service(gas);
+
+	return 0;
 }
 
 static struct btd_profile gap_profile = {
 	.name		= "gap-profile",
 	.remote_uuid	= GAP_UUID,
 	.device_probe	= gap_driver_probe,
-	.device_remove	= gap_driver_remove
+	.device_remove	= gap_driver_remove,
+	.accept		= gap_driver_accept
 };
 
 static int gap_init(void)
-- 
2.2.0.rc0.207.ga3a616c

