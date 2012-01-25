Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 1/8] gatt-service: Add support for 128-bit Bluetooth UUIDs
Date: Wed, 25 Jan 2012 11:03:03 +0100
Message-Id: <1327485790-26249-2-git-send-email-sancane@gmail.com>
In-Reply-To: <1327485790-26249-1-git-send-email-sancane@gmail.com>
References: <1327485790-26249-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

UUID services in GATT should be either 16-bit or 128-bit. Current
GATT interface does not allow to provide 128-bit ones. This patch
enables plugins to register services using 128-bit UUIDs.
---
 attrib/gatt-service.c  |   57 ++++++++++++++++++++++++++++++++++-------------
 attrib/gatt-service.h  |    2 +-
 plugins/gatt-example.c |    7 ++++-
 time/server.c          |    6 ++++-
 4 files changed, 52 insertions(+), 20 deletions(-)

diff --git a/attrib/gatt-service.c b/attrib/gatt-service.c
index bfefdee..187ef5a 100644
--- a/attrib/gatt-service.c
+++ b/attrib/gatt-service.c
@@ -116,6 +116,28 @@ static GSList *parse_opts(gatt_option opt1, va_list args)
 	return l;
 }
 
+static struct attribute *add_service_declaration(struct btd_adapter *adapter,
+				uint16_t handle, uint16_t svc, bt_uuid_t *uuid)
+{
+	bt_uuid_t bt_uuid;
+	uint8_t atval[16];
+	int len;
+
+	if (uuid->type == BT_UUID16) {
+		att_put_u16(uuid->value.u16, &atval[0]);
+		len = 2;
+	} else if (uuid->type == BT_UUID128) {
+		att_put_u128(uuid->value.u128, &atval[0]);
+		len = 16;
+	} else
+		return NULL;
+
+	bt_uuid16_create(&bt_uuid, svc);
+
+	return attrib_db_add(adapter, handle, &bt_uuid, ATT_NONE,
+						ATT_NOT_PERMITTED, atval, len);
+}
+
 static int att_read_reqs(int authorization, int authentication, uint8_t props)
 {
 	if (authorization == GATT_CHR_VALUE_READ ||
@@ -268,15 +290,21 @@ static void service_attr_del(struct btd_adapter *adapter, uint16_t start_handle,
 }
 
 gboolean gatt_service_add(struct btd_adapter *adapter, uint16_t uuid,
-				uint16_t svc_uuid, gatt_option opt1, ...)
+				bt_uuid_t *svc_uuid, gatt_option opt1, ...)
 {
+	char uuidstr[MAX_LEN_UUID_STR];
 	uint16_t start_handle, h;
 	unsigned int size;
-	bt_uuid_t bt_uuid;
-	uint8_t atval[2];
 	va_list args;
 	GSList *chrs, *l;
 
+	bt_uuid_to_string(svc_uuid, uuidstr, MAX_LEN_UUID_STR);
+
+	if (svc_uuid->type != BT_UUID16 && svc_uuid->type != BT_UUID128) {
+		error("Invalid service uuid: %s", uuidstr);
+		return FALSE;
+	}
+
 	va_start(args, opt1);
 	chrs = parse_opts(opt1, args);
 	/* calculate how many attributes are necessary for this service */
@@ -288,31 +316,24 @@ gboolean gatt_service_add(struct btd_adapter *adapter, uint16_t uuid,
 	start_handle = attrib_db_find_avail(adapter, size);
 	if (start_handle == 0) {
 		error("Not enough free handles to register service");
-		g_slist_free_full(chrs, free_gatt_info);
-		return FALSE;
+		goto fail;
 	}
 
-	DBG("New service: handle 0x%04x, UUID 0x%04x, %d attributes",
-						start_handle, svc_uuid, size);
+	DBG("New service: handle 0x%04x, UUID %s, %d attributes",
+						start_handle, uuidstr, size);
 
 	/* service declaration */
 	h = start_handle;
-	bt_uuid16_create(&bt_uuid, uuid);
-	att_put_u16(svc_uuid, &atval[0]);
-	if (attrib_db_add(adapter, h++, &bt_uuid, ATT_NONE, ATT_NOT_PERMITTED,
-						atval, sizeof(atval)) == NULL) {
-		g_slist_free_full(chrs, free_gatt_info);
-		return FALSE;
-	}
+	if (add_service_declaration(adapter, h++, uuid, svc_uuid) == NULL)
+		goto fail;
 
 	for (l = chrs; l != NULL; l = l->next) {
 		struct gatt_info *info = l->data;
 
 		DBG("New characteristic: handle 0x%04x", h);
 		if (!add_characteristic(adapter, &h, info)) {
-			g_slist_free_full(chrs, free_gatt_info);
 			service_attr_del(adapter, start_handle, h - 1);
-			return FALSE;
+			goto fail;
 		}
 	}
 
@@ -321,4 +342,8 @@ gboolean gatt_service_add(struct btd_adapter *adapter, uint16_t uuid,
 	g_slist_free_full(chrs, free_gatt_info);
 
 	return TRUE;
+
+fail:
+	g_slist_free_full(chrs, free_gatt_info);
+	return FALSE;
 }
diff --git a/attrib/gatt-service.h b/attrib/gatt-service.h
index 7af2d3e..b810e2e 100644
--- a/attrib/gatt-service.h
+++ b/attrib/gatt-service.h
@@ -48,4 +48,4 @@ typedef enum {
 } attrib_event_t;
 
 gboolean gatt_service_add(struct btd_adapter *adapter, uint16_t uuid,
-				uint16_t svc_uuid, gatt_option opt1, ...);
+					bt_uuid_t *svc_uuid, gatt_option opt1, ...);
diff --git a/plugins/gatt-example.c b/plugins/gatt-example.c
index 701c1d7..e791c53 100644
--- a/plugins/gatt-example.c
+++ b/plugins/gatt-example.c
@@ -105,8 +105,11 @@ static uint8_t battery_state_read(struct attribute *a, gpointer user_data)
 
 static gboolean register_battery_service(struct btd_adapter *adapter)
 {
-	return gatt_service_add(adapter, GATT_PRIM_SVC_UUID,
-			BATTERY_STATE_SVC_UUID,
+	bt_uuid_t uuid;
+
+	bt_uuid16_create(&uuid, BATTERY_STATE_SVC_UUID);
+
+	return gatt_service_add(adapter, GATT_PRIM_SVC_UUID, &uuid,
 			/* battery state characteristic */
 			GATT_OPT_CHR_UUID, BATTERY_STATE_UUID,
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ |
diff --git a/time/server.c b/time/server.c
index 0730fbb..42b12e2 100644
--- a/time/server.c
+++ b/time/server.c
@@ -115,9 +115,13 @@ static uint8_t local_time_info_read(struct attribute *a, gpointer user_data)
 
 static void register_current_time_service(void)
 {
+	bt_uuid_t uuid;
+
+	bt_uuid16_create(&uuid, CURRENT_TIME_SVC_UUID);
+
 	/* Current Time service */
 	/* FIXME: Provide the adapter in next function */
-	gatt_service_add(NULL, GATT_PRIM_SVC_UUID, CURRENT_TIME_SVC_UUID,
+	gatt_service_add(NULL, GATT_PRIM_SVC_UUID, &uuid,
 				/* CT Time characteristic */
 				GATT_OPT_CHR_UUID, CT_TIME_CHR_UUID,
 				GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ |
-- 
1.7.8.4

