Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 4/7] device: Convert device_get_address into simple getter
Date: Thu, 4 Oct 2012 14:06:01 +0200
Message-ID: <1349352364-5491-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1349352364-5491-1-git-send-email-szymon.janc@tieto.com>
References: <1349352364-5491-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allow to remove number of local variables used only to get device
address and pass it as pointer later on.

bdaddr_type parameter is also removed as there is device_get_addr_type
already present which can be used to get it if needed.

---
 attrib/client.c              |   42 ++++++++++++++++--------------------------
 audio/manager.c              |    6 ++----
 plugins/wiimote.c            |    4 +---
 profiles/gatt/gas.c          |   20 ++++++++------------
 profiles/health/hdp.c        |    4 +---
 profiles/health/hdp_util.c   |   27 +++++++++++++--------------
 profiles/input/device.c      |    6 +++---
 profiles/network/manager.c   |   10 +++++-----
 profiles/proximity/monitor.c |   11 +++--------
 src/adapter.c                |    6 ++----
 src/device.c                 |   37 ++++++++++++++-----------------------
 src/device.h                 |    3 +--
 src/event.c                  |   27 +++++++++------------------
 src/profile.c                |   24 +++++++++---------------
 14 files changed, 87 insertions(+), 140 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index eea06ae..30513d1 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -222,17 +222,6 @@ static void remove_attio(struct gatt_service *gatt)
 	}
 }
 
