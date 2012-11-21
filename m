Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5] device: Retrieve device pnp ids from storage
Date: Wed, 21 Nov 2012 14:49:51 +0100
Message-Id: <1353505791-21134-5-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1353505791-21134-1-git-send-email-frederic.danis@linux.intel.com>
References: <1353505791-21134-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When device pnp ids are updated, save them and emit property
changed signals.
---
 src/device.c |   51 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/src/device.c b/src/device.c
index d4a553d..4559674 100644
--- a/src/device.c
+++ b/src/device.c
@@ -236,6 +236,17 @@ static gboolean store_device_info_cb(gpointer user_data)
 	g_key_file_set_boolean(key_file, "General", "Blocked",
 							device->blocked);
 
+	if (device->vendor_src) {
+		g_key_file_set_integer(key_file, "DeviceID", "Source",
+					device->vendor_src);
+		g_key_file_set_integer(key_file, "DeviceID", "Vendor",
+					device->vendor);
+		g_key_file_set_integer(key_file, "DeviceID", "Product",
+					device->product);
+		g_key_file_set_integer(key_file, "DeviceID", "Version",
+					device->version);
+	}
+
 	ba2str(adapter_get_address(device->adapter), adapter_addr);
 	ba2str(&device->bdaddr, device_addr);
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info", adapter_addr,
@@ -1766,6 +1777,7 @@ static void load_info(struct btd_device *device, const gchar *local,
 	char *str;
 	gboolean store_needed = FALSE;
 	gboolean blocked;
+	int source, vendor, product, version;
 
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info", local, peer);
 	filename[PATH_MAX] = '\0';
@@ -1811,6 +1823,24 @@ static void load_info(struct btd_device *device, const gchar *local,
 	if (blocked)
 		device_block(device, FALSE);
 
+	/* Load device id */
+	source = g_key_file_get_integer(key_file, "DeviceID", "Source", NULL);
+	if (source) {
+		device_set_vendor_src(device, source);
+
+		vendor = g_key_file_get_integer(key_file, "DeviceID",
+							"Vendor", NULL);
+		device_set_vendor(device, vendor);
+
+		product = g_key_file_get_integer(key_file, "DeviceID",
+							"Product", NULL);
+		device_set_product(device, product);
+
+		version = g_key_file_get_integer(key_file, "DeviceID",
+							"Version", NULL);
+		device_set_version(device, version);
+	}
+
 	if (store_needed)
 		store_device_info(device);
 
@@ -1825,7 +1855,6 @@ struct btd_device *device_create(struct btd_adapter *adapter,
 	const gchar *adapter_path = adapter_get_path(adapter);
 	const bdaddr_t *src;
 	char srcaddr[18];
-	uint16_t vendor, product, version;
 
 	device = g_try_malloc0(sizeof(struct btd_device));
 	if (device == NULL)
@@ -1867,13 +1896,6 @@ struct btd_device *device_create(struct btd_adapter *adapter,
 		device_set_bonded(device, TRUE);
 	}
 
-	if (read_device_id(srcaddr, address, bdaddr_type, NULL, &vendor,
-						&product, &version) == 0) {
-		device_set_vendor(device, vendor);
-		device_set_product(device, product);
-		device_set_version(device, version);
-	}
-
 	return btd_device_ref(device);
 }
 
@@ -2320,22 +2342,15 @@ static void update_bredr_services(struct browse_req *req, sdp_list_t *recs)
 			pdlist = sdp_data_get(rec, SDP_ATTR_VENDOR_ID);
 			vendor = pdlist ? pdlist->val.uint16 : 0x0000;
 
-			device_set_vendor(device, vendor);
-
 			pdlist = sdp_data_get(rec, SDP_ATTR_PRODUCT_ID);
 			product = pdlist ? pdlist->val.uint16 : 0x0000;
 
-			device_set_product(device, product);
-
 			pdlist = sdp_data_get(rec, SDP_ATTR_VERSION);
 			version = pdlist ? pdlist->val.uint16 : 0x0000;
 
-			device_set_version(device, version);
-
 			if (source || vendor || product || version)
-				store_device_id(srcaddr, dstaddr,
-						device->bdaddr_type, source,
-						vendor, product, version);
+				device_set_pnpid(device, source, vendor,
+							product, version);
 		}
 
 		/* Check for duplicates */
@@ -4094,4 +4109,6 @@ void device_set_pnpid(struct btd_device *device, uint8_t vendor_id_src,
 	device_set_vendor_src(device, vendor_id_src);
 	device_set_product(device, product_id);
 	device_set_version(device, product_ver);
+
+	store_device_info(device);
 }
-- 
1.7.9.5

