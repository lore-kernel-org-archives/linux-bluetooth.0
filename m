Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/8] core/gatt: Add support for encryption flags
Date: Mon, 27 Apr 2015 16:14:29 +0300
Message-Id: <1430140475-20349-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1430140475-20349-1-git-send-email-luiz.dentz@gmail.com>
References: <1430140475-20349-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support to encryption related flags as defined in the
documentation.
---
 src/gatt-database.c    | 34 +++++++++++++++++++++++++++++++---
 src/shared/att-types.h | 30 ++++++++++++++++++++++--------
 2 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 2261398..cf75b41 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1241,7 +1241,19 @@ static bool parse_flags(GDBusProxy *proxy, uint8_t *props, uint8_t *ext_props)
 			*ext_props |= BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE;
 		else if (!strcmp("writable-auxiliaries", flag))
 			*ext_props |= BT_GATT_CHRC_EXT_PROP_WRITABLE_AUX;
-		else {
+		else if (!strcmp("encrypt-read", flag)) {
+			*props |= BT_GATT_CHRC_PROP_READ;
+			*ext_props |= BT_GATT_CHRC_EXT_PROP_ENC_READ;
+		} else if (!strcmp("encrypt-write", flag)) {
+			*props |= BT_GATT_CHRC_PROP_WRITE;
+			*ext_props |= BT_GATT_CHRC_EXT_PROP_ENC_WRITE;
+		} else if (!strcmp("encrypt-authenticated-read", flag)) {
+			*props |= BT_GATT_CHRC_PROP_READ;
+			*ext_props |= BT_GATT_CHRC_EXT_PROP_AUTH_READ;
+		} else if (!strcmp("encrypt-authenticated-write", flag)) {
+			*props |= BT_GATT_CHRC_PROP_WRITE;
+			*ext_props |= BT_GATT_CHRC_EXT_PROP_AUTH_WRITE;
+		} else {
 			error("Invalid characteristic flag: %s", flag);
 			return false;
 		}
@@ -1668,12 +1680,28 @@ static uint32_t permissions_from_props(uint8_t props, uint8_t ext_props)
 
 	if (props & BT_GATT_CHRC_PROP_WRITE ||
 			props & BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP ||
-			ext_props & BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE)
+			ext_props & BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE ||
+			ext_props & BT_GATT_CHRC_EXT_PROP_ENC_WRITE ||
+			ext_props & BT_GATT_CHRC_EXT_PROP_AUTH_WRITE)
 		perm |= BT_ATT_PERM_WRITE;
 
-	if (props & BT_GATT_CHRC_PROP_READ)
+	if (props & BT_GATT_CHRC_PROP_READ ||
+			ext_props & BT_GATT_CHRC_EXT_PROP_ENC_READ ||
+			ext_props & BT_GATT_CHRC_EXT_PROP_AUTH_READ)
 		perm |= BT_ATT_PERM_READ;
 
+	if (ext_props & BT_GATT_CHRC_EXT_PROP_ENC_READ)
+		perm |= BT_ATT_PERM_READ_ENCRYPT;
+
+	if (ext_props & BT_GATT_CHRC_EXT_PROP_ENC_WRITE)
+		perm |= BT_ATT_PERM_WRITE_ENCRYPT;
+
+	if (ext_props & BT_GATT_CHRC_EXT_PROP_AUTH_READ)
+		perm |= BT_ATT_PERM_READ_AUTHEN;
+
+	if (ext_props & BT_GATT_CHRC_EXT_PROP_AUTH_WRITE)
+		perm |= BT_ATT_PERM_WRITE_AUTHEN;
+
 	return perm;
 }
 
diff --git a/src/shared/att-types.h b/src/shared/att-types.h
index 10a42f2..ce531d1 100644
--- a/src/shared/att-types.h
+++ b/src/shared/att-types.h
@@ -106,12 +106,18 @@ struct bt_att_pdu_error_rsp {
  * "Access", "Encryption", "Authentication", and "Authorization". A bitmask of
  * permissions is a byte that encodes a combination of these.
  */
-#define BT_ATT_PERM_READ	0x01
-#define BT_ATT_PERM_WRITE	0x02
-#define BT_ATT_PERM_ENCRYPT	0x04
-#define BT_ATT_PERM_AUTHEN	0x08
-#define BT_ATT_PERM_AUTHOR	0x10
-#define BT_ATT_PERM_NONE	0x20
+#define BT_ATT_PERM_READ		0x01
+#define BT_ATT_PERM_WRITE		0x02
+#define BT_ATT_PERM_READ_ENCRYPT	0x04
+#define BT_ATT_PERM_WRITE_ENCRYPT	0x08
+#define BT_ATT_PERM_ENCRYPT		BT_ATT_PERM_READ_ENCRYPT | \
+					BT_ATT_PERM_WRITE_ENCRYPT
+#define BT_ATT_PERM_READ_AUTHEN		0x10
+#define BT_ATT_PERM_WRITE_AUTHEN	0x20
+#define BT_ATT_PERM_AUTHEN		BT_ATT_PERM_READ_AUTHEN | \
+					BT_ATT_PERM_WRITE_AUTHEN
+#define BT_ATT_PERM_AUTHOR		0x40
+#define BT_ATT_PERM_NONE		0x80
 
 /* GATT Characteristic Properties Bitfield values */
 #define BT_GATT_CHRC_PROP_BROADCAST			0x01
@@ -124,5 +130,13 @@ struct bt_att_pdu_error_rsp {
 #define BT_GATT_CHRC_PROP_EXT_PROP			0x80
 
 /* GATT Characteristic Extended Properties Bitfield values */
-#define BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE	0x01
-#define BT_GATT_CHRC_EXT_PROP_WRITABLE_AUX	0x02
+#define BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE		0x01
+#define BT_GATT_CHRC_EXT_PROP_WRITABLE_AUX		0x02
+#define BT_GATT_CHRC_EXT_PROP_ENC_READ			0x04
+#define BT_GATT_CHRC_EXT_PROP_ENC_WRITE			0x08
+#define BT_GATT_CHRC_EXT_PROP_ENC	BT_GATT_CHRC_EXT_PROP_ENC_READ | \
+					BT_GATT_CHRC_EXT_PROP_ENC_WRITE
+#define BT_GATT_CHRC_EXT_PROP_AUTH_READ			0x10
+#define BT_GATT_CHRC_EXT_PROP_AUTH_WRITE		0x20
+#define BT_GATT_CHRC_EXT_PROP_AUTH	BT_GATT_CHRC_EXT_PROP_AUTH_READ | \
+					BT_GATT_CHRC_EXT_PROP_AUTH_WRITE
-- 
2.1.0

