Return-Path: <cyrus@holtmann.org>
From: wu.zheng@intel.com
To: <linux-bluetooth@vger.kernel.org>
Cc: wu.zheng@intel.com, Gu Chaojie <chao.jie.gu@intel.com>
Subject: [PATCH] GATT Hirarchy for gatt-api
Date: Thu, 17 Jul 2014 17:50:19 +0800
Message-Id: <1405590619-31484-1-git-send-email-wu.zheng@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gu Chaojie <chao.jie.gu@intel.com>

Signed-off-by: Gu Chaojie <chao.jie.gu@intel.com>
---
 src/device.c |  895 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 886 insertions(+), 9 deletions(-)

diff --git a/src/device.c b/src/device.c
index 23eb8aa..bc1ac7f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -45,6 +45,7 @@
 
 #include "log.h"
 
+#include "src/shared/util.h"
 #include "btio/btio.h"
 #include "lib/uuid.h"
 #include "lib/mgmt.h"
@@ -70,6 +71,13 @@
 
 #define DISCONNECT_TIMER	2
 #define DISCOVERY_TIMER		1
+#define DESC_CHANGED_TIMER      2
+
+
+#define GATT_SERVICE_IFACE		"org.bluez.GattService1"
+#define GATT_CHR_IFACE			"org.bluez.GattCharacteristic1"
+#define GATT_DESCRIPTOR_IFACE		"org.bluez.GattDescriptor1"
+#define GATT_DESC_UUID_HEAD		"000029"
 
 static DBusConnection *dbus_conn = NULL;
 unsigned service_state_cb_id;
