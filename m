Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 10/12] android/bas: Enable notification for Battery Level characteristic
Date: Mon, 30 Jun 2014 16:47:57 +0300
Message-Id: <1404136079-24846-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1404136079-24846-1-git-send-email-luiz.dentz@gmail.com>
References: <1404136079-24846-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/bas.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 67 insertions(+), 3 deletions(-)

diff --git a/android/bas.c b/android/bas.c
index ae7d274..996f3c0 100644
--- a/android/bas.c
+++ b/android/bas.c
@@ -41,17 +41,19 @@
 
 #include "android/bas.h"
 
+#define ATT_NOTIFICATION_HEADER_SIZE 3
+
 struct bt_bas {
 	int ref_count;
 	GAttrib *attrib;
 	struct gatt_primary *primary;
 	uint16_t handle;
+	guint id;
 };
 
 static void bas_free(struct bt_bas *bas)
 {
-	if (bas->attrib)
-		g_attrib_unref(bas->attrib);
+	bt_bas_detach(bas);
 
 	g_free(bas->primary);
 	g_free(bas);
@@ -92,10 +94,61 @@ void bt_bas_unref(struct bt_bas *bas)
 	bas_free(bas);
 }
 
+static void value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
+{
+	DBG("Battery Level at %u", pdu[ATT_NOTIFICATION_HEADER_SIZE]);
+}
+
+static void ccc_written_cb(guint8 status, const guint8 *pdu,
+					guint16 plen, gpointer user_data)
+{
+	struct bt_bas *bas = user_data;
+
+	if (status != 0) {
+		error("Write Scan Refresh CCC failed: %s",
+						att_ecode2str(status));
+		return;
+	}
+
+	DBG("Battery Level: notification enabled");
+
+	bas->id = g_attrib_register(bas->attrib, ATT_OP_HANDLE_NOTIFY,
+					bas->handle, value_cb, bas, NULL);
+}
+
+static void write_ccc(GAttrib *attrib, uint16_t handle, void *user_data)
+{
+	uint8_t value[2];
+
+	put_le16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
+
+	gatt_write_char(attrib, handle, value, sizeof(value), ccc_written_cb,
+								user_data);
+}
+
+static void discover_descriptor_cb(uint8_t status, GSList *descs,
+								void *user_data)
+{
+	struct bt_bas *bas = user_data;
+	struct gatt_desc *desc;
+
+	if (status != 0) {
+		error("Discover descriptors failed: %s", att_ecode2str(status));
+		return;
+	}
+
+	/* There will be only one descriptor on list and it will be CCC */
+	desc = descs->data;
+
+	write_ccc(bas->attrib, desc->handle, bas);
+}
+
 static void bas_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 {
 	struct bt_bas *bas = user_data;
 	struct gatt_char *chr;
+	uint16_t start, end;
+	bt_uuid_t uuid;
 
 	if (status) {
 		error("Battery: %s", att_ecode2str(status));
@@ -107,7 +160,13 @@ static void bas_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 
 	DBG("Battery handle: 0x%04x", bas->handle);
 
-	/* TODO: Add handling for notification */
+	start = chr->value_handle + 1;
+	end = bas->primary->range.end;
+
+	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
+
+	gatt_discover_desc(bas->attrib, start, end, &uuid,
+						discover_descriptor_cb, bas);
 }
 
 bool bt_bas_attach(struct bt_bas *bas, void *attrib)
@@ -132,6 +191,11 @@ void bt_bas_detach(struct bt_bas *bas)
 	if (!bas || !bas->attrib)
 		return;
 
+	if (bas->id > 0) {
+		g_attrib_unregister(bas->attrib, bas->id);
+		bas->id = 0;
+	}
+
 	g_attrib_unref(bas->attrib);
 	bas->attrib = NULL;
 }
-- 
1.9.3

