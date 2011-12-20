Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 8/8] gatt-example: Use adapter driver to register GATT attributes
Date: Tue, 20 Dec 2011 16:58:01 +0100
Message-Id: <1324396681-27276-9-git-send-email-sancane@gmail.com>
In-Reply-To: <1324396681-27276-8-git-send-email-sancane@gmail.com>
References: <1324396681-27276-1-git-send-email-sancane@gmail.com>
 <1324396681-27276-2-git-send-email-sancane@gmail.com>
 <1324396681-27276-3-git-send-email-sancane@gmail.com>
 <1324396681-27276-4-git-send-email-sancane@gmail.com>
 <1324396681-27276-5-git-send-email-sancane@gmail.com>
 <1324396681-27276-6-git-send-email-sancane@gmail.com>
 <1324396681-27276-7-git-send-email-sancane@gmail.com>
 <1324396681-27276-8-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

GATT servers should register their attributes on each adapter when
it is plugged instead of doing that when the plugins is loaded. This
patch registers a new adapter driver to manage plug and unplug
events in order to register attributes in each GATT served managed
in each adapter.
---
 plugins/gatt-example.c |   98 ++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 79 insertions(+), 19 deletions(-)

diff --git a/plugins/gatt-example.c b/plugins/gatt-example.c
index 6d9b6b8..4e8f36f 100644
--- a/plugins/gatt-example.c
+++ b/plugins/gatt-example.c
@@ -29,6 +29,7 @@
 #include <glib.h>
 #include <bluetooth/uuid.h>
 #include <errno.h>
+#include <adapter.h>
 
 #include "plugin.h"
 #include "hcid.h"
@@ -57,7 +58,39 @@
 #define FMT_KILOGRAM_UUID		0xA010
 #define FMT_HANGING_UUID		0xA011
 
-static GSList *sdp_handles = NULL;
+struct gatt_example_adapter {
+	struct btd_adapter	*adapter;
+	GSList			*sdp_handles;
+};
+
+static GSList *adapters = NULL;
+
+static void gatt_example_adapter_free(struct gatt_example_adapter *gadapter)
+{
+	while (gadapter->sdp_handles != NULL) {
+		uint32_t handle = GPOINTER_TO_UINT(gadapter->sdp_handles->data);
+
+		attrib_free_sdp(handle);
+		gadapter->sdp_handles = g_slist_remove(gadapter->sdp_handles,
+						gadapter->sdp_handles->data);
+	}
+
+	if (gadapter->adapter != NULL)
+		btd_adapter_unref(gadapter->adapter);
+
+	g_free(gadapter);
+}
+
+static gint adapter_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct gatt_example_adapter *gatt_adapter = a;
+	const struct btd_adapter *adapter = b;
+
+	if (gatt_adapter->adapter == adapter)
+		return 0;
+
+	return -1;
+}
 
 static uint8_t battery_state_read(struct attribute *a, gpointer user_data)
 {
@@ -81,8 +114,8 @@ static gboolean register_battery_service(void)
 			GATT_OPT_INVALID);
 }
 
-static void register_termometer_service(const uint16_t manuf1[2],
-						const uint16_t manuf2[2])
+static void register_termometer_service(struct gatt_example_adapter *adapter,
+			const uint16_t manuf1[2], const uint16_t manuf2[2])
 {
 	const char *desc_out_temp = "Outside Temperature";
 	const char *desc_out_hum = "Outside Relative Humidity";
@@ -189,7 +222,7 @@ static void register_termometer_service(const uint16_t manuf1[2],
 	/* Add an SDP record for the above service */
 	sdp_handle = attrib_create_sdp(start_handle, "Thermometer");
 	if (sdp_handle)
-		sdp_handles = g_slist_prepend(sdp_handles,
+		adapter->sdp_handles = g_slist_prepend(adapter->sdp_handles,
 						GUINT_TO_POINTER(sdp_handle));
 }
 
@@ -352,7 +385,8 @@ static void register_vendor_service(uint16_t range[2])
 	range[1] = start_handle + svc_size - 1;
 }
 
-static void register_weight_service(const uint16_t vendor[2])
+static void register_weight_service(struct gatt_example_adapter *adapter,
+						const uint16_t vendor[2])
 {
 	const char *desc_weight = "Rucksack Weight";
 	const uint128_t char_weight_uuid_btorder = {
@@ -432,45 +466,71 @@ static void register_weight_service(const uint16_t vendor[2])
 	/* Add an SDP record for the above service */
 	sdp_handle = attrib_create_sdp(start_handle, "Weight Service");
 	if (sdp_handle)
-		sdp_handles = g_slist_prepend(sdp_handles,
+		adapter->sdp_handles = g_slist_prepend(adapter->sdp_handles,
 						GUINT_TO_POINTER(sdp_handle));
 }
 
-static int gatt_example_init(void)
+static int gatt_example_adapter_probe(struct btd_adapter *adapter)
 {
 	uint16_t manuf1_range[2] = {0, 0}, manuf2_range[2] = {0, 0};
 	uint16_t vendor_range[2] = {0, 0};
+	struct gatt_example_adapter *gadapter;
 
-	if (!main_opts.attrib_server) {
-		DBG("Attribute server is disabled");
-		return -1;
-	}
+	gadapter = g_new0(struct gatt_example_adapter, 1);
+	gadapter->adapter = btd_adapter_ref(adapter);
 
 	if (!register_battery_service()) {
 		DBG("Battery service could not be registered");
+		gatt_example_adapter_free(gadapter);
 		return -EIO;
 	}
 
 	register_manuf1_service(manuf1_range);
 	register_manuf2_service(manuf2_range);
-	register_termometer_service(manuf1_range, manuf2_range);
+	register_termometer_service(gadapter, manuf1_range, manuf2_range);
 	register_vendor_service(vendor_range);
-	register_weight_service(vendor_range);
+	register_weight_service(gadapter, vendor_range);
+
+	adapters = g_slist_append(adapters, gadapter);
 
 	return 0;
 }
 
-static void gatt_example_exit(void)
+static void gatt_example_adapter_remove(struct btd_adapter *adapter)
 {
-	if (!main_opts.attrib_server)
+	struct gatt_example_adapter *gadapter;
+	GSList *l;
+
+	l = g_slist_find_custom(adapters, adapter, adapter_cmp);
+	if (l == NULL)
 		return;
 
-	while (sdp_handles) {
-		uint32_t handle = GPOINTER_TO_UINT(sdp_handles->data);
+	gadapter = l->data;
+	gatt_example_adapter_free(gadapter);
+}
 
-		attrib_free_sdp(handle);
-		sdp_handles = g_slist_remove(sdp_handles, sdp_handles->data);
+static struct btd_adapter_driver gatt_example_adapter_driver = {
+	.name	= "gatt-example-adapter-driver",
+	.probe	= gatt_example_adapter_probe,
+	.remove	= gatt_example_adapter_remove,
+};
+
+static int gatt_example_init(void)
+{
+	if (!main_opts.attrib_server) {
+		DBG("Attribute server is disabled");
+		return -ENOTSUP;
 	}
+
+	return btd_register_adapter_driver(&gatt_example_adapter_driver);
+}
+
+static void gatt_example_exit(void)
+{
+	if (!main_opts.attrib_server)
+		return;
+
+	btd_unregister_adapter_driver(&gatt_example_adapter_driver);
 }
 
 BLUETOOTH_PLUGIN_DEFINE(gatt_example, VERSION, BLUETOOTH_PLUGIN_PRIORITY_LOW,
-- 
1.7.8

