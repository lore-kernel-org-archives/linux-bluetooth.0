Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 03/11] gas: Discover CCC using gatt_discover_desc
Date: Fri,  2 May 2014 12:57:34 +0200
Message-Id: <1399028262-17187-3-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1399028262-17187-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1399028262-17187-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/gatt/gas.c | 40 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index 7a9d34e..d240450 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -238,40 +238,22 @@ static void write_ccc(GAttrib *attrib, uint16_t handle, gpointer user_data)
 								user_data);
 }
 
-static void gatt_descriptors_cb(guint8 status, const guint8 *pdu, guint16 len,
-							gpointer user_data)
+static void discover_ccc_cb(uint8_t status, GSList *descs, void *user_data)
 {
 	struct gas *gas = user_data;
-	struct att_data_list *list;
-	int i;
-	uint8_t format;
+	struct gatt_desc *desc;
 
-	if (status) {
-		error("Discover all GATT characteristic descriptors: %s",
+	if (status != 0) {
+		error("Discover Service Changed CCC failed: %s",
 							att_ecode2str(status));
 		return;
 	}
 
-	list = dec_find_info_resp(pdu, len, &format);
-	if (list == NULL)
-		return;
-
-	if (format != ATT_FIND_INFO_RESP_FMT_16BIT)
-		goto done;
-
-	for (i = 0; i < list->num; i++) {
-		uint16_t uuid16, ccc;
-		uint8_t *value;
-
-		value = list->data[i];
-		ccc = get_le16(value);
-		uuid16 = get_le16(&value[2]);
-		DBG("CCC: 0x%04x UUID: 0x%04x", ccc, uuid16);
-		write_ccc(gas->attrib, ccc, user_data);
-	}
+	/* There will be only one descriptor on list and it will be CCC */
+	desc = descs->data;
 
-done:
-	att_data_list_free(list);
+	DBG("CCC: 0x%04x", desc->handle);
+	write_ccc(gas->attrib, desc->handle, user_data);
 }
 
 static void gatt_characteristic_cb(uint8_t status, GSList *characteristics,
@@ -280,6 +262,7 @@ static void gatt_characteristic_cb(uint8_t status, GSList *characteristics,
 	struct gas *gas = user_data;
 	struct gatt_char *chr;
 	uint16_t start, end;
+	bt_uuid_t uuid;
 
 	if (status) {
 		error("Discover Service Changed handle: %s", att_ecode2str(status));
@@ -297,7 +280,10 @@ static void gatt_characteristic_cb(uint8_t status, GSList *characteristics,
 	}
 
 	gas->changed_handle = chr->value_handle;
-	gatt_discover_char_desc(gas->attrib, start, end, gatt_descriptors_cb,
+
+	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
+
+	gatt_discover_desc(gas->attrib, start, end, &uuid, discover_ccc_cb,
 									gas);
 }
 
-- 
1.9.2

