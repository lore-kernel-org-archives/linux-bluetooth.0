Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 3/4] Add support for getting the handle of the CCC attribute
Date: Fri,  4 Nov 2011 10:30:02 -0400
Message-Id: <1320417003-23493-4-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1320417003-23493-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1320417003-23493-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

---
 attrib/gatt-service.c |    9 ++++++++-
 attrib/gatt-service.h |    3 +++
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/attrib/gatt-service.c b/attrib/gatt-service.c
index b8f2503..3199830 100644
--- a/attrib/gatt-service.c
+++ b/attrib/gatt-service.c
@@ -45,6 +45,7 @@ struct gatt_info {
 	GSList *callbacks;
 	unsigned int num_attrs;
 	uint16_t *value_handle;
+	uint16_t *ccc_handle;
 };
 
 struct attrib_cb {
@@ -89,6 +90,9 @@ static GSList *parse_opts(gatt_option opt1, va_list args)
 		case GATT_OPT_CHR_VALUE_GET_HANDLE:
 			info->value_handle = va_arg(args, void *);
 			break;
+		case GATT_OPT_CCC_GET_HANDLE:
+			info->ccc_handle = va_arg(args, void *);
+			break;
 		case GATT_OPT_CHR_AUTHENTICATION:
 			info->authentication = va_arg(args, gatt_option);
 			break;
@@ -220,8 +224,11 @@ static gboolean add_characteristic(uint16_t *handle, struct gatt_info *info)
 		bt_uuid16_create(&bt_uuid, GATT_CLIENT_CHARAC_CFG_UUID);
 		cfg_val[0] = 0x00;
 		cfg_val[1] = 0x00;
-		attrib_db_add(h++, &bt_uuid, ATT_NONE, ATT_AUTHENTICATION,
+		a = attrib_db_add(h++, &bt_uuid, ATT_NONE, ATT_AUTHENTICATION,
 						cfg_val, sizeof(cfg_val));
+
+		if (info->ccc_handle)
+			*info->ccc_handle = a->handle;
 	}
 
 	*handle = h;
diff --git a/attrib/gatt-service.h b/attrib/gatt-service.h
index ab403fd..bacd987 100644
--- a/attrib/gatt-service.h
+++ b/attrib/gatt-service.h
@@ -33,6 +33,9 @@ typedef enum {
 	/* Get attribute handle for characteristic value */
 	GATT_OPT_CHR_VALUE_GET_HANDLE,
 
+	/* Get handle for ccc attribute */
+	GATT_OPT_CCC_GET_HANDLE,
+
 	/* arguments for authentication/authorization */
 	GATT_CHR_VALUE_READ,
 	GATT_CHR_VALUE_WRITE,
-- 
1.7.0.4

