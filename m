Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ v0 02/10] device: Separate SDP browse from GATT discover primary services
Date: Fri,  1 Mar 2013 20:22:25 -0300
Message-Id: <1362180153-11133-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1362180153-11133-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1362180153-11133-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Both procedures have the same objective, which is discovering the
services that a remote device supports. But the similarities stop
there.

This commit splits the structures used for both structures, so
it's clear that the procedures are different. As the structures are
different some simplification in the service discovery logic can
be made.

The presence of a valid pointer on device->gatt_discov indicates
that there's a discovery going on, if at any point that pointer
isn't valid, the discovery should be stopped, for example, the
sender of the request has exited.
---
 src/device.c | 225 ++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 137 insertions(+), 88 deletions(-)

diff --git a/src/device.c b/src/device.c
index 8c1bd73..b7f30d8 100644
--- a/src/device.c
+++ b/src/device.c
@@ -116,10 +116,11 @@ struct browse_req {
 	guint listener_id;
 };
 
-struct included_search {
-	struct browse_req *req;
-	GSList *services;
-	GSList *current;
+struct gatt_discovery {
+	DBusMessage *msg;
+	guint sender_watch;
+	GSList *services; /* Found GATT services */
+	GSList *current; /* Current service checked for included services */
 };
 
 struct attio_data {
@@ -174,6 +175,7 @@ struct btd_device {
 	guint		disconn_timer;
 	guint		discov_timer;
 	struct browse_req *browse;		/* service discover request */
+	struct gatt_discovery *gatt_discov;	/* GATT service discovery */
 	struct bonding_req *bonding;
 	struct authentication_req *authr;	/* authentication request */
 	GSList		*disconnects;		/* disconnects message */
@@ -216,6 +218,8 @@ static int device_browse_primary(struct btd_device *device, DBusMessage *msg,
 							gboolean secure);
 static int device_browse_sdp(struct btd_device *device, DBusMessage *msg,
 							gboolean reverse);
+static void device_svc_resolved(struct btd_device *dev, DBusMessage *msg,
+								int err);
 
 static gboolean store_device_info_cb(gpointer user_data)
 {
@@ -359,6 +363,20 @@ static void browse_request_free(struct browse_req *req)
 	g_free(req);
 }
 
+static void gatt_discovery_free(struct gatt_discovery *disc)
+{
+	if (disc == NULL)
+		return;
+
+	if (disc->msg)
+		dbus_message_unref(disc->msg);
+
+	if (disc->sender_watch)
+		g_dbus_remove_watch(dbus_conn, disc->sender_watch);
+
+	g_free(disc);
+}
+
 static void attio_cleanup(struct btd_device *device)
 {
 	if (device->attachid) {
@@ -377,6 +395,16 @@ static void attio_cleanup(struct btd_device *device)
 		device->att_io = NULL;
 	}
 
+	if (device->gatt_discov) {
+		struct gatt_discovery *disc = device->gatt_discov;
+
+		device_svc_resolved(device, disc->msg, EIO);
+		disc->msg = NULL;
+
+		gatt_discovery_free(disc);
+		device->gatt_discov = NULL;
+	}
+
 	if (device->attrib) {
 		g_attrib_unref(device->attrib);
 		device->attrib = NULL;
@@ -960,6 +988,13 @@ static void discover_services_req_exit(DBusConnection *conn, void *user_data)
 	browse_request_cancel(req);
 }
 
+static void gatt_discovery_sender_exit(DBusConnection *conn, void *user_data)
+{
+	struct btd_device *device = user_data;
+
+	attio_cleanup(device);
+}
+
 static void bonding_request_cancel(struct bonding_req *bonding)
 {
 	struct btd_device *device = bonding->device;
@@ -1344,13 +1379,12 @@ static DBusMessage *disconnect_profile(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
-static void device_svc_resolved(struct btd_device *dev, int err)
+static void device_svc_resolved(struct btd_device *dev, DBusMessage *msg,
+								int err)
 {
 	DBusMessage *reply;
-	struct browse_req *req = dev->browse;
 
 	dev->svc_resolved = true;
-	dev->browse = NULL;
 
 	g_slist_free_full(dev->eir_uuids, g_free);
 	dev->eir_uuids = NULL;
@@ -1368,32 +1402,30 @@ static void device_svc_resolved(struct btd_device *dev, int err)
 		g_free(cb);
 	}
 
-	if (!req || !req->msg)
+	if (msg == NULL)
 		return;
 
-	if (dbus_message_is_method_call(req->msg, DEVICE_INTERFACE,
-								"Pair")) {
-		reply = dbus_message_new_method_return(req->msg);
+	if (dbus_message_is_method_call(msg, DEVICE_INTERFACE, "Pair")) {
+		reply = dbus_message_new_method_return(msg);
 		g_dbus_send_message(dbus_conn, reply);
 		return;
 	}
 
 	if (err) {
-		reply = btd_error_failed(req->msg, strerror(-err));
+		reply = btd_error_failed(msg, strerror(-err));
 		g_dbus_send_message(dbus_conn, reply);
 		return;
 	}
 
-	if (dbus_message_is_method_call(req->msg, DEVICE_INTERFACE, "Connect"))
-		reply = dev_connect(dbus_conn, req->msg, dev);
-	else if (dbus_message_is_method_call(req->msg, DEVICE_INTERFACE,
+	if (dbus_message_is_method_call(msg, DEVICE_INTERFACE, "Connect"))
+		reply = dev_connect(dbus_conn, msg, dev);
+	else if (dbus_message_is_method_call(msg, DEVICE_INTERFACE,
 							"ConnectProfile"))
-		reply = connect_profile(dbus_conn, req->msg, dev);
+		reply = connect_profile(dbus_conn, msg, dev);
 	else
 		return;
 
-	dbus_message_unref(req->msg);
-	req->msg = NULL;
+	dbus_message_unref(msg);
 
 	if (reply)
 		g_dbus_send_message(dbus_conn, reply);
@@ -2689,8 +2721,8 @@ static gint primary_cmp(gconstpointer a, gconstpointer b)
 	return memcmp(a, b, sizeof(struct gatt_primary));
 }
 
-static void update_gatt_services(struct browse_req *req, GSList *current,
-								GSList *found)
+static void update_gatt_services(GSList *current, GSList *found,
+					GSList **added, GSList **removed)
 {
 	GSList *l, *lmatch, *left = g_slist_copy(current);
 
@@ -2706,8 +2738,7 @@ static void update_gatt_services(struct browse_req *req, GSList *current,
 		}
 
 		/* New entry */
-		req->profiles_added = g_slist_append(req->profiles_added,
-							g_strdup(prim->uuid));
+		*added = g_slist_append(*added, g_strdup(prim->uuid));
 
 		DBG("UUID Added: %s", prim->uuid);
 	}
@@ -2715,8 +2746,7 @@ static void update_gatt_services(struct browse_req *req, GSList *current,
 	/* Removed Profiles */
 	for (l = left; l; l = g_slist_next(l)) {
 		struct gatt_primary *prim = l->data;
-		req->profiles_removed = g_slist_append(req->profiles_removed,
-							g_strdup(prim->uuid));
+		*removed = g_slist_append(*removed, g_strdup(prim->uuid));
 
 		DBG("UUID Removed: %s", prim->uuid);
 	}
@@ -2818,7 +2848,14 @@ static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
 						DEVICE_INTERFACE, "UUIDs");
 
 send_reply:
-	device_svc_resolved(device, err);
+	/* Browse has finished, some profiles may use device->browse to check
+	 * if browsing is still ongoing, so we mark it as finished, and free
+	 * it later
+	 */
+	device->browse = NULL;
+
+	device_svc_resolved(device, req->msg, err);
+	req->msg = NULL; /* The reply was sent above */
 
 	if (!device->temporary)
 		store_device_info(device);
@@ -2972,10 +3009,11 @@ static gboolean attrib_disconnected_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
 	struct btd_device *device = user_data;
+	struct gatt_discovery *disc = device->gatt_discov;
 	int sock, err = 0;
 	socklen_t len;
 
-	if (device->browse)
+	if (disc)
 		goto done;
 
 	sock = g_io_channel_unix_get_fd(io);
@@ -3003,21 +3041,24 @@ done:
 	return FALSE;
 }
 
-static void register_all_services(struct browse_req *req, GSList *services)
+static void register_all_services(struct btd_device *device, GSList *services)
 {
-	struct btd_device *device = req->device;
+	struct gatt_discovery *disc = device->gatt_discov;
+	GSList *added = NULL, *removed = NULL;
 
 	device_set_temporary(device, FALSE);
 
-	update_gatt_services(req, device->primaries, services);
+	update_gatt_services(device->primaries, services, &added, &removed);
+
+	/* 'services' is the new 'primaries', clear the old one */
 	g_slist_free_full(device->primaries, g_free);
 	device->primaries = NULL;
 
 	device_register_primaries(device, g_slist_copy(services), -1);
-	if (req->profiles_removed)
-		device_remove_profiles(device, req->profiles_removed);
+	if (removed)
+		device_remove_profiles(device, removed);
 
-	device_probe_profiles(device, req->profiles_added);
+	device_probe_profiles(device, added);
 
 	if (device->attios == NULL && device->attios_offline == NULL)
 		attio_cleanup(device);
@@ -3025,11 +3066,10 @@ static void register_all_services(struct browse_req *req, GSList *services)
 	g_dbus_emit_property_changed(dbus_conn, device->path,
 						DEVICE_INTERFACE, "UUIDs");
 
-	device_svc_resolved(device, 0);
+	device_svc_resolved(device, disc->msg, 0);
+	disc->msg = NULL; /* The reply was sent just above */
 
 	store_services(device);
-
-	browse_request_free(req);
 }
 
 static int service_by_range_cmp(gconstpointer a, gconstpointer b)
@@ -3043,11 +3083,16 @@ static int service_by_range_cmp(gconstpointer a, gconstpointer b)
 static void find_included_cb(GSList *includes, uint8_t status,
 						gpointer user_data)
 {
-	struct included_search *search = user_data;
-	struct btd_device *device = search->req->device;
+	struct btd_device *device = user_data;
+	struct gatt_discovery *disc = device->gatt_discov;
 	struct gatt_primary *prim;
 	GSList *l;
 
+	if (disc == NULL) {
+		btd_device_unref(device);
+		return;
+	}
+
 	if (status != 0) {
 		error("Find included services failed: %s (%d)",
 					att_ecode2str(status), status);
@@ -3060,7 +3105,7 @@ static void find_included_cb(GSList *includes, uint8_t status,
 	for (l = includes; l; l = l->next) {
 		struct gatt_included *incl = l->data;
 
-		if (g_slist_find_custom(search->services, &incl->range,
+		if (g_slist_find_custom(disc->services, &incl->range,
 						service_by_range_cmp))
 			continue;
 
@@ -3068,63 +3113,70 @@ static void find_included_cb(GSList *includes, uint8_t status,
 		memcpy(prim->uuid, incl->uuid, sizeof(prim->uuid));
 		memcpy(&prim->range, &incl->range, sizeof(prim->range));
 
-		search->services = g_slist_append(search->services, prim);
+		disc->services = g_slist_append(disc->services, prim);
 	}
 
 done:
-	search->current = search->current->next;
-	if (search->current == NULL) {
-		register_all_services(search->req, search->services);
-		g_slist_free(search->services);
-		g_free(search);
+	disc->current = disc->current->next;
+	if (disc->current == NULL) {
+		register_all_services(device, disc->services);
+		g_slist_free(disc->services);
+		btd_device_unref(device);
 		return;
 	}
 
-	prim = search->current->data;
+	prim = disc->current->data;
 	gatt_find_included(device->attrib, prim->range.start, prim->range.end,
-					find_included_cb, search);
+						find_included_cb, device);
 }
 
-static void find_included_services(struct browse_req *req, GSList *services)
+static void find_included_services(struct btd_device *device, GSList *services)
 {
-	struct btd_device *device = req->device;
-	struct included_search *search;
 	struct gatt_primary *prim;
+	struct gatt_discovery *disc;
+
+	disc = device->gatt_discov;
 
-	if (services == NULL)
+	if (services == NULL) {
+		gatt_discovery_free(disc);
+		device->gatt_discov = NULL;
+		btd_device_unref(device);
 		return;
+	}
 
-	search = g_new0(struct included_search, 1);
-	search->req = req;
-	search->services = g_slist_copy(services);
-	search->current = search->services;
+	disc->services = g_slist_copy(services);
+	disc->current = disc->services;
 
-	prim = search->current->data;
+	prim = disc->current->data;
 	gatt_find_included(device->attrib, prim->range.start, prim->range.end,
-					find_included_cb, search);
-
+						find_included_cb, device);
 }
 
 static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 {
-	struct browse_req *req = user_data;
+	struct btd_device *device = user_data;
+	struct gatt_discovery *disc = device->gatt_discov;
 
-	if (status) {
-		struct btd_device *device = req->device;
+	if (disc == NULL) {
+		btd_device_unref(device);
+		return;
+	}
 
-		if (req->msg) {
+	if (status) {
+		if (disc->msg) {
 			DBusMessage *reply;
-			reply = btd_error_failed(req->msg,
+			reply = btd_error_failed(disc->msg,
 							att_ecode2str(status));
 			g_dbus_send_message(dbus_conn, reply);
 		}
 
-		device->browse = NULL;
-		browse_request_free(req);
+		gatt_discovery_free(disc);
+		device->gatt_discov = NULL;
+		btd_device_unref(device);
 		return;
 	}
 
-	find_included_services(req, services);
+	find_included_services(device, services);
 }
 
 static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
@@ -3143,7 +3195,7 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 		DBG("%s", gerr->message);
 
 		if (attcb->error)
-			attcb->error(gerr, user_data);
+			attcb->error(gerr, attcb->user_data);
 
 		err = -ECONNABORTED;
 		goto done;
@@ -3199,8 +3251,7 @@ done:
 
 static void att_error_cb(const GError *gerr, gpointer user_data)
 {
-	struct att_callbacks *attcb = user_data;
-	struct btd_device *device = attcb->user_data;
+	struct btd_device *device = user_data;
 
 	if (g_error_matches(gerr, BT_IO_ERROR, ECONNABORTED))
 		return;
@@ -3292,19 +3343,18 @@ int device_connect_le(struct btd_device *dev)
 
 static void att_browse_error_cb(const GError *gerr, gpointer user_data)
 {
-	struct att_callbacks *attcb = user_data;
-	struct btd_device *device = attcb->user_data;
-	struct browse_req *req = device->browse;
+	struct btd_device *device = user_data;
+	struct gatt_discovery *disc = device->gatt_discov;
 
-	if (req->msg) {
+	if (disc->msg) {
 		DBusMessage *reply;
 
-		reply = btd_error_failed(req->msg, gerr->message);
+		reply = btd_error_failed(disc->msg, gerr->message);
 		g_dbus_send_message(dbus_conn, reply);
 	}
 
-	device->browse = NULL;
-	browse_request_free(req);
+	device->gatt_discov = NULL;
+	gatt_discovery_free(disc);
 }
 
 static void att_browse_cb(gpointer user_data)
@@ -3321,19 +3371,19 @@ static int device_browse_primary(struct btd_device *device, DBusMessage *msg,
 {
 	struct btd_adapter *adapter = device->adapter;
 	struct att_callbacks *attcb;
-	struct browse_req *req;
+	struct gatt_discovery *disc;
 	BtIOSecLevel sec_level;
 
-	if (device->browse)
+	if (device->gatt_discov)
 		return -EBUSY;
 
-	req = g_new0(struct browse_req, 1);
-	req->device = btd_device_ref(device);
+	disc = g_new0(struct gatt_discovery, 1);
 
-	device->browse = req;
+	device->gatt_discov = disc;
 
 	if (device->attrib) {
-		gatt_discover_primary(device->attrib, NULL, primary_cb, req);
+		gatt_discover_primary(device->attrib, NULL, primary_cb,
+						btd_device_ref(device));
 		goto done;
 	}
 
@@ -3355,8 +3405,8 @@ static int device_browse_primary(struct btd_device *device, DBusMessage *msg,
 				BT_IO_OPT_INVALID);
 
 	if (device->att_io == NULL) {
-		device->browse = NULL;
-		browse_request_free(req);
+		gatt_discovery_free(disc);
+		device->gatt_discov = NULL;
 		g_free(attcb);
 		return -EIO;
 	}
@@ -3366,13 +3416,12 @@ done:
 	if (msg) {
 		const char *sender = dbus_message_get_sender(msg);
 
-		req->msg = dbus_message_ref(msg);
+		disc->msg = dbus_message_ref(msg);
 		/* Track the request owner to cancel it
 		 * automatically if the owner exits */
-		req->listener_id = g_dbus_add_disconnect_watch(dbus_conn,
-						sender,
-						discover_services_req_exit,
-						req, NULL);
+		disc->sender_watch = g_dbus_add_disconnect_watch(dbus_conn,
+					sender, gatt_discovery_sender_exit,
+					device, NULL);
 	}
 
 	return 0;
-- 
1.8.1.3

