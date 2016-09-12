Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 8/8] deviceinfo: Use shorter names for profile callback
Date: Mon, 12 Sep 2016 17:07:39 +0300
Message-Id: <1473689259-9523-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1473689259-9523-1-git-send-email-luiz.dentz@gmail.com>
References: <1473689259-9523-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 profiles/deviceinfo/deviceinfo.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/profiles/deviceinfo/deviceinfo.c b/profiles/deviceinfo/deviceinfo.c
index 0ce7edb..fa94efe 100644
--- a/profiles/deviceinfo/deviceinfo.c
+++ b/profiles/deviceinfo/deviceinfo.c
@@ -111,17 +111,17 @@ static void foreach_deviceinfo_service(struct gatt_db_attribute *attr,
 	gatt_db_service_foreach_char(attr, handle_characteristic, device);
 }
 
-static int deviceinfo_driver_probe(struct btd_service *service)
+static int deviceinfo_probe(struct btd_service *service)
 {
 	return 0;
 }
 
-static void deviceinfo_driver_remove(struct btd_service *service)
+static void deviceinfo_remove(struct btd_service *service)
 {
 }
 
 
-static int deviceinfo_driver_accept(struct btd_service *service)
+static int deviceinfo_accept(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
 	struct gatt_db *db = btd_device_get_gatt_db(device);
@@ -152,9 +152,9 @@ static struct btd_profile deviceinfo_profile = {
 	.name		= "deviceinfo",
 	.remote_uuid	= DEVICE_INFORMATION_UUID,
 	.external	= true,
-	.device_probe	= deviceinfo_driver_probe,
-	.device_remove	= deviceinfo_driver_remove,
-	.accept		= deviceinfo_driver_accept,
+	.device_probe	= deviceinfo_probe,
+	.device_remove	= deviceinfo_remove,
+	.accept		= deviceinfo_accept,
 	.disconnect	= deviceinfo_disconnect,
 };
 
-- 
2.7.4

