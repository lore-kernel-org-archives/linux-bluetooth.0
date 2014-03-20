Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 43/62] Replace att_get_uuid128() by bswap_128()
Date: Thu, 20 Mar 2014 11:43:08 -0300
Message-Id: <1395326607-27068-44-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

GATT/ATT use little-endian byte order format for 128-bit UUID. No matter
the system byte order representation, internally the core will handle
128-bit UUID on big-endian format.
---
 attrib/att.c         | 38 +++++++++++++++++++++--------
 attrib/gatt.c        | 69 +++++++++++++++++++++++++++++++++++-----------------
 attrib/gatttool.c    |  9 +++++--
 attrib/interactive.c |  9 +++++--
 4 files changed, 89 insertions(+), 36 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index 1df6190..bd23142 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -121,6 +121,19 @@ struct att_data_list *att_data_list_alloc(uint16_t num, uint16_t len)
 	return list;
 }
 
+static void get_uuid(uint8_t type, const void *val, bt_uuid_t *uuid)
+{
+	if (type == BT_UUID16)
+		bt_uuid16_create(uuid, get_le16(val));
+	else {
+		uint128_t u128;
+
+		/* Convert from 128-bit LE to BE */
+		bswap_128(val, &u128);
+		bt_uuid128_create(uuid, u128);
+	}
+}
+
 uint16_t enc_read_by_grp_req(uint16_t start, uint16_t end, bt_uuid_t *uuid,
 						uint8_t *pdu, size_t len)
 {
@@ -152,6 +165,7 @@ uint16_t dec_read_by_grp_req(const uint8_t *pdu, size_t len, uint16_t *start,
 						uint16_t *end, bt_uuid_t *uuid)
 {
 	const size_t min_len = sizeof(pdu[0]) + sizeof(*start) + sizeof(*end);
+	uint8_t type;
 
 	if (pdu == NULL)
 		return 0;
@@ -162,15 +176,17 @@ uint16_t dec_read_by_grp_req(const uint8_t *pdu, size_t len, uint16_t *start,
 	if (pdu[0] != ATT_OP_READ_BY_GROUP_REQ)
 		return 0;
 
-	if (len != (min_len + 2) && len != (min_len + 16))
+	if (len == (min_len + 2))
+		type = BT_UUID16;
+	else if (len == (min_len + 16))
+		type = BT_UUID128;
+	else
 		return 0;
 
 	*start = get_le16(&pdu[1]);
 	*end = get_le16(&pdu[3]);
-	if (len == min_len + 2)
-		bt_uuid16_create(uuid, get_le16(&pdu[5]));
-	else
-		*uuid = att_get_uuid128(&pdu[5]);
+
+	get_uuid(type, &pdu[5], uuid);
 
 	return len;
 }
@@ -394,6 +410,7 @@ uint16_t dec_read_by_type_req(const uint8_t *pdu, size_t len, uint16_t *start,
 						uint16_t *end, bt_uuid_t *uuid)
 {
 	const size_t min_len = sizeof(pdu[0]) + sizeof(*start) + sizeof(*end);
+	uint8_t type;
 
 	if (pdu == NULL)
 		return 0;
@@ -401,7 +418,11 @@ uint16_t dec_read_by_type_req(const uint8_t *pdu, size_t len, uint16_t *start,
 	if (start == NULL || end == NULL || uuid == NULL)
 		return 0;
 
-	if (len != (min_len + 2) && len != (min_len + 16))
+	if (len == (min_len + 2))
+		type = BT_UUID16;
+	else if (len == (min_len + 16))
+		type = BT_UUID128;
+	else
 		return 0;
 
 	if (pdu[0] != ATT_OP_READ_BY_TYPE_REQ)
@@ -410,10 +431,7 @@ uint16_t dec_read_by_type_req(const uint8_t *pdu, size_t len, uint16_t *start,
 	*start = get_le16(&pdu[1]);
 	*end = get_le16(&pdu[3]);
 
-	if (len == min_len + 2)
-		bt_uuid16_create(uuid, get_le16(&pdu[5]));
-	else
-		*uuid = att_get_uuid128(&pdu[5]);
+	get_uuid(type, &pdu[5], uuid);
 
 	return len;
 }
diff --git a/attrib/gatt.c b/attrib/gatt.c
index 83692f4..7b8b229 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -148,6 +148,22 @@ static void put_uuid_le(const bt_uuid_t *uuid, void *dst)
 		bswap_128(&uuid->value.u128, dst);
 }
 
+static void get_uuid128(uint8_t type, const void *val, bt_uuid_t *uuid)
+{
+	if (type == BT_UUID16) {
+		bt_uuid_t uuid16;
+
+		bt_uuid16_create(uuid, get_le16(val));
+		bt_uuid_to_uuid128(&uuid16, uuid);
+	} else {
+		uint128_t u128;
+
+		/* Convert from 128-bit LE to BE */
+		bswap_128(val, &u128);
+		bt_uuid128_create(uuid, u128);
+	}
+}
+
 static guint16 encode_discover_primary(uint16_t start, uint16_t end,
 				bt_uuid_t *uuid, uint8_t *pdu, size_t len)
 {
@@ -225,6 +241,7 @@ static void primary_all_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 	struct att_data_list *list;
 	unsigned int i, err;
 	uint16_t start, end;
+	uint8_t type;
 
 	if (status) {
 		err = status == ATT_ECODE_ATTR_NOT_FOUND ? 0 : status;
@@ -240,23 +257,26 @@ static void primary_all_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 	for (i = 0, end = 0; i < list->num; i++) {
 		const uint8_t *data = list->data[i];
 		struct gatt_primary *primary;
-		bt_uuid_t uuid;
+		bt_uuid_t uuid128;
 
 		start = get_le16(&data[0]);
 		end = get_le16(&data[2]);
 
-		if (list->len == 6) {
-			bt_uuid_t uuid16;
-
-			bt_uuid16_create(&uuid16, get_le16(&data[4]));
-			bt_uuid_to_uuid128(&uuid16, &uuid);
-		} else if (list->len == 20) {
-			uuid = att_get_uuid128(&data[4]);
-		} else {
+		/*
+		 * FIXME: Check before "for". Elements in the Attribute
+		 * Data List have the same length (list->len).
+		 */
+		if (list->len == 6)
+			type = BT_UUID16;
+		else if (list->len == 20)
+			type = BT_UUID128;
+		else {
 			/* Skipping invalid data */
 			continue;
 		}
 
+		get_uuid128(type, &data[4], &uuid128);
+
 		primary = g_try_new0(struct gatt_primary, 1);
 		if (!primary) {
 			att_data_list_free(list);
@@ -265,7 +285,7 @@ static void primary_all_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 		}
 		primary->range.start = start;
 		primary->range.end = end;
-		bt_uuid_to_string(&uuid, primary->uuid, sizeof(primary->uuid));
+		bt_uuid_to_string(&uuid128, primary->uuid, sizeof(primary->uuid));
 		dp->primaries = g_slist_append(dp->primaries, primary);
 	}
 
@@ -328,7 +348,7 @@ static void resolve_included_uuid_cb(uint8_t status, const uint8_t *pdu,
 	struct included_discovery *isd = query->isd;
 	struct gatt_included *incl = query->included;
 	unsigned int err = status;
-	bt_uuid_t uuid;
+	bt_uuid_t uuid128;
 	size_t buflen;
 	uint8_t *buf;
 
@@ -341,8 +361,9 @@ static void resolve_included_uuid_cb(uint8_t status, const uint8_t *pdu,
 		goto done;
 	}
 
-	uuid = att_get_uuid128(buf);
-	bt_uuid_to_string(&uuid, incl->uuid, sizeof(incl->uuid));
+	get_uuid128(BT_UUID128, buf, &uuid128);
+
+	bt_uuid_to_string(&uuid128, incl->uuid, sizeof(incl->uuid));
 	isd->includes = g_slist_append(isd->includes, incl);
 	query->included = NULL;
 
@@ -503,19 +524,23 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 	for (i = 0; i < list->num; i++) {
 		uint8_t *value = list->data[i];
 		struct gatt_char *chars;
-		bt_uuid_t uuid;
+		bt_uuid_t uuid128;
+		uint8_t type;
 
 		last = get_le16(value);
 
-		if (list->len == 7) {
-			bt_uuid_t uuid16;
+		/*
+		 * FIXME: Check before "for". Elements in the Attribute
+		 * Data List have the same length (list->len).
+		 */
+		if (list->len == 7)
+			type = BT_UUID16;
+		else
+			type = BT_UUID128;
 
-			bt_uuid16_create(&uuid16, get_le16(&value[5]));
-			bt_uuid_to_uuid128(&uuid16, &uuid);
-		} else
-			uuid = att_get_uuid128(&value[5]);
+		get_uuid128(type, &value[5], &uuid128);
 
-		if (dc->uuid && bt_uuid_cmp(dc->uuid, &uuid))
+		if (dc->uuid && bt_uuid_cmp(dc->uuid, &uuid128))
 			continue;
 
 		chars = g_try_new0(struct gatt_char, 1);
@@ -527,7 +552,7 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 		chars->handle = last;
 		chars->properties = value[2];
 		chars->value_handle = get_le16(&value[3]);
-		bt_uuid_to_string(&uuid, chars->uuid, sizeof(chars->uuid));
+		bt_uuid_to_string(&uuid128, chars->uuid, sizeof(chars->uuid));
 		dc->characteristics = g_slist_append(dc->characteristics,
 									chars);
 	}
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 4eb2528..ca178ce 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -428,8 +428,13 @@ static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
 
 		if (format == 0x01)
 			bt_uuid16_create(&uuid, get_le16(&value[2]));
-		else
-			uuid = att_get_uuid128(&value[2]);
+		else {
+			uint128_t u128;
+
+			/* Converts from LE to BE byte order */
+			bswap_128(&value[2], &u128);
+			bt_uuid128_create(&uuid, u128);
+		}
 
 		bt_uuid_to_string(&uuid, uuidstr, MAX_LEN_UUID_STR);
 		g_print("handle = 0x%04x, uuid = %s\n", handle, uuidstr);
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 5dd47ec..4865944 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -297,8 +297,13 @@ static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
 
 		if (format == 0x01)
 			bt_uuid16_create(&uuid, get_le16(&value[2]));
-		else
-			uuid = att_get_uuid128(&value[2]);
+		else {
+			uint128_t u128;
+
+			/* Converts from LE to BE byte order */
+			bswap_128(&value[2], &u128);
+			bt_uuid128_create(&uuid, u128);
+		}
 
 		bt_uuid_to_string(&uuid, uuidstr, MAX_LEN_UUID_STR);
 		rl_printf("handle: 0x%04x, uuid: %s\n", handle, uuidstr);
-- 
1.8.3.1

