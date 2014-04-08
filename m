Return-Path: <cyrus@holtmann.org>
From: Sudha Bheemanna <b.sudha@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sudha Bheemanna <b.sudha@samsung.com>
Subject: [PATCH] [32-bit UUID Support] Added support for 32-bit uuid for the
 Attribute type in ATT and GATT for GATT Server devices as per BT core 4.1
 spec. BT core spec 4.0 supports only 16-bit and 128-bit uuids. This patch
 provides the code changes for 32-bit uuid for GATT Server role.
Date: Tue, 08 Apr 2014 15:55:37 +0530
Message-id: <1396952737-16251-1-git-send-email-b.sudha@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gatt-service.c |   18 +++++--
 src/attrib-server.c   |  125 ++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 127 insertions(+), 16 deletions(-)

diff --git a/attrib/gatt-service.c b/attrib/gatt-service.c
index 874552b..ce26335 100644
--- a/attrib/gatt-service.c
+++ b/attrib/gatt-service.c
@@ -60,6 +60,8 @@ static inline void put_uuid_le(const bt_uuid_t *src, void *dst)
 {
 	if (src->type == BT_UUID16)
 		put_le16(src->value.u16, dst);
+	if (src->type == BT_UUID32)
+		put_le32(src->value.u32, dst);
 	else
 		/* Convert from 128-bit BE to LE */
 		bswap_128(&src->value.u128, dst);
@@ -195,8 +197,8 @@ static gboolean add_characteristic(struct btd_adapter *adapter,
 	uint8_t atval[ATT_MAX_VALUE_LEN];
 	GSList *l;
 
-	if ((info->uuid.type != BT_UUID16 && info->uuid.type != BT_UUID128) ||
-								!info->props) {
+	if (info->uuid.type != BT_UUID16 && info->uuid.type != BT_UUID32
+			&& info->uuid.type != BT_UUID128 && !info->props) {
 		error("Characteristic UUID or properties are missing");
 		return FALSE;
 	}
@@ -229,10 +231,17 @@ static gboolean add_characteristic(struct btd_adapter *adapter,
 	}
 
 	/* characteristic declaration */
-	bt_uuid16_create(&bt_uuid, GATT_CHARAC_UUID);
 	atval[0] = info->props;
 	put_le16(h + 1, &atval[1]);
+
+	if (info->uuid.type == BT_UUID16)
+		bt_uuid16_create(&bt_uuid, GATT_CHARAC_UUID);
+
+	else if (info->uuid.type == BT_UUID32)
+		bt_uuid32_create(&bt_uuid, GATT_CHARAC_UUID);
+
 	put_uuid_le(&info->uuid, &atval[3]);
+
 	if (attrib_db_add(adapter, h++, &bt_uuid, ATT_NONE, ATT_NOT_PERMITTED,
 				atval, 3 + info->uuid.type / 8) == NULL)
 		return FALSE;
@@ -311,7 +320,8 @@ gboolean gatt_service_add(struct btd_adapter *adapter, uint16_t uuid,
 
 	bt_uuid_to_string(svc_uuid, uuidstr, MAX_LEN_UUID_STR);
 
-	if (svc_uuid->type != BT_UUID16 && svc_uuid->type != BT_UUID128) {
+	if (svc_uuid->type != BT_UUID16 && svc_uuid->type != BT_UUID32
+			&&	svc_uuid->type != BT_UUID128) {
 		error("Invalid service uuid: %s", uuidstr);
 		return FALSE;
 	}
diff --git a/src/attrib-server.c b/src/attrib-server.c
index e65fff2..de4c3ce 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -85,6 +85,16 @@ struct group_elem {
 	uint16_t len;
 };
 
+static bt_uuid_t prim_uuid32 = {
+			.type = BT_UUID32,
+			.value.u32 = GATT_PRIM_SVC_UUID
+};
+
+static bt_uuid_t snd_uuid32 = {
+			.type = BT_UUID32,
+			.value.u32 = GATT_SND_SVC_UUID
+};
+
 static bt_uuid_t prim_uuid = {
 			.type = BT_UUID16,
 			.value.u16 = GATT_PRIM_SVC_UUID
@@ -102,6 +112,8 @@ static inline void put_uuid_le(const bt_uuid_t *src, void *dst)
 {
 	if (src->type == BT_UUID16)
 		put_le16(src->value.u16, dst);
+	if (src->type == BT_UUID32)
+		put_le32(src->value.u32, dst);
 	else
 		/* Convert from 128-bit BE to LE */
 		bswap_128(&src->value.u128, dst);
@@ -280,18 +292,31 @@ static struct attribute *find_svc_range(struct gatt_server *server,
 
 	attrib = l->data;
 
-	if (bt_uuid_cmp(&attrib->uuid, &prim_uuid) != 0 &&
+	if (attrib->uuid.type == BT_UUID16) {
+		if (bt_uuid_cmp(&attrib->uuid, &prim_uuid) != 0 &&
 			bt_uuid_cmp(&attrib->uuid, &snd_uuid) != 0)
-		return NULL;
+			return NULL;
+	} else if (attrib->uuid.type == BT_UUID32) {
+		if (bt_uuid_cmp(&attrib->uuid, &prim_uuid32) != 0 &&
+			bt_uuid_cmp(&attrib->uuid, &snd_uuid32) != 0)
+			return NULL;
+	}
 
 	*end = start;
 
 	for (l = l->next; l; l = l->next) {
 		struct attribute *a = l->data;
 
+	if (attrib->uuid.type == BT_UUID16) {
 		if (bt_uuid_cmp(&a->uuid, &prim_uuid) == 0 ||
 				bt_uuid_cmp(&a->uuid, &snd_uuid) == 0)
 			break;
+	} else if (attrib->uuid.type == BT_UUID32) {
+		if (bt_uuid_cmp(&attrib->uuid, &prim_uuid32) != 0 &&
+			bt_uuid_cmp(&attrib->uuid, &snd_uuid32) != 0)
+			break;
+	} else
+		break;
 
 		*end = a->handle;
 	}
@@ -314,6 +339,8 @@ static uint32_t attrib_create_sdp_new(struct gatt_server *server,
 
 	if (a->len == 2)
 		sdp_uuid16_create(&svc, get_le16(a->data));
+	else if (a->len == 4)
+		sdp_uuid32_create(&svc, get_leu32(a->data));
 	else if (a->len == 16) {
 		uint8_t be128[16];
 
@@ -428,8 +455,17 @@ static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
 	 * types may be used in the Read By Group Type Request.
 	 */
 
-	if (bt_uuid_cmp(uuid, &prim_uuid) != 0 &&
-		bt_uuid_cmp(uuid, &snd_uuid) != 0)
+	if (uuid->type == BT_UUID16) {
+		if (bt_uuid_cmp(uuid, &prim_uuid) != 0 &&
+			bt_uuid_cmp(uuid, &snd_uuid) != 0)
+			return enc_error_resp(ATT_OP_READ_BY_GROUP_REQ, 0x0000,
+					ATT_ECODE_UNSUPP_GRP_TYPE, pdu, len);
+	} else if (uuid->type == BT_UUID32) {
+		if (bt_uuid_cmp(uuid, &prim_uuid32) != 0 &&
+			bt_uuid_cmp(uuid, &snd_uuid32) != 0)
+			return enc_error_resp(ATT_OP_READ_BY_GROUP_REQ, 0x0000,
+					ATT_ECODE_UNSUPP_GRP_TYPE, pdu, len);
+	} else
 		return enc_error_resp(ATT_OP_READ_BY_GROUP_REQ, 0x0000,
 					ATT_ECODE_UNSUPP_GRP_TYPE, pdu, len);
 
@@ -445,11 +481,19 @@ static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
 		if (a->handle >= end)
 			break;
 
-		/* The old group ends when a new one starts */
-		if (old && (bt_uuid_cmp(&a->uuid, &prim_uuid) == 0 ||
+		if (uuid->type == BT_UUID16) {
+			/* The old group ends when a new one starts */
+			if (old && (bt_uuid_cmp(&a->uuid, &prim_uuid) == 0 ||
 				bt_uuid_cmp(&a->uuid, &snd_uuid) == 0)) {
-			old->end = last_handle;
-			old = NULL;
+				old->end = last_handle;
+				old = NULL;
+			}
+		} else if (uuid->type == BT_UUID32) {
+			if (old && (bt_uuid_cmp(&a->uuid, &prim_uuid32) == 0 ||
+				bt_uuid_cmp(&a->uuid, &snd_uuid32) == 0)) {
+				old->end = last_handle;
+				old = NULL;
+			}
 		}
 
 		if (bt_uuid_cmp(&a->uuid, uuid) != 0) {
@@ -737,9 +781,17 @@ static uint16_t find_by_type(struct gatt_channel *channel, uint16_t start,
 			/* Update the last found handle or reset the pointer
 			 * to track that a new group started: Primary or
 			 * Secondary service. */
-			if (bt_uuid_cmp(&a->uuid, &prim_uuid) == 0 ||
+
+			if (a->uuid.type == BT_UUID16) {
+				if (bt_uuid_cmp(&a->uuid, &prim_uuid) == 0 ||
 					bt_uuid_cmp(&a->uuid, &snd_uuid) == 0)
-				range = NULL;
+					range = NULL;
+			} else if (a->uuid.type == BT_UUID32) {
+				if (bt_uuid_cmp(&a->uuid, &prim_uuid32) == 0 ||
+					bt_uuid_cmp(&a->uuid, &snd_uuid32) == 0)
+					range = NULL;
+			}
+
 			else
 				range->end = a->handle;
 		}
@@ -1462,6 +1514,11 @@ static uint16_t find_uuid16_avail(struct btd_adapter *adapter, uint16_t nitems)
 			/* Note: the range above excludes the current handle */
 			return handle;
 
+		if (a->len == 4) {
+			/* 32 bit UUID service definition */
+			return 0;
+		}
+
 		if (a->len == 16 && (bt_uuid_cmp(&a->uuid, &prim_uuid) == 0 ||
 				bt_uuid_cmp(&a->uuid, &snd_uuid) == 0)) {
 			/* 128 bit UUID service definition */
@@ -1480,6 +1537,48 @@ static uint16_t find_uuid16_avail(struct btd_adapter *adapter, uint16_t nitems)
 	return 0;
 }
 
+static uint16_t find_uuid32_avail(struct btd_adapter *adapter, uint16_t nitems)
+{
+	struct gatt_server *server;
+	uint16_t handle;
+	GSList *l;
+	GList *dl;
+
+	l = g_slist_find_custom(servers, adapter, adapter_cmp);
+	if (l == NULL)
+		return 0;
+
+	server = l->data;
+	if (server->database == NULL)
+		return 0x0001;
+
+	for (dl = server->database, handle = 0x0001; dl; dl = dl->next) {
+		struct attribute *a = dl->data;
+
+		if ((bt_uuid_cmp(&a->uuid, &prim_uuid32) == 0 ||
+				bt_uuid_cmp(&a->uuid, &snd_uuid32) == 0) &&
+				a->handle - handle >= nitems) {
+			/* Note: the range above excludes the current handle */
+			return handle;
+			}
+
+		if (a->len == 2 || a->len == 16) {
+			/* 16 bit UUID or 128 bit UUID service definition */
+			return 0;
+		}
+
+		if (a->handle == 0xffff)
+			return 0;
+
+		handle = a->handle + 1;
+	}
+
+	if (0xffff - handle + 1 >= nitems)
+		return handle;
+
+	return 0;
+}
+
 static uint16_t find_uuid128_avail(struct btd_adapter *adapter, uint16_t nitems)
 {
 	uint16_t handle = 0, end = 0xffff;
@@ -1508,8 +1607,8 @@ static uint16_t find_uuid128_avail(struct btd_adapter *adapter, uint16_t nitems)
 		if (end - handle >= nitems)
 			return end - nitems + 1;
 
-		if (a->len == 2) {
-			/* 16 bit UUID service definition */
+		if (a->len == 2 || a->len == 4) {
+			/* 16/32 bit UUID service definition */
 			return 0;
 		}
 
@@ -1533,6 +1632,8 @@ uint16_t attrib_db_find_avail(struct btd_adapter *adapter, bt_uuid_t *svc_uuid,
 
 	if (svc_uuid->type == BT_UUID16)
 		return find_uuid16_avail(adapter, nitems);
+	else if (svc_uuid->type == BT_UUID32)
+		return find_uuid32_avail(adapter, nitems);
 	else if (svc_uuid->type == BT_UUID128)
 		return find_uuid128_avail(adapter, nitems);
 	else {
-- 
1.7.9.5

