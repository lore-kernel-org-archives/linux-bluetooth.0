Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] shared/gatt-client: Speed up discovery
Date: Mon,  8 Jun 2015 16:35:42 +0300
Message-Id: <1433770545-14938-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This tune the discovery to take advantage of the cached database whenever
possible, so instead of clearing the whole db if the device is not paired
the code now make the remote services active once they are discovered
and with that bt_gatt_client can then skip discovering characteristics
and descriptors of services that have not changed since last connection
which improves the reconnecting speed for any device regardless if the
device was paired or not.
---
 src/device.c             | 18 +++++++-----------
 src/gatt-client.c        | 17 +++++------------
 src/shared/gatt-client.c | 44 ++++++++++++++++++++++++++++----------------
 src/shared/gatt-db.c     | 33 +++++++++++++++++++++++++++------
 4 files changed, 67 insertions(+), 45 deletions(-)

diff --git a/src/device.c b/src/device.c
index ce96ab5..3ef0340 100644
--- a/src/device.c
+++ b/src/device.c
@@ -541,17 +541,6 @@ static void gatt_client_cleanup(struct btd_device *device)
 	bt_gatt_client_set_ready_handler(device->client, NULL, NULL, NULL);
 	bt_gatt_client_unref(device->client);
 	device->client = NULL;
-
-	/*
-	 * TODO: Once GATT over BR/EDR is properly supported, we should check
-	 * the bonding state for the correct bearer based on the transport over
-	 * which GATT is being done.
-	 */
-	if (device->le_state.bonded)
-		return;
-
-	gatt_db_clear(device->db);
-	device->gatt_cache_used = false;
 }
 
 static void gatt_server_cleanup(struct btd_device *device)
@@ -2862,6 +2851,9 @@ static void dev_probe_gatt(struct btd_profile *p, void *user_data)
 		return;
 	}
 
+	/* Mark service as active to skip discovering it again */
+	gatt_db_service_set_active(data->cur_attr, true);
+
 	/* Mark service as claimed */
 	gatt_db_service_set_claimed(data->cur_attr, true);
 
@@ -2890,6 +2882,8 @@ static void dev_probe_gatt_profile(struct gatt_db_attribute *attr,
 
 	/* Don't probe the profiles if a matching service already exists. */
 	if (find_service_with_uuid(data->dev->services, data->cur_uuid)) {
+		/* Mark service as active to skip discovering it again */
+		gatt_db_service_set_active(data->cur_attr, true);
 		/* Mark the service as claimed by the existing profile. */
 		gatt_db_service_set_claimed(data->cur_attr, true);
 		return;
@@ -4181,6 +4175,8 @@ static void register_gatt_services(struct btd_device *device)
 	device_svc_resolved(device, device->bdaddr_type, 0);
 }
 
+static void gatt_client_init(struct btd_device *device);
+
 static void gatt_client_ready_cb(bool success, uint8_t att_ecode,
 								void *user_data)
 {
diff --git a/src/gatt-client.c b/src/gatt-client.c
index 162bcac..3356ee4 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -1535,6 +1535,9 @@ static struct service *service_create(struct gatt_db_attribute *attr,
 
 	DBG("Exported GATT service: %s", service->path);
 
+	/* Set service active so we can skip discovering next time */
+	gatt_db_service_set_active(attr, true);
+
 	return service;
 }
 
@@ -1941,22 +1944,12 @@ void btd_gatt_client_disconnected(struct btd_gatt_client *client)
 	DBG("Device disconnected. Cleaning up.");
 
 	/*
-	 * Remove all services. We'll recreate them when a new bt_gatt_client
-	 * becomes ready. Leave the services around if the device is bonded.
 	 * TODO: Once GATT over BR/EDR is properly supported, we should pass the
 	 * correct bdaddr_type based on the transport over which GATT is being
 	 * done.
 	 */
-	if (!device_is_bonded(client->device, BDADDR_LE_PUBLIC)) {
-		DBG("Device not bonded. Removing exported services.");
-		queue_remove_all(client->services, NULL, NULL,
-							unregister_service);
-	} else {
-		DBG("Device is bonded. Keeping exported services up.");
-		queue_foreach(client->all_notify_clients, clear_notify_id,
-									NULL);
-		queue_foreach(client->services, cancel_ops, client->gatt);
-	}
+	queue_foreach(client->all_notify_clients, clear_notify_id, NULL);
+	queue_foreach(client->services, cancel_ops, client->gatt);
 
 	bt_gatt_client_unref(client->gatt);
 	client->gatt = NULL;
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 7bc3b71..feb30f6 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -892,13 +892,21 @@ static void discover_secondary_cb(bool success, uint8_t att_ecode,
 		attr = gatt_db_insert_service(client->db, start, &uuid, false,
 							end - start + 1);
 		if (!attr) {
-			util_debug(client->debug_callback, client->debug_data,
-						"Failed to create service");
-			success = false;
-			goto done;
+			gatt_db_clear_range(client->db, start, end);
+			attr = gatt_db_insert_service(client->db, start, &uuid,
+							false, end - start + 1);
+			if (!attr) {
+				util_debug(client->debug_callback,
+						client->debug_data,
+						"Failed to store service");
+				success = false;
+				goto done;
+			}
 		}
 
-		queue_push_tail(op->pending_svcs, attr);
+		/* Skip if service already active */
+		if (!gatt_db_service_get_active(attr))
+			queue_push_tail(op->pending_svcs, attr);
 	}
 
 next:
@@ -906,8 +914,10 @@ next:
 	attr = queue_pop_head(op->pending_svcs);
 
 	/* Complete with success if queue is empty */
-	if (!attr)
+	if (!attr) {
+		success = true;
 		goto done;
+	}
 
 	/*
 	 * Store the service in the tmp queue to be reused during
@@ -981,13 +991,21 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
 		attr = gatt_db_insert_service(client->db, start, &uuid, true,
 							end - start + 1);
 		if (!attr) {
-			util_debug(client->debug_callback, client->debug_data,
+			gatt_db_clear_range(client->db, start, end);
+			attr = gatt_db_insert_service(client->db, start, &uuid,
+							true, end - start + 1);
+			if (!attr) {
+				util_debug(client->debug_callback,
+						client->debug_data,
 						"Failed to store service");
-			success = false;
-			goto done;
+				success = false;
+				goto done;
+			}
 		}
 
-		queue_push_tail(op->pending_svcs, attr);
+		/* Skip if service already active */
+		if (!gatt_db_service_get_active(attr))
+			queue_push_tail(op->pending_svcs, attr);
 	}
 
 secondary:
@@ -1044,12 +1062,6 @@ static void exchange_mtu_cb(bool success, uint8_t att_ecode, void *user_data)
 					"MTU exchange complete, with MTU: %u",
 					bt_att_get_mtu(client->att));
 