@@ -127,6 +135,43 @@ struct included_search {
 	struct browse_req *req;
 	GSList *services;
 	GSList *current;
+	GSList *includes;
+};
+
+struct service_info_search {
+	struct btd_device *device;
+	struct gatt_primary *prim;
+	char *service_path;
+	GSList *includes;
+	GSList *char_info_list;
+
+};
+
+struct char_info_search {
+	struct service_info_search *service_info;
+	struct gatt_char *chr;
+	char *char_path;
+	uint8_t *value;
+	int vlen;
+	uint8_t *set_value;
+	int set_len;
+	char **prop_array;
+	int array_size;
+	bool changed;
+	GSList *desc_info_list;
+};
+
+struct desc_info_search {
+	struct char_info_search *char_info;
+	struct gatt_desc *desc;
+	char *desc_path;
+	uint8_t *value;
+	int vlen;
+	uint8_t *set_value;
+	int set_len;
+	bool notified;
+	guint changed_timer;
+
 };
 
 struct attio_data {
@@ -231,9 +276,19 @@ static const uint16_t uuid_list[] = {
 	0
 };
 
+static GSList *service_info_list = NULL;
+
 static int device_browse_primary(struct btd_device *device, DBusMessage *msg);
 static int device_browse_sdp(struct btd_device *device, DBusMessage *msg);
 
+static int include_by_range_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct gatt_included *include = a;
+	const struct att_range *range = b;
+
+	return memcmp(&include->range, range, sizeof(*range));
+}
+
 static struct bearer_state *get_state(struct btd_device *dev,
 							uint8_t bdaddr_type)
 {
@@ -539,8 +594,6 @@ static void device_free(gpointer user_data)
 	if (device->disconnect)
 		dbus_message_unref(device->disconnect);
 
-	DBG("%p", device);
-
 	if (device->authr) {
 		if (device->authr->agent)
 			agent_unref(device->authr->agent);
@@ -1920,6 +1973,450 @@ static const GDBusPropertyTable device_properties[] = {
 	{ }
 };
 
+static int prop_bit_count(uint8_t num)
+{
+	int count = 0;
+
+	while (num != 0) {
+		count++;
+		num = num & (num - 1);
+	}
+
+	return count;
+}
+
+static void char_write_req_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
+{
+	struct char_info_search *char_info = user_data;
+
+	if (status != 0) {
+		error("Characteristic Write Request failed: %s",
+						att_ecode2str(status));
+		goto done;
+	}
+
+	if (!dec_write_resp(pdu, plen) && !dec_exec_write_resp(pdu, plen)) {
+		error("Protocol error");
+		goto done;
+	}
+
+	DBG("Characteristic value was written successfully");
+
+	g_free(char_info->value);
+
+	char_info->value = g_memdup(char_info->set_value, char_info->set_len);
+	char_info->vlen = char_info->set_len;
+
+	g_free(char_info->set_value);
+
+done:
+	g_dbus_emit_property_changed(dbus_conn, char_info->char_path,
+						GATT_CHR_IFACE, "Value");
+}
+
+static void desc_write_req_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
+{
+	struct desc_info_search *desc_info = user_data;
+
+	if (status != 0) {
+		error("Descriptor Write Request failed: %s",
+						att_ecode2str(status));
+		goto done;
+	}
+
+	if (!dec_write_resp(pdu, plen) && !dec_exec_write_resp(pdu, plen)) {
+		error("Protocol error");
+		goto done;
+	}
+
+	DBG("Descriptor value was written successfully");
+
+	g_free(desc_info->value);
+
+	desc_info->value = g_memdup(desc_info->set_value, desc_info->set_len);
+	desc_info->vlen = desc_info->set_len;
+
+	g_free(desc_info->set_value);
+
+done:
+	g_dbus_emit_property_changed(dbus_conn, desc_info->desc_path,
+					GATT_DESCRIPTOR_IFACE, "Value");
+}
+
+static int get_char_flags_array(struct char_info_search *char_info)
+{
+	char **prop_array;
+	int size, length, i = 0;
+	uint8_t properties = char_info->chr->properties;
+
+	size = prop_bit_count(properties);
+
+	char_info->prop_array = (char **)g_malloc0(sizeof(char*)*size);
+
+	prop_array = char_info->prop_array;
+
+	if (prop_array != NULL) {
+		if (properties & GATT_CHR_PROP_BROADCAST) {
+			length = strlen("broadcast");
+			*(prop_array+i) =
+				(char *)g_malloc0(sizeof(char*)*length);
+			strcpy(*(prop_array+i), "broadcast");
+			i++;
+		}
+
+		if (properties & GATT_CHR_PROP_READ) {
+			length = strlen("read");
+			*(prop_array+i) =
+				(char *)g_malloc0(sizeof(char*)*length);
+			strcpy(*(prop_array+i), "read");
+			i++;
+		}
+
+		if (properties & GATT_CHR_PROP_WRITE_WITHOUT_RESP) {
+			length = strlen("write-without-response");
+			*(prop_array+i) =
+				(char *)g_malloc0(sizeof(char*)*length);
+			strcpy(*(prop_array+i), "write-without-response");
+			i++;
+		}
+
+		if (properties & GATT_CHR_PROP_WRITE) {
+			length = strlen("write");
+			*(prop_array+i) =
+				(char *)g_malloc0(sizeof(char*)*length);
+			strcpy(*(prop_array+i), "write");
+			i++;
+		}
+
+		if (properties & GATT_CHR_PROP_NOTIFY) {
+			length = strlen("notify");
+			*(prop_array+i) =
+				(char *)g_malloc0(sizeof(char*)*length);
+			strcpy(*(prop_array+i), "notify");
+			i++;
+		}
+
+		if (properties & GATT_CHR_PROP_INDICATE) {
+			length = strlen("indicate");
+			*(prop_array+i) =
+				(char *)g_malloc0(sizeof(char*)*length);
+			strcpy(*(prop_array+i), "indicate");
+			i++;
+		}
+
+		if (properties & GATT_CHR_PROP_AUTH) {
+			length = strlen("authenticated-signed-writes");
+			*(prop_array+i) =
+				(char *)g_malloc0(sizeof(char*)*length);
+			strcpy(*(prop_array+i), "authenticated-signed-writes");
+			i++;
+		}
+	}
+
+	return size;
+}
+
+static gboolean service_get_uuid(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct service_info_search *service_info = data;
+	const char *ptr = service_info->prim->uuid;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &ptr);
+
+	return TRUE;
+}
+
+static gboolean service_get_includes(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct service_info_search *service_info = data;
+	DBusMessageIter entry;
+	GSList *l;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_OBJECT_PATH_AS_STRING,
+					&entry);
+
+	for (l = service_info_list; l; l = l->next) {
+		struct service_info_search *value = l->data;
+		struct gatt_primary *prim = value->prim;
+
+		if (g_slist_find_custom(service_info->includes, &prim->range,
+						include_by_range_cmp)) {
+			const char *path = value->service_path;
+
+			dbus_message_iter_append_basic(&entry,
+					DBUS_TYPE_OBJECT_PATH, &path);
+		}
+	}
+
+	dbus_message_iter_close_container(iter, &entry);
+
+	return TRUE;
+}
+
+static gboolean service_exist_includes(const GDBusPropertyTable *property,
+							void *data)
+{
+	struct service_info_search *service_info = data;
+
+	if (service_info->includes)
+		return TRUE;
+	else
+		return FALSE;
+}
+
+static gboolean chr_get_uuid(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct char_info_search *char_info = data;
+	const char *ptr = char_info->chr->uuid;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &ptr);
+
+	return TRUE;
+}
+
+static gboolean chr_get_service(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct char_info_search *char_info = data;
+	const char *str = char_info->service_info->service_path;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &str);
+
+	return TRUE;
+}
+
+static gboolean chr_get_value(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct char_info_search *char_info = data;
+
+	DBusMessageIter array;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_BYTE_AS_STRING, &array);
+
+	dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
+						&char_info->value,
+						char_info->vlen);
+
+	dbus_message_iter_close_container(iter, &array);
+
+	return TRUE;
+}
+
+static void chr_set_value(const GDBusPropertyTable *property,
+				DBusMessageIter *iter,
+				GDBusPendingPropertySet id, void *data)
+{
+	struct char_info_search *char_info = data;
+	struct btd_device *device = char_info->service_info->device;
+	DBusMessageIter array;
+	uint8_t propmask = char_info->chr->properties;
+	uint8_t *value;
+	int len;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY) {
+		DBG("Invalid value for Set('Value'...)\n");
+		g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
+		return;
+	}
+
+	dbus_message_iter_recurse(iter, &array);
+	dbus_message_iter_get_fixed_array(&array, &value, &len);
+
+	if (propmask & GATT_CHR_PROP_WRITE) {
+		char_info->set_value = g_memdup(value, len);
+		char_info->set_len = len;
+
+		gatt_write_char(device->attrib, char_info->chr->value_handle,
+				value, len, char_write_req_cb, char_info);
+	} else if (propmask & GATT_CHR_PROP_WRITE_WITHOUT_RESP) {
+		gatt_write_cmd(device->attrib, char_info->chr->value_handle,
+						value, len, NULL, NULL);
+
+		g_free(char_info->value);
+
+		char_info->value = g_memdup(value, len);
+		char_info->vlen = len;
+
+		g_dbus_emit_property_changed(dbus_conn, char_info->char_path,
+						GATT_CHR_IFACE, "Value");
+	}
+
+	g_dbus_pending_property_success(id);
+}
+
+static gboolean chr_get_props(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct char_info_search *char_info = data;
+	DBusMessageIter array;
+	char **props;
+	int i, size;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_STRING_AS_STRING, &array);
+
+	size = get_char_flags_array(char_info);
+
+	props = char_info->prop_array;
+
+	for (i = 0; i < size; i++)
+		dbus_message_iter_append_basic(&array,
+					DBUS_TYPE_STRING, &props[i]);
+
+	dbus_message_iter_close_container(iter, &array);
+
+	return TRUE;
+}
+
+static gboolean desc_get_uuid(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct desc_info_search *desc_info = data;
+	const char *ptr = desc_info->desc->uuid;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &ptr);
+
+	return TRUE;
+}
+
+static gboolean desc_get_chr(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct desc_info_search *desc_info = data;
+	const char *str = desc_info->char_info->char_path;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &str);
+
+	return TRUE;
+}
+
+static gboolean desc_get_value(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct desc_info_search *desc_info = data;
+
+	DBusMessageIter array;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_BYTE_AS_STRING, &array);
+
+	dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
+						&desc_info->value,
+						desc_info->vlen);
+
+	dbus_message_iter_close_container(iter, &array);
+
+	return TRUE;
+}
+
+static void desc_set_value(const GDBusPropertyTable *property,
+				DBusMessageIter *iter,
+				GDBusPendingPropertySet id, void *data)
+{
+	struct desc_info_search *desc_info = data;
+	struct char_info_search *char_info = desc_info->char_info;
+	struct btd_device *device = char_info->service_info->device;
+	DBusMessageIter array;
+	uint8_t *value;
+	int len;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY) {
+		DBG("Invalid value for Set('Value'...)\n");
+		g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
+		return;
+	}
+
+	dbus_message_iter_recurse(iter, &array);
+	dbus_message_iter_get_fixed_array(&array, &value, &len);
+
+	desc_info->set_value = g_memdup(value, len);
+	desc_info->set_len = len;
+
+	gatt_write_char(device->attrib, desc_info->desc->handle,
+			value, len, desc_write_req_cb, desc_info);
+
+	g_dbus_pending_property_success(id);
+}
+
+static void service_info_destroy(gpointer user_data)
+{
+	struct service_info_search *service_info = user_data;
+
+	service_info_list = g_slist_remove(service_info_list, service_info);
+
+	g_slist_free_full(service_info->includes, g_free);
+	g_slist_free(service_info->char_info_list);
+	g_free(service_info->prim);
+	g_free(service_info->service_path);
+	g_free(service_info);
+}
+
+static void char_info_destroy(gpointer user_data)
+{
+	struct char_info_search *char_info = user_data;
+	GSList *char_info_list = char_info->service_info->char_info_list;
+	int i;
+
+	char_info_list = g_slist_remove(char_info_list, char_info);
+
+	for (i = 0; char_info->array_size; i++)
+		g_free(char_info->prop_array[i]);
+
+	g_slist_free(char_info->desc_info_list);
+	g_free(char_info->prop_array);
+	g_free(char_info->chr);
+	g_free(char_info->value);
+	g_free(char_info->char_path);
+	g_free(char_info);
+}
+
+static void desc_info_destroy(gpointer user_data)
+{
+	struct desc_info_search *desc_info = user_data;
+	GSList *desc_info_list = desc_info->char_info->desc_info_list;
+
+	desc_info_list = g_slist_remove(desc_info_list, desc_info);
+
+	g_free(desc_info->desc);
+	g_free(desc_info->value);
+	g_free(desc_info->desc_path);
+	g_free(desc_info);
+}
+
+static const GDBusPropertyTable service_properties[] = {
+	{ "UUID", "s", service_get_uuid },
+	{ "Includes", "ao", service_get_includes, NULL,
+					service_exist_includes },
+	{ }
+};
+
+static const GDBusPropertyTable chr_properties[] = {
+	{ "UUID",	"s", chr_get_uuid },
+	{ "Service", "o", chr_get_service },
+	{ "Value", "ay", chr_get_value, chr_set_value, NULL },
+	{ "Flags", "as", chr_get_props, NULL, NULL },
+	{ }
+};
+
+static const GDBusPropertyTable desc_properties[] = {
+	{ "UUID",		"s",	desc_get_uuid },
+	{ "Characteristic", "o", desc_get_chr },
+	{ "Value", "ay", desc_get_value, desc_set_value, NULL },
+	{ }
+};
+
 uint8_t btd_device_get_bdaddr_type(struct btd_device *dev)
 {
 	return dev->bdaddr_type;
@@ -2297,8 +2794,6 @@ static struct btd_device *device_new(struct btd_adapter *adapter,
 	g_strdelimit(device->path, ":", '_');
 	g_free(address_up);
 
-	DBG("Creating device %s", device->path);
-
 	if (g_dbus_register_interface(dbus_conn,
 					device->path, DEVICE_INTERFACE,
 					device_methods, NULL,
@@ -3464,6 +3959,374 @@ static void send_le_browse_response(struct browse_req *req)
 	g_dbus_send_reply(dbus_conn, msg, DBUS_TYPE_INVALID);
 }
 
+static gboolean gatt_desc_changed(gpointer data)
+{
+	struct desc_info_search *desc_info = data;
+	struct char_info_search *char_info = desc_info->char_info;
+
+	DBG("");
+
+	if (char_info->changed)
+		char_info->changed = FALSE;
+	else {
+		put_le16(0x0000, desc_info->value);
+
+		g_dbus_emit_property_changed(dbus_conn,
+					desc_info->desc_path,
+					GATT_DESCRIPTOR_IFACE,
+					"Value");
+
+		desc_info->changed_timer = 0;
+
+		desc_info->notified = FALSE;
+
+		return FALSE;
+	}
+
+	return TRUE;
+
+}
+
+static void handle_desc_info_list(struct char_info_search *char_info)
+{
+	GSList *desc_info_list = char_info->desc_info_list;
+	GSList *l;
+
+	for (l = desc_info_list; l; l = l->next) {
+		struct desc_info_search *desc_info = l->data;
+
+		if (!desc_info->notified && desc_info->value) {
+			if (desc_info->desc->uuid16 ==
+					GATT_CLIENT_CHARAC_CFG_UUID)
+				put_le16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT,
+							desc_info->value);
+
+			g_dbus_emit_property_changed(dbus_conn,
+						desc_info->desc_path,
+						GATT_DESCRIPTOR_IFACE,
+						"Value");
+
+			desc_info->changed_timer = g_timeout_add_seconds(
+							DESC_CHANGED_TIMER,
+							gatt_desc_changed,
+							desc_info);
+
+			desc_info->notified = TRUE;
+		}
+
+	}
+}
+
+static void handle_char_info_list(const uint8_t *pdu, uint16_t len,
+						GSList *char_info_list)
+{
+	GSList *l;
+	uint16_t handle;
+
+	handle = get_le16(&pdu[1]);
+
+	for (l = char_info_list; l; l = l->next) {
+		struct char_info_search *char_info = l->data;
+
+		if (char_info->chr->value_handle == handle) {
+			if (char_info->vlen >= len)
+				memcpy(char_info->value, &pdu[3], len);
+			else {
+				g_free(char_info->value);
+
+				char_info->value = g_malloc0(len);
+
+				memcpy(char_info->value, &pdu[3], len);
+
+				char_info->vlen = len;
+			}
+
+			char_info->changed = TRUE;
+
+			g_dbus_emit_property_changed(dbus_conn,
+						char_info->char_path,
+						GATT_CHR_IFACE, "Value");
+
+			if (char_info->desc_info_list)
+				handle_desc_info_list(char_info);
+		}
+	}
+}
+
+static void gatt_notify_handler(const uint8_t *pdu, uint16_t len,
+						gpointer user_data)
+{
+	uint16_t handle;
+	GSList *l;
+
+	handle = get_le16(&pdu[1]);
+
+	if (pdu[0] == ATT_OP_HANDLE_NOTIFY)
+		DBG("Notification handle = 0x%04x", handle);
+	else {
+		DBG("Invalid opcode\n");
+		return;
+	}
+
+	for (l = service_info_list; l; l = l->next) {
+		struct service_info_search *service_info = l->data;
+		GSList *char_info_list = service_info->char_info_list;
+
+		handle_char_info_list(pdu, len, char_info_list);
+	}
+}
+
+static gboolean listen_start(GAttrib *attrib)
+{
+	g_attrib_register(attrib, ATT_OP_HANDLE_NOTIFY,
+				GATTRIB_ALL_HANDLES,
+				gatt_notify_handler,
+				NULL, NULL);
+
+	return TRUE;
+}
+
+static void desc_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
+{
+	struct desc_info_search *desc_info = user_data;
+	uint8_t value[plen];
+	ssize_t vlen;
+
+	if (status != 0) {
+		error("Descriptor read failed: %s",
+				att_ecode2str(status));
+		return;
+	}
+
+	vlen = dec_read_resp(pdu, plen, value, sizeof(value));
+	if (vlen < 0) {
+		error("Protocol error");
+		return;
+	}
+
+	desc_info->value = g_malloc0(vlen);
+
+	desc_info->vlen = vlen;
+
+	memcpy(desc_info->value, value, vlen);
+}
+
+static void char_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
+{
+	struct char_info_search *char_info = user_data;
+	uint8_t value[plen];
+	ssize_t vlen;
+
+	if (status != 0) {
+		error("Characteristic value read failed: %s",
+					att_ecode2str(status));
+		return;
+	}
+
+	vlen = dec_read_resp(pdu, plen, value, sizeof(value));
+	if (vlen < 0) {
+		error("Protocol error");
+		return;
+	}
+
+	char_info->value = g_malloc0(vlen);
+
+	char_info->vlen = vlen;
+
+	memcpy(char_info->value, value, vlen);
+}
+
+static void char_desc_cb(uint8_t status, GSList *descriptors, void *user_data)
+{
+	struct char_info_search *char_info = user_data;
+	struct btd_device *device = char_info->service_info->device;
+	struct desc_info_search *desc_info = NULL;
+	char *desc_path;
+	int id = 1;
+	GSList *l;
+
+	DBG("status %u", status);
+
+	if (status) {
+		error("Discover descriptors failed: %s",
+					att_ecode2str(status));
+		return;
+	}
+
+	for (l = descriptors; l; l = l->next) {
+		struct gatt_desc *desc = l->data;
+
+		if (desc->uuid == strstr(desc->uuid, GATT_DESC_UUID_HEAD)) {
+			desc_info = g_new0(struct desc_info_search, 1);
+
+			desc_info->notified = FALSE;
+
+			desc_info->char_info = char_info;
+
+			desc_info->desc = g_memdup(l->data,
+						sizeof(struct gatt_desc));
+
+			desc_path = g_strdup_printf("%s/descriptor%d",
+						char_info->char_path, id++);
+
+			desc_info->desc_path = desc_path;
+
+			DBG("Creating descriptor %s", desc_path);
+
+			char_info->desc_info_list =
+				g_slist_append(char_info->desc_info_list,
+								desc_info);
+
+			if (!g_dbus_register_interface(dbus_conn, desc_path,
+						GATT_DESCRIPTOR_IFACE,
+						NULL, NULL, desc_properties,
+						desc_info, desc_info_destroy)) {
+				error("Couldn't register descriptor interface");
+				desc_info_destroy(desc_info);
+				return;
+			}
+
+			gatt_read_char(device->attrib,
+					desc_info->desc->handle,
+					desc_read_cb, desc_info);
+		}
+	}
+}
+
+static void char_discovered_cb(uint8_t status, GSList *characteristics,
+								void *user_data)
+{
+	struct service_info_search *service_info = user_data;
+	struct gatt_primary *prim = service_info->prim;
+	struct btd_device *device = service_info->device;
+	struct char_info_search *char_info = NULL;
+	struct char_info_search *prev_char_info = NULL;
+	char *char_path;
+	int id = 1;
+	GSList *l;
+
+	DBG("status %u", status);
+
+	if (status) {
+		error("Discover all characteristics failed: %s",
+						att_ecode2str(status));
+		return;
+	}
+
+	for (l = characteristics; l; l = l->next) {
+		char_info = g_new0(struct char_info_search, 1);
+
+		char_info->changed = FALSE;
+
+		char_info->desc_info_list = NULL;
+
+		char_info->service_info = service_info;
+
+		char_info->chr = g_memdup(l->data,
+					sizeof(struct gatt_char));
+
+		char_path = g_strdup_printf("%s/char%d",
+					service_info->service_path, id++);
+
+		char_info->char_path = char_path;
+
+		DBG("Creating char %s", char_path);
+
+		service_info->char_info_list =
+			g_slist_append(service_info->char_info_list, char_info);
+
+		if (!g_dbus_register_interface(dbus_conn, char_path,
+					GATT_CHR_IFACE, NULL,
+					NULL, chr_properties,
+					char_info, char_info_destroy)) {
+			error("Couldn't register characteristic interface");
+			char_info_destroy(char_info);
+			return;
+		}
+
+		gatt_read_char(device->attrib,
+				char_info->chr->value_handle,
+				char_read_cb, char_info);
+
+		if (prev_char_info) {
+			gatt_discover_desc(device->attrib,
+					prev_char_info->chr->handle,
+					char_info->chr->handle, NULL,
+					char_desc_cb, prev_char_info);
+		}
+
+		prev_char_info = char_info;
+	}
+
+	if (char_info) {
+		gatt_discover_desc(device->attrib, char_info->chr->handle,
+					prim->range.end, NULL,
+					char_desc_cb, char_info);
+	}
+}
+
+static gboolean register_service(struct included_search *search)
+{
+	struct service_info_search *service_info;
+	struct gatt_primary *prim;
+	struct gatt_included *service_incl;
+	struct btd_device *device = search->req->device;
+	static int id = 1;
+	GSList *l;
+
+	prim = g_memdup(search->current->data, sizeof(struct gatt_primary));
+
+	service_info = g_new0(struct service_info_search, 1);
+
+	service_info->char_info_list = NULL;
+
+	service_info->device = device;
+
+	service_info->prim = prim;
+
+	service_info->service_path = g_strdup_printf("%s/service%d",
+						device->path, id++);
+
+	DBG("Creating service %s", service_info->service_path);
+
+	if (search->includes == NULL)
+		goto next;
+
+	for (l = search->includes; l; l = l->next) {
+		struct gatt_included *incl = l->data;
+
+		service_incl = g_new0(struct gatt_included, 1);
+
+		memcpy(service_incl->uuid, incl->uuid,
+					sizeof(service_incl->uuid));
+		memcpy(&service_incl->range, &incl->range,
+					sizeof(service_incl->range));
+
+		service_info->includes = g_slist_append(service_info->includes,
+						service_incl);
+	}
+
+
+next:
+	service_info_list = g_slist_append(service_info_list, service_info);
+
+	if (!g_dbus_register_interface(dbus_conn, service_info->service_path,
+				GATT_SERVICE_IFACE, NULL,
+				NULL, service_properties,
+				service_info, service_info_destroy)) {
+		error("Couldn't register service interface");
+		service_info_destroy(service_info);
+		return FALSE;
+	}
+
+	gatt_discover_char(device->attrib, prim->range.start, prim->range.end,
+				NULL, char_discovered_cb, service_info);
+
+	return TRUE;
+}
+
 static void find_included_cb(uint8_t status, GSList *includes, void *user_data)
 {
 	struct included_search *search = user_data;
@@ -3492,8 +4355,11 @@ static void find_included_cb(uint8_t status, GSList *includes, void *user_data)
 		goto complete;
 	}
 
-	if (includes == NULL)
+	if (includes == NULL) {
+		search->includes = NULL;
 		goto next;
+	} else
+		search->includes = includes;
 
 	for (l = includes; l; l = l->next) {
 		struct gatt_included *incl = l->data;
@@ -3510,16 +4376,23 @@ static void find_included_cb(uint8_t status, GSList *includes, void *user_data)
 	}
 
 next:
+	register_service(search);
+
 	search->current = search->current->next;
 	if (search->current == NULL) {
+
 		register_all_services(search->req, search->services);
 		search->services = NULL;
+
+		listen_start(device->attrib);
+
 		goto complete;
 	}
 
 	prim = search->current->data;
-	gatt_find_included(device->attrib, prim->range.start, prim->range.end,
-					find_included_cb, search);
+	gatt_find_included(device->attrib, prim->range.start,
+			prim->range.end, find_included_cb, search);
+
 	return;
 
 complete:
@@ -3560,8 +4433,8 @@ static void find_included_services(struct browse_req *req, GSList *services)
 	search->current = search->services;
 
 	prim = search->current->data;
-	gatt_find_included(device->attrib, prim->range.start, prim->range.end,
-					find_included_cb, search);
+	gatt_find_included(device->attrib, prim->range.start,
+			prim->range.end, find_included_cb, search);
 }
 
 static void primary_cb(uint8_t status, GSList *services, void *user_data)
@@ -3587,6 +4460,7 @@ bool device_attach_attrib(struct btd_device *dev, GIOChannel *io)
 	GAttrib *attrib;
 
 	attrib = g_attrib_new(io);
+
 	if (!attrib) {
 		error("Unable to create new GAttrib instance");
 		return false;
@@ -3673,6 +4547,9 @@ done:
 		g_dbus_send_message(dbus_conn, reply);
 		dbus_message_unref(device->connect);
 		device->connect = NULL;
+	} else {
+		if (!device->le_state.svc_resolved)
+			device_browse_primary(device, NULL);
 	}
 
 	g_free(attcb);
-- 
1.7.10.4

