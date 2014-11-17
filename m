Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 10/12] profiles/gap: Rewrite using bt_gatt_client.
Date: Mon, 17 Nov 2014 11:22:16 -0800
Message-Id: <1416252138-17477-11-git-send-email-armansito@chromium.org>
In-Reply-To: <1416252138-17477-1-git-send-email-armansito@chromium.org>
References: <1416252138-17477-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch rewrites the GAP profile to use the shared GATT stack instead
of GAttrib. The profile now also handles the Device Name characteristic.
---
 profiles/gap/gas.c | 213 +++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 150 insertions(+), 63 deletions(-)

diff --git a/profiles/gap/gas.c b/profiles/gap/gas.c
index 91b317f..9813d68 100644
--- a/profiles/gap/gas.c
+++ b/profiles/gap/gas.c
@@ -24,6 +24,7 @@
 #include <config.h>
 #endif
 
+#include <ctype.h>
 #include <stdbool.h>
 #include <stdlib.h>
 #include <sys/types.h>
@@ -41,29 +42,28 @@
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
+#include "src/shared/gatt-client.h"
+#include "src/gatt-callbacks.h"
 
 /* Generic Attribute/Access Service */
 struct gas {
 	struct btd_device *device;
-	struct att_range gap;	/* GAP Primary service range */
-	GAttrib *attrib;
-	guint attioid;
+	struct bt_gatt_client *client;
+	uint16_t start_handle, end_handle;
+	unsigned int gatt_cb_id;
 };
 
 static GSList *devices = NULL;
 
 static void gas_free(struct gas *gas)
 {
-	if (gas->attioid)
-		btd_device_remove_attio_callback(gas->device, gas->attioid);
+	if (gas->gatt_cb_id)
+		btd_device_remove_gatt_callbacks(gas->device,
+							gas->gatt_cb_id);
 
-	g_attrib_unref(gas->attrib);
 	btd_device_unref(gas->device);
 	g_free(gas);
 }
@@ -76,86 +76,181 @@ static int cmp_device(gconstpointer a, gconstpointer b)
 	return (gas->device == device ? 0 : -1);
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
+static void handle_device_name(struct gas *gas,
+					const bt_gatt_characteristic_t *chrc)
+{
+	if (!bt_gatt_client_read_long_value(gas->client, chrc->value_handle, 0,
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
+static void handle_appearance(struct gas *gas,
+					const bt_gatt_characteristic_t *chrc)
+{
+	uint16_t appearance;
+
+	if (device_get_appearance(gas->device, &appearance) >= 0)
+		return;
+
+	if (!bt_gatt_client_read_value(gas->client, chrc->value_handle,
+				read_appearance_cb, gas, NULL))
+		DBG("Failed to send request to read appearance");
 }
 
-static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
+static bool uuid_cmp(uint16_t u16, const uint8_t uuid[16])
 {
-	struct gas *gas = user_data;
-	GIOChannel *io;
-	GError *gerr = NULL;
-	uint16_t app;
+	uint128_t u128;
+	bt_uuid_t lhs, rhs;
 
-	gas->attrib = g_attrib_ref(attrib);
-	io = g_attrib_get_channel(attrib);
+	memcpy(u128.data, uuid, sizeof(uint8_t) * 16);
+	bt_uuid16_create(&lhs, u16);
+	bt_uuid128_create(&rhs, u128);
 
-	if (device_get_appearance(gas->device, &app) < 0) {
-		bt_uuid_t uuid;
+	return bt_uuid_cmp(&lhs, &rhs) == 0;
+}
 
-		bt_uuid16_create(&uuid, GATT_CHARAC_APPEARANCE);
+static void reset_gap_service(struct gas *gas)
+{
+	struct bt_gatt_service_iter iter;
+	struct bt_gatt_characteristic_iter chrc_iter;
+	const bt_gatt_service_t *service = NULL;
+	const bt_gatt_characteristic_t *chrc = NULL;
+	bt_uuid_t gap_uuid;
 
-		gatt_read_char_by_uuid(gas->attrib, gas->gap.start,
-						gas->gap.end, &uuid,
-						gap_appearance_cb, gas);
+	bt_string_to_uuid(&gap_uuid, GAP_UUID);
+
+	if (!bt_gatt_service_iter_init(&iter, gas->client)) {
+		DBG("Failed to initialize service iterator");
+		return;
 	}
 
-	/* TODO: Read other GAP characteristics - See Core spec page 1739 */
+	if (!bt_gatt_service_iter_next_by_uuid(&iter, gap_uuid.value.u128.data,
+								&service)) {
+		error("GAP service not found on device");
+		return;
+	}
+
+	gas->start_handle = service->start_handle;
+	gas->end_handle = service->end_handle;
+
+	if (!bt_gatt_characteristic_iter_init(&chrc_iter, service)) {
+		DBG("Failed to initialize characteristic iterator");
+		return;
+	}
+
+	while (bt_gatt_characteristic_iter_next(&chrc_iter, &chrc)) {
+		if (uuid_cmp(GATT_CHARAC_DEVICE_NAME, chrc->uuid))
+			handle_device_name(gas, chrc);
+		else if (uuid_cmp(GATT_CHARAC_APPEARANCE, chrc->uuid))
+			handle_appearance(gas, chrc);
+
+		/*
+		 * TODO: Implement peripheral privacy feature.
+		 */
+	}
+}
+
+static void gatt_client_ready_cb(struct bt_gatt_client *client, void *user_data)
+{
+	struct gas *gas = user_data;
+
+	gas->client = client;
+
+	reset_gap_service(gas);
 }
 
-static void attio_disconnected_cb(gpointer user_data)
+static void gatt_svc_chngd_cb(struct bt_gatt_client *client,
+						uint16_t start_handle,
+						uint16_t end_handle,
+						void *user_data)
 {
 	struct gas *gas = user_data;
 
-	g_attrib_unref(gas->attrib);
-	gas->attrib = NULL;
+	if (!gas->client || !gas->start_handle || !gas->end_handle)
+		return;
+
+	if (gas->end_handle < start_handle || gas->start_handle > end_handle)
+		return;
+
+	DBG("GAP service changed!");
+
+	reset_gap_service(gas);
 }
 
-static int gas_register(struct btd_device *device, struct att_range *gap)
+static int gas_register(struct btd_device *device)
 {
 	struct gas *gas;
 
 	gas = g_new0(struct gas, 1);
-	gas->gap.start = gap->start;
-	gas->gap.end = gap->end;
 
 	gas->device = btd_device_ref(device);
-
 	devices = g_slist_append(devices, gas);
 
-	gas->attioid = btd_device_add_attio_callback(device,
-						attio_connected_cb,
-						attio_disconnected_cb, gas);
+	if (!gas->gatt_cb_id)
+		gas->gatt_cb_id = btd_device_add_gatt_callbacks(device,
+							gatt_client_ready_cb,
+							gatt_svc_chngd_cb,
+							NULL, gas);
 
 	return 0;
 }
@@ -177,16 +272,8 @@ static void gas_unregister(struct btd_device *device)
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
2.1.0.rc2.206.gedb03e5

