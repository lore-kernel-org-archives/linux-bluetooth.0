Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 05/12] core: device: Use shared/gatt-client for GATT.
Date: Tue,  9 Dec 2014 15:00:58 -0800
Message-Id: <1418166065-21055-6-git-send-email-armansito@chromium.org>
In-Reply-To: <1418166065-21055-1-git-send-email-armansito@chromium.org>
References: <1418166065-21055-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch changes the GATT service discovery code path with the
following:
   - As part for device_attach_attrib, a bt_gatt_client structure is
   created that performs MTU exchange and service discovery, caches the
   services in an internal list, and handles the remote GATT service.

   - The device_browse_primary code path obtains service information
   by iterating through bt_gatt_client's services, instead of directly
   initiating primary and secondary service discovery using attrib/gatt.
   If the bt_gatt_client isn't ready at the time, the code defers
   registration of services and profile probing until the ready handler
   is called.

   - The attio connected callbacks are invoked from bt_gatt_client's
   ready handler instead of device_attach_attrib.
---
 src/device.c           | 310 ++++++++++++++++++++++++++-----------------------
 src/shared/att-types.h |   3 +-
 2 files changed, 169 insertions(+), 144 deletions(-)

diff --git a/src/device.c b/src/device.c
index 84ba88e..bb80409 100644
--- a/src/device.c
+++ b/src/device.c
@@ -45,10 +45,13 @@
 
 #include "log.h"
 
+#include "lib/uuid.h"
 #include "src/shared/util.h"
 #include "src/shared/att.h"
+#include "src/shared/queue.h"
+#include "src/shared/gatt-db.h"
+#include "src/shared/gatt-client.h"
 #include "btio/btio.h"
-#include "lib/uuid.h"
 #include "lib/mgmt.h"
 #include "attrib/att.h"
 #include "hcid.h"
@@ -73,6 +76,10 @@
 #define DISCONNECT_TIMER	2
 #define DISCOVERY_TIMER		1
 
+#ifndef MIN
+#define MIN(a, b) ((a) < (b) ? (a) : (b))
+#endif
+
 static DBusConnection *dbus_conn = NULL;
 unsigned service_state_cb_id;
 
