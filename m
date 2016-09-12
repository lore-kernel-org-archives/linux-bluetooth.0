Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/8] gap: Use shorter names for profile callback
Date: Mon, 12 Sep 2016 17:07:36 +0300
Message-Id: <1473689259-9523-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1473689259-9523-1-git-send-email-luiz.dentz@gmail.com>
References: <1473689259-9523-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 profiles/gap/gas.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/profiles/gap/gas.c b/profiles/gap/gas.c
index 2077ed9..47c8c25 100644
--- a/profiles/gap/gas.c
+++ b/profiles/gap/gas.c
@@ -195,7 +195,7 @@ static void handle_gap_service(struct gas *gas)
 	gatt_db_service_foreach_char(gas->attr, handle_characteristic, gas);
 }
 
-static int gap_driver_probe(struct btd_service *service)
+static int gap_probe(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
 	struct gas *gas = btd_service_get_user_data(service);
@@ -220,7 +220,7 @@ static int gap_driver_probe(struct btd_service *service)
 	return 0;
 }
 
-static void gap_driver_remove(struct btd_service *service)
+static void gap_remove(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
 	struct gas *gas;
@@ -260,7 +260,7 @@ static void gas_reset(struct gas *gas)
 	gas->client = NULL;
 }
 
-static int gap_driver_accept(struct btd_service *service)
+static int gap_accept(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
 	struct gatt_db *db = btd_device_get_gatt_db(device);
@@ -309,9 +309,9 @@ static int gap_disconnect(struct btd_service *service)
 static struct btd_profile gap_profile = {
 	.name		= "gap-profile",
 	.remote_uuid	= GAP_UUID,
-	.device_probe	= gap_driver_probe,
-	.device_remove	= gap_driver_remove,
-	.accept		= gap_driver_accept,
+	.device_probe	= gap_probe,
+	.device_remove	= gap_remove,
+	.accept		= gap_accept,
 	.disconnect	= gap_disconnect,
 };
 
-- 
2.7.4

