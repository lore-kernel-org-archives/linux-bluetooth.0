Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH 3/4] android: Remove dead code
Date: Mon, 26 Oct 2015 22:57:31 +0100
Message-Id: <1445896652-16417-4-git-send-email-szymon.janc@codecoup.pl>
In-Reply-To: <1445896652-16417-1-git-send-email-szymon.janc@codecoup.pl>
References: <1445896652-16417-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This removes dead code due to memory allocation with new0 not being
able to fail.
---
 android/avdtp.c             |   5 +-
 android/avdtptest.c         |   4 -
 android/bas.c               |  55 ++------
 android/bluetooth.c         |  17 ---
 android/dis.c               |  11 --
 android/gatt.c              | 336 +++++---------------------------------------
 android/handsfree-client.c  |  14 +-
 android/handsfree.c         |   9 +-
 android/health.c            |  67 ++-------
 android/hog.c               |   2 -
 android/scpp.c              |  22 +--
 android/tester-a2dp.c       |   7 +-
 android/tester-avrcp.c      |   7 +-
 android/tester-bluetooth.c  |   7 +-
 android/tester-gatt.c       |   7 +-
 android/tester-hdp.c        |   7 +-
 android/tester-hidhost.c    |   7 +-
 android/tester-map-client.c |   7 +-
 android/tester-pan.c        |   7 +-
 android/tester-socket.c     |   7 +-
 20 files changed, 67 insertions(+), 538 deletions(-)

diff --git a/android/avdtp.c b/android/avdtp.c
index 908c0ca..bab305b 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -3398,10 +3398,7 @@ struct avdtp_local_sep *avdtp_register_sep(struct queue *lseps, uint8_t type,
 	DBG("SEP %p registered: type:%d codec:%d seid:%d", sep,
 			sep->info.type, sep->codec, sep->info.seid);
 
-	if (!queue_push_tail(lseps, sep)) {
-		g_free(sep);
-		return NULL;
-	}
+	queue_push_tail(lseps, sep);
 
 	return sep;
 }
diff --git a/android/avdtptest.c b/android/avdtptest.c
index 01d52ea..ce34443 100644
--- a/android/avdtptest.c
+++ b/android/avdtptest.c
@@ -869,10 +869,6 @@ int main(int argc, char *argv[])
 	}
 
 	lseps = queue_new();
-	if (!lseps) {
-		printf("Failed to allocate memory\n");
-		exit(1);
-	}
 
 	local_sep = avdtp_register_sep(lseps, dev_role, AVDTP_MEDIA_TYPE_AUDIO,
 					0x00, TRUE, &sep_ind, &sep_cfm, NULL);
diff --git a/android/bas.c b/android/bas.c
index dcbf9de..7a1c4ca 100644
--- a/android/bas.c
+++ b/android/bas.c
@@ -77,22 +77,15 @@ static void bas_free(struct bt_bas *bas)
 
 	g_free(bas->primary);
 	queue_destroy(bas->gatt_op, (void *) destroy_gatt_req);
