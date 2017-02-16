Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Felipe F. Tonello" <eu@felipetonello.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 1/7] profiles/gap: Some code cleanup
Date: Thu, 16 Feb 2017 18:03:09 +0000
Message-Id: <20170216180315.30531-2-eu@felipetonello.com>
In-Reply-To: <20170216180315.30531-1-eu@felipetonello.com>
References: <20170216180315.30531-1-eu@felipetonello.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Just removing unecessary function and code duplication.
---
 profiles/gap/gas.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/profiles/gap/gas.c b/profiles/gap/gas.c
index 43b7c3d0ef07..0d34503ad446 100644
--- a/profiles/gap/gas.c
+++ b/profiles/gap/gas.c
@@ -57,10 +57,18 @@ struct gas {
 	struct gatt_db_attribute *attr;
 };
 
-static void gas_free(struct gas *gas)
+static void gas_reset(struct gas *gas)
 {
+	gas->attr = NULL;
 	gatt_db_unref(gas->db);
+	gas->db = NULL;
 	bt_gatt_client_unref(gas->client);
+	gas->client = NULL;
+}
+
+static void gas_free(struct gas *gas)
+{
+	gas_reset(gas);
 	btd_device_unref(gas->device);
 	g_free(gas);
 }
@@ -154,7 +162,7 @@ static void handle_appearance(struct gas *gas, uint16_t value_handle)
 		DBG("Failed to send request to read appearance");
 }
 
-static bool uuid_cmp(uint16_t u16, const bt_uuid_t *uuid)
+static inline bool uuid_cmp(uint16_t u16, const bt_uuid_t *uuid)
 {
 	bt_uuid_t lhs;
 
@@ -190,11 +198,6 @@ static void handle_characteristic(struct gatt_db_attribute *attr,
 	}
 }
 
-static void handle_gap_service(struct gas *gas)
-{
-	gatt_db_service_foreach_char(gas->attr, handle_characteristic, gas);
-}
-
 static int gap_probe(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
@@ -248,16 +251,7 @@ static void foreach_gap_service(struct gatt_db_attribute *attr, void *user_data)
 	}
 
 	gas->attr = attr;
-	handle_gap_service(gas);
-}
-
-static void gas_reset(struct gas *gas)
-{
-	gas->attr = NULL;
-	gatt_db_unref(gas->db);
-	gas->db = NULL;
-	bt_gatt_client_unref(gas->client);
-	gas->client = NULL;
+	gatt_db_service_foreach_char(gas->attr, handle_characteristic, gas);
 }
 
 static int gap_accept(struct btd_service *service)
@@ -268,13 +262,15 @@ static int gap_accept(struct btd_service *service)
 	struct gas *gas = btd_service_get_user_data(service);
 	char addr[18];
 	bt_uuid_t gap_uuid;
+	int err = 0;
 
 	ba2str(device_get_address(device), addr);
 	DBG("GAP profile accept (%s)", addr);
 
 	if (!gas) {
 		error("GAP service not handled by profile");
-		return -1;
+		err = -1;
+		goto _finish;
 	}
 
 	gas->db = gatt_db_ref(db);
@@ -287,12 +283,14 @@ static int gap_accept(struct btd_service *service)
 	if (!gas->attr) {
 		error("GAP attribute not found");
 		gas_reset(gas);
-		return -1;
+		err = -1;
 	}
 
-	btd_service_connecting_complete(service, 0);
+_finish:
 
-	return 0;
+	btd_service_connecting_complete(service, err);
+
+	return err;
 }
 
 static int gap_disconnect(struct btd_service *service)
-- 
2.11.1

