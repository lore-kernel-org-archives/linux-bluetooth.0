Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/8] gap: Make use of service user_data to store service context
Date: Mon, 12 Sep 2016 17:07:34 +0300
Message-Id: <1473689259-9523-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1473689259-9523-1-git-send-email-luiz.dentz@gmail.com>
References: <1473689259-9523-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Instead of storing service context data in a list this make use of
btd_service_set_user_data to store the context data which later can be
retrieved with btd_service_get_user_data.
---
 profiles/gap/gas.c | 40 ++++++++--------------------------------
 1 file changed, 8 insertions(+), 32 deletions(-)

diff --git a/profiles/gap/gas.c b/profiles/gap/gas.c
index b10b6ac..93a9a6d 100644
--- a/profiles/gap/gas.c
+++ b/profiles/gap/gas.c
@@ -57,8 +57,6 @@ struct gas {
 	struct gatt_db_attribute *attr;
 };
 
-static GSList *devices;
-
 static void gas_free(struct gas *gas)
 {
 	gatt_db_unref(gas->db);
@@ -67,14 +65,6 @@ static void gas_free(struct gas *gas)
 	g_free(gas);
 }
 
-static int cmp_device(gconstpointer a, gconstpointer b)
-{
-	const struct gas *gas = a;
-	const struct btd_device *device = b;
-
-	return gas->device == device ? 0 : -1;
-}
-
 static char *name2utf8(const uint8_t *name, uint16_t len)
 {
 	char utf8_name[HCI_MAX_NAME_LENGTH + 2];
@@ -208,16 +198,14 @@ static void handle_gap_service(struct gas *gas)
 static int gap_driver_probe(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
-	struct gas *gas;
-	GSList *l;
+	struct gas *gas = btd_service_get_user_data(service);
 	char addr[18];
 
 	ba2str(device_get_address(device), addr);
 	DBG("GAP profile probe (%s)", addr);
 
 	/* Ignore, if we were probed for this device already */
-	l = g_slist_find_custom(devices, device, cmp_device);
-	if (l) {
+	if (gas) {
 		error("Profile probed twice for the same device!");
 		return -1;
 	}
@@ -227,7 +215,7 @@ static int gap_driver_probe(struct btd_service *service)
 		return -1;
 
 	gas->device = btd_device_ref(device);
-	devices = g_slist_append(devices, gas);
+	btd_service_set_user_data(service, gas);
 
 	return 0;
 }
@@ -236,21 +224,17 @@ static void gap_driver_remove(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
 	struct gas *gas;
-	GSList *l;
 	char addr[18];
 
 	ba2str(device_get_address(device), addr);
 	DBG("GAP profile remove (%s)", addr);
 
-	l = g_slist_find_custom(devices, device, cmp_device);
-	if (!l) {
+	gas = btd_service_get_user_data(service);
+	if (!gas) {
 		error("GAP service not handled by profile");
 		return;
 	}
 
-	gas = l->data;
-
-	devices = g_slist_remove(devices, gas);
 	gas_free(gas);
 }
 
@@ -272,22 +256,18 @@ static int gap_driver_accept(struct btd_service *service)
 	struct btd_device *device = btd_service_get_device(service);
 	struct gatt_db *db = btd_device_get_gatt_db(device);
 	struct bt_gatt_client *client = btd_device_get_gatt_client(device);
-	struct gas *gas;
-	GSList *l;
+	struct gas *gas = btd_service_get_user_data(service);
 	char addr[18];
 	bt_uuid_t gap_uuid;
 
 	ba2str(device_get_address(device), addr);
 	DBG("GAP profile accept (%s)", addr);
 
-	l = g_slist_find_custom(devices, device, cmp_device);
-	if (!l) {
+	if (!gas) {
 		error("GAP service not handled by profile");
 		return -1;
 	}
 
-	gas = l->data;
-
 	/* Clean-up any old client/db and acquire the new ones */
 	gas->attr = NULL;
 	gatt_db_unref(gas->db);
@@ -320,11 +300,7 @@ static struct btd_profile gap_profile = {
 
 static int gap_init(void)
 {
-	devices = NULL;
-
-	btd_profile_register(&gap_profile);
-
-	return 0;
+	return btd_profile_register(&gap_profile);
 }
 
 static void gap_exit(void)
-- 
2.7.4