-	g_free(bas);
+	free(bas);
 }
 
 struct bt_bas *bt_bas_new(void *primary)
 {
 	struct bt_bas *bas;
 
-	bas = g_try_new0(struct bt_bas, 1);
-	if (!bas)
-		return NULL;
-
+	bas = new0(struct bt_bas, 1);
 	bas->gatt_op = queue_new();
-	if (!bas->gatt_op) {
-		bas_free(bas);
-		return NULL;
-	}
 
 	if (primary)
 		bas->primary = g_memdup(primary, sizeof(*bas->primary));
@@ -127,21 +120,18 @@ static struct gatt_request *create_request(struct bt_bas *bas,
 	struct gatt_request *req;
 
 	req = new0(struct gatt_request, 1);
-	if (!req)
-		return NULL;
-
 	req->user_data = user_data;
 	req->bas = bt_bas_ref(bas);
 
 	return req;
 }
 
-static bool set_and_store_gatt_req(struct bt_bas *bas,
+static void set_and_store_gatt_req(struct bt_bas *bas,
 						struct gatt_request *req,
 						unsigned int id)
 {
 	req->id = id;
-	return queue_push_head(bas->gatt_op, req);
+	queue_push_head(bas->gatt_op, req);
 }
 
 static void write_char(struct bt_bas *bas, GAttrib *attrib, uint16_t handle,
@@ -153,18 +143,10 @@ static void write_char(struct bt_bas *bas, GAttrib *attrib, uint16_t handle,
 	unsigned int id;
 
 	req = create_request(bas, user_data);
-	if (!req)
-		return;
 
 	id = gatt_write_char(attrib, handle, value, vlen, func, req);
 
-	if (set_and_store_gatt_req(bas, req, id))
-		return;
-
-	error("bas: Could not write characteristic");
-	g_attrib_cancel(attrib, id);
-	free(req);
-
+	set_and_store_gatt_req(bas, req, id);
 }
 
 static void read_char(struct bt_bas *bas, GAttrib *attrib, uint16_t handle,
@@ -174,17 +156,10 @@ static void read_char(struct bt_bas *bas, GAttrib *attrib, uint16_t handle,
 	unsigned int id;
 
 	req = create_request(bas, user_data);
-	if (!req)
-		return;
 
 	id = gatt_read_char(attrib, handle, func, req);
 
-	if (set_and_store_gatt_req(bas, req, id))
-		return;
-
-	error("bas: Could not read characteristic");
-	g_attrib_cancel(attrib, id);
-	free(req);
+	set_and_store_gatt_req(bas, req, id);
 }
 
 static void discover_char(struct bt_bas *bas, GAttrib *attrib,
@@ -196,17 +171,10 @@ static void discover_char(struct bt_bas *bas, GAttrib *attrib,
 	unsigned int id;
 
 	req = create_request(bas, user_data);
-	if (!req)
-		return;
 
 	id = gatt_discover_char(attrib, start, end, uuid, func, req);
 
-	if (set_and_store_gatt_req(bas, req, id))
-		return;
-
-	error("bas: Could not discover characteristic");
-	g_attrib_cancel(attrib, id);
-	free(req);
+	set_and_store_gatt_req(bas, req, id);
 }
 
 static void discover_desc(struct bt_bas *bas, GAttrib *attrib,
@@ -217,16 +185,9 @@ static void discover_desc(struct bt_bas *bas, GAttrib *attrib,
 	unsigned int id;
 
 	req = create_request(bas, user_data);
-	if (!req)
-		return;
 
 	id = gatt_discover_desc(attrib, start, end, uuid, func, req);
-	if (set_and_store_gatt_req(bas, req, id))
-		return;
-
-	error("bas: Could not discover descriptor");
-	g_attrib_cancel(attrib, id);
-	free(req);
+	set_and_store_gatt_req(bas, req, id);
 }
 
 static void notification_cb(const guint8 *pdu, guint16 len, gpointer user_data)
diff --git a/android/bluetooth.c b/android/bluetooth.c
index 4d0cd48..51a31fe 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -3961,9 +3961,6 @@ bool bt_le_set_advertising(bool advertising, bt_le_set_advertising_done cb,
 	uint8_t adv = advertising ? 0x01 : 0x00;
 
 	data = new0(struct adv_user_data, 1);
-	if (!data)
-		return false;
-
 	data->cb = cb;
 	data->user_data = user_data;
 
@@ -4078,9 +4075,6 @@ bool bt_read_device_rssi(const bdaddr_t *addr, bt_read_device_rssi_done cb,
 	cp.addr.type = dev->bredr ? BDADDR_BREDR : dev->bdaddr_type;
 
 	data = new0(struct read_rssi_user_data, 1);
-	if (!data)
-		return false;
-
 	data->cb = cb;
 	data->user_data = user_data;
 
@@ -5249,18 +5243,7 @@ bool bt_bluetooth_register(struct ipc *ipc, uint8_t mode)
 	DBG("mode 0x%x", mode);
 
 	unpaired_cb_list = queue_new();
-	if (!unpaired_cb_list) {
-		error("Cannot allocate queue for unpaired callbacks");
-		return false;
-	}
-
 	paired_cb_list = queue_new();
-	if (!paired_cb_list) {
-		error("Cannot allocate queue for paired callbacks");
-		queue_destroy(unpaired_cb_list, NULL);
-		unpaired_cb_list = NULL;
-		return false;
-	}
 
 	missing_settings = adapter.current_settings ^
 						adapter.supported_settings;
diff --git a/android/dis.c b/android/dis.c
index 75dbe3d..0c20850 100644
--- a/android/dis.c
+++ b/android/dis.c
@@ -96,10 +96,6 @@ struct bt_dis *bt_dis_new(void *primary)
 		return NULL;
 
 	dis->gatt_op = queue_new();
-	if (!dis->gatt_op) {
-		dis_free(dis);
-		return NULL;
-	}
 
 	if (primary)
 		dis->primary = g_memdup(primary, sizeof(*dis->primary));
@@ -134,9 +130,6 @@ static struct gatt_request *create_request(struct bt_dis *dis,
 	struct gatt_request *req;
 
 	req = new0(struct gatt_request, 1);
-	if (!req)
-		return NULL;
-
 	req->user_data = user_data;
 	req->dis = bt_dis_ref(dis);
 
@@ -197,8 +190,6 @@ static void read_char(struct bt_dis *dis, GAttrib *attrib, uint16_t handle,
 	unsigned int id;
 
 	req = create_request(dis, user_data);
-	if (!req)
-		return;
 
 	id = gatt_read_char(attrib, handle, func, req);
 
@@ -219,8 +210,6 @@ static void discover_char(struct bt_dis *dis, GAttrib *attrib,
 	unsigned int id;
 
 	req = create_request(dis, user_data);
-	if (!req)
-		return;
 
 	id = gatt_discover_char(attrib, start, end, uuid, func, req);
 
diff --git a/android/gatt.c b/android/gatt.c
index 65f3142..28635ed 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -744,37 +744,14 @@ static struct gatt_device *create_device(const bdaddr_t *addr)
 	struct gatt_device *dev;
 
 	dev = new0(struct gatt_device, 1);
-	if (!dev)
-		return NULL;
 
 	bacpy(&dev->bdaddr, addr);
 
 	dev->services = queue_new();
-	if (!dev->services) {
-		error("gatt: Failed to allocate memory for client");
-		destroy_device(dev);
-		return NULL;
-	}
-
 	dev->autoconnect_apps = queue_new();
-	if (!dev->autoconnect_apps) {
-		error("gatt: Failed to allocate memory for client");
-		destroy_device(dev);
-		return NULL;
-	}
-
 	dev->pending_requests = queue_new();
-	if (!dev->pending_requests) {
-		error("gatt: Failed to allocate memory for client");
-		destroy_device(dev);
-		return NULL;
-	}
 
-	if (!queue_push_head(gatt_devices, dev)) {
-		error("gatt: Cannot push device to queue");
-		destroy_device(dev);
-		return NULL;
-	}
+	queue_push_head(gatt_devices, dev);
 
 	return device_ref(dev);
 }
@@ -1116,25 +1093,13 @@ static struct app_connection *create_connection(struct gatt_device *device,
 
 	/* Check if already connected */
 	new_conn = new0(struct app_connection, 1);
-	if (!new_conn)
-		return NULL;
 
 	/* Make connection id unique to connection record (app, device) pair */
 	new_conn->app = app;
 	new_conn->id = last_conn_id++;
-
 	new_conn->transactions = queue_new();
-	if (!new_conn->transactions) {
-		free(new_conn);
-		return NULL;
-	}
 
-	if (!queue_push_head(app_connections, new_conn)) {
-		error("gatt: Cannot push client on the client queue!?");
-		queue_destroy(new_conn->transactions, free);
-		free(new_conn);
-		return NULL;
-	}
+	queue_push_head(app_connections, new_conn);
 
 	new_conn->device = device_ref(device);
 
@@ -1147,33 +1112,15 @@ static struct service *create_service(uint8_t id, bool primary, char *uuid,
 	struct service *s;
 
 	s = new0(struct service, 1);
-	if (!s) {
-		error("gatt: Cannot allocate memory for gatt_primary");
-		return NULL;
-	}
-
-	s->chars = queue_new();
-	if (!s->chars) {
-		error("gatt: Cannot allocate memory for char cache");
-		free(s);
-		return NULL;
-	}
-
-	s->included = queue_new();
-	if (!s->included) {
-		error("gatt: Cannot allocate memory for included queue");
-		queue_destroy(s->chars, NULL);
-		free(s);
-		return NULL;
-	}
 
 	if (bt_string_to_uuid(&s->id.uuid, uuid) < 0) {
 		error("gatt: Cannot convert string to uuid");
-		queue_destroy(s->chars, NULL);
 		free(s);
 		return NULL;
 	}
 
+	s->chars = queue_new();
+	s->included = queue_new();
 	s->id.instance = id;
 
 	/* Put primary service to our local list */
@@ -1256,12 +1203,7 @@ static void discover_srvc_by_uuid_cb(uint8_t status, GSList *ranges,
 			goto reply;
 		}
 
-		if (!queue_push_tail(dev->services, s)) {
-			error("gatt: Cannot push primary service to the list");
-			destroy_service(s);
-			gatt_status = GATT_FAILURE;
-			goto reply;
-		}
+		queue_push_tail(dev->services, s);
 
 		send_client_primary_notify(s, INT_TO_PTR(cb_data->conn->id));
 
@@ -1318,11 +1260,7 @@ static void discover_srvc_all_cb(uint8_t status, GSList *services,
 		if (!p)
 			continue;
 
-		if (!queue_push_tail(dev->services, p)) {
-			error("gatt: Cannot push primary service to the list");
-			free(p);
-			continue;
-		}
+		queue_push_tail(dev->services, p);
 
 		DBG("attr handle = 0x%04x, end grp handle = 0x%04x uuid: %s",
 			prim->range.start, prim->range.end, prim->uuid);
@@ -1412,11 +1350,6 @@ static guint search_dev_for_srvc(struct app_connection *conn, bt_uuid_t *uuid)
 	struct discover_srvc_data *cb_data;
 
 	cb_data = new0(struct discover_srvc_data, 1);
-	if (!cb_data) {
-		error("gatt: Cannot allocate cb data");
-		return 0;
-	}
-
 	cb_data->conn = conn;
 
 	if (uuid) {
@@ -1779,7 +1712,7 @@ done:
 		dev = create_device(addr);
 	}
 
-	if (!dev || dev->state != DEVICE_CONNECT_INIT)
+	if (dev->state != DEVICE_CONNECT_INIT)
 		return;
 
 	device_set_state(dev, DEVICE_CONNECT_READY);
@@ -1802,38 +1735,20 @@ static struct gatt_app *register_app(const uint8_t *uuid, gatt_type_t type)
 	}
 
 	app = new0(struct gatt_app, 1);
-	if (!app) {
-		error("gatt: Cannot allocate memory for registering app");
-		return NULL;
-	}
 
 	app->type = type;
 
-	if (app->type == GATT_CLIENT) {
+	if (app->type == GATT_CLIENT)
 		app->notifications = queue_new();
-		if (!app->notifications) {
-			error("gatt: couldn't allocate notifications queue");
-			destroy_gatt_app(app);
-			return NULL;
-		}
-	}
 
 	memcpy(app->uuid, uuid, sizeof(app->uuid));
 
 	app->id = application_id++;
 
-	if (!queue_push_head(gatt_apps, app)) {
-		error("gatt: Cannot push app on the list");
-		destroy_gatt_app(app);
-		return NULL;
-	}
+	queue_push_head(gatt_apps, app);
 
-	if ((app->type == GATT_SERVER) &&
-			!queue_push_tail(listen_apps, INT_TO_PTR(app->id))) {
-		error("gatt: Cannot push server on the list");
-		destroy_gatt_app(app);
-		return NULL;
-	}
+	if (app->type == GATT_SERVER)
+		queue_push_tail(listen_apps, INT_TO_PTR(app->id));
 
 	return app;
 }
@@ -2056,9 +1971,6 @@ static struct listen_data *create_listen_data(int32_t client_id, bool start)
 	struct listen_data *d;
 
 	d = new0(struct listen_data, 1);
-	if (!d)
-		return NULL;
-
 	d->client_id = client_id;
 	d->start = start;
 
@@ -2108,11 +2020,6 @@ static void handle_client_unregister(const void *buf, uint16_t len)
 
 	if (!advertising_cnt) {
 		data = create_listen_data(cmd->client_if, false);
-		if (!data) {
-			error("gatt: Could not allocate listen data");
-			status = HAL_STATUS_NOMEM;
-			goto reply;
-		}
 
 		if (!bt_le_set_advertising(data->start, set_advertising_cb,
 								data)) {
@@ -2144,11 +2051,8 @@ static uint8_t handle_connect(int32_t app_id, const bdaddr_t *addr, bool direct)
 		return HAL_STATUS_FAILED;
 
 	device = find_device_by_addr(addr);
-	if (!device) {
+	if (!device)
 		device = create_device(addr);
-		if (!device)
-			return HAL_STATUS_FAILED;
-	}
 
 	conn_match.device = device;
 	conn_match.app = app;
@@ -2229,12 +2133,7 @@ static void handle_client_listen(const void *buf, uint16_t len)
 			goto reply;
 		}
 
-		if (!queue_push_tail(listen_apps,
-						INT_TO_PTR(cmd->client_if))) {
-			error("gatt: Could not put client on listen queue");
-			status = HAL_STATUS_FAILED;
-			goto reply;
-		}
+		queue_push_tail(listen_apps, INT_TO_PTR(cmd->client_if));
 
 		/* If listen is already on just return success*/
 		if (advertising_cnt > 0) {
@@ -2264,11 +2163,6 @@ static void handle_client_listen(const void *buf, uint16_t len)
 	}
 
 	data = create_listen_data(cmd->client_if, cmd->start);
-	if (!data) {
-		error("gatt: Could not allocate listen data");
-		status = HAL_STATUS_NOMEM;
-		goto reply;
-	}
 
 	if (!bt_le_set_advertising(cmd->start, set_advertising_cb, data)) {
 		error("gatt: Could not set advertising");
@@ -2507,12 +2401,8 @@ static void get_included_cb(uint8_t status, GSList *included, void *user_data)
 		 * 1. on services queue together with primary service
 		 * 2. on special queue inside primary service
 		 */
-		if (!queue_push_tail(service->included, incl) ||
-			!queue_push_tail(conn->device->services, incl)) {
-			error("gatt: Cannot push incl service to the list");
-			destroy_service(incl);
-			continue;
-		}
+		queue_push_tail(service->included, incl);
+		queue_push_tail(conn->device->services, incl);
 	}
 
 	/*
@@ -2525,18 +2415,13 @@ failed:
 	send_client_incl_service_notify(&service->id, incl, conn->id);
 }
 
-static bool search_included_services(struct app_connection *conn,
+static void search_included_services(struct app_connection *conn,
 							struct service *service)
 {
 	struct get_included_data *data;
 	uint16_t start, end;
 
 	data = new0(struct get_included_data, 1);
-	if (!data) {
-		error("gatt: failed to allocate memory for included_data");
-		return false;
-	}
-
 	data->prim = service;
 	data->conn = conn;
 
@@ -2550,8 +2435,6 @@ static bool search_included_services(struct app_connection *conn,
 
 	gatt_find_included(conn->device->attrib, start, end, get_included_cb,
 									data);
-
-	return true;
 }
 
 static bool find_service(int32_t conn_id, struct element_id *service_id,
@@ -2610,13 +2493,9 @@ static void handle_client_get_included_service(const void *buf, uint16_t len)
 	}
 
 	if (!prim_service->incl_search_done) {
-		if (search_included_services(conn, prim_service)) {
-			status = HAL_STATUS_SUCCESS;
-			goto reply;
-		}
-
-		status = HAL_STATUS_FAILED;
-		goto notify;
+		search_included_services(conn, prim_service);
+		status = HAL_STATUS_SUCCESS;
+		goto reply;
 	}
 
 	/* Try to use cache here */
@@ -2696,17 +2575,7 @@ static void cache_all_srvc_chars(struct service *srvc, GSList *characteristics)
 		struct characteristic *ch;
 
 		ch = new0(struct characteristic, 1);
-		if (!ch) {
-			error("gatt: Error while caching characteristic");
-			continue;
-		}
-
 		ch->descriptors = queue_new();
-		if (!ch->descriptors) {
-			error("gatt: Error while caching characteristic");
-			free(ch);
-			continue;
-		}
 
 		memcpy(&ch->ch, characteristics->data, sizeof(ch->ch));
 
@@ -2732,10 +2601,7 @@ static void cache_all_srvc_chars(struct service *srvc, GSList *characteristics)
 		DBG("attr handle = 0x%04x, end handle = 0x%04x uuid: %s",
 				ch->ch.handle, ch->end_handle, ch->ch.uuid);
 
-		if (!queue_push_tail(srvc->chars, ch)) {
-			error("gatt: Error while caching characteristic");
-			destroy_characteristic(ch);
-		}
+		queue_push_tail(srvc->chars, ch);
 	}
 }
 
@@ -2797,12 +2663,6 @@ static void handle_client_get_characteristic(const void *buf, uint16_t len)
 		struct att_range range;
 
 		cb_data = new0(struct discover_char_data, 1);
-		if (!cb_data) {
-			error("gatt: Cannot allocate cb data");
-			status = HAL_STATUS_FAILED;
-			goto done;
-		}
-
 		cb_data->service = srvc;
 		cb_data->conn_id = conn->id;
 
@@ -2889,8 +2749,6 @@ static void gatt_discover_desc_cb(guint8 status, GSList *descs,
 		bt_uuid_t uuid;
 
 		descr = new0(struct descriptor, 1);
-		if (!descr)
-			continue;
 
 		bt_string_to_uuid(&uuid, desc->uuid);
 		bt_uuid_to_uuid128(&uuid, &descr->id.uuid);
@@ -2900,8 +2758,7 @@ static void gatt_discover_desc_cb(guint8 status, GSList *descs,
 
 		DBG("attr handle = 0x%04x, uuid: %s", desc->handle, desc->uuid);
 
-		if (!queue_push_tail(ch->descriptors, descr))
-			free(descr);
+		queue_push_tail(ch->descriptors, descr);
 	}
 
 reply:
@@ -2929,9 +2786,6 @@ static bool build_descr_cache(struct app_connection *conn, struct service *srvc,
 		return false;
 
 	cb_data = new0(struct discover_desc_data, 1);
-	if (!cb_data)
-		return false;
-
 	cb_data->conn = conn;
 	cb_data->srvc = srvc;
 	cb_data->ch = ch;
@@ -3033,9 +2887,6 @@ static struct char_op_data *create_char_op_data(int32_t conn_id,
 	struct char_op_data *d;
 
 	d = new0(struct char_op_data, 1);
-	if (!d)
-		return NULL;
-
 	d->conn_id = conn_id;
 	d->srvc_id = s_id;
 	d->char_id = ch_id;
@@ -3216,11 +3067,6 @@ static void handle_client_read_characteristic(const void *buf, uint16_t len)
 
 	cb_data = create_char_op_data(cmd->conn_id, &srvc->id, &ch->id,
 						cmd->srvc_id.is_primary);
-	if (!cb_data) {
-		error("gatt: Cannot allocate cb data");
-		status = HAL_STATUS_NOMEM;
-		goto failed;
-	}
 
 	if (!set_auth_type(conn->device, cmd->auth_req)) {
 		error("gatt: Failed to set security %d", cmd->auth_req);
@@ -3354,11 +3200,6 @@ static void handle_client_write_characteristic(const void *buf, uint16_t len)
 				cmd->write_type == GATT_WRITE_TYPE_DEFAULT) {
 		cb_data = create_char_op_data(cmd->conn_id, &srvc->id, &ch->id,
 						cmd->srvc_id.is_primary);
-		if (!cb_data) {
-			error("gatt: Cannot allocate call data");
-			status = HAL_STATUS_NOMEM;
-			goto failed;
-		}
 	}
 
 	if (!set_auth_type(conn->device, cmd->auth_req)) {
@@ -3507,9 +3348,6 @@ static struct desc_data *create_desc_data(int32_t conn_id,
 	struct desc_data *d;
 
 	d = new0(struct desc_data, 1);
-	if (!d)
-		return NULL;
-
 	d->conn_id = conn_id;
 	d->srvc_id = s_id;
 	d->char_id = ch_id;
@@ -3569,12 +3407,6 @@ static void handle_client_read_descriptor(const void *buf, uint16_t len)
 
 	cb_data = create_desc_data(conn_id, &srvc->id, &ch->id, &descr->id,
 								primary);
-	if (!cb_data) {
-		error("gatt: Read descr. could not allocate callback data");
-
-		status = HAL_STATUS_NOMEM;
-		goto failed;
-	}
 
 	if (!set_auth_type(conn->device, cmd->auth_req)) {
 		error("gatt: Failed to set security %d", cmd->auth_req);
@@ -3698,16 +3530,9 @@ static void handle_client_write_descriptor(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	if (cmd->write_type != GATT_WRITE_TYPE_NO_RESPONSE) {
+	if (cmd->write_type != GATT_WRITE_TYPE_NO_RESPONSE)
 		cb_data = create_desc_data(conn_id, &srvc->id, &ch->id,
 							&descr->id, primary);
-		if (!cb_data) {
-			error("gatt: Write descr. could not allocate cb_data");
-
-			status = HAL_STATUS_NOMEM;
-			goto failed;
-		}
-	}
 
 	if (!set_auth_type(conn->device, cmd->auth_req)) {
 		error("gatt: Failed to set security %d", cmd->auth_req);
@@ -3897,10 +3722,6 @@ static void handle_client_register_for_notification(const void *buf,
 	}
 
 	notification = new0(struct notification_data, 1);
-	if (!notification) {
-		status = HAL_STATUS_NOMEM;
-		goto failed;
-	}
 
 	memcpy(&notification->ch, &cmd->char_id, sizeof(notification->ch));
 	memcpy(&notification->service, &cmd->srvc_id,
@@ -3947,11 +3768,7 @@ static void handle_client_register_for_notification(const void *buf,
 	 */
 	notification->ref = 2;
 
-	if (!queue_push_tail(conn->app->notifications, notification)) {
-		unregister_notification(notification);
-		status = HAL_STATUS_FAILED;
-		goto failed;
-	}
+	queue_push_tail(conn->app->notifications, notification);
 
 	status = HAL_STATUS_SUCCESS;
 
@@ -4503,8 +4320,6 @@ static void send_dev_complete_response(struct gatt_device *device,
 		struct queue *temp;
 
 		temp = queue_new();
-		if (!temp)
-			goto done;
 
 		val = queue_pop_head(device->pending_requests);
 		if (!val) {
@@ -4567,8 +4382,6 @@ static void send_dev_complete_response(struct gatt_device *device,
 		struct queue *temp;
 
 		temp = queue_new();
-		if (!temp)
-			goto done;
 
 		val = queue_pop_head(device->pending_requests);
 		if (!val) {
@@ -4630,12 +4443,6 @@ static void send_dev_complete_response(struct gatt_device *device,
 			}
 
 			range = new0(struct att_range, 1);
-			if (!range) {
-				destroy_pending_request(val);
-				error = ATT_ECODE_INSUFF_RESOURCES;
-				break;
-			}
-
 			range->start = gatt_db_attribute_get_handle(
 								val->attrib);
 
@@ -4878,19 +4685,13 @@ static struct pending_trans_data *conn_add_transact(struct app_connection *conn,
 	static int32_t trans_id = 1;
 
 	transaction = new0(struct pending_trans_data, 1);
-	if (!transaction)
-		return NULL;
-
-	if (!queue_push_tail(conn->transactions, transaction)) {
-		free(transaction);
-		return NULL;
-	}
-
 	transaction->id = trans_id++;
 	transaction->opcode = opcode;
 	transaction->attrib = attrib;
 	transaction->serial_id = serial_id;
 
+	queue_push_tail(conn->transactions, transaction);
+
 	return transaction;
 }
 
@@ -4949,8 +4750,6 @@ static void read_cb(struct gatt_db_attribute *attrib, unsigned int id,
 
 	/* Store the request data, complete callback and transaction id */
 	transaction = conn_add_transact(conn, opcode, attrib, id);
-	if (!transaction)
-		goto failed;
 
 	bdaddr2android(&bdaddr, ev.bdaddr);
 	ev.conn_id = conn->id;
@@ -5009,8 +4808,6 @@ static void write_cb(struct gatt_db_attribute *attrib, unsigned int id,
 
 	/* Store the request data, complete callback and transaction id */
 	transaction = conn_add_transact(conn, opcode, attrib, id);
-	if (!transaction)
-		goto failed;
 
 	memset(ev, 0, sizeof(*ev));
 
@@ -5313,9 +5110,6 @@ static struct service_sdp *new_service_sdp_record(int32_t service_handle)
 		return NULL;
 
 	s = new0(struct service_sdp, 1);
-	if (!s)
-		return NULL;
-
 	s->service_handle = service_handle;
 	s->sdp_handle = add_sdp_record(&uuid, service_handle, end_handle, NULL);
 	if (!s->sdp_handle) {
@@ -5350,10 +5144,7 @@ static bool add_service_sdp_record(int32_t service_handle)
 	if (!s)
 		return false;
 
-	if (!queue_push_tail(services_sdp, s)) {
-		free_service_sdp_record(s);
-		return false;
-	}
+	queue_push_tail(services_sdp, s);
 
 	return true;
 }
@@ -6080,8 +5871,6 @@ static uint8_t read_by_type(const uint8_t *cmd, uint16_t cmd_len,
 		return ATT_ECODE_INVALID_HANDLE;
 
 	q = queue_new();
-	if (!q)
-		return ATT_ECODE_INSUFF_RESOURCES;
 
 	switch (cmd[0]) {
 	case ATT_OP_READ_BY_TYPE_REQ:
@@ -6104,17 +5893,8 @@ static uint8_t read_by_type(const uint8_t *cmd, uint16_t cmd_len,
 		struct gatt_db_attribute *attrib = queue_pop_head(q);
 
 		data = new0(struct pending_request, 1);
-		if (!data) {
-			queue_destroy(q, NULL);
-			return ATT_ECODE_INSUFF_RESOURCES;
-		}
-
 		data->attrib = attrib;
-		if (!queue_push_tail(device->pending_requests, data)) {
-			free(data);
-			queue_destroy(q, NULL);
-			return ATT_ECODE_INSUFF_RESOURCES;
-		}
+		queue_push_tail(device->pending_requests, data);
 	}
 
 	queue_destroy(q, NULL);
@@ -6156,15 +5936,9 @@ static uint8_t read_request(const uint8_t *cmd, uint16_t cmd_len,
 		return ATT_ECODE_INVALID_HANDLE;
 
 	data = new0(struct pending_request, 1);
-	if (!data)
-		return ATT_ECODE_INSUFF_RESOURCES;
-
 	data->offset = offset;
 	data->attrib = attrib;
-	if (!queue_push_tail(dev->pending_requests, data)) {
-		free(data);
-		return ATT_ECODE_INSUFF_RESOURCES;
-	}
+	queue_push_tail(dev->pending_requests, data);
 
 	process_dev_pending_requests(dev, cmd[0]);
 
@@ -6226,8 +6000,6 @@ static uint8_t find_info_handle(const uint8_t *cmd, uint16_t cmd_len,
 		return ATT_ECODE_INVALID_HANDLE;
 
 	q = queue_new();
-	if (!q)
-		return ATT_ECODE_UNLIKELY;
 
 	gatt_db_find_information(gatt_db, start, end, q);
 
@@ -6237,10 +6009,6 @@ static uint8_t find_info_handle(const uint8_t *cmd, uint16_t cmd_len,
 	}
 
 	temp = queue_new();
-	if (!temp) {
-		queue_destroy(q, NULL);
-		return ATT_ECODE_UNLIKELY;
-	}
 
 	attrib = queue_peek_head(q);
 	/* UUIDS can be only 128 bit and 16 bit */
@@ -6321,11 +6089,6 @@ static void find_by_type_request_cb(struct gatt_db_attribute *attrib,
 		return;
 
 	request_data = new0(struct pending_request, 1);
-	if (!request_data) {
-		find_data->error = ATT_ECODE_INSUFF_RESOURCES;
-		return;
-	}
-
 	request_data->filter_value = malloc0(find_data->search_vlen);
 	if (!request_data->filter_value) {
 		destroy_pending_request(request_data);
@@ -6338,11 +6101,7 @@ static void find_by_type_request_cb(struct gatt_db_attribute *attrib,
 	memcpy(request_data->filter_value, find_data->search_value,
 							find_data->search_vlen);
 
-	if (!queue_push_tail(find_data->device->pending_requests,
-							request_data)) {
-		destroy_pending_request(request_data);
-		find_data->error = ATT_ECODE_INSUFF_RESOURCES;
-	}
+	queue_push_tail(find_data->device->pending_requests, request_data);
 }
 
 static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
@@ -6511,7 +6270,6 @@ static void attribute_write_cb(struct gatt_db_attribute *attrib, int err,
 
 	data->attrib = attrib;
 	data->error = error;
-
 	data->completed = true;
 }
 
@@ -6545,15 +6303,9 @@ static uint8_t write_req_request(const uint8_t *cmd, uint16_t cmd_len,
 		return error;
 
 	data = new0(struct pending_request, 1);
-	if (!data)
-		return ATT_ECODE_INSUFF_RESOURCES;
-
 	data->attrib = attrib;
 
-	if (!queue_push_tail(dev->pending_requests, data)) {
-		free(data);
-		return ATT_ECODE_INSUFF_RESOURCES;
-	}
+	queue_push_tail(dev->pending_requests, data);
 
 	if (!gatt_db_attribute_write(attrib, 0, value, vlen, cmd[0],
 						g_attrib_get_att(dev->attrib),
@@ -6600,16 +6352,10 @@ static uint8_t write_prep_request(const uint8_t *cmd, uint16_t cmd_len,
 		return error;
 
 	data = new0(struct pending_request, 1);
-	if (!data)
-		return ATT_ECODE_INSUFF_RESOURCES;
-
 	data->attrib = attrib;
 	data->offset = offset;
 
-	if (!queue_push_tail(dev->pending_requests, data)) {
-		free(data);
-		return ATT_ECODE_INSUFF_RESOURCES;
-	}
+	queue_push_tail(dev->pending_requests, data);
 
 	data->value = g_memdup(value, vlen);
 	data->length = vlen;
@@ -6641,10 +6387,6 @@ static void send_server_write_execute_notify(void *data, void *user_data)
 	ev->conn_id = conn->id;
 
 	transaction = conn_add_transact(conn, ATT_OP_EXEC_WRITE_REQ, NULL, 0);
-	if (!transaction) {
-		conn->wait_execute_write = false;
-		return;
-	}
 
 	ev->trans_id = transaction->id;
 
@@ -6674,13 +6416,8 @@ static uint8_t write_execute_request(const uint8_t *cmd, uint16_t cmd_len,
 	ev.exec_write = value;
 
 	data = new0(struct pending_request, 1);
-	if (!data)
-		return ATT_ECODE_INSUFF_RESOURCES;
 
-	if (!queue_push_tail(dev->pending_requests, data)) {
-		free(data);
-		return ATT_ECODE_INSUFF_RESOURCES;
-	}
+	queue_push_tail(dev->pending_requests, data);
 
 	queue_foreach(app_connections, send_server_write_execute_notify, &ev);
 	send_dev_complete_response(dev, cmd[0]);
@@ -6774,10 +6511,6 @@ static void connect_confirm(GIOChannel *io, void *user_data)
 	dev = find_device_by_addr(&dst);
 	if (!dev) {
 		dev = create_device(&dst);
-		if (!dev) {
-			error("gatt: Could not create device");
-			goto drop;
-		}
 	} else {
 		if ((dev->state != DEVICE_DISCONNECTED) &&
 					!(dev->state == DEVICE_CONNECT_INIT &&
@@ -7227,9 +6960,8 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 	services_sdp = queue_new();
 	gatt_db = gatt_db_new();
 
-	if (!gatt_devices || !gatt_apps || !listen_apps || !app_connections ||
-						!services_sdp || !gatt_db) {
-		error("gatt: Failed to allocate memory for queues");
+	if (!gatt_db) {
+		error("gatt: Failed to allocate memory for database");
 		goto failed;
 	}
 
diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index 0e2bd40..65659b8 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -177,14 +177,6 @@ static struct device *device_create(const bdaddr_t *bdaddr)
 	struct device *dev;
 
 	dev = new0(struct device, 1);
-	if (!dev)
-		return NULL;
-
-	if (!queue_push_tail(devices, dev)) {
-		error("hf-client: Could not push dev on the list");
-		free(dev);
-		return NULL;
-	}
 
 	bacpy(&dev->bdaddr, bdaddr);
 	dev->state = HAL_HF_CLIENT_CONN_STATE_DISCONNECTED;
@@ -192,6 +184,8 @@ static struct device *device_create(const bdaddr_t *bdaddr)
 
 	init_codecs(dev);
 
+	queue_push_tail(devices, dev);
+
 	return dev;
 }
 
@@ -2166,10 +2160,6 @@ bool bt_hf_client_register(struct ipc *ipc, const bdaddr_t *addr)
 	DBG("");
 
 	devices = queue_new();
-	if (!devices) {
-		error("hf-client: Could not create devices list");
-		goto failed;
-	}
 
 	bacpy(&adapter_addr, addr);
 
diff --git a/android/handsfree.c b/android/handsfree.c
index 2f8a867..cb348ab 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -228,8 +228,6 @@ static struct hf_device *device_create(const bdaddr_t *bdaddr)
 	struct hf_device *dev;
 
 	dev = new0(struct hf_device, 1);
-	if (!dev)
-		return NULL;
 
 	bacpy(&dev->bdaddr, bdaddr);
 	dev->setup_state = HAL_HANDSFREE_CALL_STATE_IDLE;
@@ -240,10 +238,7 @@ static struct hf_device *device_create(const bdaddr_t *bdaddr)
 
 	init_codecs(dev);
 
-	if (!queue_push_head(devices, dev)) {
-		free(dev);
-		return NULL;
-	}
+	queue_push_head(devices, dev);
 
 	return dev;
 }
@@ -2968,8 +2963,6 @@ bool bt_handsfree_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode,
 		return false;
 
 	devices = queue_new();
-	if (!devices)
-		return false;
 
 	if (!enable_hsp_ag())
 		goto failed_queue;
diff --git a/android/health.c b/android/health.c
index f2895a2..eb02a64 100644
--- a/android/health.c
+++ b/android/health.c
@@ -822,9 +822,6 @@ static struct health_app *create_health_app(const char *app_name,
 	DBG("");
 
 	app = new0(struct health_app, 1);
-	if (!app)
-		return NULL;
-
 	app->id = app_id++;
 	app->num_of_mdep = mdeps;
 	app->app_name = strdup(app_name);
@@ -848,12 +845,7 @@ static struct health_app *create_health_app(const char *app_name,
 	}
 
 	app->mdeps = queue_new();
-	if (!app->mdeps)
-		goto fail;
-
 	app->devices = queue_new();
-	if (!app->devices)
-		goto fail;
 
 	return app;
 
@@ -906,8 +898,7 @@ static void bt_health_register_app(const void *buf, uint16_t len)
 	if (!app)
 		goto fail;
 
-	if (!queue_push_tail(apps, app))
-		goto fail;
+	queue_push_tail(apps, app);
 
 	rsp.app_id = app->id;
 	ipc_send_rsp_full(hal_ipc, HAL_SERVICE_ID_HEALTH, HAL_OP_HEALTH_REG_APP,
@@ -948,11 +939,6 @@ static void bt_health_mdep_cfg_data(const void *buf, uint16_t len)
 	}
 
 	mdep = new0(struct mdep_cfg, 1);
-	if (!mdep) {
-		status = HAL_STATUS_INVALID;
-		goto fail;
-	}
-
 	mdep->role = cmd->role;
 	mdep->data_type = cmd->data_type;
 	mdep->channel_type = android2channel_type(cmd->channel_type);
@@ -963,10 +949,7 @@ static void bt_health_mdep_cfg_data(const void *buf, uint16_t len)
 		memcpy(mdep->descr, cmd->descr, cmd->descr_len);
 	}
 
-	if (!queue_push_tail(app->mdeps, mdep)) {
-		status = HAL_STATUS_FAILED;
-		goto fail;
-	}
+	queue_push_tail(app->mdeps, mdep);
 
 	if (app->num_of_mdep != queue_length(app->mdeps))
 		goto send_rsp;
@@ -1258,28 +1241,15 @@ static struct health_device *create_device(struct health_app *app,
 {
 	struct health_device *dev;
 
-	if (!app)
-		return NULL;
-
 	/* create device and push it to devices queue */
 	dev = new0(struct health_device, 1);
-	if (!dev)
-		return NULL;
 
 	android2bdaddr(addr, &dev->dst);
 	dev->channels = queue_new();
-	if (!dev->channels) {
-		free_health_device(dev);
-		return NULL;
-	}
-
-	if (!queue_push_tail(app->devices, dev)) {
-		free_health_device(dev);
-		return NULL;
-	}
-
 	dev->app_id = app->id;
 
+	queue_push_tail(app->devices, dev);
+
 	return dev;
 }
 
@@ -1314,34 +1284,24 @@ static struct health_channel *create_channel(struct health_app *app,
 	if (!mdep) {
 		if (mdep_index == MDEP_ECHO) {
 			mdep = new0(struct mdep_cfg, 1);
-			if (!mdep)
-				return NULL;
 
 			/* Leave other configuration zeroes */
 			mdep->id = MDEP_ECHO;
 
-			if (!queue_push_tail(app->mdeps, mdep)) {
-				free_mdep_cfg(mdep);
-				return NULL;
-			}
-		} else
+			queue_push_tail(app->mdeps, mdep);
+		} else {
 			return NULL;
+		}
 	}
 
 	/* create channel and push it to device */
 	channel = new0(struct health_channel, 1);
-	if (!channel)
-		return NULL;
-
 	channel->mdep_id = mdep->id;
 	channel->type = mdep->channel_type;
 	channel->id = channel_id++;
 	channel->dev = dev;
 
-	if (!queue_push_tail(dev->channels, channel)) {
-		free_health_channel(channel);
-		return NULL;
-	}
+	queue_push_tail(dev->channels, channel);
 
 	return channel;
 }
@@ -1351,7 +1311,6 @@ static struct health_channel *connect_channel(struct health_app *app,
 							uint8_t mdepid)
 {
 	struct health_device *device;
-	struct health_channel *channel = NULL;
 	bdaddr_t addr;
 
 	DBG("app %p mdepid %u", app, mdepid);
@@ -1364,12 +1323,8 @@ static struct health_channel *connect_channel(struct health_app *app,
 	}
 
 	device = get_device(app, (uint8_t *) &addr);
-	if (!device)
-		return NULL;
 
-	channel = create_channel(app, mdepid, device);
-
-	return channel;
+	return create_channel(app, mdepid, device);
 }
 
 static uint8_t conf_to_l2cap(uint8_t conf)
@@ -1899,8 +1854,6 @@ static void bt_health_connect_channel(const void *buf, uint16_t len)
 		goto send_rsp;
 
 	dev = get_device(app, cmd->bdaddr);
-	if (!dev)
-		goto send_rsp;
 
 	channel = get_channel(app, cmd->mdep_index, dev);
 	if (!channel)
@@ -2076,8 +2029,6 @@ bool bt_health_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 
 	hal_ipc = ipc;
 	apps = queue_new();
-	if (!apps)
-		return false;
 
 	ipc_register(hal_ipc, HAL_SERVICE_ID_HEALTH, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
diff --git a/android/hog.c b/android/hog.c
index ff77bb3..22f4228 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -1299,8 +1299,6 @@ static void hog_attach_bas(struct bt_hog *hog, struct gatt_primary *primary)
 	struct bt_bas *instance;
 
 	instance = bt_bas_new(primary);
-	if (!instance)
-		return;
 
 	bt_bas_attach(instance, hog->attrib);
 	queue_push_head(hog->bas, instance);
diff --git a/android/scpp.c b/android/scpp.c
index f8f81f3..a432733 100644
--- a/android/scpp.c
+++ b/android/scpp.c
@@ -74,11 +74,7 @@ static void discover_char(struct bt_scpp *scpp, GAttrib *attrib,
 
 	id = gatt_discover_char(attrib, start, end, uuid, func, user_data);
 
-	if (queue_push_head(scpp->gatt_op, UINT_TO_PTR(id)))
-		return;
-
-	error("scpp: Could not discover characteristic");
-	g_attrib_cancel(attrib, id);
+	queue_push_head(scpp->gatt_op, UINT_TO_PTR(id));
 }
 
 static void discover_desc(struct bt_scpp *scpp, GAttrib *attrib,
@@ -89,11 +85,7 @@ static void discover_desc(struct bt_scpp *scpp, GAttrib *attrib,
 
 	id = gatt_discover_desc(attrib, start, end, uuid, func, user_data);
 
-	if (queue_push_head(scpp->gatt_op, UINT_TO_PTR(id)))
-		return;
-
-	error("scpp: Could not discover descriptor");
-	g_attrib_cancel(attrib, id);
+	queue_push_head(scpp->gatt_op, UINT_TO_PTR(id));
 }
 
 static void write_char(struct bt_scpp *scan, GAttrib *attrib, uint16_t handle,
@@ -105,11 +97,7 @@ static void write_char(struct bt_scpp *scan, GAttrib *attrib, uint16_t handle,
 
 	id = gatt_write_char(attrib, handle, value, vlen, func, user_data);
 
-	if (queue_push_head(scan->gatt_op, UINT_TO_PTR(id)))
-		return;
-
-	error("scpp: Could not read char");
-	g_attrib_cancel(attrib, id);
+	queue_push_head(scan->gatt_op, UINT_TO_PTR(id));
 }
 
 static void scpp_free(struct bt_scpp *scan)
@@ -133,10 +121,6 @@ struct bt_scpp *bt_scpp_new(void *primary)
 	scan->window = SCAN_WINDOW;
 
 	scan->gatt_op = queue_new();
-	if (!scan->gatt_op) {
-		scpp_free(scan);
-		return NULL;
-	}
 
 	if (primary)
 		scan->primary = g_memdup(primary, sizeof(*scan->primary));
diff --git a/android/tester-a2dp.c b/android/tester-a2dp.c
index f7d82c9..8397eef 100644
--- a/android/tester-a2dp.c
+++ b/android/tester-a2dp.c
@@ -236,14 +236,9 @@ struct queue *get_a2dp_tests(void)
 	uint16_t i = 0;
 
 	list = queue_new();
-	if (!list)
-		return NULL;
 
 	for (; i < sizeof(test_cases) / sizeof(test_cases[0]); ++i)
-		if (!queue_push_tail(list, &test_cases[i])) {
-			queue_destroy(list, NULL);
-			return NULL;
-		}
+		queue_push_tail(list, &test_cases[i]);
 
 	return list;
 }
diff --git a/android/tester-avrcp.c b/android/tester-avrcp.c
index cec9787..737602e 100644
--- a/android/tester-avrcp.c
+++ b/android/tester-avrcp.c
@@ -584,14 +584,9 @@ struct queue *get_avrcp_tests(void)
 	uint16_t i = 0;
 
 	list = queue_new();
-	if (!list)
-		return NULL;
 
 	for (; i < sizeof(test_cases) / sizeof(test_cases[0]); ++i)
-		if (!queue_push_tail(list, &test_cases[i])) {
-			queue_destroy(list, NULL);
-			return NULL;
-		}
+		queue_push_tail(list, &test_cases[i]);
 
 	return list;
 }
diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index dca8de9..22077a0 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -1224,14 +1224,9 @@ struct queue *get_bluetooth_tests(void)
 	uint16_t i = 0;
 
 	list = queue_new();
-	if (!list)
-		return NULL;
 
 	for (; i < sizeof(test_cases) / sizeof(test_cases[0]); ++i)
-		if (!queue_push_tail(list, &test_cases[i])) {
-			queue_destroy(list, NULL);
-			return NULL;
-		}
+		queue_push_tail(list, &test_cases[i]);
 
 	return list;
 }
diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index b8b088b..88be3d8 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -3665,14 +3665,9 @@ struct queue *get_gatt_tests(void)
 	uint16_t i = 0;
 
 	list = queue_new();
-	if (!list)
-		return NULL;
 
 	for (; i < sizeof(test_cases) / sizeof(test_cases[0]); ++i)
-		if (!queue_push_tail(list, &test_cases[i])) {
-			queue_destroy(list, NULL);
-			return NULL;
-		}
+		queue_push_tail(list, &test_cases[i]);
 
 	return list;
 }
diff --git a/android/tester-hdp.c b/android/tester-hdp.c
index 80f3b5f..e849820 100644
--- a/android/tester-hdp.c
+++ b/android/tester-hdp.c
@@ -549,14 +549,9 @@ struct queue *get_hdp_tests(void)
 	uint16_t i = 0;
 
 	list = queue_new();
-	if (!list)
-		return NULL;
 
 	for (; i < sizeof(test_cases) / sizeof(test_cases[0]); ++i)
-		if (!queue_push_tail(list, &test_cases[i])) {
-			queue_destroy(list, NULL);
-			return NULL;
-		}
+		queue_push_tail(list, &test_cases[i]);
 
 	return list;
 }
diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
index ab5f12b..221b122 100644
--- a/android/tester-hidhost.c
+++ b/android/tester-hidhost.c
@@ -719,14 +719,9 @@ struct queue *get_hidhost_tests(void)
 	uint16_t i = 0;
 
 	list = queue_new();
-	if (!list)
-		return NULL;
 
 	for (; i < sizeof(test_cases) / sizeof(test_cases[0]); ++i)
-		if (!queue_push_tail(list, &test_cases[i])) {
-			queue_destroy(list, NULL);
-			return NULL;
-		}
+		queue_push_tail(list, &test_cases[i]);
 
 	return list;
 }
diff --git a/android/tester-map-client.c b/android/tester-map-client.c
index 1f552a3..695c797 100644
--- a/android/tester-map-client.c
+++ b/android/tester-map-client.c
@@ -140,14 +140,9 @@ struct queue *get_map_client_tests(void)
 	uint16_t i = 0;
 
 	list = queue_new();
-	if (!list)
-		return NULL;
 
 	for (; i < sizeof(test_cases) / sizeof(test_cases[0]); ++i)
-		if (!queue_push_tail(list, &test_cases[i])) {
-			queue_destroy(list, NULL);
-			return NULL;
-		}
+		queue_push_tail(list, &test_cases[i]);
 
 	return list;
 }
diff --git a/android/tester-pan.c b/android/tester-pan.c
index e033e21..9da2488 100644
--- a/android/tester-pan.c
+++ b/android/tester-pan.c
@@ -226,14 +226,9 @@ struct queue *get_pan_tests(void)
 	uint16_t i = 0;
 
 	list = queue_new();
-	if (!list)
-		return NULL;
 
 	for (; i < sizeof(test_cases) / sizeof(test_cases[0]); ++i)
-		if (!queue_push_tail(list, &test_cases[i])) {
-			queue_destroy(list, NULL);
-			return NULL;
-		}
+		queue_push_tail(list, &test_cases[i]);
 
 	return list;
 }
diff --git a/android/tester-socket.c b/android/tester-socket.c
index 41e1434..2264a1f 100644
--- a/android/tester-socket.c
+++ b/android/tester-socket.c
@@ -447,14 +447,9 @@ struct queue *get_socket_tests(void)
 	uint16_t i = 0;
 
 	list = queue_new();
-	if (!list)
-		return NULL;
 
 	for (; i < sizeof(test_cases) / sizeof(test_cases[0]); ++i)
-		if (!queue_push_tail(list, &test_cases[i])) {
-			queue_destroy(list, NULL);
-			return NULL;
-		}
+		queue_push_tail(list, &test_cases[i]);
 
 	return list;
 }
-- 
2.6.2

