Return-Path: <cyrus@holtmann.org>
From: "Dirk-Jan C. Binnema" <djcb.bulk@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: "Dirk-Jan C. Binnema" <djcb@djcbsoftware.nl>
Subject: [PATCH] attrib/gatt_service_add: support 128-bit uuids for characteristics
Date: Wed, 24 Jul 2013 10:32:36 +0300
Message-Id: <1374651156-19959-1-git-send-email-djcb.bulk@gmail.com>
In-Reply-To: <20130724045756.GC14367@x220.p-661hnu-f1>
References: <20130724045756.GC14367@x220.p-661hnu-f1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Dirk-Jan C. Binnema" <djcb@djcbsoftware.nl>

Add GATT_OPT_CHR_BT_UUID_T, which does what GATT_OPT_CHR_UUID does, but
instead takes a bt_uuid_t*, so 128-bit uuids are supported as well.

GATT_OPT_CHR_UUID is kept around for backward compatibility.
---
 attrib/gatt-service.c | 19 +++++++++++++------
 attrib/gatt-service.h |  1 +
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/attrib/gatt-service.c b/attrib/gatt-service.c
index 4b02d39..b9e5a70 100644
--- a/attrib/gatt-service.c
+++ b/attrib/gatt-service.c
@@ -73,6 +73,12 @@ static GSList *parse_opts(gatt_option opt1, va_list args)
 			/* characteristic declaration and value */
 			info->num_attrs += 2;
 			break;
+		case GATT_OPT_CHR_BT_UUID_T:
+			memcpy(&info->uuid, va_arg(args, bt_uuid_t *),
+				sizeof(bt_uuid_t));
+			/* characteristic declaration and value */
+			info->num_attrs += 2;
+			break;
 		case GATT_OPT_CHR_PROPS:
 			info->props = va_arg(args, int);
 
@@ -108,7 +114,7 @@ static GSList *parse_opts(gatt_option opt1, va_list args)
 		}
 
 		opt = va_arg(args, gatt_option);
-		if (opt == GATT_OPT_CHR_UUID) {
+		if (opt == GATT_OPT_CHR_UUID || opt == GATT_OPT_CHR_BT_UUID_T) {
 			info = g_new0(struct gatt_info, 1);
 			l = g_slist_append(l, info);
 		}
@@ -183,10 +189,11 @@ static gboolean add_characteristic(struct btd_adapter *adapter,
 	uint16_t h = *handle;
 	struct attribute *a;
 	bt_uuid_t bt_uuid;
-	uint8_t atval[5];
+	uint8_t atval[131];
 	GSList *l;
 
-	if (!info->uuid.value.u16 || !info->props) {
+	if ((info->uuid.type != BT_UUID16 && info->uuid.type != BT_UUID128) ||
+		!info->props) {
 		error("Characteristic UUID or properties are missing");
 		return FALSE;
 	}
@@ -222,9 +229,9 @@ static gboolean add_characteristic(struct btd_adapter *adapter,
 	bt_uuid16_create(&bt_uuid, GATT_CHARAC_UUID);
 	atval[0] = info->props;
 	att_put_u16(h + 1, &atval[1]);
-	att_put_u16(info->uuid.value.u16, &atval[3]);
+	att_put_uuid(info->uuid, &atval[3]);
 	if (attrib_db_add(adapter, h++, &bt_uuid, ATT_NONE, ATT_NOT_PERMITTED,
-						atval, sizeof(atval)) == NULL)
+				atval, 3 + info->uuid.type/8) == NULL)
 		return FALSE;
 
 	/* characteristic value */
@@ -341,7 +348,7 @@ gboolean gatt_service_add(struct btd_adapter *adapter, uint16_t uuid,
 	}
 
 	g_assert(size < USHRT_MAX);
-	g_assert(h - start_handle == (uint16_t) size);
+	g_assert((uint16_t) (h - start_handle) == (uint16_t) size);
 	g_slist_free_full(chrs, free_gatt_info);
 
 	return TRUE;
diff --git a/attrib/gatt-service.h b/attrib/gatt-service.h
index b810e2e..5c3e15d 100644
--- a/attrib/gatt-service.h
+++ b/attrib/gatt-service.h
@@ -25,6 +25,7 @@
 typedef enum {
 	GATT_OPT_INVALID = 0,
 	GATT_OPT_CHR_UUID,
+	GATT_OPT_CHR_BT_UUID_T,
 	GATT_OPT_CHR_PROPS,
 	GATT_OPT_CHR_VALUE_CB,
 	GATT_OPT_CHR_AUTHENTICATION,
-- 
1.8.3.2

