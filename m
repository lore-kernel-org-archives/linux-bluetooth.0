Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH] Notify to device drivers when the SDP records change
Date: Mon, 26 Jul 2010 09:55:27 +0200
Message-Id: <1280130927-4137-2-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1280130927-4137-1-git-send-email-santoscadenas@gmail.com>
References: <1280130927-4137-1-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the remote SDP records that make a driver to be loaded change
(added, remove, or updated) And the driver is not going to be
removed, a notification is sent to the device driver. This
notification is optional annnd does not fail  if the driver does
not implemment it.
---
 src/device.c |  179 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/device.h |    1 +
 2 files changed, 178 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index 6af76d1..b8d5e26 100644
--- a/src/device.c
+++ b/src/device.c
@@ -99,7 +99,11 @@ struct browse_req {
 	GSList *match_uuids;
 	GSList *profiles_added;
 	GSList *profiles_removed;
+	GSList *profiles_updated;
 	sdp_list_t *records;
+	sdp_list_t *records_added;
+	sdp_list_t *records_removed;
+	sdp_list_t *records_changed;
 	int search_uuid;
 	int reconnect_attempt;
 	guint listener_id;
@@ -1328,6 +1332,30 @@ static void device_remove_drivers(struct btd_device *device, GSList *uuids)
 		sdp_list_free(records, (sdp_free_func_t) sdp_record_free);
 }
 
+static void device_update_drivers(struct btd_device *device, GSList *profiles)
+{
+	GSList *l;
+
+	DBG("Update drivers for %s", device->path);
+
+	for (l = device->drivers; l; l = l->next) {
+		struct btd_driver_data *driver_data = l->data;
+		struct btd_device_driver *driver = driver_data->driver;
+		GSList *updated_uuids;
+
+		DBG("Updating device %s", device->path);
+
+		updated_uuids = device_match_driver(device, driver, profiles);
+
+		if (!updated_uuids)
+			continue;
+
+		DBG("No updated uuids");
+		if (driver->update)
+			driver->update(device, updated_uuids);
+	}
+}
+
 static void services_changed(struct btd_device *device)
 {
 	DBusConnection *conn = get_dbus_connection();
@@ -1353,11 +1381,50 @@ static int rec_cmp(const void *a, const void *b)
 	return r1->handle - r2->handle;
 }
 
+static void check_changes(struct browse_req *req, sdp_list_t *stored_recs,
+							sdp_record_t *rec)
+{
+	sdp_list_t *prev_rec, *remove;
+	sdp_buf_t new_buf, prev_buf;
+
+	prev_rec = sdp_list_find(stored_recs, rec, rec_cmp);
+	if (!prev_rec) {
+		req->records_added = sdp_list_append(req->records_added,
+							sdp_copy_record(rec));
+		return;
+	} else if ((remove = sdp_list_find(req->records_removed, rec, rec_cmp))){
+		req->records_removed = sdp_list_remove(req->records_removed,
+								remove->data);
+		sdp_record_free(remove->data);
+	}
+
+	if (sdp_gen_record_pdu(rec, &new_buf) < 0)
+		return;
+	if (sdp_gen_record_pdu(prev_rec->data, &prev_buf) < 0) {
+		free(new_buf.data);
+		return;
+	}
+
+	if (new_buf.data_size != prev_buf.data_size)
+		goto change;
+
+	if (memcmp(new_buf.data, prev_buf.data, new_buf.data_size) == 0)
+		goto end;
+
+change:
+	req->records_changed = sdp_list_append(req->records_changed,
+							sdp_copy_record(rec));
+
+end:
+	free(new_buf.data);
+	free(prev_buf.data);
+}
+
 static void update_services(struct browse_req *req, sdp_list_t *recs)
 {
 	struct btd_device *device = req->device;
 	struct btd_adapter *adapter = device_get_adapter(device);
-	sdp_list_t *seq;
+	sdp_list_t *seq, *stored_recs;
 	char srcaddr[18], dstaddr[18];
 	bdaddr_t src;
 
@@ -1365,6 +1432,8 @@ static void update_services(struct browse_req *req, sdp_list_t *recs)
 	ba2str(&src, srcaddr);
 	ba2str(&device->bdaddr, dstaddr);
 
+	stored_recs = read_records(&src, &req->device->bdaddr);
+
 	for (seq = recs; seq; seq = seq->next) {
 		sdp_record_t *rec = (sdp_record_t *) seq->data;
 		sdp_list_t *svcclass = NULL;
@@ -1418,6 +1487,8 @@ static void update_services(struct browse_req *req, sdp_list_t *recs)
 			continue;
 		}
 
+		check_changes(req, stored_recs, rec);
+
 		store_record(srcaddr, dstaddr, rec);
 
 		/* Copy record */
@@ -1439,6 +1510,8 @@ static void update_services(struct browse_req *req, sdp_list_t *recs)
 
 		sdp_list_free(svcclass, free);
 	}
+
+	sdp_list_free(stored_recs, (sdp_free_func_t)sdp_record_free);
 }
 
 static void store_profiles(struct btd_device *device)