-	/* Don't do discovery if the database was pre-populated */
-	if (!gatt_db_isempty(client->db)) {
-		op->complete_func(op, true, 0);
-		return;
-	}
-
 	client->discovery_req = bt_gatt_discover_all_primary_services(
 							client->att, NULL,
 							discover_primary_cb,
diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 2b2090c..5e1537e 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -486,7 +486,8 @@ bool gatt_db_clear_range(struct gatt_db *db, uint16_t start_handle,
 	return true;
 }
 
-static bool find_insert_loc(struct gatt_db *db, uint16_t start, uint16_t end,
+static struct gatt_db_service *find_insert_loc(struct gatt_db *db,
+						uint16_t start, uint16_t end,
 						struct gatt_db_service **after)
 {
 	const struct queue_entry *services_entry;
@@ -503,19 +504,19 @@ static bool find_insert_loc(struct gatt_db *db, uint16_t start, uint16_t end,
 		gatt_db_service_get_handles(service, &cur_start, &cur_end);
 
 		if (start >= cur_start && start <= cur_end)
-			return false;
+			return service;
 
 		if (end >= cur_start && end <= cur_end)
-			return false;
+			return service;
 
 		if (end < cur_start)
-			return true;
+			return NULL;
 
 		*after = service;
 		services_entry = services_entry->next;
 	}
 
-	return true;
+	return NULL;
 }
 
 struct gatt_db_attribute *gatt_db_insert_service(struct gatt_db *db,
@@ -534,8 +535,28 @@ struct gatt_db_attribute *gatt_db_insert_service(struct gatt_db *db,
 	if (num_handles < 1 || (handle + num_handles - 1) > UINT16_MAX)
 		return NULL;
 
-	if (!find_insert_loc(db, handle, handle + num_handles - 1, &after))
+	service = find_insert_loc(db, handle, handle + num_handles - 1, &after);
+	if (service) {
+		const bt_uuid_t *type;
+		bt_uuid_t value;
+
+		if (primary)
+			type = &primary_service_uuid;
+		else
+			type = &secondary_service_uuid;
+
+		gatt_db_attribute_get_service_uuid(service->attributes[0],
+									&value);
+
+		/* Check if service match */
+		if (!bt_uuid_cmp(&service->attributes[0]->uuid, type) &&
+				!bt_uuid_cmp(&value, uuid) &&
+				service->num_handles == num_handles &&
+				service->attributes[0]->handle == handle)
+			return service->attributes[0];
+
 		return NULL;
+	}
 
 	service = gatt_db_service_create(uuid, handle, primary, num_handles);
 
-- 
2.1.0

