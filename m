Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH v4 1/2] Use new UUID functions in GATT
Date: Tue, 15 Mar 2011 10:05:03 -0300
Message-Id: <1300194304-29449-1-git-send-email-epx@signove.com>
In-Reply-To: <20110315085205.GB16296@jh-x301>
References: <20110315085205.GB16296@jh-x301>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch puts the new UUID functions into use for GATT-related
code, and adds some convenience functions to ATT API (att.h).
Example GATT server is also changed.
---
 attrib/att.c         |   47 +++++++++++--------------
 attrib/att.h         |   69 +++++++++++++++++++++++++++++++++----
 attrib/client.c      |   26 ++++++--------
 attrib/example.c     |   92 ++++++++++++++++++++++++++-----------------------
 attrib/gatt.c        |   68 +++++++++++++++++++------------------
 attrib/gatt.h        |    4 +-
 attrib/gattrib.c     |    3 +-
 attrib/gatttool.c    |   18 ++++-----
 attrib/interactive.c |   22 +++++------
 attrib/utils.c       |    1 +
 src/adapter.c        |    1 +
 src/attrib-server.c  |   93 +++++++++++++++++++++++++------------------------
 src/attrib-server.h  |    4 +-
 src/device.c         |    1 +
 src/main.c           |    1 +
 15 files changed, 250 insertions(+), 200 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index b96b97d..08000e0 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -27,8 +27,7 @@
 #include <stdlib.h>
 
 #include <bluetooth/bluetooth.h>
-#include <bluetooth/sdp.h>
-#include <bluetooth/sdp_lib.h>
+#include <bluetooth/uuid.h>
 
 #include <glib.h>
 
@@ -110,7 +109,7 @@ struct att_data_list *att_data_list_alloc(uint16_t num, uint16_t len)
 	return list;
 }
 