@@ -204,9 +211,18 @@ struct btd_device {
 	GSList		*attios_offline;
 	guint		attachid;		/* Attrib server attach */
 
-	struct bt_att *att;	/* The new ATT transport */
+	struct bt_att *att;			/* The new ATT transport */
+	uint16_t att_mtu;			/* The ATT MTU */
 	unsigned int att_disconn_id;
 
+	/*
+	 * TODO: For now, device creates and owns the client-role gatt_db, but
+	 * this needs to be persisted in a more central place so that proper
+	 * attribute cache support can be built.
+	 */
+	struct gatt_db *client_db;		/* GATT client cache */
+	struct bt_gatt_client *gatt_client;	/* GATT client implementation */
+
 	struct bearer_state bredr_state;
 	struct bearer_state le_state;
 
@@ -235,7 +251,7 @@ static const uint16_t uuid_list[] = {
 	0
 };
 
-static int device_browse_primary(struct btd_device *device, DBusMessage *msg);
+static int device_browse_gatt(struct btd_device *device, DBusMessage *msg);
 static int device_browse_sdp(struct btd_device *device, DBusMessage *msg);
 
 static struct bearer_state *get_state(struct btd_device *dev,
@@ -462,6 +478,21 @@ static void browse_request_free(struct browse_req *req)
 	g_free(req);
 }
 
+static void gatt_client_cleanup(struct btd_device *device)
+{
+	if (!device->gatt_client)
+		return;
+
+	bt_gatt_client_set_service_changed(device->gatt_client, NULL, NULL,
+									NULL);
+	bt_gatt_client_set_ready_handler(device->gatt_client, NULL, NULL, NULL);
+	bt_gatt_client_unref(device->gatt_client);
+	device->gatt_client = NULL;
+
+	if (!device->le_state.bonded)
+		gatt_db_clear(device->client_db);
+}
+
 static void attio_cleanup(struct btd_device *device)
 {
 	if (device->attachid) {
@@ -479,6 +510,8 @@ static void attio_cleanup(struct btd_device *device)
 		device->att_io = NULL;
 	}
 
+	gatt_client_cleanup(device);
+
 	if (device->att) {
 		bt_att_unref(device->att);
 		device->att = NULL;
@@ -529,6 +562,8 @@ static void device_free(gpointer user_data)
 
 	attio_cleanup(device);
 
+	gatt_db_unref(device->client_db);
+
 	if (device->tmp_records)
 		sdp_list_free(device->tmp_records,
 					(sdp_free_func_t) sdp_record_free);
@@ -1449,7 +1484,7 @@ resolve_services:
 	if (bdaddr_type == BDADDR_BREDR)
 		err = device_browse_sdp(dev, msg);
 	else
-		err = device_browse_primary(dev, msg);
+		err = device_browse_gatt(dev, msg);
 	if (err < 0)
 		return btd_error_failed(msg, strerror(-err));
 
@@ -2343,6 +2378,12 @@ static struct btd_device *device_new(struct btd_adapter *adapter,
 	if (device == NULL)
 		return NULL;
 
+	device->client_db = gatt_db_new();
+	if (!device->client_db) {
+		g_free(device);
+		return NULL;
+	}
+
 	address_up = g_ascii_strup(address, -1);
 	device->path = g_strdup_printf("%s/dev_%s", adapter_path, address_up);
 	g_strdelimit(device->path, ":", '_');
@@ -3161,7 +3202,7 @@ static int primary_cmp(gconstpointer a, gconstpointer b)
 	return memcmp(a, b, sizeof(struct gatt_primary));
 }
 
-static void update_gatt_services(struct browse_req *req, GSList *current,
+static void update_gatt_uuids(struct browse_req *req, GSList *current,
 								GSList *found)
 {
 	GSList *l, *lmatch;
@@ -3438,41 +3479,6 @@ done:
 	attio_cleanup(device);
 }
 
-static void register_all_services(struct browse_req *req, GSList *services)
-{
-	struct btd_device *device = req->device;
-
-	btd_device_set_temporary(device, FALSE);
-
-	update_gatt_services(req, device->primaries, services);
-	g_slist_free_full(device->primaries, g_free);
-	device->primaries = NULL;
-
-	device_register_primaries(device, services, -1);
-
-	device_probe_profiles(device, req->profiles_added);
-
-	if (device->attios == NULL && device->attios_offline == NULL)
-		attio_cleanup(device);
-
-	g_dbus_emit_property_changed(dbus_conn, device->path,
-						DEVICE_INTERFACE, "UUIDs");
-
-	device_svc_resolved(device, device->bdaddr_type, 0);
-
-	store_services(device);
-
-	browse_request_free(req);
-}
-
-static int service_by_range_cmp(gconstpointer a, gconstpointer b)
-{
-	const struct gatt_primary *prim = a;
-	const struct att_range *range = b;
-
-	return memcmp(&prim->range, range, sizeof(*range));
-}
-
 static void send_le_browse_response(struct browse_req *req)
 {
 	struct btd_device *dev = req->device;
@@ -3503,122 +3509,132 @@ static void send_le_browse_response(struct browse_req *req)
 	g_dbus_send_reply(dbus_conn, msg, DBUS_TYPE_INVALID);
 }
 
-static void find_included_cb(uint8_t status, GSList *includes, void *user_data)
+static void add_primary(struct gatt_db_attribute *attr, void *user_data)
 {
-	struct included_search *search = user_data;
-	struct btd_device *device = search->req->device;
 	struct gatt_primary *prim;
-	GSList *l;
+	GSList **services = user_data;
+	bt_uuid_t uuid;
 
-	DBG("status %u", status);
+	prim = g_new0(struct gatt_primary, 1);
+	if (!prim) {
+		DBG("Failed to allocate gatt_primary structure");
+		return;
+	}
 
-	if (device->attrib == NULL || status) {
-		struct browse_req *req = device->browse;
+	gatt_db_attribute_get_service_handles(attr, &prim->range.start,
+							&prim->range.end);
+	gatt_db_attribute_get_service_uuid(attr, &uuid);
+	bt_uuid_to_string(&uuid, prim->uuid, sizeof(prim->uuid));
 
-		if (status)
-			error("Find included services failed: %s (%d)",
-					att_ecode2str(status), status);
-		else
-			error("Disconnected while doing included discovery");
+	*services = g_slist_append(*services, prim);
+}
 
-		if (!req)
-			goto complete;
+static void register_gatt_services(struct browse_req *req)
+{
+	struct btd_device *device = req->device;
+	GSList *services = NULL;
 
-		send_le_browse_response(req);
-		device->browse = NULL;
-		browse_request_free(req);
+	if (!bt_gatt_client_is_ready(device->gatt_client))
+		return;
 
-		goto complete;
-	}
+	/*
+	 * TODO: Remove the primaries list entirely once all profiles use
+	 * shared/gatt.
+	 */
+	gatt_db_foreach_service(device->client_db, NULL, add_primary,
+								&services);
 
-	if (includes == NULL)
-		goto next;
+	btd_device_set_temporary(device, FALSE);
 
-	for (l = includes; l; l = l->next) {
-		struct gatt_included *incl = l->data;
+	update_gatt_uuids(req, device->primaries, services);
+	g_slist_free_full(device->primaries, g_free);
+	device->primaries = NULL;
 
-		if (g_slist_find_custom(search->services, &incl->range,
-						service_by_range_cmp))
-			continue;
+	device_register_primaries(device, services, -1);
 
-		prim = g_new0(struct gatt_primary, 1);
-		memcpy(prim->uuid, incl->uuid, sizeof(prim->uuid));
-		memcpy(&prim->range, &incl->range, sizeof(prim->range));
+	device_probe_profiles(device, req->profiles_added);
 
-		search->services = g_slist_append(search->services, prim);
-	}
+	if (device->attios == NULL && device->attios_offline == NULL)
+		attio_cleanup(device);
 
-next:
-	search->current = search->current->next;
-	if (search->current == NULL) {
-		register_all_services(search->req, search->services);
-		search->services = NULL;
-		goto complete;
-	}
+	device_svc_resolved(device, device->bdaddr_type, 0);
 
-	prim = search->current->data;
-	gatt_find_included(device->attrib, prim->range.start, prim->range.end,
-					find_included_cb, search);
-	return;
+	store_services(device);
 
-complete:
-	g_slist_free_full(search->services, g_free);
-	g_free(search);
+	browse_request_free(req);
 }
 
-static void find_included_services(struct browse_req *req, GSList *services)
+static void gatt_client_ready_cb(bool success, uint8_t att_ecode,
+								void *user_data)
 {
-	struct btd_device *device = req->device;
-	struct included_search *search;
-	struct gatt_primary *prim;
-	GSList *l;
+	struct btd_device *device = user_data;
+
+	DBG("gatt-client ready -- status: %s, ATT error: %u",
+						success ? "success" : "failed",
+						att_ecode);
 
-	DBG("service count %u", g_slist_length(services));
+	if (!success) {
+		if (device->browse) {
+			struct browse_req *req = device->browse;
+
+			send_le_browse_response(req);
+			device->browse = NULL;
+			browse_request_free(req);
+		}
 
-	if (services == NULL) {
-		DBG("No services found");
-		register_all_services(req, NULL);
 		return;
 	}
 
-	search = g_new0(struct included_search, 1);
-	search->req = req;
+	device->att_mtu = bt_att_get_mtu(device->att);
 
-	/* We have to completely duplicate the data in order to have a
-	 * clearly defined responsibility of freeing regardless of
-	 * failure or success. Otherwise memory leaks are inevitable.
-	 */
-	for (l = services; l; l = g_slist_next(l)) {
-		struct gatt_primary *dup;
+	DBG("gatt-client exchanged MTU: %u", device->att_mtu);
 
-		dup = g_memdup(l->data, sizeof(struct gatt_primary));
-
-		search->services = g_slist_append(search->services, dup);
-	}
+	if (device->browse)
+		register_gatt_services(device->browse);
 
-	search->current = search->services;
+	/*
+	 * TODO: Change attio callbacks to accept a gatt-client instead of a
+	 * GAttrib.
+	 */
+	g_slist_foreach(device->attios, attio_connected, device->attrib);
+}
 
-	prim = search->current->data;
-	gatt_find_included(device->attrib, prim->range.start, prim->range.end,
-					find_included_cb, search);
+static void gatt_client_service_changed(uint16_t start_handle,
+							uint16_t end_handle,
+							void *user_data)
+{
+	DBG("gatt-client: Service Changed: start 0x%04x, end: 0x%04x",
+						start_handle, end_handle);
 }
 
-static void primary_cb(uint8_t status, GSList *services, void *user_data)
+static void gatt_client_init(struct btd_device *device)
 {
-	struct browse_req *req = user_data;
+	gatt_client_cleanup(device);
 
-	DBG("status %u", status);
+	device->gatt_client = bt_gatt_client_new(device->client_db, device->att,
+							device->att_mtu);
+	if (!device->gatt_client) {
+		DBG("Failed to initialize gatt-client");
+		return;
+	}
 
-	if (status) {
-		struct btd_device *device = req->device;
+	if (!bt_gatt_client_set_ready_handler(device->gatt_client,
+							gatt_client_ready_cb,
+							device, NULL)) {
+		DBG("Failed to set ready handler for gatt-client");
+		gatt_client_cleanup(device);
+		return;
+	}
 
-		send_le_browse_response(req);
-		device->browse = NULL;
-		browse_request_free(req);
+	if (!bt_gatt_client_set_service_changed(device->gatt_client,
+						gatt_client_service_changed,
+						device, NULL)) {
+		DBG("Failed to set service changed handler for gatt-client");
+		gatt_client_cleanup(device);
 		return;
 	}
 
-	find_included_services(req, services);
+	DBG("gatt-client created");
 }
 
 bool device_attach_attrib(struct btd_device *dev, GIOChannel *io)
@@ -3653,10 +3669,8 @@ bool device_attach_attrib(struct btd_device *dev, GIOChannel *io)
 		}
 	}
 
-	if (cid == ATT_CID)
-		mtu = BT_ATT_DEFAULT_LE_MTU;
-
-	attrib = g_attrib_new(io, mtu);
+	dev->att_mtu = MIN(mtu, BT_ATT_MAX_LE_MTU);
+	attrib = g_attrib_new(io, dev->att_mtu);
 	if (!attrib) {
 		error("Unable to create new GAttrib instance");
 		return false;
@@ -3678,6 +3692,8 @@ bool device_attach_attrib(struct btd_device *dev, GIOChannel *io)
 						att_disconnected_cb, dev, NULL);
 	bt_att_set_close_on_unref(dev->att, true);
 
+	gatt_client_init(dev);
+
 	/*
 	 * Remove the device from the connect_list and give the passive
 	 * scanning another chance to be restarted in case there are
@@ -3685,8 +3701,6 @@ bool device_attach_attrib(struct btd_device *dev, GIOChannel *io)
 	 */
 	adapter_connect_list_remove(dev->adapter, dev);
 
-	g_slist_foreach(dev->attios, attio_connected, dev->attrib);
-
 	return true;
 }
 
@@ -3737,7 +3751,7 @@ done:
 
 	if (device->connect) {
 		if (!device->le_state.svc_resolved)
-			device_browse_primary(device, NULL);
+			device_browse_gatt(device, NULL);
 
 		if (err < 0)
 			reply = btd_error_failed(device->connect,
@@ -3840,16 +3854,32 @@ static void att_browse_error_cb(const GError *gerr, gpointer user_data)
 	browse_request_free(req);
 }
 
+static void browse_gatt_client(struct browse_req *req)
+{
+	struct btd_device *device = req->device;
+
+	if (!device->gatt_client) {
+		DBG("No gatt-client currently attached");
+		return;
+	}
+
+	/*
+	 * If gatt-client is ready, then register all services. Otherwise, this
+	 * will be deferred until client becomes ready.
+	 */
+	if (bt_gatt_client_is_ready(device->gatt_client))
+		register_gatt_services(req);
+}
+
 static void att_browse_cb(gpointer user_data)
 {
 	struct att_callbacks *attcb = user_data;
 	struct btd_device *device = attcb->user_data;
 
-	gatt_discover_primary(device->attrib, NULL, primary_cb,
-							device->browse);
+	browse_gatt_client(device->browse);
 }
 
-static int device_browse_primary(struct btd_device *device, DBusMessage *msg)
+static int device_browse_gatt(struct btd_device *device, DBusMessage *msg)
 {
 	struct btd_adapter *adapter = device->adapter;
 	struct att_callbacks *attcb;
@@ -3864,7 +3894,7 @@ static int device_browse_primary(struct btd_device *device, DBusMessage *msg)
 	device->browse = req;
 
 	if (device->attrib) {
-		gatt_discover_primary(device->attrib, NULL, primary_cb, req);
+		browse_gatt_client(device->browse);
 		goto done;
 	}
 
@@ -3981,7 +4011,7 @@ int device_discover_services(struct btd_device *device)
 	if (device->bredr)
 		err = device_browse_sdp(device, NULL);
 	else
-		err = device_browse_primary(device, NULL);
+		err = device_browse_gatt(device, NULL);
 
 	if (err == 0 && device->discov_timer) {
 		g_source_remove(device->discov_timer);
@@ -4127,7 +4157,7 @@ static gboolean start_discovery(gpointer user_data)
 	if (device->bredr)
 		device_browse_sdp(device, NULL);
 	else
-		device_browse_primary(device, NULL);
+		device_browse_gatt(device, NULL);
 
 	device->discov_timer = 0;
 
@@ -4264,7 +4294,7 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 		if (bdaddr_type == BDADDR_BREDR)
 			device_browse_sdp(device, bonding->msg);
 		else
-			device_browse_primary(device, bonding->msg);
+			device_browse_gatt(device, bonding->msg);
 
 		bonding_request_free(bonding);
 	} else if (!state->svc_resolved) {
@@ -4737,16 +4767,10 @@ GSList *btd_device_get_primaries(struct btd_device *device)
 void btd_device_gatt_set_service_changed(struct btd_device *device,
 						uint16_t start, uint16_t end)
 {
-	GSList *l;
-
-	for (l = device->primaries; l; l = g_slist_next(l)) {
-		struct gatt_primary *prim = l->data;
-
-		if (start <= prim->range.end && end >= prim->range.start)
-			prim->changed = TRUE;
-	}
-
-	device_browse_primary(device, NULL);
+	/*
+	 * TODO: Remove this function and handle service changed via
+	 * gatt-client.
+	 */
 }
 
 void btd_device_add_uuid(struct btd_device *device, const char *uuid)
diff --git a/src/shared/att-types.h b/src/shared/att-types.h
index 3d8829a..8b6d537 100644
--- a/src/shared/att-types.h
+++ b/src/shared/att-types.h
@@ -27,7 +27,8 @@
 #define __packed __attribute__((packed))
 #endif
 
-#define BT_ATT_DEFAULT_LE_MTU 23
+#define BT_ATT_DEFAULT_LE_MTU	23
+#define BT_ATT_MAX_LE_MTU	517
 
 /* ATT protocol opcodes */
 #define BT_ATT_OP_ERROR_RSP	      		0x01
-- 
2.2.0.rc0.207.ga3a616c

