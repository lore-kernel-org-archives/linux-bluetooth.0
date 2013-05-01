Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 14/16] core: Get rid of gint
Date: Wed,  1 May 2013 02:12:09 -0300
Message-Id: <1367385131-24034-14-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1367385131-24034-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1367385131-24034-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

Use plain int instead of gint. In glib gint is always a typedef to int, so it's safe to use it even for callbacks with glib.
---
 src/adapter.c       |  6 +++---
 src/attrib-server.c |  6 +++---
 src/device.c        | 10 +++++-----
 src/device.h        |  4 ++--
 src/plugin.c        |  2 +-
 src/sdp-client.c    |  2 +-
 src/service.c       |  2 +-
 src/shared/hciemu.c |  2 +-
 src/shared/mgmt.c   |  4 ++--
 9 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 0c0831c..1252e74 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1472,7 +1472,7 @@ static void stop_discovery_complete(uint8_t status, uint16_t length,
 	}
 }
 
-static gint compare_discovery_sender(gconstpointer a, gconstpointer b)
+static int compare_discovery_sender(gconstpointer a, gconstpointer b)
 {
 	const struct discovery_client *client = a;
 	const char *sender = b;
@@ -2098,7 +2098,7 @@ static gboolean property_get_modalias(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static gint device_path_cmp(gconstpointer a, gconstpointer b)
+static int device_path_cmp(gconstpointer a, gconstpointer b)
 {
 	const struct btd_device *device = a;
 	const char *path = b;
@@ -3099,7 +3099,7 @@ static void convert_did_entry(GKeyFile *key_file, void *value)
 static void convert_linkkey_entry(GKeyFile *key_file, void *value)
 {
 	char *type_str, *length_str, *str;
-	gint val;
+	int val;
 
 	type_str = strchr(value, ' ');
 	if (!type_str)
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 61bc01d..3610e60 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -150,7 +150,7 @@ static void gatt_server_free(struct gatt_server *server)
 	g_free(server);
 }
 
-static gint adapter_cmp_addr(gconstpointer a, gconstpointer b)
+static int adapter_cmp_addr(gconstpointer a, gconstpointer b)
 {
 	const struct gatt_server *server = a;
 	const bdaddr_t *bdaddr = b;
@@ -158,7 +158,7 @@ static gint adapter_cmp_addr(gconstpointer a, gconstpointer b)
 	return bacmp(adapter_get_address(server->adapter), bdaddr);
 }
 
-static gint adapter_cmp(gconstpointer a, gconstpointer b)
+static int adapter_cmp(gconstpointer a, gconstpointer b)
 {
 	const struct gatt_server *server = a;
 	const struct btd_adapter *adapter = b;
@@ -1176,7 +1176,7 @@ guint attrib_channel_attach(GAttrib *attrib)
 	return channel->id;
 }
 
-static gint channel_id_cmp(gconstpointer data, gconstpointer user_data)
+static int channel_id_cmp(gconstpointer data, gconstpointer user_data)
 {
 	const struct gatt_channel *channel = data;
 	guint id = GPOINTER_TO_UINT(user_data);
diff --git a/src/device.c b/src/device.c
index 85610c4..ff4c553 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1242,7 +1242,7 @@ static struct btd_service *find_connectable_service(struct btd_device *dev,
 	return NULL;
 }
 
-static gint service_prio_cmp(gconstpointer a, gconstpointer b)
+static int service_prio_cmp(gconstpointer a, gconstpointer b)
 {
 	struct btd_profile *p1 = btd_service_get_profile(a);
 	struct btd_profile *p2 = btd_service_get_profile(b);
@@ -1978,7 +1978,7 @@ static void load_att_info(struct btd_device *device, const char *local,
 
 	for (handle = groups; *handle; handle++) {
 		gboolean uuid_ok;
-		gint end;
+		int end;
 
 		str = g_key_file_get_string(key_file, *handle, "UUID", NULL);
 		if (!str)
@@ -2334,7 +2334,7 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
 	btd_device_unref(device);
 }
 
-gint device_address_cmp(gconstpointer a, gconstpointer b)
+int device_address_cmp(gconstpointer a, gconstpointer b)
 {
 	const struct btd_device *device = a;
 	const char *address = b;
@@ -2344,7 +2344,7 @@ gint device_address_cmp(gconstpointer a, gconstpointer b)
 	return strcasecmp(addr, address);
 }
 
-gint device_bdaddr_cmp(gconstpointer a, gconstpointer b)
+int device_bdaddr_cmp(gconstpointer a, gconstpointer b)
 {
 	const struct btd_device *device = a;
 	const bdaddr_t *bdaddr = b;
@@ -2740,7 +2740,7 @@ static void update_bredr_services(struct browse_req *req, sdp_list_t *recs)
 	}
 }
 
-static gint primary_cmp(gconstpointer a, gconstpointer b)
+static int primary_cmp(gconstpointer a, gconstpointer b)
 {
 	return memcmp(a, b, sizeof(struct gatt_primary));
 }
diff --git a/src/device.h b/src/device.h
index f4db3b9..7cd11af 100644
--- a/src/device.h
+++ b/src/device.h
@@ -43,8 +43,8 @@ uint16_t btd_device_get_vendor_src(struct btd_device *device);
 uint16_t btd_device_get_product(struct btd_device *device);
 uint16_t btd_device_get_version(struct btd_device *device);
 void device_remove(struct btd_device *device, gboolean remove_stored);
-gint device_address_cmp(gconstpointer a, gconstpointer b);
-gint device_bdaddr_cmp(gconstpointer a, gconstpointer b);
+int device_address_cmp(gconstpointer a, gconstpointer b);
+int device_bdaddr_cmp(gconstpointer a, gconstpointer b);
 GSList *device_get_uuids(struct btd_device *device);
 void device_probe_profiles(struct btd_device *device, GSList *profiles);
 const sdp_record_t *btd_device_get_record(struct btd_device *device,
diff --git a/src/plugin.c b/src/plugin.c
index a23e533..51c98bc 100644
--- a/src/plugin.c
+++ b/src/plugin.c
@@ -47,7 +47,7 @@ struct bluetooth_plugin {
 	struct bluetooth_plugin_desc *desc;
 };
 
-static gint compare_priority(gconstpointer a, gconstpointer b)
+static int compare_priority(gconstpointer a, gconstpointer b)
 {
 	const struct bluetooth_plugin *plugin1 = a;
 	const struct bluetooth_plugin *plugin2 = b;
diff --git a/src/sdp-client.c b/src/sdp-client.c
index 106344a..fdf2b01 100644
--- a/src/sdp-client.c
+++ b/src/sdp-client.c
@@ -336,7 +336,7 @@ int bt_search_service(const bdaddr_t *src, const bdaddr_t *dst,
 	return 0;
 }
 
-static gint find_by_bdaddr(gconstpointer data, gconstpointer user_data)
+static int find_by_bdaddr(gconstpointer data, gconstpointer user_data)
 {
 	const struct search_context *ctxt = data, *search = user_data;
 	int ret;
diff --git a/src/service.c b/src/service.c
index 98fcbfe..aef9502 100644
--- a/src/service.c
+++ b/src/service.c
@@ -47,7 +47,7 @@
 #include "service.h"
 
 struct btd_service {
-	gint			ref;
+	int			ref;
 	struct btd_device	*device;
 	struct btd_profile	*profile;
 	void			*user_data;
diff --git a/src/shared/hciemu.c b/src/shared/hciemu.c
index 133f16f..463ef52 100644
--- a/src/shared/hciemu.c
+++ b/src/shared/hciemu.c
@@ -41,7 +41,7 @@
 #include "hciemu.h"
 
 struct hciemu {
-	gint ref_count;
+	int ref_count;
 	enum btdev_type btdev_type;
 	struct bthost *host_stack;
 	struct btdev *master_dev;
diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index ca4b05f..2c79886 100644
--- a/src/shared/mgmt.c
+++ b/src/shared/mgmt.c
@@ -94,7 +94,7 @@ static void destroy_request(gpointer data, gpointer user_data)
 	g_free(request);
 }
 
-static gint compare_request_id(gconstpointer a, gconstpointer b)
+static int compare_request_id(gconstpointer a, gconstpointer b)
 {
 	const struct mgmt_request *request = a;
 	unsigned int id = GPOINTER_TO_UINT(b);
@@ -112,7 +112,7 @@ static void destroy_notify(gpointer data, gpointer user_data)
 	g_free(notify);
 }
 
-static gint compare_notify_id(gconstpointer a, gconstpointer b)
+static int compare_notify_id(gconstpointer a, gconstpointer b)
 {
 	const struct mgmt_notify *notify = a;
 	unsigned int id = GPOINTER_TO_UINT(b);
-- 
1.8.2.2

