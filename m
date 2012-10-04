Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 1/7] adapter: Convert adapter_get_address into simple getter
Date: Thu, 4 Oct 2012 14:05:58 +0200
Message-ID: <1349352364-5491-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1349352364-5491-1-git-send-email-szymon.janc@tieto.com>
References: <1349352364-5491-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Most uses of adapter_get_address were in form of:

bdaddr_t addr;
adapter_get_address(adapter, &addr);
foo(&addr);

Changing it to getter makes code simpler and avoid number of not
needed memcpy.

---
 attrib/client.c              |    2 +-
 audio/manager.c              |   48 +++++---------
 plugins/adaptername.c        |    4 +-
 plugins/dbusoob.c            |    8 +--
 plugins/neard.c              |   16 ++---
 plugins/service.c            |   57 ++++++-----------
 plugins/wiimote.c            |    5 +-
 profiles/alert/server.c      |    4 +-
 profiles/gatt/gas.c          |   16 ++---
 profiles/health/hdp.c        |   14 ++---
 profiles/health/hdp_util.c   |   24 ++++---
 profiles/input/device.c      |    2 +-
 profiles/input/manager.c     |   11 +---
 profiles/network/manager.c   |   10 +--
 profiles/network/server.c    |    8 +--
 profiles/proximity/monitor.c |   13 ++--
 profiles/sap/manager.c       |    5 +-
 src/adapter.c                |   13 ++--
 src/adapter.h                |    2 +-
 src/attrib-server.c          |   18 +++---
 src/device.c                 |  143 +++++++++++++++++-------------------------
 src/manager.c                |    5 +-
 src/profile.c                |   28 ++++-----
 23 files changed, 179 insertions(+), 277 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index d49804c..eea06ae 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -229,7 +229,7 @@ static void gatt_get_address(struct gatt_service *gatt, bdaddr_t *sba,
 	struct btd_adapter *adapter;
 
 	adapter = device_get_adapter(device);
-	adapter_get_address(adapter, sba);
+	bacpy(sba, adapter_get_address(adapter));
 	device_get_address(device, dba, bdaddr_type);
 }
 
diff --git a/audio/manager.c b/audio/manager.c
index dbc98d5..6ddea5a 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -507,7 +507,7 @@ static int headset_server_init(struct audio_adapter *adapter)
 	GError *err = NULL;
 	uint32_t features;
 	GIOChannel *io;
-	bdaddr_t src;
+	bdaddr_t *src;
 
 	if (config) {
 		gboolean tmp;
@@ -521,10 +521,10 @@ static int headset_server_init(struct audio_adapter *adapter)
 			master = tmp;
 	}
 
-	adapter_get_address(adapter->btd_adapter, &src);
+	src = adapter_get_address(adapter->btd_adapter);
 
 	io =  bt_io_listen(NULL, ag_confirm, adapter, NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, &src,
+				BT_IO_OPT_SOURCE_BDADDR, src,
 				BT_IO_OPT_CHANNEL, chan,
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 				BT_IO_OPT_MASTER, master,
@@ -540,7 +540,7 @@ static int headset_server_init(struct audio_adapter *adapter)
 		goto failed;
 	}
 
