Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH RFC BlueZ 2/3] Add GATT_OPT_CHR_VALUE_GET_HANDLE to gatt_service_add()
Date: Thu, 22 Sep 2011 16:56:37 -0400
Message-Id: <1316724998-1466-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1316724998-1466-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1316724998-1466-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This new parameter accepts a pointer to a variable where the attribute
handle for the characteristic value is stored.
---
 attrib/gatt-service.c |    7 +++++++
 attrib/gatt-service.h |    3 +++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/attrib/gatt-service.c b/attrib/gatt-service.c
index c6da71a..5bfeb0e 100644
--- a/attrib/gatt-service.c
+++ b/attrib/gatt-service.c
@@ -44,6 +44,7 @@ struct gatt_info {
 	int authorization;
 	GSList *callbacks;
 	unsigned int num_attrs;
+	uint16_t *value_handle;
 };
 
 struct attrib_cb {
@@ -85,6 +86,9 @@ static GSList *parse_opts(gatt_option opt1, va_list args)
 			cb->fn = va_arg(args, void *);
 			info->callbacks = g_slist_append(info->callbacks, cb);
 			break;
+		case GATT_OPT_CHR_VALUE_GET_HANDLE:
+			info->value_handle = va_arg(args, void *);
+			break;
 		case GATT_OPT_CHR_AUTHENTICATION:
 			info->authentication = va_arg(args, gatt_option);
 			break;
@@ -205,6 +209,9 @@ static gboolean add_characteristic(uint16_t *handle, struct gatt_info *info)
 		}
 	}
 
+	if (info->value_handle)
+		*info->value_handle = a->handle;
+
 	/* client characteristic configuration descriptor */
 	if (info->props & (ATT_CHAR_PROPER_NOTIFY | ATT_CHAR_PROPER_INDICATE)) {
 		uint8_t cfg_val[2];
diff --git a/attrib/gatt-service.h b/attrib/gatt-service.h
index 83e0bea..ab403fd 100644
--- a/attrib/gatt-service.h
+++ b/attrib/gatt-service.h
@@ -30,6 +30,9 @@ typedef enum {
 	GATT_OPT_CHR_AUTHENTICATION,
 	GATT_OPT_CHR_AUTHORIZATION,
 
+	/* Get attribute handle for characteristic value */
+	GATT_OPT_CHR_VALUE_GET_HANDLE,
+
 	/* arguments for authentication/authorization */
 	GATT_CHR_VALUE_READ,
 	GATT_CHR_VALUE_WRITE,
-- 
1.7.0.4

