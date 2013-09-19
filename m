Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 8/8] sdp: Decouple Device ID profile implementation
Date: Thu, 19 Sep 2013 16:11:50 +0200
Message-ID: <1379599910-8666-1-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1379599248-7923-9-git-send-email-szymon.janc@tieto.com>
References: <1379599248-7923-9-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make DeviceID profile similar to other profiles implementations. Use
btd_profile for handling DeviceID profile while adding/removing
adapters. The nice drawback is that SDP code no longer depends on
main_opts.
---

Fixed missing g_slist_remove.

 Makefile.plugins             |   3 +
 profiles/deviceid/deviceid.c | 189 +++++++++++++++++++++++++++++++++++++++++++
 src/adapter.c                |  26 +++---
 src/adapter.h                |   3 +
 src/sdpd-server.c            |   4 -
 src/sdpd-service.c           |  58 -------------
 src/sdpd.h                   |   2 -
 7 files changed, 206 insertions(+), 79 deletions(-)
 create mode 100644 profiles/deviceid/deviceid.c

diff --git a/Makefile.plugins b/Makefile.plugins
index 7c5f71d..df5d2a1 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -82,6 +82,9 @@ builtin_sources += profiles/scanparam/scan.c
 builtin_modules += deviceinfo
 builtin_sources += profiles/deviceinfo/deviceinfo.c
 
+builtin_modules += deviceid
+builtin_sources += profiles/deviceid/deviceid.c
+
 if EXPERIMENTAL
 builtin_modules += alert
 builtin_sources += profiles/alert/server.c
diff --git a/profiles/deviceid/deviceid.c b/profiles/deviceid/deviceid.c
new file mode 100644
index 0000000..1ace475
--- /dev/null
+++ b/profiles/deviceid/deviceid.c
@@ -0,0 +1,189 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2013  Intel Corporation
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <bluetooth/sdp.h>
+#include <bluetooth/sdp_lib.h>
+
+#include <glib.h>
+
+#include "sdpd.h"
+#include "hcid.h"
+#include "adapter.h"
+#include "profile.h"
+#include "plugin.h"
+#include "log.h"
+
+struct deviceid_adapter {
+	struct btd_adapter *adapter;
+	uint32_t handle;
+};
+
+static GSList *deviceid_adapters = NULL;
+
+static struct deviceid_adapter *find_adapter(struct btd_adapter *adapter)
+{
+	GSList *list;
+
+	for (list = deviceid_adapters; list; list = list->next) {
+		struct deviceid_adapter *da = list->data;
+
+		if (da->adapter == adapter)
+			return da;
+	}
+
+	return NULL;
+}
+
+static sdp_record_t *create_record(uint16_t source, uint16_t vendor,
+					uint16_t product, uint16_t version)
+{
+	const uint16_t spec = 0x0103;
+	const uint8_t primary = 1;
+	sdp_list_t *class_list, *group_list, *profile_list;
+	uuid_t class_uuid, group_uuid;
+	sdp_data_t *sdp_data, *primary_data, *source_data;
+	sdp_data_t *spec_data, *vendor_data, *product_data, *version_data;
+	sdp_profile_desc_t profile;
+	sdp_record_t *record = sdp_record_alloc();
+
+	DBG("%04x:%04x:%04x:%04x", source, vendor, product, version);
+
+	record->handle = sdp_next_handle();
+
+	sdp_data = sdp_data_alloc(SDP_UINT32, &record->handle);
+	sdp_attr_add(record, SDP_ATTR_RECORD_HANDLE, sdp_data);
+
+	sdp_uuid16_create(&class_uuid, PNP_INFO_SVCLASS_ID);
+	class_list = sdp_list_append(0, &class_uuid);
+	sdp_set_service_classes(record, class_list);
+	sdp_list_free(class_list, NULL);
+
+	sdp_uuid16_create(&group_uuid, PUBLIC_BROWSE_GROUP);
+	group_list = sdp_list_append(NULL, &group_uuid);
+	sdp_set_browse_groups(record, group_list);
+	sdp_list_free(group_list, NULL);
+
+	sdp_uuid16_create(&profile.uuid, PNP_INFO_PROFILE_ID);
+	profile.version = spec;
+	profile_list = sdp_list_append(NULL, &profile);
+	sdp_set_profile_descs(record, profile_list);
+	sdp_list_free(profile_list, NULL);
+
+	spec_data = sdp_data_alloc(SDP_UINT16, &spec);
+	sdp_attr_add(record, 0x0200, spec_data);
+
+	vendor_data = sdp_data_alloc(SDP_UINT16, &vendor);
+	sdp_attr_add(record, 0x0201, vendor_data);
+
+	product_data = sdp_data_alloc(SDP_UINT16, &product);
+	sdp_attr_add(record, 0x0202, product_data);
+
+	version_data = sdp_data_alloc(SDP_UINT16, &version);
+	sdp_attr_add(record, 0x0203, version_data);
+
+	primary_data = sdp_data_alloc(SDP_BOOL, &primary);
+	sdp_attr_add(record, 0x0204, primary_data);
+
+	source_data = sdp_data_alloc(SDP_UINT16, &source);
+	sdp_attr_add(record, 0x0205, source_data);
+
+	return record;
+}
+
+static int deviceid_adapter_probe(struct btd_profile *p,
+						struct btd_adapter *adapter)
+{
+	struct deviceid_adapter *dadapter;
+	sdp_record_t *rec;
+	int ret;
+
+	DBG("path %s", adapter_get_path(adapter));
+
+	rec = create_record(main_opts.did_source, main_opts.did_vendor,
+				main_opts.did_product, main_opts.did_version);
+
+	ret = adapter_service_add(adapter, rec);
+	if (ret < 0) {
+		sdp_record_free(rec);
+		return ret;
+	}
+
+	btd_adapter_set_did(adapter, main_opts.did_source, main_opts.did_vendor,
+				main_opts.did_product, main_opts.did_version);
+
+	dadapter = g_new0(struct deviceid_adapter, 1);
+	dadapter->adapter = btd_adapter_ref(adapter);
+	dadapter->handle = rec->handle;
+
+	deviceid_adapters = g_slist_prepend(deviceid_adapters, dadapter);
+
+	return 0;
+}
+
+static void deviceid_adapter_remove(struct btd_profile *p,
+						struct btd_adapter *adapter)
+{
+	struct deviceid_adapter *dadapter;
+
+	DBG("path %s", adapter_get_path(adapter));
+
+	dadapter = find_adapter(adapter);
+	if (!dadapter)
+		return;
+
+	deviceid_adapters = g_slist_remove(deviceid_adapters, dadapter);
+
+	adapter_service_remove(dadapter->adapter, dadapter->handle);
+
+	btd_adapter_unref(dadapter->adapter);
+	g_free(dadapter);
+}
+
+struct btd_profile deviceid_profile = {
+	.name		= "deviceid",
+	.adapter_probe	= deviceid_adapter_probe,
+	.adapter_remove	= deviceid_adapter_remove,
+};
+
+static int deviceid_init(void)
+{
+	if (main_opts.did_source == 0) {
+		info("Device ID information disabled");
+		return -1;
+	}
+
+	return btd_profile_register(&deviceid_profile);
+}
+
+static void deviceid_exit(void)
+{
+	btd_profile_unregister(&deviceid_profile);
+}
+
+BLUETOOTH_PLUGIN_DEFINE(deviceid, VERSION,
+			BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+			deviceid_init, deviceid_exit)
diff --git a/src/adapter.c b/src/adapter.c
index b99bff9..ed4824c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3929,17 +3929,12 @@ static struct btd_adapter *btd_adapter_new(uint16_t index)
 	adapter->system_name = g_strdup(main_opts.name);
 	adapter->major_class = (main_opts.class & 0x001f00) >> 8;
 	adapter->minor_class = (main_opts.class & 0x0000fc) >> 2;