-static void gatt_get_address(struct gatt_service *gatt, bdaddr_t *sba,
-					bdaddr_t *dba, uint8_t *bdaddr_type)
-{
-	struct btd_device *device = gatt->dev;
-	struct btd_adapter *adapter;
-
-	adapter = device_get_adapter(device);
-	bacpy(sba, adapter_get_address(adapter));
-	device_get_address(device, dba, bdaddr_type);
-}
-
 static int characteristic_handle_cmp(gconstpointer a, gconstpointer b)
 {
 	const struct characteristic *chr = a;
@@ -684,14 +673,15 @@ static GSList *string_to_characteristic_list(struct gatt_service *gatt,
 
 static GSList *load_characteristics(struct gatt_service *gatt, uint16_t start)
 {
+	struct btd_device *device = gatt->dev;
+	struct btd_adapter *adapter = device_get_adapter(device);
 	GSList *chrs_list;
-	bdaddr_t sba, dba;
-	uint8_t bdaddr_type;
 	char *str;
 
-	gatt_get_address(gatt, &sba, &dba, &bdaddr_type);
-
-	str = read_device_characteristics(&sba, &dba, bdaddr_type, start);
+	str = read_device_characteristics(adapter_get_address(adapter),
+						device_get_address(device),
+						device_get_addr_type(device),
+						start);
 	if (str == NULL)
 		return NULL;
 
@@ -705,8 +695,7 @@ static GSList *load_characteristics(struct gatt_service *gatt, uint16_t start)
 static void store_attribute(struct gatt_service *gatt, uint16_t handle,
 				uint16_t type, uint8_t *value, gsize len)
 {
-	bdaddr_t sba, dba;
-	uint8_t bdaddr_type;
+	struct btd_device *device = gatt->dev;
 	bt_uuid_t uuid;
 	char *str, *tmp;
 	guint i;
@@ -721,9 +710,9 @@ static void store_attribute(struct gatt_service *gatt, uint16_t handle,
 	for (i = 0, tmp = str + MAX_LEN_UUID_STR; i < len; i++, tmp += 2)
 		sprintf(tmp, "%02X", value[i]);
 
-	gatt_get_address(gatt, &sba, &dba, &bdaddr_type);
-
-	write_device_attribute(&sba, &dba, bdaddr_type, handle, str);
+	write_device_attribute(adapter_get_address(device_get_adapter(device)),
+				device_get_address(device),
+				device_get_addr_type(device), handle, str);
 
 	g_free(str);
 }
@@ -964,9 +953,9 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 	struct gatt_service *gatt = current->gatt;
 	struct gatt_primary *prim = gatt->prim;
 	uint16_t *previous_end = NULL;
+	struct btd_device *device = gatt->dev;
+	struct btd_adapter *adapter = device_get_adapter(device);
 	GSList *l;
-	bdaddr_t sba, dba;
-	uint8_t bdaddr_type;
 
 	if (status != 0) {
 		const char *str = att_ecode2str(status);
@@ -1005,9 +994,10 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 	if (previous_end)
 		*previous_end = prim->range.end;
 
-	gatt_get_address(gatt, &sba, &dba, &bdaddr_type);
-	store_characteristics(&sba, &dba, bdaddr_type, prim->range.start,
-								gatt->chars);
+	store_characteristics(adapter_get_address(adapter),
+					device_get_address(device),
+					device_get_addr_type(device),
+					prim->range.start, gatt->chars);
 
 	g_slist_foreach(gatt->chars, update_all_chars, gatt);
 
diff --git a/audio/manager.c b/audio/manager.c
index e6886d7..26cd9bf 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -663,11 +663,9 @@ failed:
 static struct audio_device *get_audio_dev(struct btd_device *device)
 {
 	struct btd_adapter *adapter = device_get_adapter(device);
-	bdaddr_t dst;
 
-	device_get_address(device, &dst, NULL);
-
-	return manager_get_device(adapter_get_address(adapter), &dst, TRUE);
+	return manager_get_device(adapter_get_address(adapter),
+					device_get_address(device), TRUE);
 }
 
 static void audio_remove(struct btd_profile *p, struct btd_device *device)
diff --git a/plugins/wiimote.c b/plugins/wiimote.c
index 93d1e2d..5708bf8 100644
--- a/plugins/wiimote.c
+++ b/plugins/wiimote.c
@@ -62,11 +62,9 @@ static ssize_t wii_pincb(struct btd_adapter *adapter, struct btd_device *device,
 						char *pinbuf, gboolean *display)
 {
 	uint16_t vendor, product;
-	bdaddr_t dba;
 	char addr[18], name[25];
 
-	device_get_address(device, &dba, NULL);
-	ba2str(&dba, addr);
+	ba2str(device_get_address(device), addr);
 
 	vendor = btd_device_get_vendor(device);
 	product = btd_device_get_product(device);
diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index 03bdd5a..82c2ef0 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -170,8 +170,6 @@ static void ccc_written_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
 	struct gas *gas = user_data;
-	bdaddr_t dba;
-	uint8_t bdaddr_type;
 
 	if (status) {
 		error("Write Service Changed CCC failed: %s",
@@ -181,11 +179,11 @@ static void ccc_written_cb(guint8 status, const guint8 *pdu, guint16 plen,
 
 	DBG("Service Changed indications enabled");
 
-	device_get_address(gas->device, &dba, &bdaddr_type);
-
 	write_ctp_handle(adapter_get_address(device_get_adapter(gas->device)),
-				&dba, bdaddr_type, GATT_CHARAC_SERVICE_CHANGED,
-				gas->changed_handle);
+					device_get_address(gas->device),
+					device_get_addr_type(gas->device),
+					GATT_CHARAC_SERVICE_CHANGED,
+					gas->changed_handle);
 }
 
 static void write_ccc(GAttrib *attrib, uint16_t handle, gpointer user_data)
@@ -379,8 +377,6 @@ int gas_register(struct btd_device *device, struct att_range *gap,
 						struct att_range *gatt)
 {
 	struct gas *gas;
-	bdaddr_t dba;
-	uint8_t bdaddr_type;
 
 	gas = g_new0(struct gas, 1);
 	gas->gap.start = gap->start;
@@ -396,11 +392,11 @@ int gas_register(struct btd_device *device, struct att_range *gap,
 						attio_connected_cb,
 						attio_disconnected_cb, gas);
 
-	device_get_address(gas->device, &dba, &bdaddr_type);
-
 	read_ctp_handle(adapter_get_address(device_get_adapter(gas->device)),
-				&dba, bdaddr_type, GATT_CHARAC_SERVICE_CHANGED,
-				&gas->changed_handle);
+					device_get_address(gas->device),
+					device_get_addr_type(gas->device),
+					GATT_CHARAC_SERVICE_CHANGED,
+					&gas->changed_handle);
 
 	return 0;
 }
diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index d07462a..fd21a23 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -210,10 +210,8 @@ static int cmp_device(gconstpointer a, gconstpointer b)
 static gint cmp_dev_addr(gconstpointer a, gconstpointer dst)
 {
 	const struct hdp_device *device = a;
-	bdaddr_t addr;
 
-	device_get_address(device->dev, &addr, NULL);
-	return bacmp(&addr, dst);
+	return bacmp(device_get_address(device->dev), dst);
 }
 
 static gint cmp_dev_mcl(gconstpointer a, gconstpointer mcl)
diff --git a/profiles/health/hdp_util.c b/profiles/health/hdp_util.c
index 1d9419e..1fd33e5 100644
--- a/profiles/health/hdp_util.c
+++ b/profiles/health/hdp_util.c
@@ -857,12 +857,12 @@ gboolean hdp_get_mdep(struct hdp_device *device, struct hdp_application *app,
 				GDestroyNotify destroy, GError **err)
 {
 	struct get_mdep_data *mdep_data;
-	bdaddr_t dst;
 	const bdaddr_t *src;
+	const bdaddr_t *dst;
 	uuid_t uuid;
 
-	device_get_address(device->dev, &dst, NULL);
 	src = adapter_get_address(device_get_adapter(device->dev));
+	dst = device_get_address(device->dev);
 
 	mdep_data = g_new0(struct get_mdep_data, 1);
 	mdep_data->app = hdp_application_ref(app);
@@ -871,7 +871,7 @@ gboolean hdp_get_mdep(struct hdp_device *device, struct hdp_application *app,
 	mdep_data->destroy = destroy;
 
 	bt_string2uuid(&uuid, HDP_UUID);
-	if (bt_search_service(src, &dst, &uuid, get_mdep_cb, mdep_data,
+	if (bt_search_service(src, dst, &uuid, get_mdep_cb, mdep_data,
 							free_mdep_data) < 0) {
 		g_set_error(err, HDP_ERROR, HDP_CONNECTION_ERROR,
 						"Can't get remote SDP record");
@@ -1044,7 +1044,6 @@ static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
 {
 	struct conn_mcl_data *conn_data = user_data;
 	GError *gerr = NULL;
-	bdaddr_t dst;
 	uint16_t ccpsm;
 
 	if (conn_data->dev->hdp_adapter->mi == NULL) {
@@ -1067,10 +1066,10 @@ static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
 
 	conn_data = con_mcl_data_ref(conn_data);
 
-	device_get_address(conn_data->dev->dev, &dst, NULL);
-	if (!mcap_create_mcl(conn_data->dev->hdp_adapter->mi, &dst, ccpsm,
-						create_mcl_cb, conn_data,
-						destroy_con_mcl_data, &gerr)) {
+	if (!mcap_create_mcl(conn_data->dev->hdp_adapter->mi,
+					device_get_address(conn_data->dev->dev),
+					ccpsm, create_mcl_cb, conn_data,
+					destroy_con_mcl_data, &gerr)) {
 		con_mcl_data_unref(conn_data);
 		goto fail;
 	}
@@ -1087,12 +1086,12 @@ gboolean hdp_establish_mcl(struct hdp_device *device,
 						GError **err)
 {
 	struct conn_mcl_data *conn_data;
-	bdaddr_t dst;
 	const bdaddr_t *src;
+	const bdaddr_t *dst;
 	uuid_t uuid;
 
-	device_get_address(device->dev, &dst, NULL);
 	src = adapter_get_address(device_get_adapter(device->dev));
+	dst = device_get_address(device->dev);
 
 	conn_data = g_new0(struct conn_mcl_data, 1);
 	conn_data->refs = 1;
@@ -1102,7 +1101,7 @@ gboolean hdp_establish_mcl(struct hdp_device *device,
 	conn_data->dev = health_device_ref(device);
 
 	bt_string2uuid(&uuid, HDP_UUID);
-	if (bt_search_service(src, &dst, &uuid, search_cb, conn_data,
+	if (bt_search_service(src, dst, &uuid, search_cb, conn_data,
 						destroy_con_mcl_data) < 0) {
 		g_set_error(err, HDP_ERROR, HDP_CONNECTION_ERROR,
 						"Can't get remote SDP record");
@@ -1158,12 +1157,12 @@ gboolean hdp_get_dcpsm(struct hdp_device *device, hdp_continue_dcpsm_f func,
 							GError **err)
 {
 	struct get_dcpsm_data *dcpsm_data;
-	bdaddr_t dst;
 	const bdaddr_t *src;
+	const bdaddr_t *dst;
 	uuid_t uuid;
 
-	device_get_address(device->dev, &dst, NULL);
 	src = adapter_get_address(device_get_adapter(device->dev));
+	dst = device_get_address(device->dev);
 
 	dcpsm_data = g_new0(struct get_dcpsm_data, 1);
 	dcpsm_data->func = func;
@@ -1171,7 +1170,7 @@ gboolean hdp_get_dcpsm(struct hdp_device *device, hdp_continue_dcpsm_f func,
 	dcpsm_data->destroy = destroy;
 
 	bt_string2uuid(&uuid, HDP_UUID);
-	if (bt_search_service(src, &dst, &uuid, get_dcpsm_cb, dcpsm_data,
+	if (bt_search_service(src, dst, &uuid, get_dcpsm_cb, dcpsm_data,
 							free_dcpsm_data) < 0) {
 		g_set_error(err, HDP_ERROR, HDP_CONNECTION_ERROR,
 						"Can't get remote SDP record");
diff --git a/profiles/input/device.c b/profiles/input/device.c
index ed50e3b..92e1fa9 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -782,11 +782,10 @@ static struct input_device *input_device_new(struct btd_device *device,
 	struct btd_adapter *adapter = device_get_adapter(device);
 	struct input_device *idev;
 	char name[249], src_addr[18], dst_addr[18];
-	uint8_t dst_type;
 
 	idev = g_new0(struct input_device, 1);
 	bacpy(&idev->src, adapter_get_address(adapter));
-	device_get_address(device, &idev->dst, &dst_type);
+	bacpy(&idev->dst, device_get_address(device));
 	idev->device = btd_device_ref(device);
 	idev->path = g_strdup(path);
 	idev->handle = handle;
@@ -795,7 +794,8 @@ static struct input_device *input_device_new(struct btd_device *device,
 	ba2str(&idev->src, src_addr);
 	ba2str(&idev->dst, dst_addr);
 
-	if (read_device_name(src_addr, dst_addr, dst_type, name) == 0)
+	if (read_device_name(src_addr, dst_addr, device_get_addr_type(device),
+				name) == 0)
 		idev->name = g_strdup(name);
 
 	if (g_dbus_register_interface(btd_get_dbus_connection(),
diff --git a/profiles/network/manager.c b/profiles/network/manager.c
index 42b5214..049fbc7 100644
--- a/profiles/network/manager.c
+++ b/profiles/network/manager.c
@@ -79,19 +79,19 @@ static int network_probe(struct btd_profile *p, struct btd_device *device,
 	struct btd_adapter *adapter = device_get_adapter(device);
 	const gchar *path = device_get_path(device);
 	const bdaddr_t *src;
-	bdaddr_t dst;
+	const bdaddr_t *dst;
 
 	DBG("path %s", path);
 
 	src = adapter_get_address(adapter);
-	device_get_address(device, &dst, NULL);
+	dst = device_get_address(device);
 
 	if (g_slist_find_custom(uuids, PANU_UUID, bt_uuid_strcmp))
-		connection_register(device, path, src, &dst, BNEP_SVC_PANU);
+		connection_register(device, path, src, dst, BNEP_SVC_PANU);
 	if (g_slist_find_custom(uuids, GN_UUID, bt_uuid_strcmp))
-		connection_register(device, path, src, &dst, BNEP_SVC_GN);
+		connection_register(device, path, src, dst, BNEP_SVC_GN);
 	if (g_slist_find_custom(uuids, NAP_UUID, bt_uuid_strcmp))
-		connection_register(device, path, src, &dst, BNEP_SVC_NAP);
+		connection_register(device, path, src, dst, BNEP_SVC_NAP);
 
 	return 0;
 }
diff --git a/profiles/proximity/monitor.c b/profiles/proximity/monitor.c
index 03df0e2..1a14265 100644
--- a/profiles/proximity/monitor.c
+++ b/profiles/proximity/monitor.c
@@ -407,7 +407,6 @@ static DBusMessage *set_link_loss_alert(DBusConnection *conn, DBusMessage *msg,
 {
 	struct monitor *monitor = data;
 	struct btd_device *device = monitor->device;
-	bdaddr_t dba;
 
 	if (!level_is_valid(level))
 		return btd_error_invalid_args(msg);
@@ -418,10 +417,9 @@ static DBusMessage *set_link_loss_alert(DBusConnection *conn, DBusMessage *msg,
 	g_free(monitor->linklosslevel);
 	monitor->linklosslevel = g_strdup(level);
 
-	device_get_address(device, &dba, NULL);
-
 	write_proximity_config(adapter_get_address(device_get_adapter(device)),
-					&dba, "LinkLossAlertLevel", level);
+					device_get_address(device),
+					"LinkLossAlertLevel", level);
 
 	if (monitor->attrib)
 		write_alert_level(monitor);
@@ -593,14 +591,11 @@ int monitor_register(struct btd_device *device,
 {
 	const char *path = device_get_path(device);
 	struct monitor *monitor;
-	bdaddr_t dba;
 	char *level;
 
-	device_get_address(device, &dba, NULL);
-
 	level = read_proximity_config(
 			adapter_get_address(device_get_adapter(device)),
-			&dba, "LinkLossAlertLevel");
+			device_get_address(device), "LinkLossAlertLevel");
 
 	monitor = g_new0(struct monitor, 1);
 	monitor->device = btd_device_ref(device);
diff --git a/src/adapter.c b/src/adapter.c
index 9ed580c..4610b85 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3614,7 +3614,6 @@ ssize_t btd_adapter_get_pin(struct btd_adapter *adapter, struct btd_device *dev,
 {
 	GSList *l;
 	btd_adapter_pin_cb_t cb;
-	bdaddr_t dba;
 	ssize_t ret;
 
 	for (l = adapter->pin_callbacks; l != NULL; l = g_slist_next(l)) {
@@ -3624,9 +3623,8 @@ ssize_t btd_adapter_get_pin(struct btd_adapter *adapter, struct btd_device *dev,
 			return ret;
 	}
 
-	device_get_address(dev, &dba, NULL);
-
-	return read_pin_code(adapter_get_address(adapter), &dba, pin_buf);
+	return read_pin_code(adapter_get_address(adapter),
+					device_get_address(dev), pin_buf);
 }
 
 void btd_adapter_register_powered_callback(struct btd_adapter *adapter,
diff --git a/src/device.c b/src/device.c
index 7133137..58498b2 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1222,28 +1222,25 @@ uint16_t btd_device_get_version(struct btd_device *device)
 
 static void device_remove_stored(struct btd_device *device)
 {
-	const bdaddr_t *src;
-	bdaddr_t dst;
-	uint8_t dst_type;
-
-	src = adapter_get_address(device->adapter);
-	device_get_address(device, &dst, &dst_type);
+	const bdaddr_t *src = adapter_get_address(device->adapter);
+	uint8_t dst_type = device->bdaddr_type;
 
-	delete_entry(src, "profiles", &dst, dst_type);
-	delete_entry(src, "trusts", &dst, dst_type);
+	delete_entry(src, "profiles", &device->bdaddr, dst_type);
+	delete_entry(src, "trusts", &device->bdaddr, dst_type);
 
 	if (device_is_bonded(device)) {
-		delete_entry(src, "linkkeys", &dst, dst_type);
-		delete_entry(src, "aliases", &dst, dst_type);
-		delete_entry(src, "longtermkeys", &dst, dst_type);
+		delete_entry(src, "linkkeys", &device->bdaddr, dst_type);
+		delete_entry(src, "aliases", &device->bdaddr, dst_type);
+		delete_entry(src, "longtermkeys", &device->bdaddr, dst_type);
 
 		device_set_bonded(device, FALSE);
 		device->paired = FALSE;
-		btd_adapter_remove_bonding(device->adapter, &dst, dst_type);
+		btd_adapter_remove_bonding(device->adapter, &device->bdaddr,
+								dst_type);
 	}
 
-	delete_all_records(src, &dst, dst_type);
-	delete_device_service(src, &dst, dst_type);
+	delete_all_records(src, &device->bdaddr, dst_type);
+	delete_device_service(src, &device->bdaddr, dst_type);
 
 	if (device->blocked)
 		device_unblock(device, TRUE, FALSE);
@@ -1883,12 +1880,9 @@ static char *primary_list_to_string(GSList *primary_list)
 static void store_services(struct btd_device *device)
 {
 	struct btd_adapter *adapter = device->adapter;
-	bdaddr_t dba;
 	char *str = primary_list_to_string(device->primaries);
 
-	device_get_address(device, &dba, NULL);
-
-	write_device_services(adapter_get_address(adapter), &dba,
+	write_device_services(adapter_get_address(adapter), &device->bdaddr,
 						device->bdaddr_type, str);
 
 	g_free(str);
@@ -2317,12 +2311,9 @@ struct btd_adapter *device_get_adapter(struct btd_device *device)
 	return device->adapter;
 }
 
-void device_get_address(struct btd_device *device, bdaddr_t *bdaddr,
-							uint8_t *bdaddr_type)
+bdaddr_t *device_get_address(struct btd_device *device)
 {
-	bacpy(bdaddr, &device->bdaddr);
-	if (bdaddr_type != NULL)
-		*bdaddr_type = device->bdaddr_type;
+	return &device->bdaddr;
 }
 
 void device_set_addr_type(struct btd_device *device, uint8_t bdaddr_type)
diff --git a/src/device.h b/src/device.h
index 462b9a1..f919af4 100644
--- a/src/device.h
+++ b/src/device.h
@@ -64,8 +64,7 @@ void btd_device_add_uuid(struct btd_device *device, const char *uuid);
 void device_probe_profile(gpointer a, gpointer b);
 void device_remove_profile(gpointer a, gpointer b);
 struct btd_adapter *device_get_adapter(struct btd_device *device);
-void device_get_address(struct btd_device *device, bdaddr_t *bdaddr,
-							uint8_t *bdaddr_type);
+bdaddr_t *device_get_address(struct btd_device *device);
 void device_set_addr_type(struct btd_device *device, uint8_t bdaddr_type);
 uint8_t device_get_addr_type(struct btd_device *device);
 const gchar *device_get_path(struct btd_device *device);
diff --git a/src/event.c b/src/event.c
index 9626053..84c7f88 100644
--- a/src/event.c
+++ b/src/event.c
@@ -90,20 +90,18 @@ static void pincode_cb(struct agent *agent, DBusError *derr,
 				const char *pincode, struct btd_device *device)
 {
 	struct btd_adapter *adapter = device_get_adapter(device);
-	bdaddr_t dba;
 	int err;
 
-	device_get_address(device, &dba, NULL);
-
 	if (derr) {
-		err = btd_adapter_pincode_reply(adapter, &dba, NULL, 0);
+		err = btd_adapter_pincode_reply(adapter,
+					device_get_address(device), NULL, 0);
 		if (err < 0)
 			goto fail;
 		return;
 	}
 
-	err = btd_adapter_pincode_reply(adapter, &dba, pincode,
-						pincode ? strlen(pincode) : 0);
+	err = btd_adapter_pincode_reply(adapter, device_get_address(device),
+					pincode, pincode ? strlen(pincode) : 0);
 	if (err < 0)
 		goto fail;
 
@@ -141,13 +139,9 @@ int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba, gboolean secure)
 static int confirm_reply(struct btd_adapter *adapter,
 				struct btd_device *device, gboolean success)
 {
-	bdaddr_t bdaddr;
-	uint8_t bdaddr_type;
-
-	device_get_address(device, &bdaddr, &bdaddr_type);
-
-	return btd_adapter_confirm_reply(adapter, &bdaddr, bdaddr_type,
-								success);
+	return btd_adapter_confirm_reply(adapter, device_get_address(device),
+						device_get_addr_type(device),
+						success);
 }
 
 static void confirm_cb(struct agent *agent, DBusError *err, void *user_data)
@@ -164,15 +158,12 @@ static void passkey_cb(struct agent *agent, DBusError *err, uint32_t passkey,
 {
 	struct btd_device *device = user_data;
 	struct btd_adapter *adapter = device_get_adapter(device);
-	bdaddr_t bdaddr;
-	uint8_t bdaddr_type;
-
-	device_get_address(device, &bdaddr, &bdaddr_type);
 
 	if (err)
 		passkey = INVALID_PASSKEY;
 
-	btd_adapter_passkey_reply(adapter, &bdaddr, bdaddr_type, passkey);
+	btd_adapter_passkey_reply(adapter, device_get_address(device),
+					device_get_addr_type(device), passkey);
 }
 
 int btd_event_user_confirm(bdaddr_t *sba, bdaddr_t *dba, uint32_t passkey)
diff --git a/src/profile.c b/src/profile.c
index 46b2e21..eb63e1e 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -184,13 +184,9 @@ static void ext_io_destroy(gpointer p)
 		ext_cancel(ext);
 	}
 
-	if (ext_io->resolving) {
-		bdaddr_t dst;
-
-		device_get_address(ext_io->device, &dst, NULL);
-
-		bt_cancel_discovery(adapter_get_address(ext_io->adapter), &dst);
-	}
+	if (ext_io->resolving)
+		bt_cancel_discovery(adapter_get_address(ext_io->adapter),
+					device_get_address(ext_io->device));
 
 	if (ext_io->rec_handle)
 		remove_record_from_server(ext_io->rec_handle);
@@ -720,7 +716,6 @@ static void record_cb(sdp_list_t *recs, int err, gpointer user_data)
 {
 	struct ext_io *conn = user_data;
 	struct ext_profile *ext = conn->ext;
-	bdaddr_t dst;
 	sdp_list_t *r;
 
 	conn->resolving = false;
@@ -772,9 +767,8 @@ static void record_cb(sdp_list_t *recs, int err, gpointer user_data)
 		goto failed;
 	}
 
-	device_get_address(conn->device, &dst, NULL);
-
-	err = connect_io(conn, adapter_get_address(conn->adapter), &dst);
+	err = connect_io(conn, adapter_get_address(conn->adapter),
+					device_get_address(conn->device));
 	if (err < 0) {
 		error("Connecting %s failed: %s", ext->name, strerror(-err));
 		goto failed;
@@ -810,7 +804,6 @@ static int ext_connect_dev(struct btd_device *dev, struct btd_profile *profile,
 	struct btd_adapter *adapter;
 	struct ext_io *conn;
 	struct ext_profile *ext;
-	bdaddr_t dst;
 	int err;
 
 	ext = find_ext(profile);
@@ -818,15 +811,16 @@ static int ext_connect_dev(struct btd_device *dev, struct btd_profile *profile,
 		return -ENOENT;
 
 	adapter = device_get_adapter(dev);
-	device_get_address(dev, &dst, NULL);
 
 	conn = g_new0(struct ext_io, 1);
 	conn->ext = ext;
 
 	if (ext->psm || ext->chan)
-		err = connect_io(conn, adapter_get_address(adapter), &dst);
+		err = connect_io(conn, adapter_get_address(adapter),
+						device_get_address(dev));
 	else
-		err = resolve_service(conn, adapter_get_address(adapter), &dst);
+		err = resolve_service(conn, adapter_get_address(adapter),
+						device_get_address(dev));
 
 	if (err < 0)
 		goto failed;
-- 
1.7.9.5

