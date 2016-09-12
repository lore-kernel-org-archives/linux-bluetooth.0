Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/8] gap: Implement disconnect callback
Date: Mon, 12 Sep 2016 17:07:35 +0300
Message-Id: <1473689259-9523-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1473689259-9523-1-git-send-email-luiz.dentz@gmail.com>
References: <1473689259-9523-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implements the profile disconnect callback using it to cleanup
existing references of bt_gatt_client and gatt_db.
---
 profiles/gap/gas.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/profiles/gap/gas.c b/profiles/gap/gas.c
index 93a9a6d..2077ed9 100644
--- a/profiles/gap/gas.c
+++ b/profiles/gap/gas.c
@@ -251,6 +251,15 @@ static void foreach_gap_service(struct gatt_db_attribute *attr, void *user_data)
 	handle_gap_service(gas);
 }
 
+static void gas_reset(struct gas *gas)
+{
+	gas->attr = NULL;
+	gatt_db_unref(gas->db);
+	gas->db = NULL;
+	bt_gatt_client_unref(gas->client);
+	gas->client = NULL;
+}
+
 static int gap_driver_accept(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
@@ -268,11 +277,6 @@ static int gap_driver_accept(struct btd_service *service)
 		return -1;
 	}
 
-	/* Clean-up any old client/db and acquire the new ones */
-	gas->attr = NULL;
-	gatt_db_unref(gas->db);
-	bt_gatt_client_unref(gas->client);
-
 	gas->db = gatt_db_ref(db);
 	gas->client = bt_gatt_client_ref(client);
 
@@ -282,6 +286,7 @@ static int gap_driver_accept(struct btd_service *service)
 
 	if (!gas->attr) {
 		error("GAP attribute not found");
+		gas_reset(gas);
 		return -1;
 	}
 
@@ -290,12 +295,24 @@ static int gap_driver_accept(struct btd_service *service)
 	return 0;
 }
 
+static int gap_disconnect(struct btd_service *service)
+{
+	struct gas *gas = btd_service_get_user_data(service);
+
+	gas_reset(gas);
+
+	btd_service_disconnecting_complete(service, 0);
+
+	return 0;
+}
+
 static struct btd_profile gap_profile = {
 	.name		= "gap-profile",
 	.remote_uuid	= GAP_UUID,
 	.device_probe	= gap_driver_probe,
 	.device_remove	= gap_driver_remove,
-	.accept		= gap_driver_accept
+	.accept		= gap_driver_accept,
+	.disconnect	= gap_disconnect,
 };
 
 static int gap_init(void)
-- 
2.7.4