-	adapter->modalias = bt_modalias(main_opts.did_source,
-						main_opts.did_vendor,
-						main_opts.did_product,
-						main_opts.did_version);
 	adapter->discoverable_timeout = main_opts.discovto;
 	adapter->pairable_timeout = main_opts.pairto;
 
 	DBG("System name: %s", adapter->system_name);
 	DBG("Major class: %u", adapter->major_class);
 	DBG("Minor class: %u", adapter->minor_class);
-	DBG("Modalias: %s", adapter->modalias);
 	DBG("Discoverable timeout: %u seconds", adapter->discoverable_timeout);
 	DBG("Pairable timeout: %u seconds", adapter->pairable_timeout);
 
@@ -5566,14 +5561,23 @@ void adapter_foreach(adapter_cb func, gpointer user_data)
 	g_slist_foreach(adapters, (GFunc) func, user_data);
 }
 
-static int set_did(struct btd_adapter *adapter, uint16_t vendor,
-			uint16_t product, uint16_t version, uint16_t source)
+int btd_adapter_set_did(struct btd_adapter *adapter,
+					uint16_t source, uint16_t vendor,
+					uint16_t product, uint16_t version)
 {
 	struct mgmt_cp_set_device_id cp;
 
 	DBG("hci%u source %x vendor %x product %x version %x",
 			adapter->dev_id, source, vendor, product, version);
 
+	g_free(adapter->modalias);
+	adapter->modalias = bt_modalias(source, vendor, product, version);
+
+	DBG("Modalias: %s", adapter->modalias);
+
+	g_dbus_emit_property_changed(dbus_conn, adapter->path,
+						ADAPTER_INTERFACE, "Modalias");
+
 	memset(&cp, 0, sizeof(cp));
 
 	cp.source = htobs(source);
@@ -5638,14 +5642,6 @@ static int adapter_register(struct btd_adapter *adapter)
 
 	adapter->initialized = TRUE;
 
-	if (main_opts.did_source) {
-		/* DeviceID record is added by sdpd-server before any other
-		 * record is registered. */
-		adapter_service_insert(adapter, sdp_record_find(0x10000));
-		set_did(adapter, main_opts.did_vendor, main_opts.did_product,
-				main_opts.did_version, main_opts.did_source);
-	}
-
 	DBG("Adapter %s registered", adapter->path);
 
 	return 0;
diff --git a/src/adapter.h b/src/adapter.h
index 5d124e7..a6fb340 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -113,6 +113,9 @@ void btd_adapter_unref(struct btd_adapter *adapter);
 
 void btd_adapter_set_class(struct btd_adapter *adapter, uint8_t major,
 							uint8_t minor);
+int btd_adapter_set_did(struct btd_adapter *adapter,
+					uint16_t source, uint16_t vendor,
+					uint16_t product, uint16_t version);
 
 struct btd_adapter_driver {
 	const char *name;
diff --git a/src/sdpd-server.c b/src/sdpd-server.c
index 7b1351f..de5aef1 100644
--- a/src/sdpd-server.c
+++ b/src/sdpd-server.c
@@ -238,10 +238,6 @@ int start_sdp_server(uint16_t mtu, uint32_t flags)
 		return -1;
 	}
 
-	if (main_opts.did_source > 0)
-		register_device_id(main_opts.did_source, main_opts.did_vendor,
-				main_opts.did_product, main_opts.did_version);
-
 	io = g_io_channel_unix_new(l2cap_sock);
 	g_io_channel_set_close_on_unref(io, TRUE);
 
diff --git a/src/sdpd-service.c b/src/sdpd-service.c
index 09f6c0a..2da70b5 100644
--- a/src/sdpd-service.c
+++ b/src/sdpd-service.c
@@ -176,64 +176,6 @@ void register_server_service(void)
 	update_db_timestamp();
 }
 