-	if (add_record_to_server(&src, record) < 0) {
+	if (add_record_to_server(src, record) < 0) {
 		error("Unable to register HS AG service record");
 		sdp_record_free(record);
 		goto failed;
@@ -555,7 +555,7 @@ static int headset_server_init(struct audio_adapter *adapter)
 	chan = DEFAULT_HF_AG_CHANNEL;
 
 	io = bt_io_listen(NULL, ag_confirm, adapter, NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, &src,
+				BT_IO_OPT_SOURCE_BDADDR, src,
 				BT_IO_OPT_CHANNEL, chan,
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 				BT_IO_OPT_MASTER, master,
@@ -571,7 +571,7 @@ static int headset_server_init(struct audio_adapter *adapter)
 		goto failed;
 	}
 
-	if (add_record_to_server(&src, record) < 0) {
+	if (add_record_to_server(src, record) < 0) {
 		error("Unable to register HF AG service record");
 		sdp_record_free(record);
 		goto failed;
@@ -608,7 +608,7 @@ static int gateway_server_init(struct audio_adapter *adapter)
 	gboolean master = TRUE;
 	GError *err = NULL;
 	GIOChannel *io;
-	bdaddr_t src;
+	bdaddr_t *src;
 
 	if (config) {
 		gboolean tmp;
@@ -622,10 +622,10 @@ static int gateway_server_init(struct audio_adapter *adapter)
 			master = tmp;
 	}
 
-	adapter_get_address(adapter->btd_adapter, &src);
+	src = adapter_get_address(adapter->btd_adapter);
 
 	io = bt_io_listen(NULL, hf_io_cb, adapter, NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, &src,
+				BT_IO_OPT_SOURCE_BDADDR, src,
 				BT_IO_OPT_CHANNEL, chan,
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 				BT_IO_OPT_MASTER, master,
@@ -643,7 +643,7 @@ static int gateway_server_init(struct audio_adapter *adapter)
 		goto failed;
 	}
 
-	if (add_record_to_server(&src, record) < 0) {
+	if (add_record_to_server(src, record) < 0) {
 		error("Unable to register HFP HS service record");
 		sdp_record_free(record);
 		goto failed;
@@ -663,12 +663,11 @@ failed:
 static struct audio_device *get_audio_dev(struct btd_device *device)
 {
 	struct btd_adapter *adapter = device_get_adapter(device);
-	bdaddr_t src, dst;
+	bdaddr_t dst;
 
-	adapter_get_address(adapter, &src);
 	device_get_address(device, &dst, NULL);
 
-	return manager_get_device(&src, &dst, TRUE);
+	return manager_get_device(adapter_get_address(adapter), &dst, TRUE);
 }
 
 static void audio_remove(struct btd_profile *p, struct btd_device *device)
@@ -970,7 +969,6 @@ static int a2dp_server_probe(struct btd_profile *p,
 {
 	struct audio_adapter *adp;
 	const gchar *path = adapter_get_path(adapter);
-	bdaddr_t src;
 	int err;
 
 	DBG("path %s", path);
@@ -979,9 +977,7 @@ static int a2dp_server_probe(struct btd_profile *p,
 	if (!adp)
 		return -EINVAL;
 
-	adapter_get_address(adapter, &src);
-
-	err = a2dp_register(&src, config);
+	err = a2dp_register(adapter_get_address(adapter), config);
 	if (err < 0)
 		audio_adapter_unref(adp);
 
@@ -993,7 +989,6 @@ static void a2dp_server_remove(struct btd_profile *p,
 {
 	struct audio_adapter *adp;
 	const gchar *path = adapter_get_path(adapter);
-	bdaddr_t src;
 
 	DBG("path %s", path);
 
@@ -1001,8 +996,7 @@ static void a2dp_server_remove(struct btd_profile *p,
 	if (!adp)
 		return;
 
-	adapter_get_address(adapter, &src);
-	a2dp_unregister(&src);
+	a2dp_unregister(adapter_get_address(adapter));
 	audio_adapter_unref(adp);
 }
 
@@ -1011,7 +1005,6 @@ static int avrcp_server_probe(struct btd_profile *p,
 {
 	struct audio_adapter *adp;
 	const gchar *path = adapter_get_path(adapter);
-	bdaddr_t src;
 	int err;
 
 	DBG("path %s", path);
@@ -1020,9 +1013,7 @@ static int avrcp_server_probe(struct btd_profile *p,
 	if (!adp)
 		return -EINVAL;
 
-	adapter_get_address(adapter, &src);
-
-	err = avrcp_register(&src, config);
+	err = avrcp_register(adapter_get_address(adapter), config);
 	if (err < 0)
 		audio_adapter_unref(adp);
 
@@ -1034,7 +1025,6 @@ static void avrcp_server_remove(struct btd_profile *p,
 {
 	struct audio_adapter *adp;
 	const gchar *path = adapter_get_path(adapter);
-	bdaddr_t src;
 
 	DBG("path %s", path);
 
@@ -1042,8 +1032,7 @@ static void avrcp_server_remove(struct btd_profile *p,
 	if (!adp)
 		return;
 
-	adapter_get_address(adapter, &src);
-	avrcp_unregister(&src);
+	avrcp_unregister(adapter_get_address(adapter));
 	audio_adapter_unref(adp);
 }
 
@@ -1051,7 +1040,6 @@ static int media_server_probe(struct btd_adapter *adapter)
 {
 	struct audio_adapter *adp;
 	const gchar *path = adapter_get_path(adapter);
-	bdaddr_t src;
 	int err;
 
 	DBG("path %s", path);
@@ -1060,9 +1048,7 @@ static int media_server_probe(struct btd_adapter *adapter)
 	if (!adp)
 		return -EINVAL;
 
-	adapter_get_address(adapter, &src);
-
-	err = media_register(path, &src);
+	err = media_register(path, adapter_get_address(adapter));
 	if (err < 0)
 		audio_adapter_unref(adp);
 
diff --git a/plugins/adaptername.c b/plugins/adaptername.c
index cd0ffb2..f58fb0f 100644
--- a/plugins/adaptername.c
+++ b/plugins/adaptername.c
@@ -200,7 +200,6 @@ static int adaptername_probe(struct btd_adapter *adapter)
 	int current_id;
 	char name[MAX_NAME_LENGTH + 1];
 	char *pretty_hostname;
-	bdaddr_t bdaddr;
 
 	pretty_hostname = read_pretty_host_name();
 	if (pretty_hostname != NULL) {
@@ -210,10 +209,9 @@ static int adaptername_probe(struct btd_adapter *adapter)
 	}
 
 	adapter_set_allow_name_changes(adapter, TRUE);
-	adapter_get_address(adapter, &bdaddr);
 	current_id = adapter_get_dev_id(adapter);
 
-	if (read_local_name(&bdaddr, name) < 0)
+	if (read_local_name(adapter_get_address(adapter), name) < 0)
 		expand_name(name, MAX_NAME_LENGTH, main_opts.name, current_id);
 
 	DBG("Setting name '%s' for device 'hci%d'", name, current_id);
diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
index ea40355..5c5b6ef 100644
--- a/plugins/dbusoob.c
+++ b/plugins/dbusoob.c
@@ -194,10 +194,8 @@ static gboolean parse_data(DBusMessageIter *data, struct oob_data *remote_data)
 static gboolean store_data(struct btd_adapter *adapter, struct oob_data *data)
 {
 	bdaddr_t bdaddr;
-	bdaddr_t local;
 
 	str2ba(data->addr, &bdaddr);
-	adapter_get_address(adapter, &local);
 
 	if (data->hash) {
 		if (btd_adapter_add_remote_oob_data(adapter, &bdaddr,
@@ -206,10 +204,12 @@ static gboolean store_data(struct btd_adapter *adapter, struct oob_data *data)
 	}
 
 	if (data->class)
-		write_remote_class(&local, &bdaddr, data->class);
+		write_remote_class(adapter_get_address(adapter), &bdaddr,
+								data->class);
 
 	if (data->name)
-		write_device_name(&local, &bdaddr, 0, data->name);
+		write_device_name(adapter_get_address(adapter), &bdaddr, 0,
+								data->name);
 
 	return TRUE;
 }
diff --git a/plugins/neard.c b/plugins/neard.c
index 632d454..2fe1785 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -180,13 +180,11 @@ static void read_local_complete(struct btd_adapter *adapter, uint8_t *hash,
 		int len;
 		uint8_t eir[NFC_OOB_EIR_MAX];
 		uint8_t *peir = eir;
-		bdaddr_t addr;
 		DBusMessageIter iter;
 		DBusMessageIter dict;
 
-		adapter_get_address(adapter, &addr);
-
-		len = eir_create_oob(&addr, btd_adapter_get_name(adapter),
+		len = eir_create_oob(adapter_get_address(adapter),
+				btd_adapter_get_name(adapter),
 				btd_adapter_get_class(adapter), hash,
 				randomizer, main_opts.did_vendor,
 				main_opts.did_product, main_opts.did_version,
@@ -254,7 +252,6 @@ static int process_eir(struct btd_adapter *adapter, uint8_t *eir, size_t size,
 {
 	struct btd_device *device;
 	struct eir_data eir_data;
-	bdaddr_t local;
 	char remote_address[18];
 
 	DBG("size %zu", size);
@@ -288,16 +285,15 @@ static int process_eir(struct btd_adapter *adapter, uint8_t *eir, size_t size,
 	if (device)
 		adapter_remove_device(adapter, device, TRUE);
 
-	adapter_get_address(adapter, &local);
-
 	/* store OOB data */
 	if (eir_data.class != 0)
-		write_remote_class(&local, &eir_data.addr, eir_data.class);
+		write_remote_class(adapter_get_address(adapter),
+					&eir_data.addr, eir_data.class);
 
 	/* TODO handle incomplete name? */
 	if (eir_data.name)
-		write_device_name(&local, &eir_data.addr, BDADDR_BREDR,
-								eir_data.name);
+		write_device_name(adapter_get_address(adapter), &eir_data.addr,
+						BDADDR_BREDR, eir_data.name);
 
 	if (eir_data.hash)
 		btd_adapter_add_remote_oob_data(adapter, &eir_data.addr,
diff --git a/plugins/service.c b/plugins/service.c
index 4a38270..e81452c 100644
--- a/plugins/service.c
+++ b/plugins/service.c
@@ -134,13 +134,20 @@ static void exit_callback(DBusConnection *conn, void *user_data)
 	g_free(user_record);
 }
 
+static const bdaddr_t *get_address(struct service_adapter *serv_adapter)
+{
+	if (serv_adapter->adapter)
+		return adapter_get_address(serv_adapter->adapter);
+
+	return BDADDR_ANY;
+}
+
 static int add_xml_record(const char *sender,
 			struct service_adapter *serv_adapter,
 			const char *record, dbus_uint32_t *handle)
 {
 	struct record_data *user_record;
 	sdp_record_t *sdp_record;
-	bdaddr_t src;
 
 	sdp_record = sdp_xml_parse_record(record, strlen(record));
 	if (!sdp_record) {
@@ -148,12 +155,7 @@ static int add_xml_record(const char *sender,
 		return -EIO;
 	}
 
-	if (serv_adapter->adapter)
-		adapter_get_address(serv_adapter->adapter, &src);
-	else
-		bacpy(&src, BDADDR_ANY);
-
-	if (add_record_to_server(&src, sdp_record) < 0) {
+	if (add_record_to_server(get_address(serv_adapter), sdp_record) < 0) {
 		error("Failed to register service record");
 		sdp_record_free(sdp_record);
 		return -EIO;
@@ -181,7 +183,6 @@ static DBusMessage *update_record(DBusMessage *msg,
 				struct service_adapter *serv_adapter,
 				dbus_uint32_t handle, sdp_record_t *sdp_record)
 {
-	bdaddr_t src;
 	int err;
 
 	if (remove_record_from_server(handle) < 0) {
@@ -189,13 +190,8 @@ static DBusMessage *update_record(DBusMessage *msg,
 		return btd_error_not_available(msg);
 	}
 
-	if (serv_adapter->adapter)
-		adapter_get_address(serv_adapter->adapter, &src);
-	else
-		bacpy(&src, BDADDR_ANY);
-
 	sdp_record->handle = handle;
-	err = add_record_to_server(&src, sdp_record);
+	err = add_record_to_server(get_address(serv_adapter), sdp_record);
 	if (err < 0) {
 		sdp_record_free(sdp_record);
 		error("Failed to update the service record");
@@ -322,7 +318,6 @@ static void auth_cb(DBusError *derr, void *user_data)
 	struct service_adapter *serv_adapter = user_data;
 	DBusMessage *reply;
 	struct pending_auth *auth;
-	bdaddr_t src;
 
 	auth = next_pending(serv_adapter);
 	if (auth == NULL) {
@@ -350,14 +345,9 @@ done:
 	if (auth == NULL)
 		return;
 
-	if (serv_adapter->adapter)
-		adapter_get_address(serv_adapter->adapter, &src);
-	else
-		bacpy(&src, BDADDR_ANY);
-
-	auth->id = btd_request_authorization(&src, &auth->dst,
-							auth->uuid, auth_cb,
-							serv_adapter);
+	auth->id = btd_request_authorization(get_address(serv_adapter),
+							&auth->dst, auth->uuid,
+							auth_cb, serv_adapter);
 }
 
 static DBusMessage *request_authorization(DBusConnection *conn,
@@ -373,7 +363,6 @@ static DBusMessage *request_authorization(DBusConnection *conn,
 	struct pending_auth *auth;
 	char uuid_str[MAX_LEN_UUID_STR];
 	uuid_t *uuid, *uuid128;
-	bdaddr_t src;
 
 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &address,
 					DBUS_TYPE_UINT32, &handle,
@@ -427,12 +416,8 @@ static DBusMessage *request_authorization(DBusConnection *conn,
 	if (auth == NULL)
 		return btd_error_does_not_exist(msg);
 
-	if (serv_adapter->adapter)
-		adapter_get_address(serv_adapter->adapter, &src);
-	else
-		bacpy(&src, BDADDR_ANY);
-
-	auth->id = btd_request_authorization(&src, &auth->dst, auth->uuid,
+	auth->id = btd_request_authorization(get_address(serv_adapter),
+							&auth->dst, auth->uuid,
 							auth_cb, serv_adapter);
 	if (auth->id == 0) {
 		serv_adapter->pending_list = g_slist_remove(serv_adapter->pending_list,
@@ -451,7 +436,6 @@ static DBusMessage *cancel_authorization(DBusConnection *conn,
 	struct service_adapter *serv_adapter = data;
 	struct pending_auth *auth;
 	const gchar *sender;
-	bdaddr_t src;
 
 	sender = dbus_message_get_sender(msg);
 
@@ -473,14 +457,9 @@ static DBusMessage *cancel_authorization(DBusConnection *conn,
 	if (auth == NULL)
 		goto done;
 
-	if (serv_adapter->adapter)
-		adapter_get_address(serv_adapter->adapter, &src);
-	else
-		bacpy(&src, BDADDR_ANY);
-
-	auth->id = btd_request_authorization(&src, &auth->dst,
-							auth->uuid, auth_cb,
-							serv_adapter);
+	auth->id = btd_request_authorization(get_address(serv_adapter),
+							&auth->dst, auth->uuid,
+							auth_cb, serv_adapter);
 
 done:
 	return dbus_message_new_method_return(msg);
diff --git a/plugins/wiimote.c b/plugins/wiimote.c
index f7fad60..93d1e2d 100644
--- a/plugins/wiimote.c
+++ b/plugins/wiimote.c
@@ -62,10 +62,9 @@ static ssize_t wii_pincb(struct btd_adapter *adapter, struct btd_device *device,
 						char *pinbuf, gboolean *display)
 {
 	uint16_t vendor, product;
-	bdaddr_t sba, dba;
+	bdaddr_t dba;
 	char addr[18], name[25];
 
-	adapter_get_address(adapter, &sba);
 	device_get_address(device, &dba, NULL);
 	ba2str(&dba, addr);
 
@@ -79,7 +78,7 @@ static ssize_t wii_pincb(struct btd_adapter *adapter, struct btd_device *device,
 				g_str_equal(name, "Nintendo RVL-WBC-01") ||
 				(vendor == 0x057e && product == 0x0306)) {
 		DBG("Forcing fixed pin on detected wiimote %s", addr);
-		memcpy(pinbuf, &sba, 6);
+		memcpy(pinbuf, adapter_get_address(adapter), 6);
 		return 6;
 	}
 
diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index 0c17176..b8ea141 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -415,10 +415,8 @@ static void filter_devices_notify(char *key, char *value, void *user_data)
 static void create_filename(char *filename, struct btd_adapter *adapter)
 {
 	char srcaddr[18];
-	bdaddr_t src;
 
-	adapter_get_address(adapter, &src);
-	ba2str(&src, srcaddr);
+	ba2str(adapter_get_address(adapter), srcaddr);
 
 	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr, "ccc");
 }
diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index da6d555..f0fcbe7 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -168,7 +168,7 @@ static void ccc_written_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
 	struct gas *gas = user_data;
-	bdaddr_t sba, dba;
+	bdaddr_t dba;
 	uint8_t bdaddr_type;
 
 	if (status) {
@@ -179,11 +179,11 @@ static void ccc_written_cb(guint8 status, const guint8 *pdu, guint16 plen,
 
 	DBG("Service Changed indications enabled");
 
-	adapter_get_address(device_get_adapter(gas->device), &sba);
 	device_get_address(gas->device, &dba, &bdaddr_type);
 
-	write_ctp_handle(&sba, &dba, bdaddr_type, GATT_CHARAC_SERVICE_CHANGED,
-							gas->changed_handle);
+	write_ctp_handle(adapter_get_address(device_get_adapter(gas->device)),
+				&dba, bdaddr_type, GATT_CHARAC_SERVICE_CHANGED,
+				gas->changed_handle);
 }
 
 static void write_ccc(GAttrib *attrib, uint16_t handle, gpointer user_data)
@@ -377,7 +377,7 @@ int gas_register(struct btd_device *device, struct att_range *gap,
 						struct att_range *gatt)
 {
 	struct gas *gas;
-	bdaddr_t sba, dba;
+	bdaddr_t dba;
 	uint8_t bdaddr_type;
 
 	gas = g_new0(struct gas, 1);
@@ -394,11 +394,11 @@ int gas_register(struct btd_device *device, struct att_range *gap,
 						attio_connected_cb,
 						attio_disconnected_cb, gas);
 
-	adapter_get_address(device_get_adapter(gas->device), &sba);
 	device_get_address(gas->device, &dba, &bdaddr_type);
 
-	read_ctp_handle(&sba, &dba, bdaddr_type, GATT_CHARAC_SERVICE_CHANGED,
-							&gas->changed_handle);
+	read_ctp_handle(adapter_get_address(device_get_adapter(gas->device)),
+				&dba, bdaddr_type, GATT_CHARAC_SERVICE_CHANGED,
+				&gas->changed_handle);
 
 	return 0;
 }
diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index d262a2a..d07462a 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -1317,7 +1317,6 @@ static void release_adapter_instance(struct hdp_adapter *hdp_adapter)
 static gboolean update_adapter(struct hdp_adapter *hdp_adapter)
 {
 	GError *err = NULL;
-	bdaddr_t addr;
 
 	if (applications == NULL) {
 		release_adapter_instance(hdp_adapter);
@@ -1327,12 +1326,13 @@ static gboolean update_adapter(struct hdp_adapter *hdp_adapter)
 	if (hdp_adapter->mi != NULL)
 		goto update;
 
-	adapter_get_address(hdp_adapter->btd_adapter, &addr);
-	hdp_adapter->mi = mcap_create_instance(&addr, BT_IO_SEC_MEDIUM, 0, 0,
-					mcl_connected, mcl_reconnected,
-					mcl_disconnected, mcl_uncached,
-					NULL, /* CSP is not used by now */
-					hdp_adapter, &err);
+	hdp_adapter->mi = mcap_create_instance(
+				adapter_get_address(hdp_adapter->btd_adapter),
+				BT_IO_SEC_MEDIUM, 0, 0,
+				mcl_connected, mcl_reconnected,
+				mcl_disconnected, mcl_uncached,
+				NULL, /* CSP is not used by now */
+				hdp_adapter, &err);
 
 	if (hdp_adapter->mi == NULL) {
 		error("Error creating the MCAP instance: %s", err->message);
diff --git a/profiles/health/hdp_util.c b/profiles/health/hdp_util.c
index 3afd715..931c1dd 100644
--- a/profiles/health/hdp_util.c
+++ b/profiles/health/hdp_util.c
@@ -695,7 +695,6 @@ static gboolean register_mcap_features(sdp_record_t *sdp_record)
 gboolean hdp_update_sdp_record(struct hdp_adapter *adapter, GSList *app_list)
 {
 	sdp_record_t *sdp_record;
-	bdaddr_t addr;
 
 	if (adapter->sdp_handler > 0)
 		remove_record_from_server(adapter->sdp_handler);
@@ -738,9 +737,8 @@ gboolean hdp_update_sdp_record(struct hdp_adapter *adapter, GSList *app_list)
 	if (sdp_set_record_state(sdp_record, adapter->record_state++) < 0)
 		goto fail;
 
-	adapter_get_address(adapter->btd_adapter, &addr);
-
-	if (add_record_to_server(&addr, sdp_record) < 0)
+	if (add_record_to_server(adapter_get_address(adapter->btd_adapter),
+					sdp_record) < 0)
 		goto fail;
 	adapter->sdp_handler = sdp_record->handle;
 	return TRUE;
@@ -859,11 +857,11 @@ gboolean hdp_get_mdep(struct hdp_device *device, struct hdp_application *app,
 				GDestroyNotify destroy, GError **err)
 {
 	struct get_mdep_data *mdep_data;
-	bdaddr_t dst, src;
+	bdaddr_t dst, *src;
 	uuid_t uuid;
 
 	device_get_address(device->dev, &dst, NULL);
-	adapter_get_address(device_get_adapter(device->dev), &src);
+	src = adapter_get_address(device_get_adapter(device->dev));
 
 	mdep_data = g_new0(struct get_mdep_data, 1);
 	mdep_data->app = hdp_application_ref(app);
@@ -872,7 +870,7 @@ gboolean hdp_get_mdep(struct hdp_device *device, struct hdp_application *app,
 	mdep_data->destroy = destroy;
 
 	bt_string2uuid(&uuid, HDP_UUID);
-	if (bt_search_service(&src, &dst, &uuid, get_mdep_cb, mdep_data,
+	if (bt_search_service(src, &dst, &uuid, get_mdep_cb, mdep_data,
 							free_mdep_data) < 0) {
 		g_set_error(err, HDP_ERROR, HDP_CONNECTION_ERROR,
 						"Can't get remote SDP record");
@@ -1088,11 +1086,11 @@ gboolean hdp_establish_mcl(struct hdp_device *device,
 						GError **err)
 {
 	struct conn_mcl_data *conn_data;
-	bdaddr_t dst, src;
+	bdaddr_t dst, *src;
 	uuid_t uuid;
 
 	device_get_address(device->dev, &dst, NULL);
-	adapter_get_address(device_get_adapter(device->dev), &src);
+	src = adapter_get_address(device_get_adapter(device->dev));
 
 	conn_data = g_new0(struct conn_mcl_data, 1);
 	conn_data->refs = 1;
@@ -1102,7 +1100,7 @@ gboolean hdp_establish_mcl(struct hdp_device *device,
 	conn_data->dev = health_device_ref(device);
 
 	bt_string2uuid(&uuid, HDP_UUID);
-	if (bt_search_service(&src, &dst, &uuid, search_cb, conn_data,
+	if (bt_search_service(src, &dst, &uuid, search_cb, conn_data,
 						destroy_con_mcl_data) < 0) {
 		g_set_error(err, HDP_ERROR, HDP_CONNECTION_ERROR,
 						"Can't get remote SDP record");
@@ -1158,11 +1156,11 @@ gboolean hdp_get_dcpsm(struct hdp_device *device, hdp_continue_dcpsm_f func,
 							GError **err)
 {
 	struct get_dcpsm_data *dcpsm_data;
-	bdaddr_t dst, src;
+	bdaddr_t dst, *src;
 	uuid_t uuid;
 
 	device_get_address(device->dev, &dst, NULL);
-	adapter_get_address(device_get_adapter(device->dev), &src);
+	src = adapter_get_address(device_get_adapter(device->dev));
 
 	dcpsm_data = g_new0(struct get_dcpsm_data, 1);
 	dcpsm_data->func = func;
@@ -1170,7 +1168,7 @@ gboolean hdp_get_dcpsm(struct hdp_device *device, hdp_continue_dcpsm_f func,
 	dcpsm_data->destroy = destroy;
 
 	bt_string2uuid(&uuid, HDP_UUID);
-	if (bt_search_service(&src, &dst, &uuid, get_dcpsm_cb, dcpsm_data,
+	if (bt_search_service(src, &dst, &uuid, get_dcpsm_cb, dcpsm_data,
 							free_dcpsm_data) < 0) {
 		g_set_error(err, HDP_ERROR, HDP_CONNECTION_ERROR,
 						"Can't get remote SDP record");
diff --git a/profiles/input/device.c b/profiles/input/device.c
index 07c72c0..ed50e3b 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -785,7 +785,7 @@ static struct input_device *input_device_new(struct btd_device *device,
 	uint8_t dst_type;
 
 	idev = g_new0(struct input_device, 1);
-	adapter_get_address(adapter, &idev->src);
+	bacpy(&idev->src, adapter_get_address(adapter));
 	device_get_address(device, &idev->dst, &dst_type);
 	idev->device = btd_device_ref(device);
 	idev->path = g_strdup(path);
diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index 32698aa..3f68620 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -77,12 +77,9 @@ static void hid_device_remove(struct btd_profile *p, struct btd_device *device)
 
 static int hid_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
 {
-	bdaddr_t src;
 	int ret;
 
-	adapter_get_address(adapter, &src);
-
-	ret = server_start(&src);
+	ret = server_start(adapter_get_address(adapter));
 	if (ret < 0)
 		return ret;
 
@@ -94,11 +91,7 @@ static int hid_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
 static void hid_server_remove(struct btd_profile *p,
 						struct btd_adapter *adapter)
 {
-	bdaddr_t src;
-
-	adapter_get_address(adapter, &src);
-
-	server_stop(&src);
+	server_stop(adapter_get_address(adapter));
 
 	adapters = g_slist_remove(adapters, adapter);
 	btd_adapter_unref(adapter);
diff --git a/profiles/network/manager.c b/profiles/network/manager.c
index e1f4164..661181d 100644
--- a/profiles/network/manager.c
+++ b/profiles/network/manager.c
@@ -78,19 +78,19 @@ static int network_probe(struct btd_profile *p, struct btd_device *device,
 {
 	struct btd_adapter *adapter = device_get_adapter(device);
 	const gchar *path = device_get_path(device);
-	bdaddr_t src, dst;
+	bdaddr_t *src, dst;
 
 	DBG("path %s", path);
 
-	adapter_get_address(adapter, &src);
+	src = adapter_get_address(adapter);
 	device_get_address(device, &dst, NULL);
 
 	if (g_slist_find_custom(uuids, PANU_UUID, bt_uuid_strcmp))
-		connection_register(device, path, &src, &dst, BNEP_SVC_PANU);
+		connection_register(device, path, src, &dst, BNEP_SVC_PANU);
 	if (g_slist_find_custom(uuids, GN_UUID, bt_uuid_strcmp))
-		connection_register(device, path, &src, &dst, BNEP_SVC_GN);
+		connection_register(device, path, src, &dst, BNEP_SVC_GN);
 	if (g_slist_find_custom(uuids, NAP_UUID, bt_uuid_strcmp))
-		connection_register(device, path, &src, &dst, BNEP_SVC_NAP);
+		connection_register(device, path, src, &dst, BNEP_SVC_NAP);
 
 	return 0;
 }
diff --git a/profiles/network/server.c b/profiles/network/server.c
index 6ee4770..ccf6e69 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -742,16 +742,14 @@ static struct network_adapter *create_adapter(struct btd_adapter *adapter)
 {
 	struct network_adapter *na;
 	GError *err = NULL;
-	bdaddr_t src;
 
 	na = g_new0(struct network_adapter, 1);
 	na->adapter = btd_adapter_ref(adapter);
 
-	adapter_get_address(adapter, &src);
-
 	na->io = bt_io_listen(NULL, confirm_event, na,
 				NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, &src,
+				BT_IO_OPT_SOURCE_BDADDR,
+				adapter_get_address(adapter),
 				BT_IO_OPT_PSM, BNEP_PSM,
 				BT_IO_OPT_OMTU, BNEP_MTU,
 				BT_IO_OPT_IMTU, BNEP_MTU,
@@ -803,7 +801,7 @@ int server_register(struct btd_adapter *adapter)
 		return -1;
 	}
 
-	adapter_get_address(adapter, &ns->src);
+	bacpy(&ns->src, adapter_get_address(adapter));
 	ns->id = BNEP_SVC_NAP;
 	ns->na = na;
 	ns->record_id = 0;
diff --git a/profiles/proximity/monitor.c b/profiles/proximity/monitor.c
index 6444a75..477eeea 100644
--- a/profiles/proximity/monitor.c
+++ b/profiles/proximity/monitor.c
@@ -407,7 +407,7 @@ static DBusMessage *set_link_loss_alert(DBusConnection *conn, DBusMessage *msg,
 {
 	struct monitor *monitor = data;
 	struct btd_device *device = monitor->device;
-	bdaddr_t sba, dba;
+	bdaddr_t dba;
 
 	if (!level_is_valid(level))
 		return btd_error_invalid_args(msg);
@@ -418,10 +418,10 @@ static DBusMessage *set_link_loss_alert(DBusConnection *conn, DBusMessage *msg,
 	g_free(monitor->linklosslevel);
 	monitor->linklosslevel = g_strdup(level);
 
-	adapter_get_address(device_get_adapter(device), &sba);
 	device_get_address(device, &dba, NULL);
 
-	write_proximity_config(&sba, &dba, "LinkLossAlertLevel", level);
+	write_proximity_config(adapter_get_address(device_get_adapter(device)),
+					&dba, "LinkLossAlertLevel", level);
 
 	if (monitor->attrib)
 		write_alert_level(monitor);
@@ -593,13 +593,14 @@ int monitor_register(struct btd_device *device,
 {
 	const char *path = device_get_path(device);
 	struct monitor *monitor;
-	bdaddr_t sba, dba;
+	bdaddr_t dba;
 	char *level;
 
-	adapter_get_address(device_get_adapter(device), &sba);
 	device_get_address(device, &dba, NULL);
 
-	level = read_proximity_config(&sba, &dba, "LinkLossAlertLevel");
+	level = read_proximity_config(
+			adapter_get_address(device_get_adapter(device)),
+			&dba, "LinkLossAlertLevel");
 
 	monitor = g_new0(struct monitor, 1);
 	monitor->device = btd_device_ref(device);
diff --git a/profiles/sap/manager.c b/profiles/sap/manager.c
index cb47b93..fddd7aa 100644
--- a/profiles/sap/manager.c
+++ b/profiles/sap/manager.c
@@ -35,13 +35,10 @@
 static int sap_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
 {
 	const char *path = adapter_get_path(adapter);
-	bdaddr_t src;
 
 	DBG("path %s", path);
 
-	adapter_get_address(adapter, &src);
-
-	return sap_server_register(path, &src);
+	return sap_server_register(path, adapter_get_address(adapter));
 }
 
 static void sap_server_remove(struct btd_profile *p,
diff --git a/src/adapter.c b/src/adapter.c
index 073c722..166b64f 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1870,7 +1870,6 @@ static void create_stored_device_from_ltks(char *key, char *value,
 	struct smp_ltk_info *info;
 	char address[18], srcaddr[18];
 	uint8_t bdaddr_type;
-	bdaddr_t src;
 
 	if (sscanf(key, "%17s#%hhu", address, &bdaddr_type) < 2)
 		return;
@@ -1885,8 +1884,7 @@ static void create_stored_device_from_ltks(char *key, char *value,
 					(GCompareFunc) device_address_cmp))
 		return;
 
-	adapter_get_address(adapter, &src);
-	ba2str(&src, srcaddr);
+	ba2str(adapter_get_address(adapter), srcaddr);
 
 	if (g_strcmp0(srcaddr, address) == 0)
 		return;
@@ -2668,9 +2666,9 @@ const gchar *adapter_get_path(struct btd_adapter *adapter)
 	return adapter->path;
 }
 
-void adapter_get_address(struct btd_adapter *adapter, bdaddr_t *bdaddr)
+bdaddr_t *adapter_get_address(struct btd_adapter *adapter)
 {
-	bacpy(bdaddr, &adapter->bdaddr);
+	return &adapter->bdaddr;
 }
 
 void adapter_set_allow_name_changes(struct btd_adapter *adapter,
@@ -3616,7 +3614,7 @@ ssize_t btd_adapter_get_pin(struct btd_adapter *adapter, struct btd_device *dev,
 {
 	GSList *l;
 	btd_adapter_pin_cb_t cb;
-	bdaddr_t sba, dba;
+	bdaddr_t dba;
 	ssize_t ret;
 
 	for (l = adapter->pin_callbacks; l != NULL; l = g_slist_next(l)) {
@@ -3626,10 +3624,9 @@ ssize_t btd_adapter_get_pin(struct btd_adapter *adapter, struct btd_device *dev,
 			return ret;
 	}
 
-	adapter_get_address(adapter, &sba);
 	device_get_address(dev, &dba, NULL);
 
-	return read_pin_code(&sba, &dba, pin_buf);
+	return read_pin_code(adapter_get_address(adapter), &dba, pin_buf);
 }
 
 void btd_adapter_register_powered_callback(struct btd_adapter *adapter,
diff --git a/src/adapter.h b/src/adapter.h
index 7ca8d95..f3599b5 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -122,7 +122,7 @@ void adapter_set_discovering(struct btd_adapter *adapter,
 						gboolean discovering);
 uint16_t adapter_get_dev_id(struct btd_adapter *adapter);
 const gchar *adapter_get_path(struct btd_adapter *adapter);
-void adapter_get_address(struct btd_adapter *adapter, bdaddr_t *bdaddr);
+bdaddr_t *adapter_get_address(struct btd_adapter *adapter);
 struct remote_dev_info *adapter_search_found_devices(struct btd_adapter *adapter,
 							bdaddr_t *bdaddr);
 void adapter_update_found_devices(struct btd_adapter *adapter,
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 9b03e54..e7e2531 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -154,11 +154,8 @@ static gint adapter_cmp_addr(gconstpointer a, gconstpointer b)
 {
 	const struct gatt_server *server = a;
 	const bdaddr_t *bdaddr = b;
-	bdaddr_t src;
-
-	adapter_get_address(server->adapter, &src);
 
-	return bacmp(&src, bdaddr);
+	return bacmp(adapter_get_address(server->adapter), bdaddr);
 }
 
 static gint adapter_cmp(gconstpointer a, gconstpointer b)
@@ -302,7 +299,6 @@ static uint32_t attrib_create_sdp_new(struct gatt_server *server,
 	struct attribute *a;
 	uint16_t end = 0;
 	uuid_t svc, gap_uuid;
-	bdaddr_t addr;
 
 	a = find_svc_range(server, handle, &end);
 
@@ -330,8 +326,8 @@ static uint32_t attrib_create_sdp_new(struct gatt_server *server,
 				"http://www.bluez.org/");
 	}
 
-	adapter_get_address(server->adapter, &addr);
-	if (add_record_to_server(&addr, record) == 0)
+	if (add_record_to_server(adapter_get_address(server->adapter), record)
+			== 0)
 		return record->handle;
 
 	sdp_record_free(record);
@@ -1241,19 +1237,19 @@ int btd_adapter_gatt_server_start(struct btd_adapter *adapter)
 {
 	struct gatt_server *server;
 	GError *gerr = NULL;
-	bdaddr_t addr;
+	bdaddr_t *addr;
 
 	DBG("Start GATT server in hci%d", adapter_get_dev_id(adapter));
 
 	server = g_new0(struct gatt_server, 1);
 	server->adapter = btd_adapter_ref(adapter);
 
-	adapter_get_address(server->adapter, &addr);
+	addr = adapter_get_address(server->adapter);
 
 	/* BR/EDR socket */
 	server->l2cap_io = bt_io_listen(NULL, confirm_event,
 					NULL, NULL, &gerr,
-					BT_IO_OPT_SOURCE_BDADDR, &addr,
+					BT_IO_OPT_SOURCE_BDADDR, addr,
 					BT_IO_OPT_PSM, ATT_PSM,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 					BT_IO_OPT_INVALID);
@@ -1273,7 +1269,7 @@ int btd_adapter_gatt_server_start(struct btd_adapter *adapter)
 	/* LE socket */
 	server->le_io = bt_io_listen(NULL, confirm_event,
 					&server->le_io, NULL, &gerr,
-					BT_IO_OPT_SOURCE_BDADDR, &addr,
+					BT_IO_OPT_SOURCE_BDADDR, addr,
 					BT_IO_OPT_CID, ATT_CID,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 					BT_IO_OPT_INVALID);
diff --git a/src/device.c b/src/device.c
index c659164..499dbc2 100644
--- a/src/device.c
+++ b/src/device.c
@@ -221,14 +221,11 @@ static void browse_request_cancel(struct browse_req *req)
 {
 	struct btd_device *device = req->device;
 	struct btd_adapter *adapter = device->adapter;
-	bdaddr_t src;
 
 	if (device_is_creating(device, NULL))
 		device_set_temporary(device, TRUE);
 
-	adapter_get_address(adapter, &src);
-
-	bt_cancel_discovery(&src, &device->bdaddr);
+	bt_cancel_discovery(adapter_get_address(adapter), &device->bdaddr);
 
 	attio_cleanup(device);
 
@@ -313,7 +310,6 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	DBusMessage *reply;
 	DBusMessageIter iter;
 	DBusMessageIter dict;
-	bdaddr_t src;
 	char name[MAX_NAME_LENGTH + 1], dstaddr[18];
 	char **str;
 	const char *ptr, *icon = NULL;
@@ -343,7 +339,6 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	/* Name */
 	ptr = NULL;
 	memset(name, 0, sizeof(name));
-	adapter_get_address(adapter, &src);
 
 	ptr = device->name;
 	dict_append_entry(&dict, "Name", DBUS_TYPE_STRING, &ptr);
@@ -359,12 +354,13 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	dict_append_entry(&dict, "Alias", DBUS_TYPE_STRING, &ptr);
 
 	/* Class */
-	if (read_remote_class(&src, &device->bdaddr, &class) == 0) {
+	if (read_remote_class(adapter_get_address(adapter),
+				&device->bdaddr, &class) == 0) {
 		icon = class_to_icon(class);
 
 		dict_append_entry(&dict, "Class", DBUS_TYPE_UINT32, &class);
-	} else if (read_remote_appearance(&src, &device->bdaddr,
-					device->bdaddr_type, &app) == 0) {
+	} else if (read_remote_appearance(adapter_get_address(adapter),
+			&device->bdaddr, device->bdaddr_type, &app) == 0) {
 		/* Appearance */
 		icon = gap_appearance_to_icon(app);
 
@@ -437,7 +433,6 @@ static DBusMessage *set_alias(DBusMessage *msg, const char *alias, void *data)
 	struct btd_device *device = data;
 	struct btd_adapter *adapter = device->adapter;
 	char srcaddr[18], dstaddr[18];
-	bdaddr_t src;
 	int err;
 
 	/* No change */
@@ -445,8 +440,7 @@ static DBusMessage *set_alias(DBusMessage *msg, const char *alias, void *data)
 			g_strcmp0(device->alias, alias) == 0)
 		return dbus_message_new_method_return(msg);
 
-	adapter_get_address(adapter, &src);
-	ba2str(&src, srcaddr);
+	ba2str(adapter_get_address(adapter), srcaddr);
 	ba2str(&device->bdaddr, dstaddr);
 
 	/* Remove alias if empty string */
@@ -470,14 +464,12 @@ static DBusMessage *set_trust(DBusMessage *msg, gboolean value, void *data)
 	struct btd_device *device = data;
 	struct btd_adapter *adapter = device->adapter;
 	char srcaddr[18], dstaddr[18];
-	bdaddr_t src;
 	int err;
 
 	if (device->trusted == value)
 		return dbus_message_new_method_return(msg);
 
-	adapter_get_address(adapter, &src);
-	ba2str(&src, srcaddr);
+	ba2str(adapter_get_address(adapter), srcaddr);
 	ba2str(&device->bdaddr, dstaddr);
 
 	err = write_trust(srcaddr, dstaddr, device->bdaddr_type, value);
@@ -516,7 +508,6 @@ static gboolean do_disconnect(gpointer user_data)
 int device_block(struct btd_device *device, gboolean update_only)
 {
 	int err = 0;
-	bdaddr_t src;
 
 	if (device->blocked)
 		return 0;
@@ -535,9 +526,8 @@ int device_block(struct btd_device *device, gboolean update_only)
 
 	device->blocked = TRUE;
 
-	adapter_get_address(device->adapter, &src);
-
-	err = write_blocked(&src, &device->bdaddr, device->bdaddr_type, TRUE);
+	err = write_blocked(adapter_get_address(device->adapter),
+				&device->bdaddr, device->bdaddr_type, TRUE);
 	if (err < 0)
 		error("write_blocked(): %s (%d)", strerror(-err), -err);
 
@@ -554,7 +544,6 @@ int device_unblock(struct btd_device *device, gboolean silent,
 							gboolean update_only)
 {
 	int err = 0;
-	bdaddr_t src;
 
 	if (!device->blocked)
 		return 0;
@@ -568,9 +557,8 @@ int device_unblock(struct btd_device *device, gboolean silent,
 
 	device->blocked = FALSE;
 
-	adapter_get_address(device->adapter, &src);
-
-	err = write_blocked(&src, &device->bdaddr, device->bdaddr_type, FALSE);
+	err = write_blocked(adapter_get_address(device->adapter),
+				&device->bdaddr, device->bdaddr_type, FALSE);
 	if (err < 0)
 		error("write_blocked(): %s (%d)", strerror(-err), -err);
 
@@ -1128,7 +1116,7 @@ struct btd_device *device_create(struct btd_adapter *adapter,
 	gchar *address_up;
 	struct btd_device *device;
 	const gchar *adapter_path = adapter_get_path(adapter);
-	bdaddr_t src;
+	bdaddr_t *src;
 	char srcaddr[18], alias[MAX_NAME_LENGTH + 1];
 	uint16_t vendor, product, version;
 
@@ -1154,25 +1142,25 @@ struct btd_device *device_create(struct btd_adapter *adapter,
 	str2ba(address, &device->bdaddr);
 	device->adapter = adapter;
 	device->bdaddr_type = bdaddr_type;
-	adapter_get_address(adapter, &src);
-	ba2str(&src, srcaddr);
+	src = adapter_get_address(adapter);
+	ba2str(src, srcaddr);
 
 	read_device_name(srcaddr, address, bdaddr_type, device->name);
 	if (read_device_alias(srcaddr, address, bdaddr_type, alias,
 							sizeof(alias)) == 0)
 		device->alias = g_strdup(alias);
-	device->trusted = read_trust(&src, address, device->bdaddr_type);
+	device->trusted = read_trust(src, address, device->bdaddr_type);
 
-	if (read_blocked(&src, &device->bdaddr, device->bdaddr_type))
+	if (read_blocked(src, &device->bdaddr, device->bdaddr_type))
 		device_block(device, FALSE);
 
-	if (read_link_key(&src, &device->bdaddr, device->bdaddr_type, NULL,
+	if (read_link_key(src, &device->bdaddr, device->bdaddr_type, NULL,
 								NULL) == 0) {
 		device_set_paired(device, TRUE);
 		device_set_bonded(device, TRUE);
 	}
 
-	if (device_is_le(device) && has_longtermkeys(&src, &device->bdaddr,
+	if (device_is_le(device) && has_longtermkeys(src, &device->bdaddr,
 							device->bdaddr_type)) {
 		device_set_paired(device, TRUE);
 		device_set_bonded(device, TRUE);
@@ -1234,27 +1222,27 @@ uint16_t btd_device_get_version(struct btd_device *device)
 
 static void device_remove_stored(struct btd_device *device)
 {
-	bdaddr_t src, dst;
+	bdaddr_t *src, dst;
 	uint8_t dst_type;
 
-	adapter_get_address(device->adapter, &src);
+	src = adapter_get_address(device->adapter);
 	device_get_address(device, &dst, &dst_type);
 
-	delete_entry(&src, "profiles", &dst, dst_type);
-	delete_entry(&src, "trusts", &dst, dst_type);
+	delete_entry(src, "profiles", &dst, dst_type);
+	delete_entry(src, "trusts", &dst, dst_type);
 
 	if (device_is_bonded(device)) {
-		delete_entry(&src, "linkkeys", &dst, dst_type);
-		delete_entry(&src, "aliases", &dst, dst_type);
-		delete_entry(&src, "longtermkeys", &dst, dst_type);
+		delete_entry(src, "linkkeys", &dst, dst_type);
+		delete_entry(src, "aliases", &dst, dst_type);
+		delete_entry(src, "longtermkeys", &dst, dst_type);
 
 		device_set_bonded(device, FALSE);
 		device->paired = FALSE;
 		btd_adapter_remove_bonding(device->adapter, &dst, dst_type);
 	}
 
-	delete_all_records(&src, &dst, dst_type);
-	delete_device_service(&src, &dst, dst_type);
+	delete_all_records(src, &dst, dst_type);
+	delete_device_service(src, &dst, dst_type);
 
 	if (device->blocked)
 		device_unblock(device, TRUE, FALSE);
@@ -1467,15 +1455,13 @@ static void device_remove_profiles(struct btd_device *device, GSList *uuids)
 {
 	struct btd_adapter *adapter = device_get_adapter(device);
 	char srcaddr[18], dstaddr[18];
-	bdaddr_t src;
 	sdp_list_t *records;
 	GSList *l;
 
-	adapter_get_address(adapter, &src);
-	ba2str(&src, srcaddr);
+	ba2str(adapter_get_address(adapter), srcaddr);
 	ba2str(&device->bdaddr, dstaddr);
 
-	records = read_records(&src, &device->bdaddr);
+	records = read_records(adapter_get_address(adapter), &device->bdaddr);
 
 	DBG("Removing profiles for %s", dstaddr);
 
@@ -1546,10 +1532,8 @@ static void update_bredr_services(struct browse_req *req, sdp_list_t *recs)
 	sdp_list_t *seq;
 	char srcaddr[18], dstaddr[18];
 	uint8_t dst_type;
-	bdaddr_t src;
 
-	adapter_get_address(adapter, &src);
-	ba2str(&src, srcaddr);
+	ba2str(adapter_get_address(adapter), srcaddr);
 	ba2str(&device->bdaddr, dstaddr);
 
 	for (seq = recs; seq; seq = seq->next) {
@@ -1680,19 +1664,18 @@ static void update_gatt_services(struct browse_req *req, GSList *current,
 static void store_profiles(struct btd_device *device)
 {
 	struct btd_adapter *adapter = device->adapter;
-	bdaddr_t src;
 	char *str;
 
-	adapter_get_address(adapter, &src);
-
 	if (!device->uuids) {
-		write_device_profiles(&src, &device->bdaddr,
-				      device->bdaddr_type, "");
+		write_device_profiles(adapter_get_address(adapter),
+					&device->bdaddr, device->bdaddr_type,
+					"");
 		return;
 	}
 
 	str = bt_list2string(device->uuids);
-	write_device_profiles(&src, &device->bdaddr, device->bdaddr_type, str);
+	write_device_profiles(adapter_get_address(adapter), &device->bdaddr,
+						device->bdaddr_type, str);
 	g_free(str);
 }
 
@@ -1831,7 +1814,6 @@ static void browse_cb(sdp_list_t *recs, int err, gpointer user_data)
 	struct browse_req *req = user_data;
 	struct btd_device *device = req->device;
 	struct btd_adapter *adapter = device->adapter;
-	bdaddr_t src;
 	uuid_t uuid;
 
 	/* If we have a valid response and req->search_uuid == 2, then L2CAP
@@ -1846,12 +1828,11 @@ static void browse_cb(sdp_list_t *recs, int err, gpointer user_data)
 
 	update_bredr_services(req, recs);
 
-	adapter_get_address(adapter, &src);
-
 	/* Search for mandatory uuids */
 	if (uuid_list[req->search_uuid]) {
 		sdp_uuid16_create(&uuid, uuid_list[req->search_uuid++]);
-		bt_search_service(&src, &device->bdaddr, &uuid,
+		bt_search_service(adapter_get_address(adapter),
+						&device->bdaddr, &uuid,
 						browse_cb, user_data, NULL);
 		return;
 	}
@@ -1901,13 +1882,13 @@ static char *primary_list_to_string(GSList *primary_list)
 static void store_services(struct btd_device *device)
 {
 	struct btd_adapter *adapter = device->adapter;
-	bdaddr_t dba, sba;
+	bdaddr_t dba;
 	char *str = primary_list_to_string(device->primaries);
 
-	adapter_get_address(adapter, &sba);
 	device_get_address(device, &dba, NULL);
 
-	write_device_services(&sba, &dba, device->bdaddr_type, str);
+	write_device_services(adapter_get_address(adapter), &dba,
+						device->bdaddr_type, str);
 
 	g_free(str);
 }
@@ -2129,9 +2110,7 @@ GIOChannel *device_att_connect(gpointer user_data)
 	GIOChannel *io;
 	GError *gerr = NULL;
 	char addr[18];
-	bdaddr_t sba;
 
-	adapter_get_address(adapter, &sba);
 	ba2str(&device->bdaddr, addr);
 
 	DBG("Connection attempt to: %s", addr);
@@ -2144,7 +2123,8 @@ GIOChannel *device_att_connect(gpointer user_data)
 	if (device_is_bredr(device)) {
 		io = bt_io_connect(att_connect_cb,
 					attcb, NULL, &gerr,
-					BT_IO_OPT_SOURCE_BDADDR, &sba,
+					BT_IO_OPT_SOURCE_BDADDR,
+					adapter_get_address(adapter),
 					BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
 					BT_IO_OPT_PSM, ATT_PSM,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
@@ -2153,7 +2133,8 @@ GIOChannel *device_att_connect(gpointer user_data)
 		/* this is a LE device during pairing, using low sec level */
 		io = bt_io_connect(att_connect_cb,
 				attcb, NULL, &gerr,
-				BT_IO_OPT_SOURCE_BDADDR, &sba,
+				BT_IO_OPT_SOURCE_BDADDR,
+				adapter_get_address(adapter),
 				BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
 				BT_IO_OPT_DEST_TYPE, device->bdaddr_type,
 				BT_IO_OPT_CID, ATT_CID,
@@ -2169,7 +2150,8 @@ GIOChannel *device_att_connect(gpointer user_data)
 	} else {
 		io = bt_io_connect(att_connect_cb,
 				attcb, NULL, &gerr,
-				BT_IO_OPT_SOURCE_BDADDR, &sba,
+				BT_IO_OPT_SOURCE_BDADDR,
+				adapter_get_address(adapter),
 				BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
 				BT_IO_OPT_DEST_TYPE, device->bdaddr_type,
 				BT_IO_OPT_CID, ATT_CID,
@@ -2222,14 +2204,12 @@ int device_browse_primary(struct btd_device *device, DBusMessage *msg,
 	struct att_callbacks *attcb;
 	struct browse_req *req;
 	BtIOSecLevel sec_level;
-	bdaddr_t src;
 
 	if (device->browse)
 		return -EBUSY;
 
 	req = g_new0(struct browse_req, 1);
 	req->device = btd_device_ref(device);
-	adapter_get_address(adapter, &src);
 
 	device->browse = req;
 
@@ -2247,7 +2227,8 @@ int device_browse_primary(struct btd_device *device, DBusMessage *msg,
 
 	device->att_io = bt_io_connect(att_connect_cb,
 				attcb, NULL, NULL,
-				BT_IO_OPT_SOURCE_BDADDR, &src,
+				BT_IO_OPT_SOURCE_BDADDR,
+				adapter_get_address(adapter),
 				BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
 				BT_IO_OPT_DEST_TYPE, device->bdaddr_type,
 				BT_IO_OPT_CID, ATT_CID,
@@ -2285,15 +2266,12 @@ int device_browse_sdp(struct btd_device *device, DBusMessage *msg,
 	struct btd_adapter *adapter = device->adapter;
 	struct browse_req *req;
 	bt_callback_t cb;
-	bdaddr_t src;
 	uuid_t uuid;
 	int err;
 
 	if (device->browse)
 		return -EBUSY;
 
-	adapter_get_address(adapter, &src);
-
 	req = g_new0(struct browse_req, 1);
 	req->device = btd_device_ref(device);
 	if (search) {
@@ -2305,7 +2283,8 @@ int device_browse_sdp(struct btd_device *device, DBusMessage *msg,
 		cb = browse_cb;
 	}
 
-	err = bt_search_service(&src, &device->bdaddr, &uuid, cb, req, NULL);
+	err = bt_search_service(adapter_get_address(adapter), &device->bdaddr,
+							&uuid, cb, req, NULL);
 	if (err < 0) {
 		browse_request_free(req);
 		return err;
@@ -2577,6 +2556,7 @@ DBusMessage *device_create_bonding(struct btd_device *device,
 	if (device_is_bonded(device))
 		return btd_error_already_exists(msg);
 
+				adapter_get_address(adapter),
 	bonding = bonding_request_new(msg, device, agent_path,
 					capability);
 
@@ -3127,8 +3107,6 @@ void btd_device_add_uuid(struct btd_device *device, const char *uuid)
 const sdp_record_t *btd_device_get_record(struct btd_device *device,
 							const char *uuid)
 {
-	bdaddr_t src;
-
 	if (device->tmp_records) {
 		const sdp_record_t *record;
 
@@ -3141,9 +3119,8 @@ const sdp_record_t *btd_device_get_record(struct btd_device *device,
 		device->tmp_records = NULL;
 	}
 
-	adapter_get_address(device->adapter, &src);
-
-	device->tmp_records = read_records(&src, &device->bdaddr);
+	device->tmp_records = read_records(adapter_get_address(device->adapter),
+							&device->bdaddr);
 	if (!device->tmp_records)
 		return NULL;
 
@@ -3194,14 +3171,12 @@ void device_set_class(struct btd_device *device, uint32_t value)
 
 int device_get_appearance(struct btd_device *device, uint16_t *value)
 {
-	bdaddr_t src;
 	uint16_t app;
 	int err;
 
-	adapter_get_address(device_get_adapter(device), &src);
-
-	err = read_remote_appearance(&src, &device->bdaddr,
-						device->bdaddr_type, &app);
+	err = read_remote_appearance(adapter_get_address(device->adapter),
+					&device->bdaddr, device->bdaddr_type,
+					&app);
 	if (err < 0)
 		return err;
 
@@ -3214,7 +3189,6 @@ int device_get_appearance(struct btd_device *device, uint16_t *value)
 void device_set_appearance(struct btd_device *device, uint16_t value)
 {
 	const char *icon = gap_appearance_to_icon(value);
-	bdaddr_t src;
 
 	emit_property_changed(device->path,
 				DEVICE_INTERFACE, "Appearance",
@@ -3225,9 +3199,8 @@ void device_set_appearance(struct btd_device *device, uint16_t value)
 					DEVICE_INTERFACE, "Icon",
 					DBUS_TYPE_STRING, &icon);
 
-	adapter_get_address(device_get_adapter(device), &src);
-	write_remote_appearance(&src, &device->bdaddr, device->bdaddr_type,
-									value);
+	write_remote_appearance(adapter_get_address(device->adapter),
+				&device->bdaddr, device->bdaddr_type, value);
 }
 
 static gboolean notify_attios(gpointer user_data)
diff --git a/src/manager.c b/src/manager.c
index f1f0f4d..083e24e 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -312,11 +312,8 @@ static gint adapter_cmp(gconstpointer a, gconstpointer b)
 {
 	struct btd_adapter *adapter = (struct btd_adapter *) a;
 	const bdaddr_t *bdaddr = b;
-	bdaddr_t src;
 
-	adapter_get_address(adapter, &src);
-
-	return bacmp(&src, bdaddr);
+	return bacmp(adapter_get_address(adapter), bdaddr);
 }
 
 struct btd_adapter *manager_find_adapter(const bdaddr_t *sba)
diff --git a/src/profile.c b/src/profile.c
index 338e903..c10e315 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -185,12 +185,11 @@ static void ext_io_destroy(gpointer p)
 	}
 
 	if (ext_io->resolving) {
-		bdaddr_t src, dst;
+		bdaddr_t dst;
 
-		adapter_get_address(ext_io->adapter, &src);
 		device_get_address(ext_io->device, &dst, NULL);
 
-		bt_cancel_discovery(&src, &dst);
+		bt_cancel_discovery(adapter_get_address(ext_io->adapter), &dst);
 	}
 
 	if (ext_io->rec_handle)
@@ -501,11 +500,8 @@ static int ext_start_servers(struct ext_profile *ext,
 	GError *err = NULL;
 	uint16_t handle;
 	GIOChannel *io;
-	bdaddr_t src;
-
-	adapter_get_address(adapter, &src);
 
-	handle = ext_register_record(ext, &src);
+	handle = ext_register_record(ext, adapter_get_address(adapter));
 
 	if (ext->authorize) {
 		confirm = ext_confirm;
@@ -521,7 +517,8 @@ static int ext_start_servers(struct ext_profile *ext,
 		server->rec_handle = handle;
 
 		io = bt_io_listen(connect, confirm, server, NULL, &err,
-					BT_IO_OPT_SOURCE_BDADDR, &src,
+					BT_IO_OPT_SOURCE_BDADDR,
+					adapter_get_address(adapter),
 					BT_IO_OPT_PSM, ext->psm,
 					BT_IO_OPT_SEC_LEVEL, ext->sec_level,
 					BT_IO_OPT_INVALID);
@@ -545,7 +542,8 @@ static int ext_start_servers(struct ext_profile *ext,
 		server->rec_handle = handle;
 
 		io = bt_io_listen(connect, confirm, server, NULL, &err,
-					BT_IO_OPT_SOURCE_BDADDR, &src,
+					BT_IO_OPT_SOURCE_BDADDR,
+					adapter_get_address(adapter),
 					BT_IO_OPT_CHANNEL, ext->chan,
 					BT_IO_OPT_SEC_LEVEL, ext->sec_level,
 					BT_IO_OPT_INVALID);
@@ -720,7 +718,7 @@ static void record_cb(sdp_list_t *recs, int err, gpointer user_data)
 {
 	struct ext_io *conn = user_data;
 	struct ext_profile *ext = conn->ext;
-	bdaddr_t src, dst;
+	bdaddr_t dst;
 	sdp_list_t *r;
 
 	conn->resolving = false;
@@ -772,10 +770,9 @@ static void record_cb(sdp_list_t *recs, int err, gpointer user_data)
 		goto failed;
 	}
 
-	adapter_get_address(conn->adapter, &src);
 	device_get_address(conn->device, &dst, NULL);
 
-	err = connect_io(conn, &src, &dst);
+	err = connect_io(conn, adapter_get_address(conn->adapter), &dst);
 	if (err < 0) {
 		error("Connecting %s failed: %s", ext->name, strerror(-err));
 		goto failed;
@@ -810,7 +807,7 @@ static int ext_connect_dev(struct btd_device *dev, struct btd_profile *profile,
 	struct btd_adapter *adapter;
 	struct ext_io *conn;
 	struct ext_profile *ext;
-	bdaddr_t src, dst;
+	bdaddr_t dst;
 	int err;
 
 	ext = find_ext(profile);
@@ -818,16 +815,15 @@ static int ext_connect_dev(struct btd_device *dev, struct btd_profile *profile,
 		return -ENOENT;
 
 	adapter = device_get_adapter(dev);
-	adapter_get_address(adapter, &src);
 	device_get_address(dev, &dst, NULL);
 
 	conn = g_new0(struct ext_io, 1);
 	conn->ext = ext;
 
 	if (ext->psm || ext->chan)
-		err = connect_io(conn, &src, &dst);
+		err = connect_io(conn, adapter_get_address(adapter), &dst);
 	else
-		err = resolve_service(conn, &src, &dst);
+		err = resolve_service(conn, adapter_get_address(adapter), &dst);
 
 	if (err < 0)
 		goto failed;
-- 
1.7.9.5

