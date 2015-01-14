Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v3 2/8] core: device: Fix GATT profile probing
Date: Tue, 13 Jan 2015 19:31:01 -0800
Message-Id: <1421206267-26369-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1421206267-26369-1-git-send-email-armansito@chromium.org>
References: <1421206267-26369-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes a recently introduced issue which changed the behavior
of profile probing for GATT-based profiles to create a btd_service
instance for all discovered GATT services to be on a per-UUID basis
rather than per-service.
---
 src/device.c | 182 +++++++++++++++++++++++------------------------------------
 1 file changed, 70 insertions(+), 112 deletions(-)

diff --git a/src/device.c b/src/device.c
index 75a5984..4f702ba 100644
--- a/src/device.c
+++ b/src/device.c
@@ -295,21 +295,15 @@ static GSList *find_service_with_state(GSList *list,
 	return NULL;
 }
 
-static GSList *find_service_with_gatt_handles(GSList *list,
-							uint16_t start_handle,
-							uint16_t end_handle)
+static GSList *find_service_with_uuid(GSList *list, char *uuid)
 {
 	GSList *l;
-	uint16_t svc_start, svc_end;
 
 	for (l = list; l != NULL; l = g_slist_next(l)) {
 		struct btd_service *service = l->data;
+		struct btd_profile *profile = btd_service_get_profile(service);
 
-		if (!btd_service_get_gatt_handles(service, &svc_start,
-								&svc_end))
-			continue;
-
-		if (svc_start == start_handle && svc_end == end_handle)
+		if (bt_uuid_strcmp(profile->remote_uuid, uuid) == 0)
 			return l;
 	}
 
@@ -2420,6 +2414,7 @@ static void add_primary(struct gatt_db_attribute *attr, void *user_data)
 static void device_add_uuids(struct btd_device *device, GSList *uuids)
 {
 	GSList *l;
+	bool changed = false;
 
 	for (l = uuids; l != NULL; l = g_slist_next(l)) {
 		GSList *match = g_slist_find_custom(device->uuids, l->data,
@@ -2427,12 +2422,14 @@ static void device_add_uuids(struct btd_device *device, GSList *uuids)
 		if (match)
 			continue;
 
+		changed = true;
 		device->uuids = g_slist_insert_sorted(device->uuids,
 						g_strdup(l->data),
 						bt_uuid_strcmp);
 	}
 
-	g_dbus_emit_property_changed(dbus_conn, device->path,
+	if (changed)
+		g_dbus_emit_property_changed(dbus_conn, device->path,
 						DEVICE_INTERFACE, "UUIDs");
 }
 
@@ -2444,8 +2441,6 @@ struct gatt_probe_data {
 	GSList *uuids;
 	struct gatt_db_attribute *cur_attr;
 	char cur_uuid[MAX_LEN_UUID_STR];
-	uint16_t start_handle, end_handle;
-	GSList *valid_services;
 };
 
 static bool device_match_profile(struct btd_device *device,
@@ -2473,8 +2468,7 @@ static void dev_probe_gatt(struct btd_profile *p, void *user_data)
 	if (!p->remote_uuid || bt_uuid_strcmp(p->remote_uuid, data->cur_uuid))
 		return;
 
-	service = service_create_gatt(data->dev, p, data->start_handle,
-							data->end_handle);
+	service = service_create(data->dev, p);
 	if (!service)
 		return;
 
@@ -2487,72 +2481,6 @@ static void dev_probe_gatt(struct btd_profile *p, void *user_data)
 	gatt_db_service_set_active(data->cur_attr, false);
 
 	data->dev->services = g_slist_append(data->dev->services, service);
-
-	if (data->all_services)
-		data->valid_services = g_slist_append(data->valid_services,
-								service);
-}
-
-static bool match_existing_service(struct gatt_probe_data *data)
-{
-	struct btd_device *dev = data->dev;
-	struct btd_service *service;
-	struct btd_profile *profile;
-	uint16_t start, end;
-	GSList *l, *tmp;
-
-	/*
-	 * Check if the profiles should be probed for the service in the
-	 * database.
-	 */
-	for (l = dev->services; l != NULL;) {
-		service = l->data;
-		profile = btd_service_get_profile(service);
-
-		/* If this is local or non-GATT based service, then skip. */
-		if (!profile->remote_uuid ||
-			!btd_service_get_gatt_handles(service, &start, &end)) {
-			l = g_slist_next(l);
-			continue;
-		}
-
-		/* Skip this service if the handle ranges don't overlap. */
-		if (start > data->end_handle || end < data->start_handle) {
-			l = g_slist_next(l);
-			continue;
-		}
-
-		/*
-		 * If there is an exact match, then there's no need to probe the
-		 * profiles. An exact match is when the service handles AND the
-		 * service UUID match.
-		 */
-		if (start == data->start_handle && end == data->end_handle &&
-			!bt_uuid_strcmp(profile->remote_uuid, data->cur_uuid)) {
-			if (data->all_services)
-				data->valid_services = g_slist_append(
-						data->valid_services, service);
-			return true;
-		}
-
-		/*
-		 * The handles overlap but there is no exact match. This means
-		 * that the service is no longer valid. Remove it.
-		 *
-		 * TODO: The following code is fairly inefficient, especially
-		 * when we consider all the extra searches that we're already
-		 * doing. Consider changing the services list to a GList.
-		 */
-		tmp = l->next;
-		dev->services = g_slist_delete_link(dev->services, l);
-		dev->pending = g_slist_remove(dev->pending, service);
-		service_remove(service);
-
-		l = tmp;
-	}
-
-	/* No match found */
-	return false;
 }
 
 static void dev_probe_gatt_profile(struct gatt_db_attribute *attr,
@@ -2562,22 +2490,27 @@ static void dev_probe_gatt_profile(struct gatt_db_attribute *attr,
 	bt_uuid_t uuid;
 	GSList *l = NULL;
 
-	gatt_db_attribute_get_service_data(attr, &data->start_handle,
-							&data->end_handle, NULL,
-							&uuid);
+	gatt_db_attribute_get_service_uuid(attr, &uuid);
 	bt_uuid_to_string(&uuid, data->cur_uuid, sizeof(data->cur_uuid));
 
 	data->cur_attr = attr;
 
-	/* Don't probe the profiles if a matching service already exists. */
-	if (!match_existing_service(data))
-		btd_profile_foreach(dev_probe_gatt, data);
-
-	if (data->all_services) {
+	/*
+	 * If we're probing for all services, store the UUID since device->uuids
+	 * was cleared.
+	 */
+	if (data->all_services)
 		data->uuids = g_slist_append(data->uuids,
 						g_strdup(data->cur_uuid));
+
+	/* Don't probe the profiles if a matching service already exists. */
+	if (find_service_with_uuid(data->dev->services, data->cur_uuid))
+		return;
+
+	btd_profile_foreach(dev_probe_gatt, data);
+
+	if (data->all_services)
 		return;
-	}
 
 	l = g_slist_append(l, g_strdup(data->cur_uuid));
 	device_add_uuids(data->dev, l);
@@ -2600,12 +2533,15 @@ static void remove_invalid_services(struct gatt_probe_data *data)
 {
 	struct btd_device *dev = data->dev;
 	struct btd_service *service;
+	struct btd_profile *profile;
 	GSList *l, *tmp;
 
 	for (l = dev->services; l != NULL;) {
 		service = l->data;
+		profile = btd_service_get_profile(service);
 
-		if (g_slist_find(data->valid_services, service)) {
+		if (g_slist_find_custom(dev->uuids, profile->remote_uuid,
+							bt_uuid_strcmp)) {
 			l = g_slist_next(l);
 			continue;
 		}
@@ -2639,11 +2575,21 @@ static void device_probe_gatt_profiles(struct btd_device *device)
 
 	gatt_db_foreach_service(device->db, NULL, dev_probe_gatt_profile,
 									&data);
+
+	/*
+	 * Clear the UUIDs list
+	 *
+	 * FIXME: The management of UUIDs here iss currently broken, as clearing
+	 * the entire list here will likely remove UUIDs that shouldn't be
+	 * removed (e.g. those obtained via SDP for a dual-mode device).
+	 */
+	g_slist_free_full(device->uuids, g_free);
+	device->uuids = NULL;
+
 	device_add_uuids(device, data.uuids);
 	g_slist_free_full(data.uuids, g_free);
 
 	remove_invalid_services(&data);
-	g_slist_free(data.valid_services);
 }
 
 static void device_accept_gatt_profiles(struct btd_device *device)
@@ -2657,13 +2603,15 @@ static void device_accept_gatt_profiles(struct btd_device *device)
 static void device_remove_gatt_profile(struct btd_device *device,
 						struct gatt_db_attribute *attr)
 {
-	uint16_t start, end;
 	struct btd_service *service;
+	bt_uuid_t uuid;
+	char uuid_str[MAX_LEN_UUID_STR];
 	GSList *l;
 
-	gatt_db_attribute_get_service_handles(attr, &start, &end);
+	gatt_db_attribute_get_service_uuid(attr, &uuid);
+	bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
 
-	l = find_service_with_gatt_handles(device->services, start, end);
+	l = find_service_with_uuid(device->services, uuid_str);
 	if (!l)
 		return;
 
@@ -2677,13 +2625,16 @@ static void gatt_service_added(struct gatt_db_attribute *attr, void *user_data)
 {
 	struct btd_device *device = user_data;
 	GSList *new_service = NULL;
+	bt_uuid_t uuid;
+	char uuid_str[MAX_LEN_UUID_STR];
 	uint16_t start, end;
 	GSList *l;
 
 	if (!bt_gatt_client_is_ready(device->client))
 		return;
 
-	gatt_db_attribute_get_service_handles(attr, &start, &end);
+	gatt_db_attribute_get_service_data(attr, &start, &end, NULL, &uuid);
+	bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
 
 	DBG("start: 0x%04x, end: 0x%04x", start, end);
 
@@ -2695,14 +2646,19 @@ static void gatt_service_added(struct gatt_db_attribute *attr, void *user_data)
 	if (!new_service)
 		return;
 
-	device_register_primaries(device, new_service, -1);
+	l = find_service_with_uuid(device->services, uuid_str);
 
-	device_probe_gatt_profile(device, attr);
+	device_register_primaries(device, new_service, -1);
 
-	l = find_service_with_gatt_handles(device->services, start, end);
-	if (l)
+	/*
+	 * If the profile was probed for the first time then call accept on
+	 * the service.
+	 */
+	if (!l && (l = find_service_with_uuid(device->services, uuid_str)))
 		service_accept(l->data);
 
+	device_probe_gatt_profile(device, attr);
+
 	store_device_info(device);
 
 	btd_gatt_client_service_added(device->client_dbus, attr);
@@ -2750,24 +2706,26 @@ static void gatt_service_removed(struct gatt_db_attribute *attr,
 	prim = l->data;
 	device->primaries = g_slist_delete_link(device->primaries, l);
 
-	/*
-	 * If this happend since the db was cleared for a non-bonded device,
-	 * then don't remove the btd_service just yet. We do this so that we can
-	 * avoid re-probing the profile if the same GATT service is found on the
-	 * device on re-connection. However, if the device is marked as
-	 * temporary, then we remove it anyway.
-	 */
-	if (device->client || device->temporary == TRUE)
-		device_remove_gatt_profile(device, attr);
+	/* Get the UUID entry to be removed below */
+	l = g_slist_find_custom(device->uuids, prim->uuid, bt_uuid_strcmp);
 
 	/*
-	 * Remove the corresponding UUIDs entry, only if this is the last
-	 * service with this UUID.
+	 * Remove the corresponding UUIDs entry and the profile, only if this
+	 * is the last service with this UUID.
 	 */
-	l = g_slist_find_custom(device->uuids, prim->uuid, bt_uuid_strcmp);
-
 	if (!g_slist_find_custom(device->primaries, prim->uuid,
 							prim_uuid_cmp)) {
+		/*
+		 * If this happened since the db was cleared for a non-bonded
+		 * device, then don't remove the btd_service just yet. We do
+		 * this so that we can avoid re-probing the profile if the same
+		 * GATT service is found on the device on re-connection.
+		 * However, if the device is marked as temporary, then we remove
+		 * it anyway.
+		 */
+		if (device->client || device->temporary == TRUE)
+			device_remove_gatt_profile(device, attr);
+
 		g_free(l->data);
 		device->uuids = g_slist_delete_link(device->uuids, l);
 		g_dbus_emit_property_changed(dbus_conn, device->path,
-- 
2.2.0.rc0.207.ga3a616c

