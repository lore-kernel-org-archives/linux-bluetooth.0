Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 07/13] Rename adapter_get_address to btd_adapter_get_address
Date: Mon, 25 Nov 2013 22:15:46 +0000
Message-Id: <1385417752-25664-8-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1385417752-25664-1-git-send-email-szymon.janc@gmail.com>
References: <1385417752-25664-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Allow this symbol to be exported and usable from external plugins.
---
 plugins/neard.c               |  2 +-
 plugins/wiimote.c             |  2 +-
 profiles/audio/avctp.c        | 16 ++++++++++------
 profiles/audio/avdtp.c        |  9 ++++++---
 profiles/health/hdp.c         |  6 ++++--
 profiles/health/hdp_util.c    |  6 +++---
 profiles/input/device.c       |  2 +-
 profiles/input/manager.c      |  4 ++--
 profiles/network/connection.c |  2 +-
 profiles/network/server.c     |  4 ++--
 profiles/sap/server.c         |  3 ++-
 src/adapter.c                 |  6 +++---
 src/adapter.h                 |  2 +-
 src/attrib-server.c           |  4 ++--
 src/device.c                  | 31 ++++++++++++++++---------------
 src/profile.c                 | 12 ++++++------
 16 files changed, 61 insertions(+), 50 deletions(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index 58689e6..35fdaeb 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -227,7 +227,7 @@ static DBusMessage *create_request_oob_reply(struct btd_adapter *adapter,
 	uint8_t *peir = eir;
 	int len;
 
-	len = eir_create_oob(adapter_get_address(adapter),
+	len = eir_create_oob(btd_adapter_get_address(adapter),
 				btd_adapter_get_name(adapter),
 				btd_adapter_get_class(adapter), hash,
 				randomizer, main_opts.did_vendor,
diff --git a/plugins/wiimote.c b/plugins/wiimote.c
index 6cc21ee..96a6569 100644
--- a/plugins/wiimote.c
+++ b/plugins/wiimote.c
@@ -106,7 +106,7 @@ static ssize_t wii_pincb(struct btd_adapter *adapter, struct btd_device *device,
 
 found:
 	DBG("Forcing fixed pin on detected wiimote %s", addr);
-	memcpy(pinbuf, adapter_get_address(adapter), 6);
+	memcpy(pinbuf, btd_adapter_get_address(adapter), 6);
 	return 6;
 }
 
diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 476f61a..29fe763 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -1307,7 +1307,7 @@ static void avctp_control_confirm(struct avctp *session, GIOChannel *chan,
 	avctp_set_state(session, AVCTP_STATE_CONNECTING);
 	session->control = avctp_channel_create(session, chan, NULL);
 
-	src = adapter_get_address(device_get_adapter(dev));
+	src = btd_adapter_get_address(device_get_adapter(dev));
 	dst = device_get_address(dev);
 
 	session->auth_id = btd_request_authorization(src, dst,
@@ -1422,7 +1422,7 @@ static GIOChannel *avctp_server_socket(const bdaddr_t *src, gboolean master,
 int avctp_register(struct btd_adapter *adapter, gboolean master)
 {
 	struct avctp_server *server;
-	const bdaddr_t *src = adapter_get_address(adapter);
+	const bdaddr_t *src = btd_adapter_get_address(adapter);
 
 	server = g_new0(struct avctp_server, 1);
 
@@ -1937,6 +1937,7 @@ struct avctp *avctp_connect(struct btd_device *device)
 	struct avctp *session;
 	GError *err = NULL;
 	GIOChannel *io;
+	const bdaddr_t *src;
 
 	session = avctp_get_internal(device);
 	if (!session)
@@ -1947,9 +1948,10 @@ struct avctp *avctp_connect(struct btd_device *device)
 
 	avctp_set_state(session, AVCTP_STATE_CONNECTING);
 
+	src = btd_adapter_get_address(session->server->adapter);
+
 	io = bt_io_connect(avctp_connect_cb, session, NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR,
-				adapter_get_address(session->server->adapter),
+				BT_IO_OPT_SOURCE_BDADDR, src,
 				BT_IO_OPT_DEST_BDADDR,
 				device_get_address(session->device),
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
@@ -1971,6 +1973,7 @@ struct avctp *avctp_connect(struct btd_device *device)
 
 int avctp_connect_browsing(struct avctp *session)
 {
+	const bdaddr_t *src;
 	GError *err = NULL;
 	GIOChannel *io;
 
@@ -1982,9 +1985,10 @@ int avctp_connect_browsing(struct avctp *session)
 
 	avctp_set_state(session, AVCTP_STATE_BROWSING_CONNECTING);
 
+	src = btd_adapter_get_address(session->server->adapter);
+
 	io = bt_io_connect(avctp_connect_browsing_cb, session, NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR,
-				adapter_get_address(session->server->adapter),
+				BT_IO_OPT_SOURCE_BDADDR, src,
 				BT_IO_OPT_DEST_BDADDR,
 				device_get_address(session->device),
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index b7a7d9c..9386c44 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -2523,11 +2523,13 @@ static GIOChannel *l2cap_connect(struct avdtp *session)
 {
 	GError *err = NULL;
 	GIOChannel *io;
+	const bdaddr_t *src;
+
+	src = btd_adapter_get_address(session->server->adapter);
 
 	io = bt_io_connect(avdtp_connect_cb, session,
 				NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR,
-				adapter_get_address(session->server->adapter),
+				BT_IO_OPT_SOURCE_BDADDR, src,
 				BT_IO_OPT_DEST_BDADDR,
 				device_get_address(session->device),
 				BT_IO_OPT_PSM, AVDTP_PSM,
@@ -3675,7 +3677,8 @@ static struct avdtp_server *avdtp_server_init(struct btd_adapter *adapter)
 
 	server = g_new0(struct avdtp_server, 1);
 
-	server->io = avdtp_server_socket(adapter_get_address(adapter), TRUE);
+	server->io = avdtp_server_socket(btd_adapter_get_address(adapter),
+									TRUE);
 	if (!server->io) {
 		g_free(server);
 		return NULL;
diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index 86cebe6..6203fa8 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -1322,6 +1322,7 @@ static void release_adapter_instance(struct hdp_adapter *hdp_adapter)
 static gboolean update_adapter(struct hdp_adapter *hdp_adapter)
 {
 	GError *err = NULL;
+	const bdaddr_t *src;
 
 	if (applications == NULL) {
 		release_adapter_instance(hdp_adapter);
@@ -1331,8 +1332,9 @@ static gboolean update_adapter(struct hdp_adapter *hdp_adapter)
 	if (hdp_adapter->mi != NULL)
 		goto update;
 
-	hdp_adapter->mi = mcap_create_instance(
-				adapter_get_address(hdp_adapter->btd_adapter),
+	src = btd_adapter_get_address(hdp_adapter->btd_adapter);
+
+	hdp_adapter->mi = mcap_create_instance(src,
 				BT_IO_SEC_MEDIUM, 0, 0,
 				mcl_connected, mcl_reconnected,
 				mcl_disconnected, mcl_uncached,
diff --git a/profiles/health/hdp_util.c b/profiles/health/hdp_util.c
index 34e4671..7de87a8 100644
--- a/profiles/health/hdp_util.c
+++ b/profiles/health/hdp_util.c
@@ -853,7 +853,7 @@ gboolean hdp_get_mdep(struct hdp_device *device, struct hdp_application *app,
 	const bdaddr_t *dst;
 	uuid_t uuid;
 
-	src = adapter_get_address(device_get_adapter(device->dev));
+	src = btd_adapter_get_address(device_get_adapter(device->dev));
 	dst = device_get_address(device->dev);
 
 	mdep_data = g_new0(struct get_mdep_data, 1);
@@ -1080,7 +1080,7 @@ gboolean hdp_establish_mcl(struct hdp_device *device,
 	const bdaddr_t *dst;
 	uuid_t uuid;
 
-	src = adapter_get_address(device_get_adapter(device->dev));
+	src = btd_adapter_get_address(device_get_adapter(device->dev));
 	dst = device_get_address(device->dev);
 
 	conn_data = g_new0(struct conn_mcl_data, 1);
@@ -1151,7 +1151,7 @@ gboolean hdp_get_dcpsm(struct hdp_device *device, hdp_continue_dcpsm_f func,
 	const bdaddr_t *dst;
 	uuid_t uuid;
 
-	src = adapter_get_address(device_get_adapter(device->dev));
+	src = btd_adapter_get_address(device_get_adapter(device->dev));
 	dst = device_get_address(device->dev);
 
 	dcpsm_data = g_new0(struct get_dcpsm_data, 1);
diff --git a/profiles/input/device.c b/profiles/input/device.c
index 6523161..71fe04a 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -812,7 +812,7 @@ static struct input_device *input_device_new(struct btd_service *service)
 	char name[HCI_MAX_NAME_LENGTH + 1];
 
 	idev = g_new0(struct input_device, 1);
-	bacpy(&idev->src, adapter_get_address(adapter));
+	bacpy(&idev->src, btd_adapter_get_address(adapter));
 	bacpy(&idev->dst, device_get_address(device));
 	idev->service = btd_service_ref(service);
 	idev->device = btd_device_ref(device);
diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index 689ccdd..660043e 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -46,13 +46,13 @@
 
 static int hid_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
 {
-	return server_start(adapter_get_address(adapter));
+	return server_start(btd_adapter_get_address(adapter));
 }
 
 static void hid_server_remove(struct btd_profile *p,
 						struct btd_adapter *adapter)
 {
-	server_stop(adapter_get_address(adapter));
+	server_stop(btd_adapter_get_address(adapter));
 }
 
 static struct btd_profile input_profile = {
diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index 960a1fe..5966268 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -452,7 +452,7 @@ int connection_connect(struct btd_service *service)
 	if (nc->state != DISCONNECTED)
 		return -EALREADY;
 
-	src = adapter_get_address(device_get_adapter(peer->device));
+	src = btd_adapter_get_address(device_get_adapter(peer->device));
 	dst = device_get_address(peer->device);
 
 	nc->io = bt_io_connect(connect_cb, nc,
diff --git a/profiles/network/server.c b/profiles/network/server.c
index 7b784e5..0050b30 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -765,7 +765,7 @@ static struct network_adapter *create_adapter(struct btd_adapter *adapter)
 	na->io = bt_io_listen(NULL, confirm_event, na,
 				NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR,
-				adapter_get_address(adapter),
+				btd_adapter_get_address(adapter),
 				BT_IO_OPT_PSM, BNEP_PSM,
 				BT_IO_OPT_OMTU, BNEP_MTU,
 				BT_IO_OPT_IMTU, BNEP_MTU,
@@ -823,7 +823,7 @@ int server_register(struct btd_adapter *adapter, uint16_t id)
 									path);
 
 done:
-	bacpy(&ns->src, adapter_get_address(adapter));
+	bacpy(&ns->src, btd_adapter_get_address(adapter));
 	ns->id = id;
 	ns->na = na;
 	ns->record_id = 0;
diff --git a/profiles/sap/server.c b/profiles/sap/server.c
index 63314a7..119862d 100644
--- a/profiles/sap/server.c
+++ b/profiles/sap/server.c
@@ -1372,7 +1372,8 @@ int sap_server_register(struct btd_adapter *adapter)
 
 	io = bt_io_listen(NULL, connect_confirm_cb, server,
 			NULL, &gerr,
-			BT_IO_OPT_SOURCE_BDADDR, adapter_get_address(adapter),
+			BT_IO_OPT_SOURCE_BDADDR,
+			btd_adapter_get_address(adapter),
 			BT_IO_OPT_CHANNEL, SAP_SERVER_CHANNEL,
 			BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_HIGH,
 			BT_IO_OPT_MASTER, TRUE,
diff --git a/src/adapter.c b/src/adapter.c
index ec15715..a5a9ada 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3991,7 +3991,7 @@ const char *adapter_get_path(struct btd_adapter *adapter)
 	return adapter->path;
 }
 
-const bdaddr_t *adapter_get_address(struct btd_adapter *adapter)
+const bdaddr_t *btd_adapter_get_address(struct btd_adapter *adapter)
 {
 	return &adapter->bdaddr;
 }
@@ -5225,7 +5225,7 @@ static void store_link_key(struct btd_adapter *adapter,
 	char *str;
 	int i;
 
-	ba2str(adapter_get_address(adapter), adapter_addr);
+	ba2str(btd_adapter_get_address(adapter), adapter_addr);
 	ba2str(device_get_address(device), device_addr);
 
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info", adapter_addr,
@@ -5382,7 +5382,7 @@ static void new_long_term_key_callback(uint16_t index, uint16_t length,
 
 	if (ev->store_hint) {
 		const struct mgmt_ltk_info *key = &ev->key;
-		const bdaddr_t *bdaddr = adapter_get_address(adapter);
+		const bdaddr_t *bdaddr = btd_adapter_get_address(adapter);
 
 		store_longtermkey(bdaddr, &key->addr.bdaddr,
 					key->addr.type, key->val, key->master,
diff --git a/src/adapter.h b/src/adapter.h
index 8a2ddae..e982243 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -99,7 +99,7 @@ struct btd_device *adapter_find_device(struct btd_adapter *adapter,
 							const bdaddr_t *dst);
 
 const char *adapter_get_path(struct btd_adapter *adapter);
-const bdaddr_t *adapter_get_address(struct btd_adapter *adapter);
+const bdaddr_t *btd_adapter_get_address(struct btd_adapter *adapter);
 int adapter_set_name(struct btd_adapter *adapter, const char *name);
 
 int adapter_service_add(struct btd_adapter *adapter, sdp_record_t *rec);
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 2861a00..9231b5b 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -156,7 +156,7 @@ static int adapter_cmp_addr(gconstpointer a, gconstpointer b)
 	const struct gatt_server *server = a;
 	const bdaddr_t *bdaddr = b;
 
-	return bacmp(adapter_get_address(server->adapter), bdaddr);
+	return bacmp(btd_adapter_get_address(server->adapter), bdaddr);
 }
 
 static int adapter_cmp(gconstpointer a, gconstpointer b)
@@ -1310,7 +1310,7 @@ int btd_adapter_gatt_server_start(struct btd_adapter *adapter)
 	server = g_new0(struct gatt_server, 1);
 	server->adapter = btd_adapter_ref(adapter);
 
-	addr = adapter_get_address(server->adapter);
+	addr = btd_adapter_get_address(server->adapter);
 
 	/* BR/EDR socket */
 	server->l2cap_io = bt_io_listen(connect_event, NULL, NULL, NULL, &gerr,
diff --git a/src/device.c b/src/device.c
index 4ff8a14..4e952c5 100644
--- a/src/device.c
+++ b/src/device.c
@@ -263,7 +263,7 @@ static gboolean store_device_info_cb(gpointer user_data)
 
 	device->store_id = 0;
 
-	ba2str(adapter_get_address(device->adapter), adapter_addr);
+	ba2str(btd_adapter_get_address(device->adapter), adapter_addr);
 	ba2str(&device->bdaddr, device_addr);
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info", adapter_addr,
 			device_addr);
@@ -409,7 +409,7 @@ void device_store_cached_name(struct btd_device *dev, const char *name)
 		return;
 	}
 
-	ba2str(adapter_get_address(dev->adapter), s_addr);
+	ba2str(btd_adapter_get_address(dev->adapter), s_addr);
 	ba2str(&dev->bdaddr, d_addr);
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", s_addr, d_addr);
 	filename[PATH_MAX] = '\0';
@@ -470,7 +470,7 @@ static void browse_request_cancel(struct browse_req *req)
 	struct btd_device *device = req->device;
 	struct btd_adapter *adapter = device->adapter;
 
-	bt_cancel_discovery(adapter_get_address(adapter), &device->bdaddr);
+	bt_cancel_discovery(btd_adapter_get_address(adapter), &device->bdaddr);
 
 	attio_cleanup(device);
 
@@ -2183,7 +2183,7 @@ struct btd_device *device_create_from_storage(struct btd_adapter *adapter,
 	if (device == NULL)
 		return NULL;
 
-	src = adapter_get_address(adapter);
+	src = btd_adapter_get_address(adapter);
 	ba2str(src, srcaddr);
 
 	load_info(device, srcaddr, address, key_file);
@@ -2208,7 +2208,7 @@ struct btd_device *device_create(struct btd_adapter *adapter,
 		return NULL;
 
 	device->bdaddr_type = bdaddr_type;
-	sba = adapter_get_address(adapter);
+	sba = btd_adapter_get_address(adapter);
 	ba2str(sba, src);
 
 	str = load_cached_name(device, src, dst);
@@ -2231,7 +2231,7 @@ char *btd_device_get_storage_path(struct btd_device *device,
 		return NULL;
 	}
 
-	ba2str(adapter_get_address(device->adapter), srcaddr);
+	ba2str(btd_adapter_get_address(device->adapter), srcaddr);
 	ba2str(&device->bdaddr, dstaddr);
 
 	if (!filename)
@@ -2342,7 +2342,7 @@ static void delete_folder_tree(const char *dirname)
 
 static void device_remove_stored(struct btd_device *device)
 {
-	const bdaddr_t *src = adapter_get_address(device->adapter);
+	const bdaddr_t *src = btd_adapter_get_address(device->adapter);
 	uint8_t dst_type = device->bdaddr_type;
 	char adapter_addr[18];
 	char device_addr[18];
@@ -2717,7 +2717,7 @@ static void update_bredr_services(struct browse_req *req, sdp_list_t *recs)
 	char *data;
 	gsize length = 0;
 
-	ba2str(adapter_get_address(device->adapter), srcaddr);
+	ba2str(btd_adapter_get_address(device->adapter), srcaddr);
 	ba2str(&device->bdaddr, dstaddr);
 
 	if (!device->temporary) {
@@ -2961,7 +2961,7 @@ static void browse_cb(sdp_list_t *recs, int err, gpointer user_data)
 	/* Search for mandatory uuids */
 	if (uuid_list[req->search_uuid]) {
 		sdp_uuid16_create(&uuid, uuid_list[req->search_uuid++]);
-		bt_search_service(adapter_get_address(adapter),
+		bt_search_service(btd_adapter_get_address(adapter),
 						&device->bdaddr, &uuid,
 						browse_cb, user_data, NULL);
 		return;
@@ -2994,7 +2994,7 @@ static void store_services(struct btd_device *device)
 	if (prim_uuid == NULL)
 		return;
 
-	ba2str(adapter_get_address(adapter), src_addr);
+	ba2str(btd_adapter_get_address(adapter), src_addr);
 	ba2str(&device->bdaddr, dst_addr);
 
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/attributes", src_addr,
@@ -3370,7 +3370,8 @@ int device_connect_le(struct btd_device *dev)
 	 * pairing finishes
 	 */
 	io = bt_io_connect(att_connect_cb, attcb, NULL, &gerr,
-			BT_IO_OPT_SOURCE_BDADDR, adapter_get_address(adapter),
+			BT_IO_OPT_SOURCE_BDADDR,
+			btd_adapter_get_address(adapter),
 			BT_IO_OPT_SOURCE_TYPE, BDADDR_LE_PUBLIC,
 			BT_IO_OPT_DEST_BDADDR, &dev->bdaddr,
 			BT_IO_OPT_DEST_TYPE, dev->bdaddr_type,
@@ -3453,7 +3454,7 @@ static int device_browse_primary(struct btd_device *device, DBusMessage *msg)
 	device->att_io = bt_io_connect(att_connect_cb,
 				attcb, NULL, NULL,
 				BT_IO_OPT_SOURCE_BDADDR,
-				adapter_get_address(adapter),
+				btd_adapter_get_address(adapter),
 				BT_IO_OPT_SOURCE_TYPE, BDADDR_LE_PUBLIC,
 				BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
 				BT_IO_OPT_DEST_TYPE, device->bdaddr_type,
@@ -3499,8 +3500,8 @@ static int device_browse_sdp(struct btd_device *device, DBusMessage *msg)
 	req->device = device;
 	sdp_uuid16_create(&uuid, uuid_list[req->search_uuid++]);
 
-	err = bt_search_service(adapter_get_address(adapter), &device->bdaddr,
-						&uuid, browse_cb, req, NULL);
+	err = bt_search_service(btd_adapter_get_address(adapter),
+				&device->bdaddr, &uuid, browse_cb, req, NULL);
 	if (err < 0) {
 		browse_request_free(req);
 		return err;
@@ -4280,7 +4281,7 @@ static sdp_list_t *read_device_records(struct btd_device *device)
 	sdp_list_t *recs = NULL;
 	sdp_record_t *rec;
 
-	ba2str(adapter_get_address(device->adapter), local);
+	ba2str(btd_adapter_get_address(device->adapter), local);
 	ba2str(&device->bdaddr, peer);
 
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", local, peer);
diff --git a/src/profile.c b/src/profile.c
index baadd99..97cb1bc 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -718,7 +718,7 @@ static void ext_io_destroy(gpointer p)
 	}
 
 	if (ext_io->resolving)
-		bt_cancel_discovery(adapter_get_address(ext_io->adapter),
+		bt_cancel_discovery(btd_adapter_get_address(ext_io->adapter),
 					device_get_address(ext_io->device));
 
 	if (ext_io->adapter)
@@ -1257,7 +1257,7 @@ static uint32_t ext_start_servers(struct ext_profile *ext,
 
 		io = bt_io_listen(connect, confirm, l2cap, NULL, &err,
 					BT_IO_OPT_SOURCE_BDADDR,
-					adapter_get_address(adapter),
+					btd_adapter_get_address(adapter),
 					BT_IO_OPT_MODE, ext->mode,
 					BT_IO_OPT_PSM, psm,
 					BT_IO_OPT_SEC_LEVEL, ext->sec_level,
@@ -1295,7 +1295,7 @@ static uint32_t ext_start_servers(struct ext_profile *ext,
 
 		io = bt_io_listen(connect, confirm, rfcomm, NULL, &err,
 					BT_IO_OPT_SOURCE_BDADDR,
-					adapter_get_address(adapter),
+					btd_adapter_get_address(adapter),
 					BT_IO_OPT_CHANNEL, chan,
 					BT_IO_OPT_SEC_LEVEL, ext->sec_level,
 					BT_IO_OPT_INVALID);
@@ -1580,7 +1580,7 @@ static void record_cb(sdp_list_t *recs, int err, gpointer user_data)
 		goto failed;
 	}
 
-	err = connect_io(conn, adapter_get_address(conn->adapter),
+	err = connect_io(conn, btd_adapter_get_address(conn->adapter),
 					device_get_address(conn->device));
 	if (err < 0) {
 		error("Connecting %s failed: %s", ext->name, strerror(-err));
@@ -1637,10 +1637,10 @@ static int ext_connect_dev(struct btd_service *service)
 	if (ext->remote_psm || ext->remote_chan) {
 		conn->psm = ext->remote_psm;
 		conn->chan = ext->remote_chan;
-		err = connect_io(conn, adapter_get_address(adapter),
+		err = connect_io(conn, btd_adapter_get_address(adapter),
 						device_get_address(dev));
 	} else {
-		err = resolve_service(conn, adapter_get_address(adapter),
+		err = resolve_service(conn, btd_adapter_get_address(adapter),
 						device_get_address(dev));
 	}
 
-- 
1.8.4.4