-void register_device_id(uint16_t source, uint16_t vendor,
-					uint16_t product, uint16_t version)
-{
-	const uint16_t spec = 0x0103;
-	const uint8_t primary = 1;
-	sdp_list_t *class_list, *group_list, *profile_list;
-	uuid_t class_uuid, group_uuid;
-	sdp_data_t *sdp_data, *primary_data, *source_data;
-	sdp_data_t *spec_data, *vendor_data, *product_data, *version_data;
-	sdp_profile_desc_t profile;
-	sdp_record_t *record = sdp_record_alloc();
-
-	DBG("Adding device id record for %04x:%04x:%04x:%04x",
-					source, vendor, product, version);
-
-	record->handle = sdp_next_handle();
-
-	sdp_record_add(BDADDR_ANY, record);
-	sdp_data = sdp_data_alloc(SDP_UINT32, &record->handle);
-	sdp_attr_add(record, SDP_ATTR_RECORD_HANDLE, sdp_data);
-
-	sdp_uuid16_create(&class_uuid, PNP_INFO_SVCLASS_ID);
-	class_list = sdp_list_append(0, &class_uuid);
-	sdp_set_service_classes(record, class_list);
-	sdp_list_free(class_list, NULL);
-
-	sdp_uuid16_create(&group_uuid, PUBLIC_BROWSE_GROUP);
-	group_list = sdp_list_append(NULL, &group_uuid);
-	sdp_set_browse_groups(record, group_list);
-	sdp_list_free(group_list, NULL);
-
-	sdp_uuid16_create(&profile.uuid, PNP_INFO_PROFILE_ID);
-	profile.version = spec;
-	profile_list = sdp_list_append(NULL, &profile);
-	sdp_set_profile_descs(record, profile_list);
-	sdp_list_free(profile_list, NULL);
-
-	spec_data = sdp_data_alloc(SDP_UINT16, &spec);
-	sdp_attr_add(record, 0x0200, spec_data);
-
-	vendor_data = sdp_data_alloc(SDP_UINT16, &vendor);
-	sdp_attr_add(record, 0x0201, vendor_data);
-
-	product_data = sdp_data_alloc(SDP_UINT16, &product);
-	sdp_attr_add(record, 0x0202, product_data);
-
-	version_data = sdp_data_alloc(SDP_UINT16, &version);
-	sdp_attr_add(record, 0x0203, version_data);
-
-	primary_data = sdp_data_alloc(SDP_BOOL, &primary);
-	sdp_attr_add(record, 0x0204, primary_data);
-
-	source_data = sdp_data_alloc(SDP_UINT16, &source);
-	sdp_attr_add(record, 0x0205, source_data);
-
-	update_db_timestamp();
-}
-
 int add_record_to_server(const bdaddr_t *src, sdp_record_t *rec)
 {
 	sdp_data_t *data;
diff --git a/src/sdpd.h b/src/sdpd.h
index 3c6ee01..174a4d7 100644
--- a/src/sdpd.h
+++ b/src/sdpd.h
@@ -54,8 +54,6 @@ int service_update_req(sdp_req_t *req, sdp_buf_t *rsp);
 
 void register_public_browse_group(void);
 void register_server_service(void);
-void register_device_id(uint16_t source, uint16_t vendor,
-					uint16_t product, uint16_t version);
 
 int record_sort(const void *r1, const void *r2);
 void sdp_svcdb_reset(void);
-- 
1.8.4

