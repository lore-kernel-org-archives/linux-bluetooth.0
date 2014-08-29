Return-Path: <cyrus@holtmann.org>
From: Gu Chaojie <chao.jie.gu@intel.com>
To: linux-bluetooth@vger.kernel.org, marcel@holmann.org,
	armansito@chromium.org
Cc: Chaojie Gu <chao.jie.gu@intel.com>
Subject: [PATCH] gatt api V2
Date: Fri, 29 Aug 2014 14:59:26 +0800
Message-Id: <1409295566-13583-1-git-send-email-chao.jie.gu@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chaojie Gu <chao.jie.gu@intel.com>

This patch focus on implementing the Gatt DBus API defined in gatt-api.txt discussed in mailist latestly. It implement all the DBus property and method except for array{object} of characteristics and descriptors. Through our internal test, patche work well. I would like to contribute this featrue for bluez upstream. This first patch is just an implementation, maybe not very closely suitable for design or put in the right file. It would be OK to modify to make more sense.
Arman, Marcel, would you like to review the patch and give some suggestion for the patch? It would be great honor for me to contribute little to bluez.

---
 src/device.c | 1602 +++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 1412 insertions(+), 190 deletions(-)

diff --git a/src/device.c b/src/device.c
index d63e627..a53a4e9 100644
--- a/src/device.c
+++ b/src/device.c
@@ -71,6 +71,13 @@
 
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
@@ -126,8 +133,48 @@ struct browse_req {
 
 struct included_search {
 	struct browse_req *req;
+	uint8_t	primary_count;
 	GSList *services;
 	GSList *current;
+	GSList *includes;
+};
+
+struct service_info_search {
+	struct btd_device *device;
+	struct gatt_primary *prim;
+	char *service_path;
+	bool primary;
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
+	bool notified;
+	GSList *desc_info_list;
+	DBusMessage *msg;
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
+	guint changed_timer;
+	DBusMessage *msg;
 };
 
 struct attio_data {
@@ -238,9 +285,19 @@ static const uint16_t uuid_list[] = {
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
@@ -1983,263 +2040,1039 @@ static const GDBusPropertyTable device_properties[] = {
 	{ }
 };
 
-uint8_t btd_device_get_bdaddr_type(struct btd_device *dev)
+static int prop_bit_count(uint8_t num)
 {
-	return dev->bdaddr_type;
+	int count = 0;
+
+	while (num != 0) {
+		count++;
+		num = num & (num - 1);
+	}
+
+	return count;
 }
 
-bool btd_device_is_connected(struct btd_device *dev)
+static int read_value_cmp(gconstpointer a, gconstpointer b, size_t n)
 {
-	return dev->bredr_state.connected || dev->le_state.connected;
+	return memcmp(a, b, n);
 }
 
-void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type)
+static void char_read_value_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
 {
-	struct bearer_state *state = get_state(dev, bdaddr_type);
-
-	device_update_last_seen(dev, bdaddr_type);
+	struct char_info_search *char_info = user_data;
+	uint8_t value[plen];
+	ssize_t vlen;
+	DBusMessage *reply;
 
-	if (state->connected) {
-		char addr[18];
-		ba2str(&dev->bdaddr, addr);
-		error("Device %s is already connected", addr);
-		return;
+	if (status != 0) {
+		reply = btd_error_failed(char_info->msg,
+					att_ecode2str(status));
+		goto done;
 	}
 
-	/* If this is the first connection over this bearer */
-	if (bdaddr_type == BDADDR_BREDR)
-		device_set_bredr_support(dev);
-	else
-		device_set_le_support(dev, bdaddr_type);
+	vlen = dec_read_resp(pdu, plen, value, sizeof(value));
+	if (vlen < 0) {
+		reply = btd_error_failed(char_info->msg,
+					"Protocol error");
+		goto done;
+	}
 
-	state->connected = true;
+	if ((char_info->vlen != vlen) ||
+			(read_value_cmp(char_info->value, value, vlen))) {
+		if (char_info->vlen < vlen) {
+			g_free(char_info->value);
+			char_info->value = g_malloc0(vlen);
+		}
 
-	if (dev->le_state.connected && dev->bredr_state.connected)
-		return;
+		memcpy(char_info->value, value, vlen);
+		char_info->vlen = vlen;
 
-	g_dbus_emit_property_changed(dbus_conn, dev->path, DEVICE_INTERFACE,
-								"Connected");
-}
+		g_dbus_emit_property_changed(dbus_conn, char_info->char_path,
+						GATT_CHR_IFACE, "Value");
+	}
 
-void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
-{
-	struct bearer_state *state = get_state(device, bdaddr_type);
+	reply = dbus_message_new_method_return(char_info->msg);
 
-	if (!state->connected)
-		return;
+	dbus_message_append_args(reply,
+			DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE,
+			&char_info->value,
+			char_info->vlen,
+			DBUS_TYPE_INVALID);
 
-	state->connected = false;
-	device->svc_refreshed = false;
-	device->general_connect = FALSE;
+done:
+	dbus_message_unref(char_info->msg);
+	char_info->msg = NULL;
 
-	if (device->disconn_timer > 0) {
-		g_source_remove(device->disconn_timer);
-		device->disconn_timer = 0;
-	}
+	g_dbus_send_message(dbus_conn, reply);
+}
 
-	while (device->disconnects) {
-		DBusMessage *msg = device->disconnects->data;
+static void char_write_req_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
+{
+	struct char_info_search *char_info = user_data;
+	DBusMessage *reply;
 
-		g_dbus_send_reply(dbus_conn, msg, DBUS_TYPE_INVALID);
-		device->disconnects = g_slist_remove(device->disconnects, msg);
-		dbus_message_unref(msg);
+	DBG("");
+	if (status != 0) {
+		reply = btd_error_failed(char_info->msg,
+					att_ecode2str(status));
+		goto done;
 	}
 
-	if (state->paired && !state->bonded)
-		btd_adapter_remove_bonding(device->adapter, &device->bdaddr,
-								bdaddr_type);
+	if (!dec_write_resp(pdu, plen) && !dec_exec_write_resp(pdu, plen)) {
+		reply = btd_error_failed(char_info->msg,
+					"Protocol error");
+		goto done;
+	}
 
-	if (device->bredr_state.connected || device->le_state.connected)
-		return;
+	DBG("Characteristic value was written successfully");
 
-	g_dbus_emit_property_changed(dbus_conn, device->path,
-						DEVICE_INTERFACE, "Connected");
-}
+	if (char_info->vlen < char_info->set_len) {
+		g_free(char_info->value);
+		char_info->value = g_malloc0(char_info->set_len);
+	}
 
-guint device_add_disconnect_watch(struct btd_device *device,
-				disconnect_watch watch, void *user_data,
-				GDestroyNotify destroy)
-{
-	struct btd_disconnect_data *data;
-	static guint id = 0;
+	char_info->vlen = char_info->set_len;
+	memcpy(char_info->value, char_info->set_value, char_info->set_len);
 
-	data = g_new0(struct btd_disconnect_data, 1);
-	data->id = ++id;
-	data->watch = watch;
-	data->user_data = user_data;
-	data->destroy = destroy;
+	g_free(char_info->set_value);
+	char_info->set_len = 0;
 
-	device->watches = g_slist_append(device->watches, data);
+	reply = dbus_message_new_method_return(char_info->msg);
 
-	return data->id;
+	g_dbus_emit_property_changed(dbus_conn, char_info->char_path,
+						GATT_CHR_IFACE, "Value");
+done:
+	g_dbus_send_message(dbus_conn, reply);
+	dbus_message_unref(char_info->msg);
+	char_info->msg = NULL;
 }
 
-void device_remove_disconnect_watch(struct btd_device *device, guint id)
+static void desc_read_value_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
 {
-	GSList *l;
+	struct desc_info_search *desc_info = user_data;
+	uint8_t value[plen];
+	ssize_t vlen;
+	DBusMessage *reply;
 
-	for (l = device->watches; l; l = l->next) {
-		struct btd_disconnect_data *data = l->data;
+	if (status != 0) {
+		reply = btd_error_failed(desc_info->msg,
+					att_ecode2str(status));
+		goto done;
+	}
 
-		if (data->id == id) {
-			device->watches = g_slist_remove(device->watches,
-							data);
-			if (data->destroy)
-				data->destroy(data->user_data);
-			g_free(data);
-			return;
-		}
+	vlen = dec_read_resp(pdu, plen, value, sizeof(value));
+	if (vlen < 0) {
+		reply = btd_error_failed(desc_info->msg,
+					"Protocol error");
+		goto done;
 	}
-}
 
-static char *load_cached_name(struct btd_device *device, const char *local,
-				const char *peer)
-{
-	char filename[PATH_MAX];
-	GKeyFile *key_file;
-	char *str = NULL;
-	int len;
+	if ((desc_info->vlen != vlen) ||
+			(read_value_cmp(desc_info->value, value, vlen))) {
+		if (desc_info->vlen < vlen) {
+			g_free(desc_info->value);
+			desc_info->value = g_malloc0(vlen);
+		}
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", local, peer);
+		memcpy(desc_info->value, value, vlen);
+		desc_info->vlen = vlen;
 
-	key_file = g_key_file_new();
+		g_dbus_emit_property_changed(dbus_conn, desc_info->desc_path,
+						GATT_DESCRIPTOR_IFACE, "Value");
+	}
 
-	if (!g_key_file_load_from_file(key_file, filename, 0, NULL))
-		goto failed;
+	reply = dbus_message_new_method_return(desc_info->msg);
 
-	str = g_key_file_get_string(key_file, "General", "Name", NULL);
-	if (str) {
-		len = strlen(str);
-		if (len > HCI_MAX_NAME_LENGTH)
-			str[HCI_MAX_NAME_LENGTH] = '\0';
-	}
+	dbus_message_append_args(reply,
+			DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE,
+			&desc_info->value,
+			desc_info->vlen,
+			DBUS_TYPE_INVALID);
 
-failed:
-	g_key_file_free(key_file);
+done:
+	dbus_message_unref(desc_info->msg);
+	desc_info->msg = NULL;
 
-	return str;
+	g_dbus_send_message(dbus_conn, reply);
 }
 
-static void load_info(struct btd_device *device, const char *local,
-			const char *peer, GKeyFile *key_file)
+static void desc_write_req_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
 {
-	char *str;
-	gboolean store_needed = FALSE;
-	gboolean blocked;
-	char **uuids;
-	int source, vendor, product, version;
-	char **techno, **t;
+	struct desc_info_search *desc_info = user_data;
+	DBusMessage *reply;
 
-	/* Load device name from storage info file, if that fails fall back to
-	 * the cache.
-	 */
-	str = g_key_file_get_string(key_file, "General", "Name", NULL);
-	if (str == NULL) {
-		str = load_cached_name(device, local, peer);
-		if (str)
-			store_needed = TRUE;
+	if (status != 0) {
+		reply = btd_error_failed(desc_info->msg,
+					att_ecode2str(status));
+		g_dbus_send_message(dbus_conn, reply);
+		goto done;
 	}
 
-	if (str) {
-		strcpy(device->name, str);
-		g_free(str);
+	if (!dec_write_resp(pdu, plen) && !dec_exec_write_resp(pdu, plen)) {
+		reply = btd_error_failed(desc_info->msg,
+					"Protocol error");
+		g_dbus_send_message(dbus_conn, reply);
+		goto done;
 	}
 
-	/* Load alias */
-	device->alias = g_key_file_get_string(key_file, "General", "Alias",
-									NULL);
-
-	/* Load class */
-	str = g_key_file_get_string(key_file, "General", "Class", NULL);
-	if (str) {
-		uint32_t class;
+	DBG("Descriptor value was written successfully");
 
-		if (sscanf(str, "%x", &class) == 1)
-			device->class = class;
-		g_free(str);
+	if (desc_info->vlen < desc_info->set_len) {
+		g_free(desc_info->value);
+		desc_info->value = g_malloc0(desc_info->set_len);
 	}
 
-	/* Load appearance */
-	str = g_key_file_get_string(key_file, "General", "Appearance", NULL);
-	if (str) {
-		device->appearance = strtol(str, NULL, 16);
-		g_free(str);
-	}
+	desc_info->vlen = desc_info->set_len;
+	memcpy(desc_info->value, desc_info->set_value, desc_info->set_len);
 
-	/* Load device technology */
-	techno = g_key_file_get_string_list(key_file, "General",
-					"SupportedTechnologies", NULL, NULL);
-	if (!techno)
-		goto next;
+	g_free(desc_info->set_value);
+	desc_info->set_len = 0;
 
-	for (t = techno; *t; t++) {
-		if (g_str_equal(*t, "BR/EDR"))
-			device->bredr = true;
-		else if (g_str_equal(*t, "LE"))
-			device->le = true;
-		else
-			error("Unknown device technology");
-	}
+	g_dbus_emit_property_changed(dbus_conn, desc_info->desc_path,
+					GATT_DESCRIPTOR_IFACE, "Value");
+done:
+	dbus_message_unref(desc_info->msg);
+	desc_info->msg = NULL;
+}
 
-	if (!device->le) {
-		device->bdaddr_type = BDADDR_BREDR;
-	} else {
-		str = g_key_file_get_string(key_file, "General",
-						"AddressType", NULL);
+static int get_char_flags_array(struct char_info_search *char_info)
+{
+	char **prop_array;
+	int size, length, i = 0;
+	uint8_t properties = char_info->chr->properties;
 
-		if (str && g_str_equal(str, "public"))
-			device->bdaddr_type = BDADDR_LE_PUBLIC;
-		else if (str && g_str_equal(str, "static"))
-			device->bdaddr_type = BDADDR_LE_RANDOM;
-		else
-			error("Unknown LE device technology");
+	size = prop_bit_count(properties);
 
-		g_free(str);
-	}
+	char_info->prop_array = (char **)g_malloc0(sizeof(char*)*size);
 
-	g_strfreev(techno);
+	prop_array = char_info->prop_array;
 
-next:
-	/* Load trust */
-	device->trusted = g_key_file_get_boolean(key_file, "General",
-							"Trusted", NULL);
+	if (prop_array != NULL) {
+		if (properties & GATT_CHR_PROP_BROADCAST) {
+			length = strlen("broadcast");
+			*(prop_array+i) =
+				(char *)g_malloc0(sizeof(char*)*length);
+			strcpy(*(prop_array+i), "broadcast");
+			i++;
+		}
 
-	/* Load device blocked */
-	blocked = g_key_file_get_boolean(key_file, "General", "Blocked", NULL);
-	if (blocked)
-		device_block(device, FALSE);
+		if (properties & GATT_CHR_PROP_READ) {
+			length = strlen("read");
+			*(prop_array+i) =
+				(char *)g_malloc0(sizeof(char*)*length);
+			strcpy(*(prop_array+i), "read");
+			i++;
+		}
 
-	/* Load device profile list */
-	uuids = g_key_file_get_string_list(key_file, "General", "Services",
-						NULL, NULL);
-	if (uuids) {
-		char **uuid;
+		if (properties & GATT_CHR_PROP_WRITE_WITHOUT_RESP) {
+			length = strlen("write-without-response");
+			*(prop_array+i) =
+				(char *)g_malloc0(sizeof(char*)*length);
+			strcpy(*(prop_array+i), "write-without-response");
+			i++;
+		}
 
-		for (uuid = uuids; *uuid; uuid++) {
-			GSList *match;
+		if (properties & GATT_CHR_PROP_WRITE) {
+			length = strlen("write");
+			*(prop_array+i) =
+				(char *)g_malloc0(sizeof(char*)*length);
+			strcpy(*(prop_array+i), "write");
+			i++;
+		}
 
-			match = g_slist_find_custom(device->uuids, *uuid,
-							bt_uuid_strcmp);
-			if (match)
-				continue;
+		if (properties & GATT_CHR_PROP_NOTIFY) {
+			length = strlen("notify");
+			*(prop_array+i) =
+				(char *)g_malloc0(sizeof(char*)*length);
+			strcpy(*(prop_array+i), "notify");
+			i++;
+		}
 
-			device->uuids = g_slist_insert_sorted(device->uuids,
-								g_strdup(*uuid),
-								bt_uuid_strcmp);
+		if (properties & GATT_CHR_PROP_INDICATE) {
+			length = strlen("indicate");
+			*(prop_array+i) =
+				(char *)g_malloc0(sizeof(char*)*length);
+			strcpy(*(prop_array+i), "indicate");
+			i++;
 		}
-		g_strfreev(uuids);
 
-		/* Discovered services restored from storage */
-		device->bredr_state.svc_resolved = true;
+		if (properties & GATT_CHR_PROP_AUTH) {
+			length = strlen("authenticated-signed-writes");
+			*(prop_array+i) =
+				(char *)g_malloc0(sizeof(char*)*length);
+			strcpy(*(prop_array+i), "authenticated-signed-writes");
+			i++;
+		}
 	}
 
-	/* Load device id */
-	source = g_key_file_get_integer(key_file, "DeviceID", "Source", NULL);
-	if (source) {
-		vendor = g_key_file_get_integer(key_file, "DeviceID",
-							"Vendor", NULL);
+	return size;
+}
 
-		product = g_key_file_get_integer(key_file, "DeviceID",
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
+static gboolean service_get_primary(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct service_info_search *service_info = data;
+	gboolean val = service_info->primary;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &val);
+
+	return TRUE;
+}
+
+static gboolean service_get_device(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct service_info_search *service_info = data;
+	const char *str = service_info->device->path;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &str);
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
+static DBusMessage *char_read_value(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
+{
+	struct char_info_search *char_info = user_data;
+	struct btd_device *device = char_info->service_info->device;
+	uint8_t properties = char_info->chr->properties;
+
+	if (properties & GATT_CHR_PROP_READ) {
+		char_info->msg = dbus_message_ref(msg);
+
+		gatt_read_char(device->attrib,
+				char_info->chr->value_handle,
+				char_read_value_cb, char_info);
+	} else
+		return btd_error_not_supported(msg);
+
+	return NULL;
+}
+
+static DBusMessage *char_write_value(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
+{
+	struct char_info_search *char_info = user_data;
+	struct btd_device *device = char_info->service_info->device;
+	DBusMessageIter iter, sub;
+	uint8_t propmask;
+	uint8_t *value;
+	int len;
+
+	DBG("");
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return btd_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY ||
+		dbus_message_iter_get_element_type(&iter) != DBUS_TYPE_BYTE)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_recurse(&iter, &sub);
+
+	dbus_message_iter_get_fixed_array(&sub, &value, &len);
+
+	propmask = char_info->chr->properties;
+
+	if (len == 0)
+		return btd_error_invalid_args(msg);
+
+	if (propmask & GATT_CHR_PROP_WRITE) {
+		char_info->msg = dbus_message_ref(msg);
+		char_info->set_value = g_memdup(value, len);
+		char_info->set_len = len;
+
+		gatt_write_char(device->attrib, char_info->chr->value_handle,
+				value, len, char_write_req_cb, char_info);
+	} else if (propmask & GATT_CHR_PROP_WRITE_WITHOUT_RESP) {
+		gatt_write_cmd(device->attrib, char_info->chr->value_handle,
+						value, len, NULL, NULL);
+		char_info->vlen = 0;
+	} else
+		return btd_error_not_supported(msg);
+
+	return NULL;
+}
+
+static DBusMessage *start_notify(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
+{
+	struct char_info_search *char_info = user_data;
+	struct btd_device *device = char_info->service_info->device;
+	uint8_t properties = char_info->chr->properties;
+	GSList *desc_info_list = char_info->desc_info_list;
+	GSList *l;
+	uint8_t attr_val[2];
+	int len;
+
+	if (properties & GATT_CHR_PROP_NOTIFY) {
+		if (char_info->notified)
+			return btd_error_busy(msg);
+
+		for (l = desc_info_list; l; l = l->next) {
+			struct desc_info_search *desc_info = l->data;
+
+			if (desc_info->desc->uuid16 ==
+					GATT_CLIENT_CHARAC_CFG_UUID) {
+				put_le16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT,
+							attr_val);
+				len = sizeof(attr_val);
+
+				desc_info->set_value =
+					g_memdup(attr_val, len);
+				desc_info->set_len = len;
+				desc_info->msg = dbus_message_ref(msg);
+
+				gatt_write_char(device->attrib,
+						desc_info->desc->handle,
+						attr_val, len,
+						desc_write_req_cb,
+						desc_info);
+			}
+		}
+	} else
+		return btd_error_not_supported(msg);
+
+	return NULL;
+}
+
+static DBusMessage *stop_notify(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
+{
+	struct char_info_search *char_info = user_data;
+	struct btd_device *device = char_info->service_info->device;
+	uint8_t properties = char_info->chr->properties;
+	GSList *desc_info_list = char_info->desc_info_list;
+	GSList *l;
+	uint8_t attr_val[2];
+	int len;
+
+	if (properties & GATT_CHR_PROP_NOTIFY) {
+		if (!char_info->notified)
+			return btd_error_failed(msg, "notify already off");
+
+		for (l = desc_info_list; l; l = l->next) {
+			struct desc_info_search *desc_info = l->data;
+
+			if (desc_info->desc->uuid16 ==
+					GATT_CLIENT_CHARAC_CFG_UUID) {
+				put_le16(0x0000, attr_val);
+				len = sizeof(attr_val);
+
+				desc_info->set_value =
+					g_memdup(attr_val, len);
+				desc_info->set_len = len;
+				desc_info->msg = dbus_message_ref(msg);
+
+				gatt_write_char(device->attrib,
+						desc_info->desc->handle,
+						attr_val, len,
+						desc_write_req_cb,
+						desc_info);
+			}
+		}
+	} else
+		return btd_error_not_supported(msg);
+
+	return NULL;
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
+static gboolean chr_exist_value(const GDBusPropertyTable *property,
+							void *data)
+{
+	struct char_info_search *char_info = data;
+
+	if (char_info->vlen)
+		return TRUE;
+	else
+		return FALSE;
+}
+
+static gboolean chr_get_notifying(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct char_info_search *char_info = data;
+	uint8_t properties = char_info->chr->properties;
+	gboolean val;
+
+	if (properties & GATT_CHR_PROP_NOTIFY)
+		val = char_info->notified;
+	else
+		val = FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &val);
+
+	return TRUE;
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
+static DBusMessage *desc_read_value(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
+{
+	struct desc_info_search *desc_info = user_data;
+	struct char_info_search *char_info = desc_info->char_info;
+	struct btd_device *device = char_info->service_info->device;
+
+	desc_info->msg = dbus_message_ref(msg);
+
+	gatt_read_char(device->attrib,
+			desc_info->desc->handle,
+			desc_read_value_cb, desc_info);
+
+	return NULL;
+}
+
+static DBusMessage *desc_write_value(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
+{
+	struct desc_info_search *desc_info = user_data;
+	struct char_info_search *char_info = desc_info->char_info;
+	struct btd_device *device = char_info->service_info->device;
+	DBusMessageIter iter, sub;
+	uint8_t *value;
+	int len;
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return btd_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY ||
+		dbus_message_iter_get_element_type(&iter) != DBUS_TYPE_BYTE)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_recurse(&iter, &sub);
+
+	dbus_message_iter_get_fixed_array(&sub, &value, &len);
+
+	desc_info->msg = dbus_message_ref(msg);
+	desc_info->set_value = g_memdup(value, len);
+	desc_info->set_len = len;
+
+	gatt_write_char(device->attrib, desc_info->desc->handle,
+			value, len, desc_write_req_cb, desc_info);
+
+	return NULL;
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
+static gboolean desc_exist_value(const GDBusPropertyTable *property,
+							void *data)
+{
+	struct desc_info_search *desc_info = data;
+
+	if (desc_info->vlen)
+		return TRUE;
+	else
+		return FALSE;
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
+	{ "Primary", "b", service_get_primary },
+	{ "Device", "o", service_get_device },
+	{ "Includes", "ao", service_get_includes, NULL,
+					service_exist_includes },
+	{ }
+};
+
+static const GDBusMethodTable chr_methods[] = {
+	{ GDBUS_ASYNC_METHOD("ReadValue",
+			NULL, GDBUS_ARGS({ "value", "ay" }),
+			char_read_value) },
+	{ GDBUS_ASYNC_METHOD("WriteValue",
+			GDBUS_ARGS({ "value", "ay" }), NULL,
+			char_write_value) },
+	{ GDBUS_ASYNC_METHOD("StartNotify", NULL, NULL, start_notify) },
+	{ GDBUS_ASYNC_METHOD("StopNotify", NULL, NULL, stop_notify) },
+	{ }
+};
+
+static const GDBusPropertyTable chr_properties[] = {
+	{ "UUID",	"s", chr_get_uuid },
+	{ "Service", "o", chr_get_service },
+	{ "Value", "ay", chr_get_value, NULL, chr_exist_value },
+	{ "Notifying", "b", chr_get_notifying },
+	{ "Flags", "as", chr_get_props },
+	{ }
+};
+
+static const GDBusMethodTable desc_methods[] = {
+	{ GDBUS_ASYNC_METHOD("ReadValue",
+			NULL, GDBUS_ARGS({ "value", "ay" }),
+			desc_read_value) },
+	{ GDBUS_ASYNC_METHOD("WriteValue",
+			GDBUS_ARGS({ "value", "ay" }), NULL,
+			desc_write_value) },
+	{ }
+};
+
+static const GDBusPropertyTable desc_properties[] = {
+	{ "UUID",		"s",	desc_get_uuid },
+	{ "Characteristic", "o", desc_get_chr },
+	{ "Value", "ay", desc_get_value, NULL, desc_exist_value },
+	{ }
+};
+
+uint8_t btd_device_get_bdaddr_type(struct btd_device *dev)
+{
+	return dev->bdaddr_type;
+}
+
+bool btd_device_is_connected(struct btd_device *dev)
+{
+	return dev->bredr_state.connected || dev->le_state.connected;
+}
+
+void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type)
+{
+	struct bearer_state *state = get_state(dev, bdaddr_type);
+
+	device_update_last_seen(dev, bdaddr_type);
+
+	if (state->connected) {
+		char addr[18];
+		ba2str(&dev->bdaddr, addr);
+		error("Device %s is already connected", addr);
+		return;
+	}
+
+	/* If this is the first connection over this bearer */
+	if (bdaddr_type == BDADDR_BREDR)
+		device_set_bredr_support(dev);
+	else
+		device_set_le_support(dev, bdaddr_type);
+
+	state->connected = true;
+
+	if (dev->le_state.connected && dev->bredr_state.connected)
+		return;
+
+	g_dbus_emit_property_changed(dbus_conn, dev->path, DEVICE_INTERFACE,
+								"Connected");
+}
+
+void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
+{
+	struct bearer_state *state = get_state(device, bdaddr_type);
+
+	if (!state->connected)
+		return;
+
+	state->connected = false;
+	device->svc_refreshed = false;
+	device->general_connect = FALSE;
+
+	if (device->disconn_timer > 0) {
+		g_source_remove(device->disconn_timer);
+		device->disconn_timer = 0;
+	}
+
+	while (device->disconnects) {
+		DBusMessage *msg = device->disconnects->data;
+
+		g_dbus_send_reply(dbus_conn, msg, DBUS_TYPE_INVALID);
+		device->disconnects = g_slist_remove(device->disconnects, msg);
+		dbus_message_unref(msg);
+	}
+
+	if (state->paired && !state->bonded)
+		btd_adapter_remove_bonding(device->adapter, &device->bdaddr,
+								bdaddr_type);
+
+	if (device->bredr_state.connected || device->le_state.connected)
+		return;
+
+	g_dbus_emit_property_changed(dbus_conn, device->path,
+						DEVICE_INTERFACE, "Connected");
+}
+
+guint device_add_disconnect_watch(struct btd_device *device,
+				disconnect_watch watch, void *user_data,
+				GDestroyNotify destroy)
+{
+	struct btd_disconnect_data *data;
+	static guint id = 0;
+
+	data = g_new0(struct btd_disconnect_data, 1);
+	data->id = ++id;
+	data->watch = watch;
+	data->user_data = user_data;
+	data->destroy = destroy;
+
+	device->watches = g_slist_append(device->watches, data);
+
+	return data->id;
+}
+
+void device_remove_disconnect_watch(struct btd_device *device, guint id)
+{
+	GSList *l;
+
+	for (l = device->watches; l; l = l->next) {
+		struct btd_disconnect_data *data = l->data;
+
+		if (data->id == id) {
+			device->watches = g_slist_remove(device->watches,
+							data);
+			if (data->destroy)
+				data->destroy(data->user_data);
+			g_free(data);
+			return;
+		}
+	}
+}
+
+static char *load_cached_name(struct btd_device *device, const char *local,
+				const char *peer)
+{
+	char filename[PATH_MAX];
+	GKeyFile *key_file;
+	char *str = NULL;
+	int len;
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", local, peer);
+
+	key_file = g_key_file_new();
+
+	if (!g_key_file_load_from_file(key_file, filename, 0, NULL))
+		goto failed;
+
+	str = g_key_file_get_string(key_file, "General", "Name", NULL);
+	if (str) {
+		len = strlen(str);
+		if (len > HCI_MAX_NAME_LENGTH)
+			str[HCI_MAX_NAME_LENGTH] = '\0';
+	}
+
+failed:
+	g_key_file_free(key_file);
+
+	return str;
+}
+
+static void load_info(struct btd_device *device, const char *local,
+			const char *peer, GKeyFile *key_file)
+{
+	char *str;
+	gboolean store_needed = FALSE;
+	gboolean blocked;
+	char **uuids;
+	int source, vendor, product, version;
+	char **techno, **t;
+
+	/* Load device name from storage info file, if that fails fall back to
+	 * the cache.
+	 */
+	str = g_key_file_get_string(key_file, "General", "Name", NULL);
+	if (str == NULL) {
+		str = load_cached_name(device, local, peer);
+		if (str)
+			store_needed = TRUE;
+	}
+
+	if (str) {
+		strcpy(device->name, str);
+		g_free(str);
+	}
+
+	/* Load alias */
+	device->alias = g_key_file_get_string(key_file, "General", "Alias",
+									NULL);
+
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
+	/* Load appearance */
+	str = g_key_file_get_string(key_file, "General", "Appearance", NULL);
+	if (str) {
+		device->appearance = strtol(str, NULL, 16);
+		g_free(str);
+	}
+
+	/* Load device technology */
+	techno = g_key_file_get_string_list(key_file, "General",
+					"SupportedTechnologies", NULL, NULL);
+	if (!techno)
+		goto next;
+
+	for (t = techno; *t; t++) {
+		if (g_str_equal(*t, "BR/EDR"))
+			device->bredr = true;
+		else if (g_str_equal(*t, "LE"))
+			device->le = true;
+		else
+			error("Unknown device technology");
+	}
+
+	if (!device->le) {
+		device->bdaddr_type = BDADDR_BREDR;
+	} else {
+		str = g_key_file_get_string(key_file, "General",
+						"AddressType", NULL);
+
+		if (str && g_str_equal(str, "public"))
+			device->bdaddr_type = BDADDR_LE_PUBLIC;
+		else if (str && g_str_equal(str, "static"))
+			device->bdaddr_type = BDADDR_LE_RANDOM;
+		else
+			error("Unknown LE device technology");
+
+		g_free(str);
+	}
+
+	g_strfreev(techno);
+
+next:
+	/* Load trust */
+	device->trusted = g_key_file_get_boolean(key_file, "General",
+							"Trusted", NULL);
+
+	/* Load device blocked */
+	blocked = g_key_file_get_boolean(key_file, "General", "Blocked", NULL);
+	if (blocked)
+		device_block(device, FALSE);
+
+	/* Load device profile list */
+	uuids = g_key_file_get_string_list(key_file, "General", "Services",
+						NULL, NULL);
+	if (uuids) {
+		char **uuid;
+
+		for (uuid = uuids; *uuid; uuid++) {
+			GSList *match;
+
+			match = g_slist_find_custom(device->uuids, *uuid,
+							bt_uuid_strcmp);
+			if (match)
+				continue;
+
+			device->uuids = g_slist_insert_sorted(device->uuids,
+								g_strdup(*uuid),
+								bt_uuid_strcmp);
+		}
+		g_strfreev(uuids);
+
+		/* Discovered services restored from storage */
+		device->bredr_state.svc_resolved = true;
+	}
+
+	/* Load device id */
+	source = g_key_file_get_integer(key_file, "DeviceID", "Source", NULL);
+	if (source) {
+		vendor = g_key_file_get_integer(key_file, "DeviceID",
+							"Vendor", NULL);
+
+		product = g_key_file_get_integer(key_file, "DeviceID",
 							"Product", NULL);
 
 		version = g_key_file_get_integer(key_file, "DeviceID",
@@ -3534,6 +4367,383 @@ static void send_le_browse_response(struct browse_req *req)
 
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
+		char_info->notified = FALSE;
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
+		if (!char_info->notified && desc_info->value) {
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
+			char_info->notified = TRUE;
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
+static gboolean listen_start(struct btd_device *dev)
+{
+	g_attrib_register(dev->attrib, ATT_OP_HANDLE_NOTIFY,
+				GATTRIB_ALL_HANDLES,
+				gatt_notify_handler,
+				NULL, NULL);
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
+						desc_methods, NULL,
+						desc_properties, desc_info,
+						desc_info_destroy)) {
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
+		char_info->notified = FALSE;
+
+		char_info->vlen = 0;
+
+		char_info->msg = NULL;
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
+					GATT_CHR_IFACE, chr_methods,
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
+	if (search->primary_count > 0) {
+		service_info->primary = TRUE;
+		search->primary_count--;
+	} else
+		service_info->primary = FALSE;
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
 
 static void find_included_cb(uint8_t status, GSList *includes, void *user_data)
 {
@@ -3563,8 +4773,11 @@ static void find_included_cb(uint8_t status, GSList *includes, void *user_data)
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
@@ -3581,10 +4794,13 @@ static void find_included_cb(uint8_t status, GSList *includes, void *user_data)
 	}
 
 next:
+	register_service(search);
+
 	search->current = search->current->next;
 	if (search->current == NULL) {
 		register_all_services(search->req, search->services);
 		search->services = NULL;
+		listen_start(device);
 		goto complete;
 	}
 
@@ -3615,6 +4831,7 @@ static void find_included_services(struct browse_req *req, GSList *services)
 
 	search = g_new0(struct included_search, 1);
 	search->req = req;
+	search->primary_count = g_slist_length(services);
 
 	/* We have to completely duplicate the data in order to have a
 	 * clearly defined responsibility of freeing regardless of
@@ -3767,6 +4984,11 @@ done:
 		g_dbus_send_message(dbus_conn, reply);
 		dbus_message_unref(device->connect);
 		device->connect = NULL;
+	} else {
+		if (!device->le_state.svc_resolved)
+			device_browse_primary(device, NULL);
+		else
+			listen_start(device);
 	}
 
 	g_free(attcb);
-- 
1.7.9.5

