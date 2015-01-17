Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 2/2] core: device: Fix broken GATT UUID management
Date: Fri, 16 Jan 2015 19:26:31 -0800
Message-Id: <1421465191-1494-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1421465191-1494-1-git-send-email-armansito@chromium.org>
References: <1421465191-1494-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes the broken GATT UUID management, which incorrectly
remove valid UUIDs during the GATT profile probe process. This is
achieved by splitting UUIDs obtained via GATT and SDP into their own
lists that are internal to btd_device. At the end of each probe, all
invalid services are now removed from the UUID lists and their profiles
are unloaded.

We initially load the legacy UUIDs list if it exists but once a
connection is established, we migrate the older UUIDs to the new
formats. Profile probing is deferred until connection establishment and
service discovery.
---
 plugins/sixaxis.c |   2 +-
 src/adapter.c     |   8 +-
 src/device.c      | 389 +++++++++++++++++++++++++++++++++++++++---------------
 src/device.h      |   6 +-
 4 files changed, 296 insertions(+), 109 deletions(-)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index ac53ba9..0a4e3d8 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -289,7 +289,7 @@ static bool setup_device(int fd, int index, struct btd_adapter *adapter)
 
 	device = btd_adapter_get_device(adapter, &device_bdaddr, BDADDR_BREDR);
 
