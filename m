Return-Path: <cyrus@holtmann.org>
From: "Dirk-Jan C. Binnema" <djcb.bulk@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: "Dirk-Jan C. Binnema" <djcb@djcbsoftware.nl>
Subject: [PATCH 3/3] Add support for 128-bit characteristic uuids in gatt_service_add
Date: Mon, 29 Jul 2013 11:42:50 -0700
Message-Id: <1375123370-20055-3-git-send-email-djcb.bulk@gmail.com>
In-Reply-To: <1375123370-20055-1-git-send-email-djcb.bulk@gmail.com>
References: <1375123370-20055-1-git-send-email-djcb.bulk@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Dirk-Jan C. Binnema" <djcb@djcbsoftware.nl>

Custom GATT services typically use 128-bits UUIDs; this patch allows for using
gatt_service_add to define such services by adding a new option GATT_OPT_CHR_UUID,
which allows for passing bt_uuid_t* values. Note, a previous patch renamed the
old GATT_OPT_CHR_UUID into GATT_OPT_CHR_UUID16.
---
 attrib/gatt-service.c | 17 ++++++++++++-----
 attrib/gatt-service.h |  6 ++++++
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/attrib/gatt-service.c b/attrib/gatt-service.c
index 6ae3902..4cd300f 100644
--- a/attrib/gatt-service.c
+++ b/attrib/gatt-service.c
@@ -73,6 +73,12 @@ static GSList *parse_opts(gatt_option opt1, va_list args)
 			/* characteristic declaration and value */
 			info->num_attrs += 2;
 			break;
+		case GATT_OPT_CHR_UUID:
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
-		if (opt == GATT_OPT_CHR_UUID16) {
+		if (opt == GATT_OPT_CHR_UUID16 || opt == GATT_OPT_CHR_UUID) {
 			info = g_new0(struct gatt_info, 1);
 			l = g_slist_append(l, info);
 		}
@@ -183,10 +189,11 @@ static gboolean add_characteristic(struct btd_adapter *adapter,
 	uint16_t h = *handle;
 	struct attribute *a;
 	bt_uuid_t bt_uuid;
-	uint8_t atval[5];
+	uint8_t atval[ATT_MAX_VALUE_LEN];
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
+				atval, 3 + info->uuid.type / 8) == NULL)
 		return FALSE;
 
 	/* characteristic value */
diff --git a/attrib/gatt-service.h b/attrib/gatt-service.h
index 3964c2b..728d3a8 100644
--- a/attrib/gatt-service.h
+++ b/attrib/gatt-service.h
@@ -24,7 +24,13 @@
 
 typedef enum {
 	GATT_OPT_INVALID = 0,
+
+	/* bt_uuid_t* value */
+	GATT_OPT_CHR_UUID,
+
+	/* a uint16 value */
 	GATT_OPT_CHR_UUID16,
+
 	GATT_OPT_CHR_PROPS,
 	GATT_OPT_CHR_VALUE_CB,
 	GATT_OPT_CHR_AUTHENTICATION,
-- 
1.8.1.4

