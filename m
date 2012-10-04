Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 3/7] adapter: Constify pointer returned by adapter_get_address
Date: Thu, 4 Oct 2012 14:06:00 +0200
Message-ID: <1349352364-5491-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1349352364-5491-1-git-send-email-szymon.janc@tieto.com>
References: <1349352364-5491-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/manager.c               |    4 ++--
 profiles/gatt/gas.c           |   10 ++++++----
 profiles/health/hdp_util.c    |    9 ++++++---
 profiles/health/mcap.c        |    2 +-
 profiles/health/mcap_lib.h    |    2 +-
 profiles/network/connection.c |    6 +++---
 profiles/network/connection.h |    2 +-
 profiles/network/manager.c    |    3 ++-
 profiles/proximity/monitor.c  |    4 ++--
 profiles/sap/server.c         |    2 +-
 profiles/sap/server.h         |    2 +-
 src/adapter.c                 |    2 +-
 src/adapter.h                 |    2 +-
 src/attrib-server.c           |    2 +-
 src/device.c                  |    5 +++--
 src/eir.c                     |    2 +-
 src/eir.h                     |    2 +-
 src/profile.c                 |    9 ++++++---
 18 files changed, 40 insertions(+), 30 deletions(-)

diff --git a/audio/manager.c b/audio/manager.c
index 6ddea5a..e6886d7 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -507,7 +507,7 @@ static int headset_server_init(struct audio_adapter *adapter)
 	GError *err = NULL;
 	uint32_t features;
 	GIOChannel *io;