@@ -1473,6 +1546,97 @@ static void create_device_reply(struct btd_device *device, struct browse_req *re
 	g_dbus_send_message(req->conn, reply);
 }
 
+static void remove_record(void *a, void *b)
+{
+	sdp_record_t *rec = a;
+	struct btd_device *device = b;
+	char srcaddr[18], dstaddr[18];
+	bdaddr_t src;
+
+	adapter_get_address(device_get_adapter(device), &src);
+	ba2str(&src, srcaddr);
+	ba2str(&device->bdaddr, dstaddr);
+
+	delete_record(srcaddr, dstaddr, rec->handle);
+}
+
+static void extract_updated_uuids(struct browse_req *req, sdp_record_t *rec)
+{
+	sdp_list_t *svcclass = NULL;
+	gchar *profile_uuid;
+	GSList *l;
+
+	if (sdp_get_service_classes(rec, &svcclass) < 0)
+			return;
+
+	/* Check for empty service classes list */
+	if (svcclass == NULL) {
+		DBG("Skipping record with no service classes");
+		return;
+	}
+
+	/* Extract the first element and skip the remainning */
+	profile_uuid = bt_uuid2string(svcclass->data);
+	if (!profile_uuid) {
+		sdp_list_free(svcclass, free);
+		return;
+	}
+
+	l = g_slist_find_custom(req->profiles_added, profile_uuid,
+						(GCompareFunc) strcmp);
+	if (l)
+		goto end;
+
+	l = g_slist_find_custom(req->profiles_removed, profile_uuid,
+						(GCompareFunc) strcmp);
+	if (l)
+		goto end;
+
+	l = g_slist_find_custom(req->profiles_updated, profile_uuid,
+						(GCompareFunc) strcmp);
+	if (l)
+		goto end;
+
+	req->profiles_updated = g_slist_append(req->profiles_updated,
+							profile_uuid);
+
+end:
+	g_free(profile_uuid);
+	sdp_list_free(svcclass, free);
+}
+
+static void get_updated_uuids(struct browse_req *req)
+{
+	sdp_list_t *l;
+
+	for (l = req->records_added; l; l = l->next) {
+		extract_updated_uuids(req, l->data);
+	}
+
+	for (l = req->records_removed; l; l = l->next) {
+		extract_updated_uuids(req, l->data);
+	}
+
+	for (l = req->records_changed; l; l = l->next) {
+		extract_updated_uuids(req, l->data);
+	}
+
+	if (req->records_added)
+		sdp_list_free(req->records_added,
+					(sdp_free_func_t)sdp_record_free);
+
+	if (req->records_changed)
+		sdp_list_free(req->records_changed,
+					(sdp_free_func_t)sdp_record_free);
+
+	if (req->records_removed) {
+		sdp_list_foreach(req->records_removed, remove_record,
+								req->device);
+		sdp_list_free(req->records_removed,
+					(sdp_free_func_t)sdp_record_free);
+	}
+}
+
 static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
 {
 	struct browse_req *req = user_data;
@@ -1493,7 +1657,10 @@ static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
 	device->tmp_records = req->records;
 	req->records = NULL;
 
-	if (!req->profiles_added && !req->profiles_removed) {
+	get_updated_uuids(req);
+
+	if (!req->profiles_added && !req->profiles_removed &&
+						!req->profiles_updated) {
 		DBG("%s: No service update", device->path);
 		goto send_reply;
 	}
@@ -1506,6 +1673,10 @@ static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
 	if (req->profiles_removed)
 		device_remove_drivers(device, req->profiles_removed);
 
+	/* Notify the UUIDS whoose SDP records have changed */
+	if (req->profiles_updated)
+		device_update_drivers(device, req->profiles_updated);
+
 	/* Propagate services changes */
 	services_changed(req->device);
 
@@ -1574,6 +1745,7 @@ done:
 static void init_browse(struct browse_req *req, gboolean reverse)
 {
 	GSList *l;
+	bdaddr_t src;
 
 	/* If we are doing reverse-SDP don't try to detect removed profiles
 	 * since some devices hide their service records while they are
@@ -1585,6 +1757,9 @@ static void init_browse(struct browse_req *req, gboolean reverse)
 	for (l = req->device->uuids; l; l = l->next)
 		req->profiles_removed = g_slist_append(req->profiles_removed,
 						l->data);
+
+	adapter_get_address(device_get_adapter(req->device), &src);
+	req->records_removed = read_records(&src, &req->device->bdaddr);
 }
 
 int device_browse(struct btd_device *device, DBusConnection *conn,
diff --git a/src/device.h b/src/device.h
index 5f75e61..72593c4 100644
--- a/src/device.h
+++ b/src/device.h
@@ -103,6 +103,7 @@ struct btd_device_driver {
 	const char **uuids;
 	int (*probe) (struct btd_device *device, GSList *uuids);
 	void (*remove) (struct btd_device *device);
+	void (*update) (struct btd_device *device, GSList *uuids);
 };
 
 int btd_register_device_driver(struct btd_device_driver *driver);
-- 
1.7.1

