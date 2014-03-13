Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org,
	Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH BlueZ v2 04/17] gatt: Add helper for creating GATT characteristics
Date: Thu, 13 Mar 2014 11:38:40 -0300
Message-Id: <1394721533-6932-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1394721533-6932-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1394641631-1534-1-git-send-email-claudio.takahasi@openbossa.org>
 <1394721533-6932-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andre Guedes <andre.guedes@openbossa.org>

This patch adds btd_gatt_add_char() helper. It creates and adds the
Characteristic declaration, and Characteristic value attributes to the
local attribute database.
---
 src/gatt.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/gatt.h | 12 +++++++++
 2 files changed, 100 insertions(+)

diff --git a/src/gatt.c b/src/gatt.c
index a4d1665..41d03cd 100644
--- a/src/gatt.c
+++ b/src/gatt.c
@@ -39,6 +39,9 @@
 static const bt_uuid_t primary_uuid  = { .type = BT_UUID16,
 					.value.u16 = GATT_PRIM_SVC_UUID };
 
+static const bt_uuid_t chr_uuid = { .type = BT_UUID16,
+					.value.u16 = GATT_CHARAC_UUID };
+
 struct btd_attribute {
 	uint16_t handle;
 	bt_uuid_t type;
@@ -116,6 +119,91 @@ struct btd_attribute *btd_gatt_add_service(const bt_uuid_t *uuid)
 	return attr;
 }
 
+struct btd_attribute *btd_gatt_add_char(const bt_uuid_t *uuid,
+							uint8_t properties)
+{
+	struct btd_attribute *char_decl, *char_value = NULL;
+
+	/* Attribute value length */
+	uint16_t len = 1 + 2 + bt_uuid_len(uuid);
+	uint8_t value[len];
+
+	/*
+	 * Characteristic DECLARATION
+	 *
+	 *   TYPE         ATTRIBUTE VALUE
+	 * +-------+---------------------------------+
+	 * |0x2803 | 0xXX 0xYYYY 0xZZZZ...           |
+	 * | (1)   |  (2)   (3)   (4)                |
+	 * +------+----------------------------------+
+	 * (1) - 2 octets: Characteristic declaration UUID
+	 * (2) - 1 octet : Properties
+	 * (3) - 2 octets: Handle of the characteristic Value
+	 * (4) - 2 or 16 octets: Characteristic UUID
+	 */
+
+	value[0] = properties;
+
+	/*
+	 * Since we don't know yet the characteristic value attribute
+	 * handle, we skip and set it later.
+	 */
+
+	put_uuid(uuid, &value[3]);
+
+	char_decl = new_const_attribute(&chr_uuid, value, len);
+	if (char_decl == NULL)
+		goto fail;
+
+	char_value = new0(struct btd_attribute, 1);
+	if (char_value == NULL)
+		goto fail;
+
+	if (local_database_add(next_handle, char_decl) < 0)
+		goto fail;
+
+	next_handle = next_handle + 1;
+
+	/*
+	 * Characteristic VALUE
+	 *
+	 *   TYPE         ATTRIBUTE VALUE
+	 * +----------+---------------------------------+
+	 * |0xZZZZ... | 0x...                           |
+	 * |  (1)     |  (2)                            |
+	 * +----------+---------------------------------+
+	 * (1) - 2 or 16 octets: Characteristic UUID
+	 * (2) - N octets: Value is read dynamically from the service
+	 * implementation (external entity).
+	 */
+
+	char_value->type = *uuid;
+
+	/* TODO: Read & Write callbacks */
+
+	if (local_database_add(next_handle, char_value) < 0)
+		/* TODO: remove declaration */
+		goto fail;
+
+	next_handle = next_handle + 1;
+
+	/*
+	 * Update characteristic value handle in characteristic declaration
+	 * attribute. For local attributes, we can assume that the handle
+	 * representing the characteristic value will get the next available
+	 * handle. However, for remote attribute this assumption is not valid.
+	 */
+	put_le16(char_value->handle, &char_decl->value[1]);
+
+	return char_value;
+
+fail:
+	free(char_decl);
+	free(char_value);
+
+	return NULL;
+}
+
 void gatt_init(void)
 {
 	DBG("Starting GATT server");
diff --git a/src/gatt.h b/src/gatt.h
index 8dd1312..d7acc5b 100644
--- a/src/gatt.h
+++ b/src/gatt.h
@@ -34,3 +34,15 @@ void gatt_cleanup(void);
  * NULL is returned.
  */
 struct btd_attribute *btd_gatt_add_service(const bt_uuid_t *uuid);
+
+/*
+ * btd_gatt_add_char - Add a characteristic (declaration and value attributes)
+ * to local attribute database.
+ * @uuid:	Characteristic UUID (16-bits or 128-bits).
+ * @properties:	Characteristic properties. See Core SPEC 4.1 page 2183.
+ *
+ * Returns a reference to characteristic value attribute. In case of error,
+ * NULL is returned.
+ */
+struct btd_attribute *btd_gatt_add_char(const bt_uuid_t *uuid,
+							uint8_t properties);
-- 
1.8.3.1