-	bdaddr_t *src;
+	const bdaddr_t *src;
 
 	if (config) {
 		gboolean tmp;
@@ -608,7 +608,7 @@ static int gateway_server_init(struct audio_adapter *adapter)
 	gboolean master = TRUE;
 	GError *err = NULL;
 	GIOChannel *io;
-	bdaddr_t *src;
+	const bdaddr_t *src;
 
 	if (config) {
 		gboolean tmp;
diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index f0fcbe7..03bdd5a 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -86,8 +86,9 @@ static inline int create_filename(char *buf, size_t size,
 	return create_name(buf, size, STORAGEDIR, addr, name);
 }
 
-static int write_ctp_handle(bdaddr_t *sba, bdaddr_t *dba, uint8_t bdaddr_type,
-						uint16_t uuid, uint16_t handle)
+static int write_ctp_handle(const bdaddr_t *sba, const bdaddr_t *dba,
+					uint8_t bdaddr_type, uint16_t uuid,
+					uint16_t handle)
 {
 	char filename[PATH_MAX + 1], addr[18], key[27], value[7];
 
@@ -104,8 +105,9 @@ static int write_ctp_handle(bdaddr_t *sba, bdaddr_t *dba, uint8_t bdaddr_type,
 	return textfile_put(filename, key, value);
 }
 
-static int read_ctp_handle(bdaddr_t *sba, bdaddr_t *dba, uint8_t bdaddr_type,
-						uint16_t uuid, uint16_t *value)
+static int read_ctp_handle(const bdaddr_t *sba, const bdaddr_t *dba,
+					uint8_t bdaddr_type, uint16_t uuid,
+					uint16_t *value)
 {
 	char filename[PATH_MAX + 1], addr[18], key[27];
 	char *str;
diff --git a/profiles/health/hdp_util.c b/profiles/health/hdp_util.c
index 931c1dd..1d9419e 100644
--- a/profiles/health/hdp_util.c
+++ b/profiles/health/hdp_util.c
@@ -857,7 +857,8 @@ gboolean hdp_get_mdep(struct hdp_device *device, struct hdp_application *app,
 				GDestroyNotify destroy, GError **err)
 {
 	struct get_mdep_data *mdep_data;
-	bdaddr_t dst, *src;
+	bdaddr_t dst;
+	const bdaddr_t *src;
 	uuid_t uuid;
 
 	device_get_address(device->dev, &dst, NULL);
@@ -1086,7 +1087,8 @@ gboolean hdp_establish_mcl(struct hdp_device *device,
 						GError **err)
 {
 	struct conn_mcl_data *conn_data;
-	bdaddr_t dst, *src;
+	bdaddr_t dst;
+	const bdaddr_t *src;
 	uuid_t uuid;
 
 	device_get_address(device->dev, &dst, NULL);
@@ -1156,7 +1158,8 @@ gboolean hdp_get_dcpsm(struct hdp_device *device, hdp_continue_dcpsm_f func,
 							GError **err)
 {
 	struct get_dcpsm_data *dcpsm_data;
-	bdaddr_t dst, *src;
+	bdaddr_t dst;
+	const bdaddr_t *src;
 	uuid_t uuid;
 
 	device_get_address(device->dev, &dst, NULL);
diff --git a/profiles/health/mcap.c b/profiles/health/mcap.c
index 86f0575..57ea1c3 100644
--- a/profiles/health/mcap.c
+++ b/profiles/health/mcap.c
@@ -1984,7 +1984,7 @@ drop:
 	g_io_channel_shutdown(chan, TRUE, NULL);
 }
 
-struct mcap_instance *mcap_create_instance(bdaddr_t *src,
+struct mcap_instance *mcap_create_instance(const bdaddr_t *src,
 					BtIOSecLevel sec,
 					uint16_t ccpsm,
 					uint16_t dcpsm,
diff --git a/profiles/health/mcap_lib.h b/profiles/health/mcap_lib.h
index 8fcc141..603ccc0 100644
--- a/profiles/health/mcap_lib.h
+++ b/profiles/health/mcap_lib.h
@@ -196,7 +196,7 @@ void mcap_sync_set_req(struct mcap_mcl *mcl,
 
 /* MCAP main operations */
 
-struct mcap_instance *mcap_create_instance(bdaddr_t *src,
+struct mcap_instance *mcap_create_instance(const bdaddr_t *src,
 					BtIOSecLevel sec, uint16_t ccpsm,
 					uint16_t dcpsm,
 					mcap_mcl_event_cb mcl_connected,
diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index 7688beb..9646e5a 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -594,8 +594,8 @@ void connection_unregister(const char *path)
 }
 
 static struct network_peer *create_peer(struct btd_device *device,
-					const char *path, bdaddr_t *src,
-					bdaddr_t *dst)
+					const char *path, const bdaddr_t *src,
+					const bdaddr_t *dst)
 {
 	struct network_peer *peer;
 
@@ -623,7 +623,7 @@ static struct network_peer *create_peer(struct btd_device *device,
 }
 
 int connection_register(struct btd_device *device, const char *path,
-			bdaddr_t *src, bdaddr_t *dst, uint16_t id)
+			const bdaddr_t *src, const bdaddr_t *dst, uint16_t id)
 {
 	struct network_peer *peer;
 	struct network_conn *nc;
diff --git a/profiles/network/connection.h b/profiles/network/connection.h
index 2e33c55..efc4ccb 100644
--- a/profiles/network/connection.h
+++ b/profiles/network/connection.h
@@ -22,5 +22,5 @@
  */
 
 int connection_register(struct btd_device *device, const char *path,
-			bdaddr_t *src, bdaddr_t *dst, uint16_t id);
+			const bdaddr_t *src, const bdaddr_t *dst, uint16_t id);
 void connection_unregister(const char *path);
diff --git a/profiles/network/manager.c b/profiles/network/manager.c
index 661181d..42b5214 100644
--- a/profiles/network/manager.c
+++ b/profiles/network/manager.c
@@ -78,7 +78,8 @@ static int network_probe(struct btd_profile *p, struct btd_device *device,
 {
 	struct btd_adapter *adapter = device_get_adapter(device);
 	const gchar *path = device_get_path(device);
-	bdaddr_t *src, dst;
+	const bdaddr_t *src;
+	bdaddr_t dst;
 
 	DBG("path %s", path);
 
diff --git a/profiles/proximity/monitor.c b/profiles/proximity/monitor.c
index 477eeea..03df0e2 100644
--- a/profiles/proximity/monitor.c
+++ b/profiles/proximity/monitor.c
@@ -93,7 +93,7 @@ static inline int create_filename(char *buf, size_t size,
 	return create_name(buf, size, STORAGEDIR, addr, name);
 }
 
-static int write_proximity_config(bdaddr_t *sba, bdaddr_t *dba,
+static int write_proximity_config(const bdaddr_t *sba, const bdaddr_t *dba,
 					const char *alert, const char *level)
 {
 	char filename[PATH_MAX + 1], addr[18], key[38];
@@ -109,7 +109,7 @@ static int write_proximity_config(bdaddr_t *sba, bdaddr_t *dba,
 	return textfile_put(filename, key, level);
 }
 
-static char *read_proximity_config(bdaddr_t *sba, bdaddr_t *dba,
+static char *read_proximity_config(const bdaddr_t *sba, const bdaddr_t *dba,
 							const char *alert)
 {
 	char filename[PATH_MAX + 1], addr[18], key[38];
diff --git a/profiles/sap/server.c b/profiles/sap/server.c
index 6072432..9a7cb72 100644
--- a/profiles/sap/server.c
+++ b/profiles/sap/server.c
@@ -1366,7 +1366,7 @@ static void destroy_sap_interface(void *data)
 	server_remove(server);
 }
 
-int sap_server_register(const char *path, bdaddr_t *src)
+int sap_server_register(const char *path, const bdaddr_t *src)
 {
 	sdp_record_t *record = NULL;
 	GError *gerr = NULL;
diff --git a/profiles/sap/server.h b/profiles/sap/server.h
index 9ea9a78..e636d91 100644
--- a/profiles/sap/server.h
+++ b/profiles/sap/server.h
@@ -20,5 +20,5 @@
 
 #include <gdbus.h>
 
-int sap_server_register(const char *path, bdaddr_t *src);
+int sap_server_register(const char *path, const bdaddr_t *src);
 void sap_server_unregister(const char *path);
diff --git a/src/adapter.c b/src/adapter.c
index 166b64f..9ed580c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2666,7 +2666,7 @@ const gchar *adapter_get_path(struct btd_adapter *adapter)
 	return adapter->path;
 }
 
-bdaddr_t *adapter_get_address(struct btd_adapter *adapter)
+const bdaddr_t *adapter_get_address(struct btd_adapter *adapter)
 {
 	return &adapter->bdaddr;
 }
diff --git a/src/adapter.h b/src/adapter.h
index f3599b5..d4fb14b 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -122,7 +122,7 @@ void adapter_set_discovering(struct btd_adapter *adapter,
 						gboolean discovering);
 uint16_t adapter_get_dev_id(struct btd_adapter *adapter);
 const gchar *adapter_get_path(struct btd_adapter *adapter);
-bdaddr_t *adapter_get_address(struct btd_adapter *adapter);
+const bdaddr_t *adapter_get_address(struct btd_adapter *adapter);
 struct remote_dev_info *adapter_search_found_devices(struct btd_adapter *adapter,
 							bdaddr_t *bdaddr);
 void adapter_update_found_devices(struct btd_adapter *adapter,
diff --git a/src/attrib-server.c b/src/attrib-server.c
index e7e2531..9155ab2 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -1237,7 +1237,7 @@ int btd_adapter_gatt_server_start(struct btd_adapter *adapter)
 {
 	struct gatt_server *server;
 	GError *gerr = NULL;
-	bdaddr_t *addr;
+	const bdaddr_t *addr;
 
 	DBG("Start GATT server in hci%d", adapter_get_dev_id(adapter));
 
diff --git a/src/device.c b/src/device.c
index 499dbc2..7133137 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1116,7 +1116,7 @@ struct btd_device *device_create(struct btd_adapter *adapter,
 	gchar *address_up;
 	struct btd_device *device;
 	const gchar *adapter_path = adapter_get_path(adapter);
-	bdaddr_t *src;
+	const bdaddr_t *src;
 	char srcaddr[18], alias[MAX_NAME_LENGTH + 1];
 	uint16_t vendor, product, version;
 
@@ -1222,7 +1222,8 @@ uint16_t btd_device_get_version(struct btd_device *device)
 
 static void device_remove_stored(struct btd_device *device)
 {
-	bdaddr_t *src, dst;
+	const bdaddr_t *src;
+	bdaddr_t dst;
 	uint8_t dst_type;
 
 	src = adapter_get_address(device->adapter);
diff --git a/src/eir.c b/src/eir.c
index d9fdb32..1f8d229 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -280,7 +280,7 @@ static void eir_generate_uuid128(sdp_list_t *list, uint8_t *ptr,
 	}
 }
 
-int eir_create_oob(bdaddr_t *addr, const char *name, uint32_t cod,
+int eir_create_oob(const bdaddr_t *addr, const char *name, uint32_t cod,
 			uint8_t *hash, uint8_t *randomizer,
 			uint16_t did_vendor, uint16_t did_product,
 			uint16_t did_version, uint16_t did_source,
diff --git a/src/eir.h b/src/eir.h
index d8c5e32..1ad0832 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -53,7 +53,7 @@ struct eir_data {
 void eir_data_free(struct eir_data *eir);
 int eir_parse(struct eir_data *eir, uint8_t *eir_data, uint8_t eir_len);
 int eir_parse_oob(struct eir_data *eir, uint8_t *eir_data, uint16_t eir_len);
-int eir_create_oob(bdaddr_t *addr, const char *name, uint32_t cod,
+int eir_create_oob(const bdaddr_t *addr, const char *name, uint32_t cod,
 			uint8_t *hash, uint8_t *randomizer,
 			uint16_t did_vendor, uint16_t did_product,
 			uint16_t did_version, uint16_t did_source,
diff --git a/src/profile.c b/src/profile.c
index c10e315..46b2e21 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -470,7 +470,8 @@ static sdp_record_t *ext_get_record(struct ext_profile *ext)
 	return NULL;
 }
 
-static uint16_t ext_register_record(struct ext_profile *ext, bdaddr_t *src)
+static uint16_t ext_register_record(struct ext_profile *ext,
+							const bdaddr_t *src)
 {
 	sdp_record_t *rec;
 
@@ -661,7 +662,8 @@ static void ext_device_remove(struct btd_profile *p, struct btd_device *dev)
 	remove_connect(ext, dev);
 }
 
-static int connect_io(struct ext_io *conn, bdaddr_t *src, bdaddr_t *dst)
+static int connect_io(struct ext_io *conn, const bdaddr_t *src,
+							const bdaddr_t *dst)
 {
 	struct ext_profile *ext = conn->ext;
 	GError *gerr = NULL;
@@ -786,7 +788,8 @@ failed:
 	ext_io_destroy(conn);
 }
 
-static int resolve_service(struct ext_io *conn, bdaddr_t *src, bdaddr_t *dst)
+static int resolve_service(struct ext_io *conn, const bdaddr_t *src,
+							const bdaddr_t *dst)
 {
 	struct ext_profile *ext = conn->ext;
 	uuid_t uuid;
-- 
1.7.9.5