-uint16_t enc_read_by_grp_req(uint16_t start, uint16_t end, uuid_t *uuid,
+uint16_t enc_read_by_grp_req(uint16_t start, uint16_t end, bt_uuid_t *uuid,
 							uint8_t *pdu, int len)
 {
 	const uint16_t min_len = sizeof(pdu[0]) + sizeof(start) + sizeof(end);
@@ -119,9 +118,9 @@ uint16_t enc_read_by_grp_req(uint16_t start, uint16_t end, uuid_t *uuid,
 	if (!uuid)
 		return 0;
 
-	if (uuid->type == SDP_UUID16)
+	if (uuid->type == BT_UUID16)
 		length = 2;
-	else if (uuid->type == SDP_UUID128)
+	else if (uuid->type == BT_UUID128)
 		length = 16;
 	else
 		return 0;
@@ -133,16 +132,13 @@ uint16_t enc_read_by_grp_req(uint16_t start, uint16_t end, uuid_t *uuid,
 	att_put_u16(start, &pdu[1]);
 	att_put_u16(end, &pdu[3]);
 
-	if (uuid->type == SDP_UUID16)
-		att_put_u16(uuid->value.uuid16, &pdu[5]);
-	else
-		memcpy(&pdu[5], &uuid->value.uuid128, length);
+	att_put_uuid(*uuid, &pdu[5]);
 
 	return min_len + length;
 }
 
 uint16_t dec_read_by_grp_req(const uint8_t *pdu, int len, uint16_t *start,
-						uint16_t *end, uuid_t *uuid)
+						uint16_t *end, bt_uuid_t *uuid)
 {
 	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*start) + sizeof(*end);
 
@@ -161,9 +157,9 @@ uint16_t dec_read_by_grp_req(const uint8_t *pdu, int len, uint16_t *start,
 	*start = att_get_u16(&pdu[1]);
 	*end = att_get_u16(&pdu[3]);
 	if (len == min_len + 2)
-		sdp_uuid16_create(uuid, att_get_u16(&pdu[5]));
+		*uuid = att_get_uuid16(&pdu[5]);
 	else
-		sdp_uuid128_create(uuid, &pdu[5]);
+		*uuid = att_get_uuid128(&pdu[5]);
 
 	return len;
 }
@@ -219,7 +215,7 @@ struct att_data_list *dec_read_by_grp_resp(const uint8_t *pdu, int len)
 	return list;
 }
 
-uint16_t enc_find_by_type_req(uint16_t start, uint16_t end, uuid_t *uuid,
+uint16_t enc_find_by_type_req(uint16_t start, uint16_t end, bt_uuid_t *uuid,
 			const uint8_t *value, int vlen, uint8_t *pdu, int len)
 {
 	uint16_t min_len = sizeof(pdu[0]) + sizeof(start) + sizeof(end) +
@@ -231,7 +227,7 @@ uint16_t enc_find_by_type_req(uint16_t start, uint16_t end, uuid_t *uuid,
 	if (!uuid)
 		return 0;
 
-	if (uuid->type != SDP_UUID16)
+	if (uuid->type != BT_UUID16)
 		return 0;
 
 	if (len < min_len)
@@ -243,7 +239,7 @@ uint16_t enc_find_by_type_req(uint16_t start, uint16_t end, uuid_t *uuid,
 	pdu[0] = ATT_OP_FIND_BY_TYPE_REQ;
 	att_put_u16(start, &pdu[1]);
 	att_put_u16(end, &pdu[3]);
-	att_put_u16(uuid->value.uuid16, &pdu[5]);
+	att_put_uuid16(*uuid, &pdu[5]);
 
 	if (vlen > 0) {
 		memcpy(&pdu[7], value, vlen);
@@ -254,7 +250,7 @@ uint16_t enc_find_by_type_req(uint16_t start, uint16_t end, uuid_t *uuid,
 }
 
 uint16_t dec_find_by_type_req(const uint8_t *pdu, int len, uint16_t *start,
-			uint16_t *end, uuid_t *uuid, uint8_t *value, int *vlen)
+		uint16_t *end, bt_uuid_t *uuid, uint8_t *value, int *vlen)
 {
 	int valuelen;
 	uint16_t min_len = sizeof(pdu[0]) + sizeof(*start) +
@@ -279,7 +275,7 @@ uint16_t dec_find_by_type_req(const uint8_t *pdu, int len, uint16_t *start,
 
 	/* Always UUID16 */
 	if (uuid)
-		sdp_uuid16_create(uuid, att_get_u16(&pdu[5]));
+		*uuid = att_get_uuid16(&pdu[5]);
 
 	valuelen = len - min_len;
 
@@ -337,7 +333,7 @@ GSList *dec_find_by_type_resp(const uint8_t *pdu, int len)
 	return matches;
 }
 
-uint16_t enc_read_by_type_req(uint16_t start, uint16_t end, uuid_t *uuid,
+uint16_t enc_read_by_type_req(uint16_t start, uint16_t end, bt_uuid_t *uuid,
 							uint8_t *pdu, int len)
 {
 	const uint16_t min_len = sizeof(pdu[0]) + sizeof(start) + sizeof(end);
@@ -346,9 +342,9 @@ uint16_t enc_read_by_type_req(uint16_t start, uint16_t end, uuid_t *uuid,
 	if (!uuid)
 		return 0;
 
-	if (uuid->type == SDP_UUID16)
+	if (uuid->type == BT_UUID16)
 		length = 2;
-	else if (uuid->type == SDP_UUID128)
+	else if (uuid->type == BT_UUID128)
 		length = 16;
 	else
 		return 0;
@@ -360,16 +356,13 @@ uint16_t enc_read_by_type_req(uint16_t start, uint16_t end, uuid_t *uuid,
 	att_put_u16(start, &pdu[1]);
 	att_put_u16(end, &pdu[3]);
 
-	if (uuid->type == SDP_UUID16)
-		att_put_u16(uuid->value.uuid16, &pdu[5]);
-	else
-		memcpy(&pdu[5], &uuid->value.uuid128, length);
+	att_put_uuid(*uuid, &pdu[5]);
 
 	return min_len + length;
 }
 
 uint16_t dec_read_by_type_req(const uint8_t *pdu, int len, uint16_t *start,
-						uint16_t *end, uuid_t *uuid)
+						uint16_t *end, bt_uuid_t *uuid)
 {
 	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*start) + sizeof(*end);
 
@@ -389,9 +382,9 @@ uint16_t dec_read_by_type_req(const uint8_t *pdu, int len, uint16_t *start,
 	*end = att_get_u16(&pdu[3]);
 
 	if (len == min_len + 2)
-		sdp_uuid16_create(uuid, att_get_u16(&pdu[5]));
+		*uuid = att_get_uuid16(&pdu[5]);
 	else
-		sdp_uuid128_create(uuid, &pdu[5]);
+		*uuid = att_get_uuid128(&pdu[5]);
 
 	return len;
 }
diff --git a/attrib/att.h b/attrib/att.h
index b62f254..7a83bfa 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -120,7 +120,7 @@ enum {
 
 struct attribute {
 	uint16_t handle;
-	uuid_t uuid;
+	bt_uuid_t uuid;
 	int read_reqs;
 	int write_reqs;
 	uint8_t (*read_cb)(struct attribute *a, gpointer user_data);
@@ -173,6 +173,16 @@ static inline uint32_t att_get_u32(const void *ptr)
 	return btohl(bt_get_unaligned(u32_ptr));
 }
 
+static inline uint128_t att_get_u128(const void *ptr)
+{
+	const uint128_t *u128_ptr = ptr;
+	uint128_t dst;
+
+	btoh128(u128_ptr, &dst);
+
+	return dst;
+}
+
 static inline void att_put_u8(uint8_t src, void *dst)
 {
 	bt_put_unaligned(src, (uint8_t *) dst);
@@ -188,26 +198,71 @@ static inline void att_put_u32(uint32_t src, void *dst)
 	bt_put_unaligned(htobl(src), (uint32_t *) dst);
 }
 
+static inline void att_put_u128(uint128_t src, void *dst)
+{
+	uint128_t *d128 = dst;
+
+	htob128(&src, d128);
+}
+
+static inline void att_put_uuid16(bt_uuid_t src, void *dst)
+{
+	att_put_u16(src.value.u16, dst);
+}
+
+static inline void att_put_uuid128(bt_uuid_t src, void *dst)
+{
+	att_put_u128(src.value.u128, dst);
+}
+
+static inline void att_put_uuid(bt_uuid_t src, void *dst)
+{
+	if (src.type == BT_UUID16)
+		att_put_uuid16(src, dst);
+	else
+		att_put_uuid128(src, dst);
+}
+
+static inline bt_uuid_t att_get_uuid16(const void *ptr)
+{
+	bt_uuid_t uuid;
+
+	bt_uuid16_create(&uuid, att_get_u16(ptr));
+
+	return uuid;
+}
+
+static inline bt_uuid_t att_get_uuid128(const void *ptr)
+{
+	bt_uuid_t uuid;
+	uint128_t value;
+
+	value  = att_get_u128(ptr);
+	bt_uuid128_create(&uuid, value);
+
+	return uuid;
+}
+
 struct att_data_list *att_data_list_alloc(uint16_t num, uint16_t len);
 void att_data_list_free(struct att_data_list *list);
 
 const char *att_ecode2str(uint8_t status);
-uint16_t enc_read_by_grp_req(uint16_t start, uint16_t end, uuid_t *uuid,
+uint16_t enc_read_by_grp_req(uint16_t start, uint16_t end, bt_uuid_t *uuid,
 							uint8_t *pdu, int len);
 uint16_t dec_read_by_grp_req(const uint8_t *pdu, int len, uint16_t *start,
-						uint16_t *end, uuid_t *uuid);
+						uint16_t *end, bt_uuid_t *uuid);
 uint16_t enc_read_by_grp_resp(struct att_data_list *list, uint8_t *pdu, int len);
-uint16_t enc_find_by_type_req(uint16_t start, uint16_t end, uuid_t *uuid,
+uint16_t enc_find_by_type_req(uint16_t start, uint16_t end, bt_uuid_t *uuid,
 			const uint8_t *value, int vlen, uint8_t *pdu, int len);
 uint16_t dec_find_by_type_req(const uint8_t *pdu, int len, uint16_t *start,
-		uint16_t *end, uuid_t *uuid, uint8_t *value, int *vlen);
+		uint16_t *end, bt_uuid_t *uuid, uint8_t *value, int *vlen);
 uint16_t enc_find_by_type_resp(GSList *ranges, uint8_t *pdu, int len);
 GSList *dec_find_by_type_resp(const uint8_t *pdu, int len);
 struct att_data_list *dec_read_by_grp_resp(const uint8_t *pdu, int len);
-uint16_t enc_read_by_type_req(uint16_t start, uint16_t end, uuid_t *uuid,
+uint16_t enc_read_by_type_req(uint16_t start, uint16_t end, bt_uuid_t *uuid,
 							uint8_t *pdu, int len);
 uint16_t dec_read_by_type_req(const uint8_t *pdu, int len, uint16_t *start,
-						uint16_t *end, uuid_t *uuid);
+						uint16_t *end, bt_uuid_t *uuid);
 uint16_t enc_read_by_type_resp(struct att_data_list *list, uint8_t *pdu,
 								int len);
 uint16_t enc_write_cmd(uint16_t handle, const uint8_t *value, int vlen,
diff --git a/attrib/client.c b/attrib/client.c
index 17157cd..2bea9dd 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -32,15 +32,13 @@
 #include <glib.h>
 
 #include <bluetooth/bluetooth.h>
-#include <bluetooth/sdp.h>
-#include <bluetooth/sdp_lib.h>
+#include <bluetooth/uuid.h>
 
 #include "adapter.h"
 #include "device.h"
 #include "log.h"
 #include "gdbus.h"
 #include "error.h"
-#include "glib-helper.h"
 #include "dbus-common.h"
 #include "btio.h"
 #include "storage.h"
@@ -665,16 +663,14 @@ static void load_characteristics(gpointer data, gpointer user_data)
 static void store_attribute(struct gatt_service *gatt, uint16_t handle,
 				uint16_t type, uint8_t *value, gsize len)
 {
-	uuid_t uuid;
-	char *str, *uuidstr, *tmp;
+	bt_uuid_t uuid;
+	char *str, *tmp;
 	guint i;
 
 	str = g_malloc0(MAX_LEN_UUID_STR + len * 2 + 1);
 
-	sdp_uuid16_create(&uuid, type);
-	uuidstr = bt_uuid2string(&uuid);
-	strcpy(str, uuidstr);
-	g_free(uuidstr);
+	bt_uuid16_create(&uuid, type);
+	bt_uuid_to_string(&uuid, str, MAX_LEN_UUID_STR);
 
 	str[MAX_LEN_UUID_STR - 1] = '#';
 
@@ -770,13 +766,13 @@ static void update_char_value(guint8 status, const guint8 *pdu,
 	g_free(current);
 }
 
-static int uuid_desc16_cmp(uuid_t *uuid, guint16 desc)
+static int uuid_desc16_cmp(bt_uuid_t *uuid, guint16 desc)
 {
-	uuid_t u16;
+	bt_uuid_t u16;
 
-	sdp_uuid16_create(&u16, desc);
+	bt_uuid16_create(&u16, desc);
 
-	return sdp_uuid_cmp(uuid, &u16);
+	return bt_uuid_cmp(uuid, &u16);
 }
 
 static void descriptor_cb(guint8 status, const guint8 *pdu, guint16 plen,
@@ -799,14 +795,14 @@ static void descriptor_cb(guint8 status, const guint8 *pdu, guint16 plen,
 
 	for (i = 0; i < list->num; i++) {
 		guint16 handle;
-		uuid_t uuid;
+		bt_uuid_t uuid;
 		uint8_t *info = list->data[i];
 		struct query_data *qfmt;
 
 		handle = att_get_u16(info);
 
 		if (format == 0x01) {
-			sdp_uuid16_create(&uuid, att_get_u16(&info[2]));
+			uuid = att_get_uuid16(&info[2]);
 		} else {
 			/* Currently, only "user description" and "presentation
 			 * format" descriptors are used, and both have 16-bit
diff --git a/attrib/example.c b/attrib/example.c
index 395650a..fae288c 100644
--- a/attrib/example.c
+++ b/attrib/example.c
@@ -29,8 +29,7 @@
 
 #include <arpa/inet.h>
 
-#include <bluetooth/sdp.h>
-#include <bluetooth/sdp_lib.h>
+#include <bluetooth/uuid.h>
 
 #include <glib.h>
 
@@ -70,36 +69,41 @@ static int register_attributes(void)
 	const char *manufacturer_name2 = "ACME Weighing Scales";
 	const char *serial1 = "237495-3282-A";
 	const char *serial2 = "11267-2327A00239";
-	const unsigned char char_weight_uuid[] = { 0x80, 0x88, 0xF2, 0x18, 0x90,
-		0x2C, 0x45, 0x0B, 0xB6, 0xC4, 0x62, 0x89, 0x1E, 0x8C, 0x25,
-		0xE9 };
-	const unsigned char prim_weight_uuid[] = { 0x4F, 0x0A, 0xC0, 0x96, 0x35,
-		0xD4, 0x49, 0x11, 0x96, 0x31, 0xDE, 0xA8, 0xDC, 0x74, 0xEE,
-		0xFE };
+
+	const uint128_t char_weight_uuid_btorder = {
+		.data = { 0x80, 0x88, 0xF2, 0x18, 0x90, 0x2C, 0x45, 0x0B,
+			  0xB6, 0xC4, 0x62, 0x89, 0x1E, 0x8C, 0x25, 0xE9 } };
+	const uint128_t prim_weight_uuid_btorder = {
+		.data = { 0x4F, 0x0A, 0xC0, 0x96, 0x35, 0xD4, 0x49, 0x11,
+			  0x96, 0x31, 0xDE, 0xA8, 0xDC, 0x74, 0xEE, 0xFE } };
+
+	uint128_t char_weight_uuid;
 	uint8_t atval[256];
 	uint32_t handle;
-	uuid_t uuid;
+	bt_uuid_t uuid;
 	int len;
 
+	btoh128(&char_weight_uuid_btorder, &char_weight_uuid);
+
 	/* Battery state service: primary service definition */
-	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
+	bt_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
 	att_put_u16(BATTERY_STATE_SVC_UUID, &atval[0]);
 	attrib_db_add(0x0100, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
 	/* Battery: battery state characteristic */
-	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
+	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(0x0110, &atval[1]);
 	att_put_u16(BATTERY_STATE_UUID, &atval[3]);
 	attrib_db_add(0x0106, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* Battery: battery state attribute */
-	sdp_uuid16_create(&uuid, BATTERY_STATE_UUID);
+	bt_uuid16_create(&uuid, BATTERY_STATE_UUID);
 	atval[0] = 0x04;
 	attrib_db_add(0x0110, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 1);
 
 	/* Battery: Client Characteristic Configuration */
-	sdp_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
+	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
 	atval[0] = 0x00;
 	atval[1] = 0x00;
 	attrib_db_add(0x0111, &uuid, ATT_NONE, ATT_AUTHENTICATION, atval, 2);
@@ -110,12 +114,12 @@ static int register_attributes(void)
 		sdp_handles = g_slist_prepend(sdp_handles, GUINT_TO_POINTER(handle));
 
 	/* Thermometer: primary service definition */
-	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
+	bt_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
 	att_put_u16(THERM_HUMIDITY_SVC_UUID, &atval[0]);
 	attrib_db_add(0x0200, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
 	/* Thermometer: Include */
-	sdp_uuid16_create(&uuid, GATT_INCLUDE_UUID);
+	bt_uuid16_create(&uuid, GATT_INCLUDE_UUID);
 	att_put_u16(0x0500, &atval[0]);
 	att_put_u16(0x0504, &atval[2]);
 	att_put_u16(MANUFACTURER_SVC_UUID, &atval[4]);
@@ -128,20 +132,20 @@ static int register_attributes(void)
 	attrib_db_add(0x0202, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 6);
 
 	/* Thermometer: temperature characteristic */
-	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
+	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(0x0204, &atval[1]);
 	att_put_u16(TEMPERATURE_UUID, &atval[3]);
 	attrib_db_add(0x0203, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* Thermometer: temperature characteristic value */
-	sdp_uuid16_create(&uuid, TEMPERATURE_UUID);
+	bt_uuid16_create(&uuid, TEMPERATURE_UUID);
 	atval[0] = 0x8A;
 	atval[1] = 0x02;
 	attrib_db_add(0x0204, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
 	/* Thermometer: temperature characteristic format */
-	sdp_uuid16_create(&uuid, GATT_CHARAC_FMT_UUID);
+	bt_uuid16_create(&uuid, GATT_CHARAC_FMT_UUID);
 	atval[0] = 0x0E;
 	atval[1] = 0xFE;
 	att_put_u16(FMT_CELSIUS_UUID, &atval[2]);
@@ -150,25 +154,25 @@ static int register_attributes(void)
 	attrib_db_add(0x0205, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 7);
 
 	/* Thermometer: characteristic user description */
-	sdp_uuid16_create(&uuid, GATT_CHARAC_USER_DESC_UUID);
+	bt_uuid16_create(&uuid, GATT_CHARAC_USER_DESC_UUID);
 	len = strlen(desc_out_temp);
 	strncpy((char *) atval, desc_out_temp, len);
 	attrib_db_add(0x0206, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
 
 	/* Thermometer: relative humidity characteristic */
-	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
+	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(0x0212, &atval[1]);
 	att_put_u16(RELATIVE_HUMIDITY_UUID, &atval[3]);
 	attrib_db_add(0x0210, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* Thermometer: relative humidity value */
-	sdp_uuid16_create(&uuid, RELATIVE_HUMIDITY_UUID);
+	bt_uuid16_create(&uuid, RELATIVE_HUMIDITY_UUID);
 	atval[0] = 0x27;
 	attrib_db_add(0x0212, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 1);
 
 	/* Thermometer: relative humidity characteristic format */
-	sdp_uuid16_create(&uuid, GATT_CHARAC_FMT_UUID);
+	bt_uuid16_create(&uuid, GATT_CHARAC_FMT_UUID);
 	atval[0] = 0x04;
 	atval[1] = 0x00;
 	att_put_u16(FMT_PERCENT_UUID, &atval[2]);
@@ -177,7 +181,7 @@ static int register_attributes(void)
 	attrib_db_add(0x0213, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 8);
 
 	/* Thermometer: characteristic user description */
-	sdp_uuid16_create(&uuid, GATT_CHARAC_USER_DESC_UUID);
+	bt_uuid16_create(&uuid, GATT_CHARAC_USER_DESC_UUID);
 	len = strlen(desc_out_hum);
 	strncpy((char *) atval, desc_out_hum, len);
 	attrib_db_add(0x0214, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
@@ -188,62 +192,62 @@ static int register_attributes(void)
 		sdp_handles = g_slist_prepend(sdp_handles, GUINT_TO_POINTER(handle));
 
 	/* Secondary Service: Manufacturer Service */
-	sdp_uuid16_create(&uuid, GATT_SND_SVC_UUID);
+	bt_uuid16_create(&uuid, GATT_SND_SVC_UUID);
 	att_put_u16(MANUFACTURER_SVC_UUID, &atval[0]);
 	attrib_db_add(0x0500, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
 	/* Manufacturer name characteristic definition */
-	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
+	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(0x0502, &atval[1]);
 	att_put_u16(MANUFACTURER_NAME_UUID, &atval[3]);
 	attrib_db_add(0x0501, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* Manufacturer name characteristic value */
-	sdp_uuid16_create(&uuid, MANUFACTURER_NAME_UUID);
+	bt_uuid16_create(&uuid, MANUFACTURER_NAME_UUID);
 	len = strlen(manufacturer_name1);
 	strncpy((char *) atval, manufacturer_name1, len);
 	attrib_db_add(0x0502, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
 
 	/* Manufacturer serial number characteristic */
-	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
+	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(0x0504, &atval[1]);
 	att_put_u16(MANUFACTURER_SERIAL_UUID, &atval[3]);
 	attrib_db_add(0x0503, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* Manufacturer serial number characteristic value */
-	sdp_uuid16_create(&uuid, MANUFACTURER_SERIAL_UUID);
+	bt_uuid16_create(&uuid, MANUFACTURER_SERIAL_UUID);
 	len = strlen(serial1);
 	strncpy((char *) atval, serial1, len);
 	attrib_db_add(0x0504, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
 
 	/* Secondary Service: Manufacturer Service */
-	sdp_uuid16_create(&uuid, GATT_SND_SVC_UUID);
+	bt_uuid16_create(&uuid, GATT_SND_SVC_UUID);
 	att_put_u16(MANUFACTURER_SVC_UUID, &atval[0]);
 	attrib_db_add(0x0505, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
 	/* Manufacturer name characteristic definition */
-	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
+	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(0x0507, &atval[1]);
 	att_put_u16(MANUFACTURER_NAME_UUID, &atval[3]);
 	attrib_db_add(0x0506, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* Secondary Service: Vendor Specific Service */
-	sdp_uuid16_create(&uuid, GATT_SND_SVC_UUID);
+	bt_uuid16_create(&uuid, GATT_SND_SVC_UUID);
 	att_put_u16(VENDOR_SPECIFIC_SVC_UUID, &atval[0]);
 	attrib_db_add(0x0550, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
 	/* Vendor Specific Type characteristic definition */
-	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
+	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(0x0568, &atval[1]);
 	att_put_u16(VENDOR_SPECIFIC_TYPE_UUID, &atval[3]);
 	attrib_db_add(0x0560, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* Vendor Specific Type characteristic value */
-	sdp_uuid16_create(&uuid, VENDOR_SPECIFIC_TYPE_UUID);
+	bt_uuid16_create(&uuid, VENDOR_SPECIFIC_TYPE_UUID);
 	atval[0] = 0x56;
 	atval[1] = 0x65;
 	atval[2] = 0x6E;
@@ -253,45 +257,45 @@ static int register_attributes(void)
 	attrib_db_add(0x0568, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 6);
 
 	/* Manufacturer name attribute */
-	sdp_uuid16_create(&uuid, MANUFACTURER_NAME_UUID);
+	bt_uuid16_create(&uuid, MANUFACTURER_NAME_UUID);
 	len = strlen(manufacturer_name2);
 	strncpy((char *) atval, manufacturer_name2, len);
 	attrib_db_add(0x0507, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
 
 	/* Characteristic: serial number */
-	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
+	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(0x0509, &atval[1]);
 	att_put_u16(MANUFACTURER_SERIAL_UUID, &atval[3]);
 	attrib_db_add(0x0508, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* Serial number characteristic value */
-	sdp_uuid16_create(&uuid, MANUFACTURER_SERIAL_UUID);
+	bt_uuid16_create(&uuid, MANUFACTURER_SERIAL_UUID);
 	len = strlen(serial2);
 	strncpy((char *) atval, serial2, len);
 	attrib_db_add(0x0509, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
 
 	/* Weight service: primary service definition */
-	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
-	memcpy(atval, prim_weight_uuid, 16);
+	bt_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
+	memcpy(atval, &prim_weight_uuid_btorder, 16);
 	attrib_db_add(0x0680, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 16);
 
 	/* Weight: include */
-	sdp_uuid16_create(&uuid, GATT_INCLUDE_UUID);
+	bt_uuid16_create(&uuid, GATT_INCLUDE_UUID);
 	att_put_u16(0x0505, &atval[0]);
 	att_put_u16(0x0509, &atval[2]);
 	att_put_u16(MANUFACTURER_SVC_UUID, &atval[4]);
 	attrib_db_add(0x0681, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 6);
 
 	/* Weight: characteristic */
-	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
+	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(0x0683, &atval[1]);
-	memcpy(&atval[3], char_weight_uuid, 16);
+	memcpy(&atval[3], &char_weight_uuid_btorder, 16);
 	attrib_db_add(0x0682, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 19);
 
 	/* Weight: characteristic value */
-	sdp_uuid128_create(&uuid, char_weight_uuid);
+	bt_uuid128_create(&uuid, char_weight_uuid);
 	atval[0] = 0x82;
 	atval[1] = 0x55;
 	atval[2] = 0x00;
@@ -299,7 +303,7 @@ static int register_attributes(void)
 	attrib_db_add(0x0683, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 4);
 
 	/* Weight: characteristic format */
-	sdp_uuid16_create(&uuid, GATT_CHARAC_FMT_UUID);
+	bt_uuid16_create(&uuid, GATT_CHARAC_FMT_UUID);
 	atval[0] = 0x08;
 	atval[1] = 0xFD;
 	att_put_u16(FMT_KILOGRAM_UUID, &atval[2]);
@@ -308,7 +312,7 @@ static int register_attributes(void)
 	attrib_db_add(0x0684, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 8);
 
 	/* Weight: characteristic user description */
-	sdp_uuid16_create(&uuid, GATT_CHARAC_USER_DESC_UUID);
+	bt_uuid16_create(&uuid, GATT_CHARAC_USER_DESC_UUID);
 	len = strlen(desc_weight);
 	strncpy((char *) atval, desc_weight, len);
 	attrib_db_add(0x0685, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
diff --git a/attrib/gatt.c b/attrib/gatt.c
index 2b0d827..32bd4a0 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -24,8 +24,7 @@
 
 #include <stdint.h>
 #include <glib.h>
-#include <bluetooth/sdp.h>
-#include <bluetooth/sdp_lib.h>
+#include <bluetooth/uuid.h>
 
 #include "att.h"
 #include "gattrib.h"
@@ -33,7 +32,7 @@
 
 struct discover_primary {
 	GAttrib *attrib;
-	uuid_t uuid;
+	bt_uuid_t uuid;
 	GSList *primaries;
 	gatt_cb_t cb;
 	void *user_data;
@@ -41,7 +40,7 @@ struct discover_primary {
 
 struct discover_char {
 	GAttrib *attrib;
-	uuid_t uuid;
+	bt_uuid_t uuid;
 	uint16_t end;
 	GSList *characteristics;
 	gatt_cb_t cb;
@@ -64,31 +63,35 @@ static void discover_char_free(struct discover_char *dc)
 }
 
 static guint16 encode_discover_primary(uint16_t start, uint16_t end,
-					uuid_t *uuid, uint8_t *pdu, size_t len)
+				bt_uuid_t *uuid, uint8_t *pdu, size_t len)
 {
-	uuid_t prim;
+	bt_uuid_t prim;
 	guint16 plen;
 	uint8_t op;
 
-	sdp_uuid16_create(&prim, GATT_PRIM_SVC_UUID);
+	bt_uuid16_create(&prim, GATT_PRIM_SVC_UUID);
 
 	if (uuid == NULL) {
 		/* Discover all primary services */
 		op = ATT_OP_READ_BY_GROUP_REQ;
 		plen = enc_read_by_grp_req(start, end, &prim, pdu, len);
 	} else {
+		uint16_t u16;
+		uint128_t u128;
 		const void *value;
 		int vlen;
 
 		/* Discover primary service by service UUID */
 		op = ATT_OP_FIND_BY_TYPE_REQ;
 
-		if (uuid->type == SDP_UUID16) {
-			value = &uuid->value.uuid16;
-			vlen = sizeof(uuid->value.uuid16);
+		if (uuid->type == BT_UUID16) {
+			u16 = htobs(uuid->value.u16);
+			value = &u16;
+			vlen = sizeof(u16);
 		} else {
-			value = &uuid->value.uuid128;
-			vlen = sizeof(uuid->value.uuid128);
+			htob128(&uuid->value.u128, &u128);
+			value = &u128;
+			vlen = sizeof(u128);
 		}
 
 		plen = enc_find_by_type_req(start, end, &prim, value, vlen,
@@ -163,21 +166,20 @@ static void primary_all_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 	for (i = 0, end = 0; i < list->num; i++) {
 		const uint8_t *data = list->data[i];
 		struct att_primary *primary;
-		uuid_t u128, u16;
+		bt_uuid_t uuid;
 
 		start = att_get_u16(&data[0]);
 		end = att_get_u16(&data[2]);
 
 		if (list->len == 6) {
-			sdp_uuid16_create(&u16,
-					att_get_u16(&data[4]));
-			sdp_uuid16_to_uuid128(&u128, &u16);
-
-		} else if (list->len == 20)
-			sdp_uuid128_create(&u128, &data[4]);
-		else
+			bt_uuid_t uuid16 = att_get_uuid16(&data[4]);
+			bt_uuid_to_uuid128(&uuid16, &uuid);
+		} else if (list->len == 20) {
+			uuid = att_get_uuid128(&data[4]);
+		} else {
 			/* Skipping invalid data */
 			continue;
+		}
 
 		primary = g_try_new0(struct att_primary, 1);
 		if (!primary) {
@@ -186,7 +188,7 @@ static void primary_all_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 		}
 		primary->start = start;
 		primary->end = end;
-		sdp_uuid2strn(&u128, primary->uuid, sizeof(primary->uuid));
+		bt_uuid_to_string(&uuid, primary->uuid, sizeof(primary->uuid));
 		dp->primaries = g_slist_append(dp->primaries, primary);
 	}
 
@@ -209,7 +211,7 @@ done:
 	discover_primary_free(dp);
 }
 
-guint gatt_discover_primary(GAttrib *attrib, uuid_t *uuid, gatt_cb_t func,
+guint gatt_discover_primary(GAttrib *attrib, bt_uuid_t *uuid, gatt_cb_t func,
 							gpointer user_data)
 {
 	struct discover_primary *dp;
@@ -230,7 +232,7 @@ guint gatt_discover_primary(GAttrib *attrib, uuid_t *uuid, gatt_cb_t func,
 	dp->user_data = user_data;
 
 	if (uuid) {
-		memcpy(&dp->uuid, uuid, sizeof(uuid_t));
+		memcpy(&dp->uuid, uuid, sizeof(bt_uuid_t));
 		cb = primary_by_uuid_cb;
 	} else
 		cb = primary_all_cb;
@@ -246,7 +248,7 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 	unsigned int i, err;
 	uint8_t opdu[ATT_DEFAULT_LE_MTU];
 	guint16 oplen;
-	uuid_t uuid;
+	bt_uuid_t uuid;
 	uint16_t last = 0;
 
 	if (status) {
@@ -263,15 +265,15 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 	for (i = 0; i < list->num; i++) {
 		uint8_t *value = list->data[i];
 		struct att_char *chars;
-		uuid_t u128, u16;
+		bt_uuid_t uuid;
 
 		last = att_get_u16(value);
 
 		if (list->len == 7) {
-			sdp_uuid16_create(&u16, att_get_u16(&value[5]));
-			sdp_uuid16_to_uuid128(&u128, &u16);
+			bt_uuid_t uuid16 = att_get_uuid16(&value[5]);
+			bt_uuid_to_uuid128(&uuid16, &uuid);
 		} else
-			sdp_uuid128_create(&u128, &value[5]);
+			uuid = att_get_uuid128(&value[5]);
 
 		chars = g_try_new0(struct att_char, 1);
 		if (!chars) {
@@ -282,7 +284,7 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 		chars->handle = last;
 		chars->properties = value[2];
 		chars->value_handle = att_get_u16(&value[3]);
-		sdp_uuid2strn(&u128, chars->uuid, sizeof(chars->uuid));
+		bt_uuid_to_string(&uuid, chars->uuid, sizeof(chars->uuid));
 		dc->characteristics = g_slist_append(dc->characteristics,
 									chars);
 	}
@@ -291,7 +293,7 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 	err = 0;
 
 	if (last != 0) {
-		sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
+		bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 
 		oplen = enc_read_by_type_req(last + 1, dc->end, &uuid, opdu,
 								sizeof(opdu));
@@ -316,9 +318,9 @@ guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
 	uint8_t pdu[ATT_DEFAULT_LE_MTU];
 	struct discover_char *dc;
 	guint16 plen;
-	uuid_t uuid;
+	bt_uuid_t uuid;
 
-	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
+	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 
 	plen = enc_read_by_type_req(start, end, &uuid, pdu, sizeof(pdu));
 	if (plen == 0)
@@ -338,7 +340,7 @@ guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
 }
 
 guint gatt_read_char_by_uuid(GAttrib *attrib, uint16_t start, uint16_t end,
-					uuid_t *uuid, GAttribResultFunc func,
+					bt_uuid_t *uuid, GAttribResultFunc func,
 					gpointer user_data)
 {
 	uint8_t pdu[ATT_DEFAULT_LE_MTU];
diff --git a/attrib/gatt.h b/attrib/gatt.h
index b1a46e1..730de7e 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -26,7 +26,7 @@
 
 typedef void (*gatt_cb_t) (GSList *l, guint8 status, gpointer user_data);
 
-guint gatt_discover_primary(GAttrib *attrib, uuid_t *uuid, gatt_cb_t func,
+guint gatt_discover_primary(GAttrib *attrib, bt_uuid_t *uuid, gatt_cb_t func,
 							gpointer user_data);
 
 guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
@@ -45,5 +45,5 @@ guint gatt_write_cmd(GAttrib *attrib, uint16_t handle, uint8_t *value, int vlen,
 				GDestroyNotify notify, gpointer user_data);
 
 guint gatt_read_char_by_uuid(GAttrib *attrib, uint16_t start, uint16_t end,
-				uuid_t *uuid, GAttribResultFunc func,
+				bt_uuid_t *uuid, GAttribResultFunc func,
 				gpointer user_data);
diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index c4cfd95..07e56de 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -29,8 +29,7 @@
 #include <stdio.h>
 
 #include <bluetooth/bluetooth.h>
-#include <bluetooth/sdp.h>
-#include <bluetooth/sdp_lib.h>
+#include <bluetooth/uuid.h>
 
 #include "att.h"
 #include "btio.h"
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 4e344ba..729e18d 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -34,13 +34,11 @@
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
 #include <bluetooth/hci_lib.h>
-#include <bluetooth/sdp.h>
-#include <bluetooth/sdp_lib.h>
+#include <bluetooth/uuid.h>
 
 #include "att.h"
 #include "btio.h"
 #include "gattrib.h"
-#include "glib-helper.h"
 #include "gatt.h"
 #include "gatttool.h"
 
@@ -48,7 +46,7 @@ static gchar *opt_src = NULL;
 static gchar *opt_dst = NULL;
 static gchar *opt_value = NULL;
 static gchar *opt_sec_level = NULL;
-static uuid_t *opt_uuid = NULL;
+static bt_uuid_t *opt_uuid = NULL;
 static int opt_start = 0x0001;
 static int opt_end = 0xffff;
 static int opt_handle = -1;
@@ -427,17 +425,17 @@ static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		char uuidstr[MAX_LEN_UUID_STR];
 		uint16_t handle;
 		uint8_t *value;
-		uuid_t uuid;
+		bt_uuid_t uuid;
 
 		value = list->data[i];
 		handle = att_get_u16(value);
 
 		if (format == 0x01)
-			sdp_uuid16_create(&uuid, att_get_u16(&value[2]));
+			uuid = att_get_uuid16(&value[2]);
 		else
-			sdp_uuid128_create(&uuid, &value[2]);
+			uuid = att_get_uuid128(&value[2]);
 
-		sdp_uuid2strn(&uuid, uuidstr, MAX_LEN_UUID_STR);
+		bt_uuid_to_string(&uuid, uuidstr, MAX_LEN_UUID_STR);
 		g_print("handle = 0x%04x, uuid = %s\n", handle, uuidstr);
 	}
 
@@ -463,11 +461,11 @@ static gboolean parse_uuid(const char *key, const char *value,
 	if (!value)
 		return FALSE;
 
-	opt_uuid = g_try_malloc(sizeof(uuid_t));
+	opt_uuid = g_try_malloc(sizeof(bt_uuid_t));
 	if (opt_uuid == NULL)
 		return FALSE;
 
-	if (bt_string2uuid(opt_uuid, value) < 0)
+	if (bt_string_to_uuid(opt_uuid, value) < 0)
 		return FALSE;
 
 	return TRUE;
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 1d6f42d..99e99c5 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -26,8 +26,7 @@
 #include <stdio.h>
 #include <glib.h>
 
-#include <bluetooth/sdp.h>
-#include <bluetooth/sdp_lib.h>
+#include <bluetooth/uuid.h>
 
 #include <readline/readline.h>
 #include <readline/history.h>
@@ -35,7 +34,6 @@
 #include "att.h"
 #include "btio.h"
 #include "gattrib.h"
-#include "glib-helper.h"
 #include "gatt.h"
 #include "gatttool.h"
 
@@ -54,7 +52,7 @@ struct characteristic_data {
 	uint16_t orig_start;
 	uint16_t start;
 	uint16_t end;
-	uuid_t uuid;
+	bt_uuid_t uuid;
 };
 
 static void cmd_help(int argcp, char **argvp);
@@ -237,17 +235,17 @@ static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		char uuidstr[MAX_LEN_UUID_STR];
 		uint16_t handle;
 		uint8_t *value;
-		uuid_t uuid;
+		bt_uuid_t uuid;
 
 		value = list->data[i];
 		handle = att_get_u16(value);
 
 		if (format == 0x01)
-			sdp_uuid16_create(&uuid, att_get_u16(&value[2]));
+			uuid = att_get_uuid16(&value[2]);
 		else
-			sdp_uuid128_create(&uuid, &value[2]);
+			uuid = att_get_uuid128(&value[2]);
 
-		sdp_uuid2strn(&uuid, uuidstr, MAX_LEN_UUID_STR);
+		bt_uuid_to_string(&uuid, uuidstr, MAX_LEN_UUID_STR);
 		printf("handle: 0x%04x, uuid: %s\n", handle, uuidstr);
 	}
 
@@ -378,7 +376,7 @@ static void cmd_disconnect(int argcp, char **argvp)
 
 static void cmd_primary(int argcp, char **argvp)
 {
-	uuid_t uuid;
+	bt_uuid_t uuid;
 
 	if (conn_state != STATE_CONNECTED) {
 		printf("Command failed: disconnected\n");
@@ -390,7 +388,7 @@ static void cmd_primary(int argcp, char **argvp)
 		return;
 	}
 
-	if (bt_string2uuid(&uuid, argvp[1]) < 0) {
+	if (bt_string_to_uuid(&uuid, argvp[1]) < 0) {
 		printf("Invalid UUID\n");
 		return;
 	}
@@ -509,7 +507,7 @@ static void cmd_read_uuid(int argcp, char **argvp)
 	struct characteristic_data *char_data;
 	int start = 0x0001;
 	int end = 0xffff;
-	uuid_t uuid;
+	bt_uuid_t uuid;
 
 	if (conn_state != STATE_CONNECTED) {
 		printf("Command failed: disconnected\n");
@@ -521,7 +519,7 @@ static void cmd_read_uuid(int argcp, char **argvp)
 		return;
 	}
 
-	if (bt_string2uuid(&uuid, argvp[1]) < 0) {
+	if (bt_string_to_uuid(&uuid, argvp[1]) < 0) {
 		printf("Invalid UUID\n");
 		return;
 	}
diff --git a/attrib/utils.c b/attrib/utils.c
index 8d1ca74..5f4444a 100644
--- a/attrib/utils.c
+++ b/attrib/utils.c
@@ -27,6 +27,7 @@
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
 #include <bluetooth/hci_lib.h>
+#include <bluetooth/uuid.h>
 #include <bluetooth/sdp.h>
 
 #include "gattrib.h"
diff --git a/src/adapter.c b/src/adapter.c
index e8abf42..8c368fe 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -34,6 +34,7 @@
 #include <sys/ioctl.h>
 
 #include <bluetooth/bluetooth.h>
+#include <bluetooth/uuid.h>
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 8010f1b..8151514 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -33,6 +33,7 @@
 #include <glib.h>
 
 #include <bluetooth/bluetooth.h>
+#include <bluetooth/uuid.h>
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 
@@ -81,13 +82,13 @@ static uint32_t gap_sdp_handle = 0;
 static uint16_t name_handle = 0x0000;
 static uint16_t appearance_handle = 0x0000;
 
-static uuid_t prim_uuid = {
-			.type = SDP_UUID16,
-			.value.uuid16 = GATT_PRIM_SVC_UUID
+static bt_uuid_t prim_uuid = {
+			.type = BT_UUID16,
+			.value.u16 = GATT_PRIM_SVC_UUID
 };
-static uuid_t snd_uuid = {
-			.type = SDP_UUID16,
-			.value.uuid16 = GATT_SND_SVC_UUID
+static bt_uuid_t snd_uuid = {
+			.type = BT_UUID16,
+			.value.u16 = GATT_SND_SVC_UUID
 };
 
 static sdp_record_t *server_record_new(uuid_t *uuid, uint16_t start, uint16_t end)
@@ -199,12 +200,12 @@ static uint8_t client_set_notifications(struct attribute *attr,
 	struct attribute *last_chr_val = NULL;
 	uint16_t cfg_val;
 	uint8_t props;
-	uuid_t uuid;
+	bt_uuid_t uuid;
 	GSList *l;
 
 	cfg_val = att_get_u16(attr->data);
 
-	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
+	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	for (l = database, props = 0; l != NULL; l = l->next) {
 		struct attribute *a = l->data;
 		static uint16_t handle = 0;
@@ -212,7 +213,7 @@ static uint8_t client_set_notifications(struct attribute *attr,
 		if (a->handle >= attr->handle)
 			break;
 
-		if (sdp_uuid_cmp(&a->uuid, &uuid) == 0) {
+		if (bt_uuid_cmp(&a->uuid, &uuid) == 0) {
 			props = att_get_u8(&a->data[0]);
 			handle = att_get_u16(&a->data[1]);
 			continue;
@@ -251,11 +252,11 @@ static struct attribute *client_cfg_attribute(struct gatt_channel *channel,
 						const uint8_t *value, int vlen)
 {
 	guint handle = orig_attr->handle;
-	uuid_t uuid;
+	bt_uuid_t uuid;
 	GSList *l;
 
-	sdp_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
-	if (sdp_uuid_cmp(&orig_attr->uuid, &uuid) != 0)
+	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
+	if (bt_uuid_cmp(&orig_attr->uuid, &uuid) != 0)
 		return NULL;
 
 	/* Value is unchanged, not need to create a private copy yet */
@@ -285,7 +286,7 @@ static struct attribute *client_cfg_attribute(struct gatt_channel *channel,
 }
 
 static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
-						uint16_t end, uuid_t *uuid,
+						uint16_t end, bt_uuid_t *uuid,
 						uint8_t *pdu, int len)
 {
 	struct att_data_list *adl;
@@ -305,8 +306,8 @@ static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
 	 * types may be used in the Read By Group Type Request.
 	 */
 
-	if (sdp_uuid_cmp(uuid, &prim_uuid) != 0 &&
-		sdp_uuid_cmp(uuid, &snd_uuid) != 0)
+	if (bt_uuid_cmp(uuid, &prim_uuid) != 0 &&
+		bt_uuid_cmp(uuid, &snd_uuid) != 0)
 		return enc_error_resp(ATT_OP_READ_BY_GROUP_REQ, 0x0000,
 					ATT_ECODE_UNSUPP_GRP_TYPE, pdu, len);
 
@@ -323,13 +324,13 @@ static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
 			break;
 
 		/* The old group ends when a new one starts */
-		if (old && (sdp_uuid_cmp(&a->uuid, &prim_uuid) == 0 ||
-				sdp_uuid_cmp(&a->uuid, &snd_uuid) == 0)) {
+		if (old && (bt_uuid_cmp(&a->uuid, &prim_uuid) == 0 ||
+				bt_uuid_cmp(&a->uuid, &snd_uuid) == 0)) {
 			old->end = last_handle;
 			old = NULL;
 		}
 
-		if (sdp_uuid_cmp(&a->uuid, uuid) != 0) {
+		if (bt_uuid_cmp(&a->uuid, uuid) != 0) {
 			/* Still inside a service, update its last handle */
 			if (old)
 				last_handle = a->handle;
@@ -405,7 +406,7 @@ static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
 }
 
 static uint16_t read_by_type(struct gatt_channel *channel, uint16_t start,
-						uint16_t end, uuid_t *uuid,
+						uint16_t end, bt_uuid_t *uuid,
 						uint8_t *pdu, int len)
 {
 	struct att_data_list *adl;
@@ -430,7 +431,7 @@ static uint16_t read_by_type(struct gatt_channel *channel, uint16_t start,
 		if (a->handle >= end)
 			break;
 
-		if (sdp_uuid_cmp(&a->uuid, uuid)  != 0)
+		if (bt_uuid_cmp(&a->uuid, uuid)  != 0)
 			continue;
 
 		status = att_check_reqs(channel, ATT_OP_READ_BY_TYPE_REQ,
@@ -495,7 +496,7 @@ static int find_info(uint16_t start, uint16_t end, uint8_t *pdu, int len)
 	struct attribute *a;
 	struct att_data_list *adl;
 	GSList *l, *info;
-	uint8_t format, last_type = SDP_UUID_UNSPEC;
+	uint8_t format, last_type = BT_UUID_UNSPEC;
 	uint16_t length, num;
 	int i;
 
@@ -512,7 +513,7 @@ static int find_info(uint16_t start, uint16_t end, uint8_t *pdu, int len)
 		if (a->handle > end)
 			break;
 
-		if (last_type == SDP_UUID_UNSPEC)
+		if (last_type == BT_UUID_UNSPEC)
 			last_type = a->uuid.type;
 
 		if (a->uuid.type != last_type)
@@ -528,10 +529,10 @@ static int find_info(uint16_t start, uint16_t end, uint8_t *pdu, int len)
 		return enc_error_resp(ATT_OP_FIND_INFO_REQ, start,
 					ATT_ECODE_ATTR_NOT_FOUND, pdu, len);
 
-	if (last_type == SDP_UUID16) {
+	if (last_type == BT_UUID16) {
 		length = 2;
 		format = 0x01;
-	} else if (last_type == SDP_UUID128) {
+	} else if (last_type == BT_UUID128) {
 		length = 16;
 		format = 0x02;
 	}
@@ -548,7 +549,7 @@ static int find_info(uint16_t start, uint16_t end, uint8_t *pdu, int len)
 		att_put_u16(a->handle, value);
 
 		/* Attribute Value */
-		memcpy(&value[2], &a->uuid.value, length);
+		att_put_uuid(a->uuid, &value[2]);
 	}
 
 	length = enc_find_info_resp(format, adl, pdu, len);
@@ -559,7 +560,7 @@ static int find_info(uint16_t start, uint16_t end, uint8_t *pdu, int len)
 	return length;
 }
 
-static int find_by_type(uint16_t start, uint16_t end, uuid_t *uuid,
+static int find_by_type(uint16_t start, uint16_t end, bt_uuid_t *uuid,
 			const uint8_t *value, int vlen, uint8_t *opdu, int mtu)
 {
 	struct attribute *a;
@@ -582,7 +583,7 @@ static int find_by_type(uint16_t start, uint16_t end, uuid_t *uuid,
 			break;
 
 		/* Primary service? Attribute value matches? */
-		if ((sdp_uuid_cmp(&a->uuid, uuid) == 0) && (a->len == vlen) &&
+		if ((bt_uuid_cmp(&a->uuid, uuid) == 0) && (a->len == vlen) &&
 					(memcmp(a->data, value, vlen) == 0)) {
 
 			range = g_new0(struct att_range, 1);
@@ -596,8 +597,8 @@ static int find_by_type(uint16_t start, uint16_t end, uuid_t *uuid,
 			/* Update the last found handle or reset the pointer
 			 * to track that a new group started: Primary or
 			 * Secondary service. */
-			if (sdp_uuid_cmp(&a->uuid, &prim_uuid) == 0 ||
-					sdp_uuid_cmp(&a->uuid, &snd_uuid) == 0)
+			if (bt_uuid_cmp(&a->uuid, &prim_uuid) == 0 ||
+					bt_uuid_cmp(&a->uuid, &snd_uuid) == 0)
 				range = NULL;
 			else
 				range->end = a->handle;
@@ -632,7 +633,7 @@ static struct attribute *find_primary_range(uint16_t start, uint16_t *end)
 
 	attrib = l->data;
 
-	if (sdp_uuid_cmp(&attrib->uuid, &prim_uuid) != 0)
+	if (bt_uuid_cmp(&attrib->uuid, &prim_uuid) != 0)
 		return NULL;
 
 	*end = start;
@@ -640,8 +641,8 @@ static struct attribute *find_primary_range(uint16_t start, uint16_t *end)
 	for (l = l->next; l; l = l->next) {
 		struct attribute *a = l->data;
 
-		if (sdp_uuid_cmp(&a->uuid, &prim_uuid) == 0 ||
-				sdp_uuid_cmp(&a->uuid, &snd_uuid) == 0)
+		if (bt_uuid_cmp(&a->uuid, &prim_uuid) == 0 ||
+				bt_uuid_cmp(&a->uuid, &snd_uuid) == 0)
 			break;
 
 		*end = a->handle;
@@ -795,7 +796,7 @@ static void channel_handler(const uint8_t *ipdu, uint16_t len,
 	struct gatt_channel *channel = user_data;
 	uint8_t opdu[ATT_MAX_MTU], value[ATT_MAX_MTU];
 	uint16_t length, start, end, mtu, offset;
-	uuid_t uuid;
+	bt_uuid_t uuid;
 	uint8_t status = 0;
 	int vlen;
 
@@ -1014,37 +1015,37 @@ static void attrib_notify_clients(struct attribute *attr)
 static gboolean register_core_services(void)
 {
 	uint8_t atval[256];
-	uuid_t uuid;
+	bt_uuid_t uuid;
 	uint16_t appearance = 0x0000;
 
 	/* GAP service: primary service definition */
-	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
+	bt_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
 	att_put_u16(GENERIC_ACCESS_PROFILE_ID, &atval[0]);
 	attrib_db_add(0x0001, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
 	/* GAP service: device name characteristic */
 	name_handle = 0x0006;
-	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
+	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(name_handle, &atval[1]);
 	att_put_u16(GATT_CHARAC_DEVICE_NAME, &atval[3]);
 	attrib_db_add(0x0004, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* GAP service: device name attribute */
-	sdp_uuid16_create(&uuid, GATT_CHARAC_DEVICE_NAME);
+	bt_uuid16_create(&uuid, GATT_CHARAC_DEVICE_NAME);
 	attrib_db_add(name_handle, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
 								NULL, 0);
 
 	/* GAP service: device appearance characteristic */
 	appearance_handle = 0x0008;
-	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
+	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(appearance_handle, &atval[1]);
 	att_put_u16(GATT_CHARAC_APPEARANCE, &atval[3]);
 	attrib_db_add(0x0007, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* GAP service: device appearance attribute */
-	sdp_uuid16_create(&uuid, GATT_CHARAC_APPEARANCE);
+	bt_uuid16_create(&uuid, GATT_CHARAC_APPEARANCE);
 	att_put_u16(appearance, &atval[0]);
 	attrib_db_add(appearance_handle, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
 								atval, 2);
@@ -1056,7 +1057,7 @@ static gboolean register_core_services(void)
 	}
 
 	/* GATT service: primary service definition */
-	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
+	bt_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
 	att_put_u16(GENERIC_ATTRIB_PROFILE_ID, &atval[0]);
 	attrib_db_add(0x0010, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
@@ -1213,7 +1214,7 @@ void attrib_free_sdp(uint32_t sdp_handle)
 	remove_record_from_server(sdp_handle);
 }
 
-struct attribute *attrib_db_add(uint16_t handle, uuid_t *uuid, int read_reqs,
+struct attribute *attrib_db_add(uint16_t handle, bt_uuid_t *uuid, int read_reqs,
 				int write_reqs, const uint8_t *value, int len)
 {
 	struct attribute *a;
@@ -1222,7 +1223,7 @@ struct attribute *attrib_db_add(uint16_t handle, uuid_t *uuid, int read_reqs,
 
 	a = g_malloc0(sizeof(struct attribute) + len);
 	a->handle = handle;
-	memcpy(&a->uuid, uuid, sizeof(uuid_t));
+	memcpy(&a->uuid, uuid, sizeof(bt_uuid_t));
 	a->read_reqs = read_reqs;
 	a->write_reqs = write_reqs;
 	a->len = len;
@@ -1233,7 +1234,7 @@ struct attribute *attrib_db_add(uint16_t handle, uuid_t *uuid, int read_reqs,
 	return a;
 }
 
-int attrib_db_update(uint16_t handle, uuid_t *uuid, const uint8_t *value,
+int attrib_db_update(uint16_t handle, bt_uuid_t *uuid, const uint8_t *value,
 								int len)
 {
 	struct attribute *a;
@@ -1251,7 +1252,7 @@ int attrib_db_update(uint16_t handle, uuid_t *uuid, const uint8_t *value,
 	l->data = a;
 	a->handle = handle;
 	if (uuid != &a->uuid)
-		memcpy(&a->uuid, uuid, sizeof(uuid_t));
+		memcpy(&a->uuid, uuid, sizeof(bt_uuid_t));
 	a->len = len;
 	memcpy(a->data, value, len);
 
@@ -1279,12 +1280,12 @@ int attrib_db_del(uint16_t handle)
 
 int attrib_gap_set(uint16_t uuid, const uint8_t *value, int len)
 {
-	uuid_t u16;
+	bt_uuid_t u16;
 	uint16_t handle;
 
 	/* FIXME: Missing Privacy and Reconnection Address */
 
-	sdp_uuid16_create(&u16, uuid);
+	bt_uuid16_create(&u16, uuid);
 
 	switch (uuid) {
 	case GATT_CHARAC_DEVICE_NAME:
diff --git a/src/attrib-server.h b/src/attrib-server.h
index 85f3bdb..c03d3c5 100644
--- a/src/attrib-server.h
+++ b/src/attrib-server.h
@@ -25,9 +25,9 @@
 int attrib_server_init(void);
 void attrib_server_exit(void);
 
-struct attribute *attrib_db_add(uint16_t handle, uuid_t *uuid, int read_reqs,
+struct attribute *attrib_db_add(uint16_t handle, bt_uuid_t *uuid, int read_reqs,
 				int write_reqs, const uint8_t *value, int len);
-int attrib_db_update(uint16_t handle, uuid_t *uuid, const uint8_t *value,
+int attrib_db_update(uint16_t handle, bt_uuid_t *uuid, const uint8_t *value,
 								int len);
 int attrib_db_del(uint16_t handle);
 int attrib_gap_set(uint16_t uuid, const uint8_t *value, int len);
diff --git a/src/device.c b/src/device.c
index 529e0de..e9d9e65 100644
--- a/src/device.c
+++ b/src/device.c
@@ -35,6 +35,7 @@
 #include <errno.h>
 
 #include <bluetooth/bluetooth.h>
+#include <bluetooth/uuid.h>
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 
diff --git a/src/main.c b/src/main.c
index 1aaa181..c454327 100644
--- a/src/main.c
+++ b/src/main.c
@@ -39,6 +39,7 @@
 #include <sys/types.h>
 
 #include <bluetooth/bluetooth.h>
+#include <bluetooth/uuid.h>
 
 #include <glib.h>
 
-- 
1.7.1

