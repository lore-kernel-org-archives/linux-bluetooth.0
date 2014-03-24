Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 18/22] Replace att_put_uuid() by util.h helpers
Date: Mon, 24 Mar 2014 16:25:39 -0300
Message-Id: <1395689143-11091-19-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395689143-11091-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
 <1395689143-11091-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/att.c          | 13 +++++++++++--
 attrib/gatt-service.c | 22 +++++++++++++---------
 src/attrib-server.c   | 11 ++++++++++-
 3 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index bd23142..bdf7c00 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -38,6 +38,15 @@
 #include "lib/uuid.h"
 #include "att.h"
 
+static inline void put_uuid_le(const bt_uuid_t *src, void *dst)
+{
+	if (src->type == BT_UUID16)
+		put_le16(src->value.u16, dst);
+	else
+		/* Convert from 128-bit BE to LE */
+		bswap_128(&src->value.u128, dst);
+}
+
 const char *att_ecode2str(uint8_t status)
 {
 	switch (status)  {
@@ -156,7 +165,7 @@ uint16_t enc_read_by_grp_req(uint16_t start, uint16_t end, bt_uuid_t *uuid,
 	/* Ending Handle (2 octets) */
 	att_put_u16(end, &pdu[3]);
 	/* Attribute Group Type (2 or 16 octet UUID) */
-	att_put_uuid(*uuid, &pdu[5]);
+	put_uuid_le(uuid, &pdu[5]);
 
 	return 5 + uuid_len;
 }
@@ -401,7 +410,7 @@ uint16_t enc_read_by_type_req(uint16_t start, uint16_t end, bt_uuid_t *uuid,
 	/* Ending Handle (2 octets) */
 	att_put_u16(end, &pdu[3]);
 	/* Attribute Type (2 or 16 octet UUID) */
-	att_put_uuid(*uuid, &pdu[5]);
+	put_uuid_le(uuid, &pdu[5]);
 
 	return 5 + uuid_len;
 }
diff --git a/attrib/gatt-service.c b/attrib/gatt-service.c
index 227d4d4..699ac1e 100644
--- a/attrib/gatt-service.c
+++ b/attrib/gatt-service.c
@@ -30,6 +30,7 @@
 #include <bluetooth/sdp.h>
 
 #include "src/adapter.h"
+#include "src/shared/util.h"
 #include "lib/uuid.h"
 #include "attrib/gattrib.h"
 #include "attrib/att.h"
@@ -56,6 +57,15 @@ struct attrib_cb {
 	void *user_data;
 };
 
+static inline void put_uuid_le(const bt_uuid_t *src, void *dst)
+{
+	if (src->type == BT_UUID16)
+		put_le16(src->value.u16, dst);
+	else
+		/* Convert from 128-bit BE to LE */
+		bswap_128(&src->value.u128, dst);
+}
+
 static GSList *parse_opts(gatt_option opt1, va_list args)
 {
 	gatt_option opt = opt1;
@@ -130,14 +140,8 @@ static struct attribute *add_service_declaration(struct btd_adapter *adapter,
 	uint8_t atval[16];
 	int len;
 
-	if (uuid->type == BT_UUID16) {
-		att_put_u16(uuid->value.u16, &atval[0]);
-		len = 2;
-	} else if (uuid->type == BT_UUID128) {
-		att_put_u128(uuid->value.u128, &atval[0]);
-		len = 16;
-	} else
-		return NULL;
+	put_uuid_le(uuid, &atval[0]);
+	len = bt_uuid_len(uuid);
 
 	bt_uuid16_create(&bt_uuid, svc);
 
@@ -229,7 +233,7 @@ static gboolean add_characteristic(struct btd_adapter *adapter,
 	bt_uuid16_create(&bt_uuid, GATT_CHARAC_UUID);
 	atval[0] = info->props;
 	att_put_u16(h + 1, &atval[1]);
-	att_put_uuid(info->uuid, &atval[3]);
+	put_uuid_le(&info->uuid, &atval[3]);
 	if (attrib_db_add(adapter, h++, &bt_uuid, ATT_NONE, ATT_NOT_PERMITTED,
 				atval, 3 + info->uuid.type / 8) == NULL)
 		return FALSE;
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 85e63a6..cb27315 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -102,6 +102,15 @@ static bt_uuid_t ccc_uuid = {
 			.value.u16 = GATT_CLIENT_CHARAC_CFG_UUID
 };
 
+static inline void put_uuid_le(const bt_uuid_t *src, void *dst)
+{
+	if (src->type == BT_UUID16)
+		put_le16(src->value.u16, dst);
+	else
+		/* Convert from 128-bit BE to LE */
+		bswap_128(&src->value.u128, dst);
+}
+
 static void attrib_free(void *data)
 {
 	struct attribute *a = data;
@@ -676,7 +685,7 @@ static uint16_t find_info(struct gatt_channel *channel, uint16_t start,
 		att_put_u16(a->handle, value);
 
 		/* Attribute Value */
-		att_put_uuid(a->uuid, &value[2]);
+		put_uuid_le(&a->uuid, &value[2]);
 	}
 
 	length = enc_find_info_resp(format, adl, pdu, len);
-- 
1.8.3.1