-	if (g_slist_find_custom(btd_device_get_uuids(device), HID_UUID,
+	if (g_slist_find_custom(btd_device_get_sdp_uuids(device), HID_UUID,
 						(GCompareFunc)strcasecmp)) {
 		DBG("device %s already known, skipping", device_addr);
 		return true;
diff --git a/src/adapter.c b/src/adapter.c
index 1839286..c86d6e2 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2912,9 +2912,13 @@ static void load_devices(struct btd_adapter *adapter)
 
 		/* TODO: register services from pre-loaded list of primaries */
 
-		list = btd_device_get_uuids(device);
+		list = btd_device_get_sdp_uuids(device);
 		if (list)
-			device_probe_profiles(device, list);
+			device_probe_profiles(device, list, false);
+
+		list = btd_device_get_gatt_uuids(device);
+		if (list)
+			device_probe_profiles(device, list, true);
 
 device_exist:
 		if (key_info) {
diff --git a/src/device.c b/src/device.c
index d2b2947..ea5f357 100644
--- a/src/device.c
+++ b/src/device.c
@@ -169,6 +169,7 @@ struct bearer_state {
 	bool bonded;
 	bool connected;
 	bool svc_resolved;
+	GSList *uuids;
 };
 
 struct btd_device {
@@ -193,7 +194,7 @@ struct btd_device {
 	uint16_t	appearance;
 	char		*modalias;
 	struct btd_adapter	*adapter;
-	GSList		*uuids;
+	GSList		*legacy_uuids;
 	GSList		*primaries;		/* List of primary services */
 	GSList		*services;		/* List of btd_service */
 	GSList		*pending;		/* Pending services */
@@ -335,6 +336,28 @@ static void update_technologies(GKeyFile *file, struct btd_device *dev)
 								list, len);
 }
 
+static char **store_service_uuids(GKeyFile *key_file, gchar *key, GSList *uuids)
+{
+	GSList *l;
+	char **array;
+	int i;
+
+	if (!uuids) {
+		g_key_file_remove_key(key_file, "General", key, NULL);
+		return NULL;
+	}
+
+	array = g_new0(char *, g_slist_length(uuids) + 1);
+
+	for (i = 0, l = uuids; l; l = g_slist_next(l), i++)
+		array[i] = l->data;
+
+	g_key_file_set_string_list(key_file, "General", key,
+						(const char **)array, i);
+
+	return array;
+}
+
 static gboolean store_device_info_cb(gpointer user_data)
 {
 	struct btd_device *device = user_data;
@@ -344,7 +367,7 @@ static gboolean store_device_info_cb(gpointer user_data)
 	char device_addr[18];
 	char *str;
 	char class[9];
-	char **uuids = NULL;
+	char **sdp_uuids, **gatt_uuids;
 	gsize length = 0;
 
 	device->store_id = 0;
@@ -387,18 +410,17 @@ static gboolean store_device_info_cb(gpointer user_data)
 	g_key_file_set_boolean(key_file, "General", "Blocked",
 							device->blocked);
 
-	if (device->uuids) {
-		GSList *l;
-		int i;
-
-		uuids = g_new0(char *, g_slist_length(device->uuids) + 1);
-		for (i = 0, l = device->uuids; l; l = g_slist_next(l), i++)
-			uuids[i] = l->data;
-		g_key_file_set_string_list(key_file, "General", "Services",
-						(const char **)uuids, i);
-	} else {
+	/*
+	 * Remove the legacy-format "Services" entry if we have new data to
+	 * populate for either GATT or SDP after a connection.
+	 */
+	if (device->bredr_state.uuids || device->le_state.uuids)
 		g_key_file_remove_key(key_file, "General", "Services", NULL);
-	}
+
+	sdp_uuids = store_service_uuids(key_file, "SDPServices",
+						device->bredr_state.uuids);
+	gatt_uuids = store_service_uuids(key_file, "GATTServices",
+						device->le_state.uuids);
 
 	if (device->vendor_src) {
 		g_key_file_set_integer(key_file, "DeviceID", "Source",
@@ -420,7 +442,8 @@ static gboolean store_device_info_cb(gpointer user_data)
 	g_free(str);
 
 	g_key_file_free(key_file);
-	g_free(uuids);
+	g_free(sdp_uuids);
+	g_free(gatt_uuids);
 
 	return FALSE;
 }
@@ -574,7 +597,9 @@ static void device_free(gpointer user_data)
 	btd_gatt_client_destroy(device->client_dbus);
 	device->client_dbus = NULL;
 
-	g_slist_free_full(device->uuids, g_free);
+	g_slist_free_full(device->bredr_state.uuids, g_free);
+	g_slist_free_full(device->le_state.uuids, g_free);
+	g_slist_free_full(device->legacy_uuids, g_free);
 	g_slist_free_full(device->primaries, g_free);
 	g_slist_free_full(device->attios, g_free);
 	g_slist_free_full(device->attios_offline, g_free);
@@ -988,22 +1013,51 @@ static gboolean dev_property_get_uuids(const GDBusPropertyTable *property,
 {
 	struct btd_device *dev = data;
 	DBusMessageIter entry;
-	GSList *l;
+	GHashTable *uuids = NULL;
+	GSList *sl;
+	GList *keys, *l;
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
 				DBUS_TYPE_STRING_AS_STRING, &entry);
 
-	if (dev->bredr_state.svc_resolved || dev->le_state.svc_resolved)
-		l = dev->uuids;
-	else if (dev->eir_uuids)
-		l = dev->eir_uuids;
-	else
-		l = dev->uuids;
+	if (!dev->bredr_state.svc_resolved && dev->le_state.svc_resolved &&
+							dev->eir_uuids) {
+		for (sl = dev->eir_uuids; sl; sl = g_slist_next(sl))
+			dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
+								&sl->data);
+
+		goto done;
+	}
+
+	if (!dev->bredr_state.uuids && !dev->le_state.uuids) {
+		for (sl = dev->legacy_uuids; sl; sl = g_slist_next(sl))
+			dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
+								&sl->data);
+
+		goto done;
+	}
+
+	/* Insert GATT and SDP UUIDs into a set to prevent any duplicates */
+	uuids = g_hash_table_new(g_str_hash, bt_uuid_strcmp);
 
-	for (; l != NULL; l = l->next)
+	for (sl = dev->bredr_state.uuids; sl; sl = g_slist_next(sl))
+		g_hash_table_add(uuids, sl->data);
+
+	for (sl = dev->le_state.uuids; sl; sl = g_slist_next(sl))
+		g_hash_table_add(uuids, sl->data);
+
+	/* Obtain a list of UUIDs and sort it */
+	keys = g_hash_table_get_keys(uuids);
+	keys = g_list_sort(keys, bt_uuid_strcmp);
+
+	for (l = keys; l; l = g_list_next(l))
 		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
-							&l->data);
+								&l->data);
 
+	g_list_free(keys);
+	g_hash_table_destroy(uuids);
+
+done:
 	dbus_message_iter_close_container(iter, &entry);
 
 	return TRUE;
@@ -1130,7 +1184,8 @@ int device_unblock(struct btd_device *device, gboolean silent,
 	if (!silent) {
 		g_dbus_emit_property_changed(dbus_conn, device->path,
 						DEVICE_INTERFACE, "Blocked");
-		device_probe_profiles(device, device->uuids);
+		device_probe_profiles(device, device->bredr_state.uuids, false);
+		device_probe_profiles(device, device->le_state.uuids, true);
 	}
 
 	return 0;
@@ -2168,6 +2223,66 @@ failed:
 	return str;
 }
 
+static bool device_add_uuid(GSList **uuids, const char *uuid)
+{
+	if (g_slist_find_custom(*uuids, uuid, bt_uuid_strcmp))
+		return false;
+
+	*uuids = g_slist_insert_sorted(*uuids, g_strdup(uuid), bt_uuid_strcmp);
+
+	return true;
+}
+
+static bool device_add_uuids(struct btd_device *device, GSList **uuids,
+							GSList *new_uuids)
+{
+	GSList *l;
+	bool changed = false;
+
+	for (l = new_uuids; l; l = g_slist_next(l)) {
+		if (device_add_uuid(uuids, l->data))
+			changed = true;
+	}
+
+	if (changed)
+		g_dbus_emit_property_changed(dbus_conn, device->path,
+						DEVICE_INTERFACE, "UUIDs");
+
+	return changed;
+}
+
+static bool device_add_sdp_uuid(struct btd_device *device, const char *uuid)
+{
+	return device_add_uuid(&device->bredr_state.uuids, uuid);
+}
+
+static bool device_add_sdp_uuids(struct btd_device *device, GSList *uuids)
+{
+	return device_add_uuids(device, &device->bredr_state.uuids, uuids);
+}
+
+static bool device_add_gatt_uuid(struct btd_device *device, const char *uuid)
+{
+	return device_add_uuid(&device->le_state.uuids, uuid);
+}
+
+static bool device_add_gatt_uuids(struct btd_device *device, GSList *uuids)
+{
+	return device_add_uuids(device, &device->le_state.uuids, uuids);
+}
+
+static void device_remove_gatt_uuid(struct btd_device *device, const char *uuid)
+{
+	GSList *l;
+
+	l = g_slist_find_custom(device->le_state.uuids, uuid, bt_uuid_strcmp);
+	if (!l)
+		return;
+
+	g_free(l->data);
+	device->le_state.uuids = g_slist_delete_link(device->le_state.uuids, l);
+}
+
 static void load_info(struct btd_device *device, const char *local,
 			const char *peer, GKeyFile *key_file)
 {
@@ -2257,30 +2372,58 @@ next:
 	if (blocked)
 		device_block(device, FALSE);
 
-	/* Load device profile list */
+	/*
+	 * Load legacy, mixed profile list, to display UUIDs before a
+	 * connection. We immediately load the values and then clear the stored
+	 * value.
+	 */
 	uuids = g_key_file_get_string_list(key_file, "General", "Services",
-						NULL, NULL);
+								NULL, NULL);
 	if (uuids) {
 		char **uuid;
 
-		for (uuid = uuids; *uuid; uuid++) {
-			GSList *match;
+		for (uuid = uuids; *uuid; uuid++)
+			device->legacy_uuids = g_slist_append(
+							device->legacy_uuids,
+							g_strdup(*uuid));
 
-			match = g_slist_find_custom(device->uuids, *uuid,
-							bt_uuid_strcmp);
-			if (match)
-				continue;
+		g_strfreev(uuids);
+	}
+
+	/* Load classic device profile list */
+	uuids = g_key_file_get_string_list(key_file, "General", "SDPServices",
+								NULL, NULL);
+	if (uuids) {
+		char **uuid;
+
+		for (uuid = uuids; *uuid; uuid++)
+			device_add_sdp_uuid(device, *uuid);
 
-			device->uuids = g_slist_insert_sorted(device->uuids,
-								g_strdup(*uuid),
-								bt_uuid_strcmp);
-		}
 		g_strfreev(uuids);
 
 		/* Discovered services restored from storage */
 		device->bredr_state.svc_resolved = true;
 	}
 
+	/* Load GATT-based device profile list */
+	uuids = g_key_file_get_string_list(key_file, "General", "GATTServices",
+								NULL, NULL);
+	if (uuids) {
+		char **uuid;
+
+		for (uuid = uuids; *uuid; uuid++)
+			device_add_gatt_uuid(device, *uuid);
+
+		g_strfreev(uuids);
+
+		/*
+		 * TODO: The GATT-based service UUIDs have been restored from
+		 * storage but we don't have a populated gatt-db yet. Here we
+		 * should mark le_state.svc_resolved as true, if we're bonded
+		 * and we have a populated gatt_db.
+		 */
+	}
+
 	/* Load device id */
 	source = g_key_file_get_integer(key_file, "DeviceID", "Source", NULL);
 	if (source) {
@@ -2414,34 +2557,13 @@ static void add_primary(struct gatt_db_attribute *attr, void *user_data)
 	*new_services = g_slist_append(*new_services, prim);
 }
 
-static void device_add_uuids(struct btd_device *device, GSList *uuids)
-{
-	GSList *l;
-	bool changed = false;
-
-	for (l = uuids; l != NULL; l = g_slist_next(l)) {
-		GSList *match = g_slist_find_custom(device->uuids, l->data,
-							bt_uuid_strcmp);
-		if (match)
-			continue;
-
-		changed = true;
-		device->uuids = g_slist_insert_sorted(device->uuids,
-						g_strdup(l->data),
-						bt_uuid_strcmp);
-	}
-
-	if (changed)
-		g_dbus_emit_property_changed(dbus_conn, device->path,
-						DEVICE_INTERFACE, "UUIDs");
-}
-
 static void store_services(struct btd_device *device);
 
 struct gatt_probe_data {
 	struct btd_device *dev;
 	bool all_services;
-	GSList *uuids;
+	GSList *new_uuids;
+	GSList *old_uuids;
 	struct gatt_db_attribute *cur_attr;
 	char cur_uuid[MAX_LEN_UUID_STR];
 };
@@ -2491,20 +2613,31 @@ static void dev_probe_gatt_profile(struct gatt_db_attribute *attr,
 {
 	struct gatt_probe_data *data = user_data;
 	bt_uuid_t uuid;
-	GSList *l = NULL;
+	gpointer dup_uuid;
 
 	gatt_db_attribute_get_service_uuid(attr, &uuid);
 	bt_uuid_to_string(&uuid, data->cur_uuid, sizeof(data->cur_uuid));
 
 	data->cur_attr = attr;
 
-	/*
-	 * If we're probing for all services, store the UUID since device->uuids
-	 * was cleared.
-	 */
-	if (data->all_services)
-		data->uuids = g_slist_append(data->uuids,
+	if (data->all_services) {
+		GSList *l;
+
+		/*
+		 * Check if the service is already in the old UUIDs list. If so,
+		 * remove it.
+		 */
+		l = g_slist_find_custom(data->old_uuids, data->cur_uuid,
+								bt_uuid_strcmp);
+		if (l) {
+			g_free(l->data);
+			data->old_uuids = g_slist_delete_link(data->old_uuids,
+									l);
+		} else {
+			data->new_uuids = g_slist_append(data->new_uuids,
 						g_strdup(data->cur_uuid));
+		}
+	}
 
 	/* Don't probe the profiles if a matching service already exists. */
 	if (find_service_with_uuid(data->dev->services, data->cur_uuid)) {
@@ -2518,8 +2651,14 @@ static void dev_probe_gatt_profile(struct gatt_db_attribute *attr,
 	if (data->all_services)
 		return;
 
-	l = g_slist_append(l, g_strdup(data->cur_uuid));
-	device_add_uuids(data->dev, l);
+	dup_uuid = g_strdup(data->cur_uuid);
+	if (!device_add_gatt_uuid(data->dev, dup_uuid)) {
+		g_free(dup_uuid);
+		return;
+	}
+
+	g_dbus_emit_property_changed(dbus_conn, data->dev->path,
+						DEVICE_INTERFACE, "UUIDs");
 }
 
 static void device_probe_gatt_profile(struct btd_device *device,
@@ -2532,13 +2671,33 @@ static void device_probe_gatt_profile(struct btd_device *device,
 	data.dev = device;
 
 	dev_probe_gatt_profile(attr, &data);
-	g_slist_free_full(data.uuids, g_free);
+}
+
+static void remove_invalid_services(struct gatt_probe_data *data)
+{
+	struct btd_device *dev = data->dev;
+	struct btd_service *service;
+	GSList *l, *svc;
+
+	for (l = data->old_uuids; l; l = g_slist_next(l)) {
+		device_remove_gatt_uuid(dev, l->data);
+
+		svc = find_service_with_uuid(dev->services, l->data);
+		if (!svc)
+			continue;
+
+		service = svc->data;
+		dev->services = g_slist_delete_link(dev->services, svc);
+		dev->pending = g_slist_remove(dev->pending, service);
+		service_remove(service);
+	}
 }
 
 static void device_probe_gatt_profiles(struct btd_device *device)
 {
 	struct gatt_probe_data data;
 	char addr[18];
+	GSList *l;
 
 	ba2str(&device->bdaddr, addr);
 
@@ -2552,11 +2711,24 @@ static void device_probe_gatt_profiles(struct btd_device *device)
 	data.dev = device;
 	data.all_services = true;
 
+	/* Copy current list of GATT UUIDs */
+	for (l = device->le_state.uuids; l; l = g_slist_next(l))
+		data.old_uuids = g_slist_append(data.old_uuids,
+							g_strdup(l->data));
+
 	gatt_db_foreach_service(device->db, NULL, dev_probe_gatt_profile,
 									&data);
 
-	device_add_uuids(device, data.uuids);
-	g_slist_free_full(data.uuids, g_free);
+	/* Whatever remains in data.old_uuids is stale and should be removed */
+	remove_invalid_services(&data);
+
+	/* Update the list with new UUIDs */
+	if (!device_add_gatt_uuids(device, data.new_uuids) && data.old_uuids)
+		g_dbus_emit_property_changed(dbus_conn, device->path,
+						DEVICE_INTERFACE, "UUIDs");
+
+	g_slist_free_full(data.new_uuids, g_free);
+	g_slist_free_full(data.old_uuids, g_free);
 }
 
 static void device_accept_gatt_profiles(struct btd_device *device)
@@ -2645,45 +2817,38 @@ static gint prim_attr_cmp(gconstpointer a, gconstpointer b)
 	return !(prim->range.start == start && prim->range.end == end);
 }
 
-static gint prim_uuid_cmp(gconstpointer a, gconstpointer b)
-{
-	const struct gatt_primary *prim = a;
-	const char *uuid = b;
-
-	return bt_uuid_strcmp(prim->uuid, uuid);
-}
-
 static void gatt_service_removed(struct gatt_db_attribute *attr,
 								void *user_data)
 {
 	struct btd_device *device = user_data;
 	GSList *l;
-	struct gatt_primary *prim;
 	uint16_t start, end;
+	bt_uuid_t uuid;
+	char uuid_str[MAX_LEN_UUID_STR];
 
 	if (!bt_gatt_client_is_ready(device->client))
 		return;
 
-	gatt_db_attribute_get_service_handles(attr, &start, &end);
+	gatt_db_attribute_get_service_data(attr, &start, &end, NULL, &uuid);
 
 	DBG("start: 0x%04x, end: 0x%04x", start, end);
 
 	/* Remove the corresponding gatt_primary */
 	l = g_slist_find_custom(device->primaries, attr, prim_attr_cmp);
-	if (!l)
-		return;
+	if (l) {
+		g_free(l->data);
+		device->primaries = g_slist_delete_link(device->primaries, l);
+	}
 
-	prim = l->data;
-	device->primaries = g_slist_delete_link(device->primaries, l);
+	bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
 
 	/*
 	 * Remove the corresponding UUIDs entry and profile, only if this is
 	 * the last service with this UUID.
 	 */
-	l = g_slist_find_custom(device->uuids, prim->uuid, bt_uuid_strcmp);
-
-	if (l && !g_slist_find_custom(device->primaries, prim->uuid,
-							prim_uuid_cmp)) {
+	l = g_slist_find_custom(device->le_state.uuids, uuid_str,
+								bt_uuid_strcmp);
+	if (l && !gatt_db_get_service_with_uuid(device->db, &uuid)) {
 		/*
 		 * If this happend since the db was cleared for a non-bonded
 		 * device, then don't remove the btd_service just yet. We do
@@ -2696,13 +2861,12 @@ static void gatt_service_removed(struct gatt_db_attribute *attr,
 			device_remove_gatt_profile(device, attr);
 
 		g_free(l->data);
-		device->uuids = g_slist_delete_link(device->uuids, l);
+		device->le_state.uuids = g_slist_delete_link(
+						device->le_state.uuids, l);
 		g_dbus_emit_property_changed(dbus_conn, device->path,
 						DEVICE_INTERFACE, "UUIDs");
 	}
 
-	g_free(prim);
-
 	store_device_info(device);
 
 	btd_gatt_client_service_removed(device->client_dbus, attr);
@@ -2957,8 +3121,13 @@ void device_merge_duplicate(struct btd_device *dev, struct btd_device *dup)
 	dev->trusted = dup->trusted;
 	dev->blocked = dup->blocked;
 
-	for (l = dup->uuids; l; l = g_slist_next(l))
-		dev->uuids = g_slist_append(dev->uuids, g_strdup(l->data));
+	for (l = dup->bredr_state.uuids; l; l = g_slist_next(l))
+		dev->bredr_state.uuids = g_slist_append(dev->bredr_state.uuids,
+							g_strdup(l->data));
+
+	for (l = dup->le_state.uuids; l; l = g_slist_next(l))
+		dev->le_state.uuids = g_slist_append(dev->le_state.uuids,
+							g_strdup(l->data));
 
 	if (dev->name[0] == '\0')
 		strcpy(dev->name, dup->name);
@@ -3209,9 +3378,14 @@ static gboolean record_has_uuid(const sdp_record_t *rec,
 	return FALSE;
 }
 
-GSList *btd_device_get_uuids(struct btd_device *device)
+GSList *btd_device_get_sdp_uuids(struct btd_device *device)
 {
-	return device->uuids;
+	return device->bredr_state.uuids;
+}
+
+GSList *btd_device_get_gatt_uuids(struct btd_device *device)
+{
+	return device->le_state.uuids;
 }
 
 struct probe_data {
@@ -3249,7 +3423,8 @@ void device_probe_profile(gpointer a, gpointer b)
 	if (profile->device_probe == NULL)
 		return;
 
-	if (!device_match_profile(device, profile, device->uuids))
+	if (!device_match_profile(device, profile, device->bredr_state.uuids) &&
+		!device_match_profile(device, profile, device->le_state.uuids))
 		return;
 
 	service = service_create(device, profile);
@@ -3287,7 +3462,8 @@ void device_remove_profile(gpointer a, gpointer b)
 	service_remove(service);
 }
 
-void device_probe_profiles(struct btd_device *device, GSList *uuids)
+void device_probe_profiles(struct btd_device *device, GSList *uuids,
+								bool gatt)
 {
 	struct probe_data d = { device, uuids };
 	char addr[18];
@@ -3304,7 +3480,10 @@ void device_probe_profiles(struct btd_device *device, GSList *uuids)
 	btd_profile_foreach(dev_probe, &d);
 
 add_uuids:
-	device_add_uuids(device, uuids);
+	if (gatt)
+		device_add_gatt_uuids(device, uuids);
+	else
+		device_add_sdp_uuids(device, uuids);
 }
 
 static void store_sdp_record(GKeyFile *key_file, sdp_record_t *rec)
@@ -3400,7 +3579,8 @@ static int update_record(struct browse_req *req, const char *uuid,
 	req->records = sdp_list_append(req->records, sdp_copy_record(rec));
 
 	/* Check if UUID is duplicated */
-	l = g_slist_find_custom(req->device->uuids, uuid, bt_uuid_strcmp);
+	l = g_slist_find_custom(req->device->bredr_state.uuids, uuid,
+								bt_uuid_strcmp);
 	if (l == NULL) {
 		l = g_slist_find_custom(req->profiles_added, uuid,
 							bt_uuid_strcmp);
@@ -3631,7 +3811,7 @@ static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
 	 * the full list of services and populate a client-role gatt_db over
 	 * BR/EDR.
 	 */
-	device_probe_profiles(device, req->profiles_added);
+	device_probe_profiles(device, req->profiles_added, false);
 
 	/* Propagate services changes */
 	g_dbus_emit_property_changed(dbus_conn, req->device->path,
@@ -5090,13 +5270,14 @@ void btd_device_add_uuid(struct btd_device *device, const char *uuid)
 	GSList *uuid_list;
 	char *new_uuid;
 
-	if (g_slist_find_custom(device->uuids, uuid, bt_uuid_strcmp))
+	if (g_slist_find_custom(device->bredr_state.uuids, uuid,
+								bt_uuid_strcmp))
 		return;
 
 	new_uuid = g_strdup(uuid);
 	uuid_list = g_slist_append(NULL, new_uuid);
 
-	device_probe_profiles(device, uuid_list);
+	device_probe_profiles(device, uuid_list, false);
 
 	g_free(new_uuid);
 	g_slist_free(uuid_list);
diff --git a/src/device.h b/src/device.h
index a7fefee..f250bfa 100644
--- a/src/device.h
+++ b/src/device.h
@@ -60,8 +60,10 @@ struct device_addr_type {
 };
 
 int device_addr_type_cmp(gconstpointer a, gconstpointer b);
-GSList *btd_device_get_uuids(struct btd_device *device);
-void device_probe_profiles(struct btd_device *device, GSList *profiles);
+GSList *btd_device_get_sdp_uuids(struct btd_device *device);
+GSList *btd_device_get_gatt_uuids(struct btd_device *device);
+void device_probe_profiles(struct btd_device *device, GSList *profiles,
+								bool gatt);
 const sdp_record_t *btd_device_get_record(struct btd_device *device,
 						const char *uuid);
 struct gatt_primary *btd_device_get_primary(struct btd_device *device,
-- 
2.2.0.rc0.207.ga3a616c

