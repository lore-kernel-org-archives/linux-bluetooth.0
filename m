Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 1/8] attrib-server: Add blutooth adapter to attrib_db_find_avail function
Date: Wed, 28 Dec 2011 11:24:43 +0100
Message-Id: <1325067890-6953-2-git-send-email-sancane@gmail.com>
In-Reply-To: <1325067890-6953-1-git-send-email-sancane@gmail.com>
References: <1325067890-6953-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adapters manage their own list of handlers so we need to specify
the adapter where the handlers will be registered.
---
 attrib/gatt-service.c  |    4 +++-
 plugins/gatt-example.c |   25 ++++++++++++++-----------
 proximity/reporter.c   |   10 +++++++---
 src/attrib-server.c    |   10 +++++-----
 src/attrib-server.h    |    2 +-
 time/server.c          |    1 +
 6 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/attrib/gatt-service.c b/attrib/gatt-service.c
index b904ce6..327569f 100644
--- a/attrib/gatt-service.c
+++ b/attrib/gatt-service.c
@@ -29,6 +29,7 @@
 #include <glib.h>
 #include <bluetooth/uuid.h>
 #include <bluetooth/sdp.h>
+#include <adapter.h>
 
 #include "att.h"
 #include "gattrib.h"
@@ -262,7 +263,8 @@ gboolean gatt_service_add(uint16_t uuid, uint16_t svc_uuid, gatt_option opt1, ..
 	}
 	va_end(args);
 
