Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 3/8] gatt-service: Add bluetooth adapter in gatt_service_add function
Date: Wed, 28 Dec 2011 11:24:45 +0100
Message-Id: <1325067890-6953-4-git-send-email-sancane@gmail.com>
In-Reply-To: <1325067890-6953-3-git-send-email-sancane@gmail.com>
References: <1325067890-6953-1-git-send-email-sancane@gmail.com>
 <1325067890-6953-2-git-send-email-sancane@gmail.com>
 <1325067890-6953-3-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gatt-service.c  |   31 +++++++++++++------------------
 attrib/gatt-service.h  |    3 ++-
 plugins/gatt-example.c |    7 ++++---
 time/server.c          |    3 ++-
 4 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/attrib/gatt-service.c b/attrib/gatt-service.c
index 73230f2..3bfa565 100644
--- a/attrib/gatt-service.c
+++ b/attrib/gatt-service.c
@@ -151,7 +151,8 @@ static gint find_callback(gconstpointer a, gconstpointer b)
 	return cb->event - event;
 }
 
-static gboolean add_characteristic(uint16_t *handle, struct gatt_info *info)
+static gboolean add_characteristic(struct btd_adapter *adapter,
+				uint16_t *handle, struct gatt_info *info)
 {
 	int read_reqs, write_reqs;
 	uint16_t h = *handle;
@@ -197,14 +198,12 @@ static gboolean add_characteristic(uint16_t *handle, struct gatt_info *info)
 	atval[0] = info->props;
 	att_put_u16(h + 1, &atval[1]);
 	att_put_u16(info->uuid.value.u16, &atval[3]);
-	/* FIXME: Provide the adapter in next function */
-	attrib_db_add(NULL, h++, &bt_uuid, ATT_NONE, ATT_NOT_PERMITTED, atval,
-								sizeof(atval));
+	attrib_db_add(adapter, h++, &bt_uuid, ATT_NONE, ATT_NOT_PERMITTED,
+							atval, sizeof(atval));
 
 	/* characteristic value */
-	/* FIXME: Provide the adapter in next function */
-	a = attrib_db_add(NULL, h++, &info->uuid, read_reqs, write_reqs, NULL,
-									0);
+	a = attrib_db_add(adapter, h++, &info->uuid, read_reqs, write_reqs,
+								NULL, 0);
 	for (l = info->callbacks; l != NULL; l = l->next) {
 		struct attrib_cb *cb = l->data;
 
@@ -228,8 +227,7 @@ static gboolean add_characteristic(uint16_t *handle, struct gatt_info *info)
 		bt_uuid16_create(&bt_uuid, GATT_CLIENT_CHARAC_CFG_UUID);
 		cfg_val[0] = 0x00;
 		cfg_val[1] = 0x00;
-		/* FIXME: Provide the adapter in next function */
-		a = attrib_db_add(NULL, h++, &bt_uuid, ATT_NONE,
+		a = attrib_db_add(adapter, h++, &bt_uuid, ATT_NONE,
 				ATT_AUTHENTICATION, cfg_val, sizeof(cfg_val));
 
 		if (info->ccc_handle != NULL)
@@ -249,7 +247,8 @@ static void free_gatt_info(void *data)
 	g_free(info);
 }
 
-gboolean gatt_service_add(uint16_t uuid, uint16_t svc_uuid, gatt_option opt1, ...)
+gboolean gatt_service_add(struct btd_adapter *adapter, uint16_t uuid,
+				uint16_t svc_uuid, gatt_option opt1, ...)
 {
 	uint16_t start_handle, h;
 	unsigned int size;
@@ -266,9 +265,7 @@ gboolean gatt_service_add(uint16_t uuid, uint16_t svc_uuid, gatt_option opt1, ..
 		size += info->num_attrs;
 	}
 	va_end(args);
-
-	/* FIXME: Provide the adapter in next function */
-	start_handle = attrib_db_find_avail(NULL, size);
+	start_handle = attrib_db_find_avail(adapter, size);
 	if (start_handle == 0) {
 		error("Not enough free handles to register service");
 		g_slist_free_full(chrs, free_gatt_info);
@@ -282,15 +279,13 @@ gboolean gatt_service_add(uint16_t uuid, uint16_t svc_uuid, gatt_option opt1, ..
 	h = start_handle;
 	bt_uuid16_create(&bt_uuid, uuid);
 	att_put_u16(svc_uuid, &atval[0]);
-	/* FIXME: Provide the adapter in next function */
-	attrib_db_add(NULL, h++, &bt_uuid, ATT_NONE, ATT_NOT_PERMITTED, atval,
-								sizeof(atval));
-
+	attrib_db_add(adapter, h++, &bt_uuid, ATT_NONE, ATT_NOT_PERMITTED,
+							atval, sizeof(atval));
 	for (l = chrs; l != NULL; l = l->next) {
 		struct gatt_info *info = l->data;
 
 		DBG("New characteristic: handle 0x%04x", h);
-		if (!add_characteristic(&h, info)) {
+		if (!add_characteristic(adapter, &h, info)) {
 			g_slist_free_full(chrs, free_gatt_info);
 			return FALSE;
 		}
diff --git a/attrib/gatt-service.h b/attrib/gatt-service.h
index 95064c0..7af2d3e 100644
--- a/attrib/gatt-service.h
+++ b/attrib/gatt-service.h
@@ -47,4 +47,5 @@ typedef enum {
 	ATTRIB_WRITE,
 } attrib_event_t;
 
-gboolean gatt_service_add(uint16_t uuid, uint16_t svc_uuid, gatt_option opt1, ...);
+gboolean gatt_service_add(struct btd_adapter *adapter, uint16_t uuid,
+				uint16_t svc_uuid, gatt_option opt1, ...);
diff --git a/plugins/gatt-example.c b/plugins/gatt-example.c
index f3f2b3a..27d3d13 100644
--- a/plugins/gatt-example.c
+++ b/plugins/gatt-example.c
@@ -102,9 +102,10 @@ static uint8_t battery_state_read(struct attribute *a, gpointer user_data)
 	return 0;
 }
 
-static gboolean register_battery_service(void)
+static gboolean register_battery_service(struct btd_adapter *adapter)
 {
-	return gatt_service_add(GATT_PRIM_SVC_UUID, BATTERY_STATE_SVC_UUID,
+	return gatt_service_add(adapter, GATT_PRIM_SVC_UUID,
+			BATTERY_STATE_SVC_UUID,
 			/* battery state characteristic */
 			GATT_OPT_CHR_UUID, BATTERY_STATE_UUID,
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ |
@@ -509,7 +510,7 @@ static int gatt_example_adapter_probe(struct btd_adapter *adapter)
 	gadapter = g_new0(struct gatt_example_adapter, 1);
 	gadapter->adapter = btd_adapter_ref(adapter);
 
-	if (!register_battery_service()) {
+	if (!register_battery_service(adapter)) {
 		DBG("Battery service could not be registered");
 		gatt_example_adapter_free(gadapter);
 		return -EIO;
diff --git a/time/server.c b/time/server.c
index 5636cca..839b33a 100644
--- a/time/server.c
+++ b/time/server.c
@@ -114,7 +114,8 @@ static uint8_t local_time_info_read(struct attribute *a, gpointer user_data)
 static void register_current_time_service(void)
 {
 	/* Current Time service */
-	gatt_service_add(GATT_PRIM_SVC_UUID, CURRENT_TIME_SVC_UUID,
+	/* FIXME: Provide the adapter in next function */
+	gatt_service_add(NULL, GATT_PRIM_SVC_UUID, CURRENT_TIME_SVC_UUID,
 				/* CT Time characteristic */
 				GATT_OPT_CHR_UUID, CT_TIME_CHR_UUID,
 				GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ |
-- 
1.7.8.1

