Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0] attrib: Improve Attribute Data length checking
Date: Tue,  1 Apr 2014 14:33:30 -0300
Message-Id: <1396373610-28223-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to Core SPEC, attribute data list must be grouped in elements
of the same size.
---
 attrib/gatt.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 5ae20f4..49cd1a3 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -254,6 +254,16 @@ static void primary_all_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 		goto done;
 	}
 
+	if (list->len == 6)
+		type = BT_UUID16;
+	else if (list->len == 20)
+		type = BT_UUID128;
+	else {
+		att_data_list_free(list);
+		err = ATT_ECODE_INVALID_PDU;
+		goto done;
+	}
+
 	for (i = 0, end = 0; i < list->num; i++) {
 		const uint8_t *data = list->data[i];
 		struct gatt_primary *primary;
@@ -262,19 +272,6 @@ static void primary_all_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 		start = get_le16(&data[0]);
 		end = get_le16(&data[2]);
 
-		/*
-		 * FIXME: Check before "for". Elements in the Attribute
-		 * Data List have the same length (list->len).
-		 */
-		if (list->len == 6)
-			type = BT_UUID16;
-		else if (list->len == 20)
-			type = BT_UUID128;
-		else {
-			/* Skipping invalid data */
-			continue;
-		}
-
 		get_uuid128(type, &data[4], &uuid128);
 
 		primary = g_try_new0(struct gatt_primary, 1);
@@ -507,6 +504,7 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 	struct att_data_list *list;
 	unsigned int i, err = ATT_ECODE_ATTR_NOT_FOUND;
 	uint16_t last = 0;
+	uint8_t type;
 
 	if (status) {
 		err = status;
@@ -519,23 +517,18 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 		goto done;
 	}
 
+	if (list->len == 7)
+		type = BT_UUID16;
+	else
+		type = BT_UUID128;
+
 	for (i = 0; i < list->num; i++) {
 		uint8_t *value = list->data[i];
 		struct gatt_char *chars;
 		bt_uuid_t uuid128;
-		uint8_t type;
 
 		last = get_le16(value);
 
-		/*
-		 * FIXME: Check before "for". Elements in the Attribute
-		 * Data List have the same length (list->len).
-		 */
-		if (list->len == 7)
-			type = BT_UUID16;
-		else
-			type = BT_UUID128;
-
 		get_uuid128(type, &value[5], &uuid128);
 
 		if (dc->uuid && bt_uuid_cmp(dc->uuid, &uuid128))
@@ -543,6 +536,7 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 
 		chars = g_try_new0(struct gatt_char, 1);
 		if (!chars) {
+			att_data_list_free(list);
 			err = ATT_ECODE_INSUFF_RESOURCES;
 			goto done;
 		}
-- 
1.8.3.1