-	start_handle = attrib_db_find_avail(size);
+	/* FIXME: Provide the adapter in next function */
+	start_handle = attrib_db_find_avail(NULL, size);
 	if (start_handle == 0) {
 		error("Not enough free handles to register service");
 		g_slist_free_full(chrs, free_gatt_info);
diff --git a/plugins/gatt-example.c b/plugins/gatt-example.c
index 4e8f36f..4aa5a8b 100644
--- a/plugins/gatt-example.c
+++ b/plugins/gatt-example.c
@@ -126,7 +126,7 @@ static void register_termometer_service(struct gatt_example_adapter *adapter,
 	bt_uuid_t uuid;
 	int len;
 
-	start_handle = attrib_db_find_avail(svc_size);
+	start_handle = attrib_db_find_avail(adapter->adapter, svc_size);
 	if (start_handle == 0) {
 		error("Not enough free handles to register service");
 		return;
@@ -226,7 +226,8 @@ static void register_termometer_service(struct gatt_example_adapter *adapter,
 						GUINT_TO_POINTER(sdp_handle));
 }
 
-static void register_manuf1_service(uint16_t range[2])
+static void register_manuf1_service(struct gatt_example_adapter *adapter,
+							uint16_t range[2])
 {
 	const char *manufacturer_name1 = "ACME Temperature Sensor";
 	const char *serial1 = "237495-3282-A";
@@ -236,7 +237,7 @@ static void register_manuf1_service(uint16_t range[2])
 	bt_uuid_t uuid;
 	int len;
 
-	start_handle = attrib_db_find_avail(svc_size);
+	start_handle = attrib_db_find_avail(adapter->adapter, svc_size);
 	if (start_handle == 0) {
 		error("Not enough free handles to register service");
 		return;
@@ -283,7 +284,8 @@ static void register_manuf1_service(uint16_t range[2])
 	range[1] = start_handle + svc_size - 1;
 }
 
-static void register_manuf2_service(uint16_t range[2])
+static void register_manuf2_service(struct gatt_example_adapter *adapter,
+							uint16_t range[2])
 {
 	const char *manufacturer_name2 = "ACME Weighing Scales";
 	const char *serial2 = "11267-2327A00239";
@@ -293,7 +295,7 @@ static void register_manuf2_service(uint16_t range[2])
 	bt_uuid_t uuid;
 	int len;
 
-	start_handle = attrib_db_find_avail(svc_size);
+	start_handle = attrib_db_find_avail(adapter->adapter, svc_size);
 	if (start_handle == 0) {
 		error("Not enough free handles to register service");
 		return;
@@ -340,14 +342,15 @@ static void register_manuf2_service(uint16_t range[2])
 	range[1] = start_handle + svc_size - 1;
 }
 
-static void register_vendor_service(uint16_t range[2])
+static void register_vendor_service(struct gatt_example_adapter *adapter,
+							uint16_t range[2])
 {
 	uint16_t start_handle, h;
 	const int svc_size = 3;
 	uint8_t atval[256];
 	bt_uuid_t uuid;
 
-	start_handle = attrib_db_find_avail(svc_size);
+	start_handle = attrib_db_find_avail(adapter->adapter, svc_size);
 	if (start_handle == 0) {
 		error("Not enough free handles to register service");
 		return;
@@ -405,7 +408,7 @@ static void register_weight_service(struct gatt_example_adapter *adapter,
 
 	btoh128(&char_weight_uuid_btorder, &char_weight_uuid);
 
-	start_handle = attrib_db_find_avail(svc_size);
+	start_handle = attrib_db_find_avail(adapter->adapter, svc_size);
 	if (start_handle == 0) {
 		error("Not enough free handles to register service");
 		return;
@@ -485,10 +488,10 @@ static int gatt_example_adapter_probe(struct btd_adapter *adapter)
 		return -EIO;
 	}
 
-	register_manuf1_service(manuf1_range);
-	register_manuf2_service(manuf2_range);
+	register_manuf1_service(gadapter, manuf1_range);
+	register_manuf2_service(gadapter, manuf2_range);
 	register_termometer_service(gadapter, manuf1_range, manuf2_range);
-	register_vendor_service(vendor_range);
+	register_vendor_service(gadapter, vendor_range);
 	register_weight_service(gadapter, vendor_range);
 
 	adapters = g_slist_append(adapters, gadapter);
diff --git a/proximity/reporter.c b/proximity/reporter.c
index 77a7dcd..050b1c7 100644
--- a/proximity/reporter.c
+++ b/proximity/reporter.c
@@ -28,6 +28,7 @@
 
 #include <glib.h>
 #include <bluetooth/uuid.h>
+#include <adapter.h>
 
 #include "log.h"
 
@@ -58,7 +59,8 @@ static void register_link_loss(void)
 	uint8_t atval[256];
 	bt_uuid_t uuid;
 
-	start_handle = attrib_db_find_avail(svc_size);
+	/* FIXME: Provide the adapter in next function */
+	start_handle = attrib_db_find_avail(NULL, svc_size);
 	if (start_handle == 0) {
 		error("Not enough free handles to register service");
 		return;
@@ -95,7 +97,8 @@ static void register_tx_power(void)
 	uint8_t atval[256];
 	bt_uuid_t uuid;
 
-	start_handle = attrib_db_find_avail(svc_size);
+	/* FIXME: Provide the adapter in next function */
+	start_handle = attrib_db_find_avail(NULL, svc_size);
 	if (start_handle == 0) {
 		error("Not enough free handles to register service");
 		return;
@@ -139,7 +142,8 @@ static void register_immediate_alert(void)
 	uint8_t atval[256];
 	bt_uuid_t uuid;
 
-	start_handle = attrib_db_find_avail(svc_size);
+	/* FIXME: Provide the adapter in next function */
+	start_handle = attrib_db_find_avail(NULL, svc_size);
 	if (start_handle == 0) {
 		error("Not enough free handles to register service");
 		return;
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 3a3eebb..ccb7b34 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -1281,20 +1281,20 @@ void attrib_free_sdp(uint32_t sdp_handle)
 	remove_record_from_server(sdp_handle);
 }
 
-uint16_t attrib_db_find_avail(uint16_t nitems)
+uint16_t attrib_db_find_avail(struct btd_adapter *adapter, uint16_t nitems)
 {
 	struct gatt_server *server;
 	uint16_t handle;
 	GSList *l;
 
-	DBG("Deprecated function!");
-
 	g_assert(nitems > 0);
 
-	server = get_default_gatt_server();
-	if (server == NULL)
+	l = g_slist_find_custom(servers, adapter, adapter_cmp);
+	if (l == NULL)
 		return 0;
 
+	server = l->data;
+
 	for (l = server->database, handle = 0; l; l = l->next) {
 		struct attribute *a = l->data;
 
diff --git a/src/attrib-server.h b/src/attrib-server.h
index 943096c..8bf9c07 100644
--- a/src/attrib-server.h
+++ b/src/attrib-server.h
@@ -22,7 +22,7 @@
  *
  */
 
-uint16_t attrib_db_find_avail(uint16_t nitems);
+uint16_t attrib_db_find_avail(struct btd_adapter *adapter, uint16_t nitems);
 struct attribute *attrib_db_add(uint16_t handle, bt_uuid_t *uuid, int read_reqs,
 				int write_reqs, const uint8_t *value, int len);
 int attrib_db_update(uint16_t handle, bt_uuid_t *uuid, const uint8_t *value,
diff --git a/time/server.c b/time/server.c
index 5c32dc2..5636cca 100644
--- a/time/server.c
+++ b/time/server.c
@@ -30,6 +30,7 @@
 #include <time.h>
 #include <errno.h>
 #include <bluetooth/uuid.h>
+#include <adapter.h>
 
 #include "att.h"
 #include "gattrib.h"
-- 
1.7.8.1

