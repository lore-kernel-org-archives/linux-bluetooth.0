Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 06/16] thermometer: Remove boilerplate code
Date: Tue, 25 Jun 2013 18:24:39 +0200
Message-Id: <1372177489-6858-7-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1372177489-6858-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1372177489-6858-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The helper fuctions to adapt btd_profile signatures with internal APIs
add boilerplate code of little use, so remove them.
---
 profiles/thermometer/thermometer.c | 51 ++++++++++----------------------------
 1 file changed, 13 insertions(+), 38 deletions(-)

diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index 44f5e79..034e50b 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -1162,14 +1162,19 @@ static void attio_disconnected_cb(gpointer user_data)
 	t->attrib = NULL;
 }
 
-static int thermometer_register(struct btd_device *device,
-						struct gatt_primary *tattr)
+static int thermometer_device_probe(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	const char *path = device_get_path(device);
+	struct gatt_primary *tattr;
 	struct thermometer *t;
 	struct btd_adapter *adapter;
 	struct thermometer_adapter *tadapter;
 
+	tattr = btd_device_get_primary(device, HEALTH_THERMOMETER_UUID);
+	if (tattr == NULL)
+		return -EINVAL;
+
 	adapter = device_get_adapter(device);
 
 	tadapter = find_thermometer_adapter(adapter);
@@ -1201,8 +1206,9 @@ static int thermometer_register(struct btd_device *device,
 	return 0;
 }
 
-static void thermometer_unregister(struct btd_device *device)
+static void thermometer_device_remove(struct btd_service *service)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	struct thermometer *t;
 	struct btd_adapter *adapter;
 	struct thermometer_adapter *tadapter;
@@ -1243,8 +1249,9 @@ static const GDBusMethodTable thermometer_manager_methods[] = {
 	{ }
 };
 
-static int thermometer_adapter_register(struct btd_adapter *adapter)
+static int thermometer_adapter_probe(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
 	struct thermometer_adapter *tadapter;
 
 	tadapter = g_new0(struct thermometer_adapter, 1);
@@ -1267,8 +1274,9 @@ static int thermometer_adapter_register(struct btd_adapter *adapter)
 	return 0;
 }
 
-static void thermometer_adapter_unregister(struct btd_adapter *adapter)
+static void thermometer_adapter_remove(struct btd_server *server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(server);
 	struct thermometer_adapter *tadapter;
 
 	tadapter = find_thermometer_adapter(adapter);
@@ -1282,39 +1290,6 @@ static void thermometer_adapter_unregister(struct btd_adapter *adapter)
 					THERMOMETER_MANAGER_INTERFACE);
 }
 
-static int thermometer_device_probe(struct btd_service *service)
-{
-	struct btd_device *device = btd_service_get_device(service);
-	struct gatt_primary *tattr;
-
-	tattr = btd_device_get_primary(device, HEALTH_THERMOMETER_UUID);
-	if (tattr == NULL)
-		return -EINVAL;
-
-	return thermometer_register(device, tattr);
-}
-
-static void thermometer_device_remove(struct btd_service *service)
-{
-	struct btd_device *device = btd_service_get_device(service);
-
-	thermometer_unregister(device);
-}
-
-static int thermometer_adapter_probe(struct btd_server *server)
-{
-	struct btd_adapter *adapter = btd_server_get_adapter(server);
-
-	return thermometer_adapter_register(adapter);
-}
-
-static void thermometer_adapter_remove(struct btd_server *server)
-{
-	struct btd_adapter *adapter = btd_server_get_adapter(server);
-
-	thermometer_adapter_unregister(adapter);
-}
-
 static struct btd_profile thermometer_profile = {
 	.name		= "Health Thermometer GATT driver",
 	.remote_uuid	= HEALTH_THERMOMETER_UUID,
-- 
1.8.1.4

