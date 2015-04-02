Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH ] core/gatt: Parse InProgress error code from err_msg
Date: Thu, 02 Apr 2015 14:56:23 +0530
Message-id: <1427966783-15629-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In Common Profile and Service Error Code descriptions (Supplement
to Bluetooth Core Specification, sections 1.2 and 2), it is
mentioned that following error codes are sent over the Attribute
Protocol.
1)Client Characteristic Configuration Descriptor Improperly Configured(0xFD)
2)Procedure Already in Progress(0xFE)
3)Out of Range(0xFF)

It should be treated as ATT Error codes. So, moved those to att-types.h
and handled org.bluez.Error.InProgress.
---
 src/gatt-database.c    |  4 +++-
 src/shared/att-types.h | 10 ++++++++++
 src/shared/att.c       | 10 ----------
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index bbeb7cd..fd456e5 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1441,7 +1441,6 @@ static bool parse_primary(GDBusProxy *proxy, bool *primary)
 
 static uint8_t dbus_error_to_att_ecode(const char *error_name)
 {
-	/* TODO: Parse error ATT ecode from error_message */
 
 	if (strcmp(error_name, "org.bluez.Error.Failed") == 0)
 		return 0x80;  /* For now return this "application error" */
@@ -1455,6 +1454,9 @@ static uint8_t dbus_error_to_att_ecode(const char *error_name)
 	if (strcmp(error_name, "org.bluez.Error.InvalidValueLength") == 0)
 		return BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN;
 
+	if (strcmp(error_name, "org.bluez.Error.InProgress") == 0)
+		return BT_ERROR_ALREADY_IN_PROGRESS;
+
 	return 0;
 }
 
diff --git a/src/shared/att-types.h b/src/shared/att-types.h
index aa7f0da..10a42f2 100644
--- a/src/shared/att-types.h
+++ b/src/shared/att-types.h
@@ -92,6 +92,16 @@ struct bt_att_pdu_error_rsp {
 #define BT_ATT_ERROR_INSUFFICIENT_RESOURCES		0x11
 
 /*
+ * Common Profile and Service Error Code descriptions (see Supplement to the
+ * Bluetooth Core Specification, sections 1.2 and 2). The error codes within
+ * 0xE0-0xFC are reserved for future use. The remaining 3 are defined as the
+ * following:
+ */
+#define BT_ERROR_CCC_IMPROPERLY_CONFIGURED      0xfd
+#define BT_ERROR_ALREADY_IN_PROGRESS            0xfe
+#define BT_ERROR_OUT_OF_RANGE                   0xff
+
+/*
  * ATT attribute permission bitfield values. Permissions are grouped as
  * "Access", "Encryption", "Authentication", and "Authorization". A bitmask of
  * permissions is a byte that encodes a combination of these.
diff --git a/src/shared/att.c b/src/shared/att.c
index 422cc2c..b920eb8 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -43,16 +43,6 @@
 #define ATT_OP_SIGNED_MASK		0x80
 #define ATT_TIMEOUT_INTERVAL		30000  /* 30000 ms */
 
-/*
- * Common Profile and Service Error Code descriptions (see Supplement to the
- * Bluetooth Core Specification, sections 1.2 and 2). The error codes within
- * 0xE0-0xFC are reserved for future use. The remaining 3 are defined as the
- * following:
- */
-#define BT_ERROR_CCC_IMPROPERLY_CONFIGURED	0xfd
-#define BT_ERROR_ALREADY_IN_PROGRESS		0xfe
-#define BT_ERROR_OUT_OF_RANGE			0xff
-
 /* Length of signature in write signed packet */
 #define BT_ATT_SIGNATURE_LEN		12
 
-- 
1.9.1

