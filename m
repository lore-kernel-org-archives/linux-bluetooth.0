Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 10/15] core: Use gatt_db service callbacks
Date: Mon,  8 Dec 2014 16:40:50 -0800
Message-Id: <1418085655-7304-11-git-send-email-armansito@chromium.org>
In-Reply-To: <1418085655-7304-1-git-send-email-armansito@chromium.org>
References: <1418085655-7304-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch integrates the gatt_db service callbacks into btd_device.
Based on the event, the device objects UUIDs list is updated and
profiles are probed for new services.

There is currently no mechanism to tell a profile that a service has
been removed, however profiles can use the gatt_db callbacks to make
necessary updates in the future.
---
 src/device.c | 143 ++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 117 insertions(+), 26 deletions(-)

diff --git a/src/device.c b/src/device.c
index 09df701..0bfac1e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2365,6 +2365,119 @@ static void load_att_info(struct btd_device *device, const char *local,
 	free(prim_uuid);
 }
 
+static void device_register_primaries(struct btd_device *device,
+						GSList *prim_list, int psm)
+{
+	device->primaries = g_slist_concat(device->primaries, prim_list);
+}
+
+static void add_primary(struct gatt_db_attribute *attr, void *user_data)
+{
+	GSList **new_services = user_data;
+	struct gatt_primary *prim;
+	bt_uuid_t uuid;
+
+	prim = g_new0(struct gatt_primary, 1);
+	if (!prim) {
+		DBG("Failed to allocate gatt_primary structure");
+		return;
+	}
+
+	gatt_db_attribute_get_service_handles(attr, &prim->range.start,
+							&prim->range.end);
+	gatt_db_attribute_get_service_uuid(attr, &uuid);
+	bt_uuid_to_string(&uuid, prim->uuid, sizeof(prim->uuid));
+
+	*new_services = g_slist_append(*new_services, prim);
+}
+
+static void store_services(struct btd_device *device);
+
+static void gatt_service_added(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct btd_device *device = user_data;
+	struct gatt_primary *prim;
+	GSList *new_service = NULL;
+	GSList *profiles_added = NULL;
+	uint16_t start, end;
+
+	if (!bt_gatt_client_is_ready(device->gatt_client))
+		return;
+
+	gatt_db_attribute_get_service_handles(attr, &start, &end);
+
+	DBG("GATT service added - start: 0x%04x, end: 0x%04x", start, end);
+
+	/*
+	 * TODO: Remove the primaries list entirely once all profiles use
+	 * shared/gatt.
+	 */
+	add_primary(attr, &new_service);
+	if (!new_service)
+		return;
+
+	device_register_primaries(device, new_service, -1);
+
+	prim = new_service->data;
+	profiles_added = g_slist_append(profiles_added, g_strdup(prim->uuid));
+
+	device_probe_profiles(device, profiles_added);
+
+	store_services(device);
+
+	g_slist_free_full(profiles_added, g_free);
+}
+
+static gint prim_attr_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct gatt_primary *prim = a;
+	const struct gatt_db_attribute *attr = b;
+	uint16_t start, end;
+
+	gatt_db_attribute_get_service_handles(attr, &start, &end);
+
+	return !(prim->range.start == start && prim->range.end == end);
+}
+
+static void gatt_service_removed(struct gatt_db_attribute *attr,
+								void *user_data)
+{
+	struct btd_device *device = user_data;
+	GSList *l;
+	struct gatt_primary *prim;
+	uint16_t start, end;
+
+	if (!bt_gatt_client_is_ready(device->gatt_client))
+		return;
+
+	gatt_db_attribute_get_service_handles(attr, &start, &end);
+
+	DBG("GATT service removed - start: 0x%04x, end: 0x%04x", start, end);
+
+	/* Remove the corresponding gatt_primary */
+	l = g_slist_find_custom(device->primaries, attr, prim_attr_cmp);
+	if (!l)
+		return;
+
+	prim = l->data;
+	device->primaries = g_slist_delete_link(device->primaries, l);
+
+	/* Remove the corresponding UUIDs entry */
+	l = g_slist_find_custom(device->uuids, prim->uuid, bt_uuid_strcmp);
+	device->uuids = g_slist_delete_link(device->uuids, l);
+	g_free(prim);
+
+	store_services(device);
+
+	/*
+	 * TODO: Notify the profiles somehow. It may be sufficient for each
+	 * profile to register a service_removed handler.
+	 */
+
+	g_dbus_emit_property_changed(dbus_conn, device->path,
+						DEVICE_INTERFACE, "UUIDs");
+}
+
 static struct btd_device *device_new(struct btd_adapter *adapter,
 				const char *address)
 {
@@ -2405,6 +2518,10 @@ static struct btd_device *device_new(struct btd_adapter *adapter,
 	device->adapter = adapter;
 	device->temporary = TRUE;
 
+	gatt_db_register(device->client_db, gatt_service_added,
+							gatt_service_removed,
+							device, NULL);
+
 	return btd_device_ref(device);
 }
 
@@ -3264,12 +3381,6 @@ static GSList *device_services_from_record(struct btd_device *device,
 	return prim_list;
 }
 
-static void device_register_primaries(struct btd_device *device,
-						GSList *prim_list, int psm)
-{
-	device->primaries = g_slist_concat(device->primaries, prim_list);
-}
-
 static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
 {
 	struct browse_req *req = user_data;
@@ -3515,26 +3626,6 @@ static void send_le_browse_response(struct browse_req *req)
 	g_dbus_send_reply(dbus_conn, msg, DBUS_TYPE_INVALID);
 }
 
-static void add_primary(struct gatt_db_attribute *attr, void *user_data)
-{
-	struct gatt_primary *prim;
-	GSList **services = user_data;
-	bt_uuid_t uuid;
-
-	prim = g_new0(struct gatt_primary, 1);
-	if (!prim) {
-		DBG("Failed to allocate gatt_primary structure");
-		return;
-	}
-
-	gatt_db_attribute_get_service_handles(attr, &prim->range.start,
-							&prim->range.end);
-	gatt_db_attribute_get_service_uuid(attr, &uuid);
-	bt_uuid_to_string(&uuid, prim->uuid, sizeof(prim->uuid));
-
-	*services = g_slist_append(*services, prim);
-}
-
 static void register_gatt_services(struct browse_req *req)
 {
 	struct btd_device *device = req->device;
-- 
2.2.0.rc0.207.ga3a616c

