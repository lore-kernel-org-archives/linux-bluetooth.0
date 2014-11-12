Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] android/gatt: Store Appearance and Privacy in db
Date: Wed, 12 Nov 2014 17:03:12 +0200
Message-Id: <1415804594-1761-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This stores Appearance and Privacy values in the db itself since they
are static and don't depend in any context information.
---
 android/gatt.c | 49 +++++++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 086bb94..7105daf 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -6443,24 +6443,6 @@ static void gap_read_cb(struct gatt_db_attribute *attrib, unsigned int id,
 
 		entry->length = strlen(name);
 		memcpy(entry->value, bt_get_adapter_name(), entry->length);
-	} else if (attrib == gap_srvc_data.appear) {
-		entry->value = malloc0(2);
-		if (!entry->value) {
-			entry->error = ATT_ECODE_INSUFF_RESOURCES;
-			goto done;
-		}
-
-		put_le16(APPEARANCE_GENERIC_PHONE, entry->value);
-		entry->length = sizeof(uint8_t) * 2;
-	} else if (attrib == gap_srvc_data.priv) {
-		entry->value = malloc0(1);
-		if (!entry->value) {
-			entry->error = ATT_ECODE_INSUFF_RESOURCES;
-			goto done;
-		}
-
-		*entry->value = PERIPHERAL_PRIVACY_DISABLE;
-		entry->length = sizeof(uint8_t);
 	} else {
 		entry->error = ATT_ECODE_ATTR_NOT_FOUND;
 	}
@@ -6471,6 +6453,15 @@ done:
 	entry->state  = REQUEST_DONE;
 }
 
+static void write_confirm(struct gatt_db_attribute *attrib,
+						int err, void *user_data)
+{
+	if (!err)
+		return;
+
+	error("Error writting attribute %p", attrib);
+}
+
 static void register_gap_service(void)
 {
 	uint16_t start, end;
@@ -6491,12 +6482,21 @@ static void register_gap_service(void)
 
 	/* Appearance */
 	bt_uuid16_create(&uuid, GATT_CHARAC_APPEARANCE);
+
 	gap_srvc_data.appear =
 			gatt_db_service_add_characteristic(gap_srvc_data.srvc,
 							&uuid, GATT_PERM_READ,
 							GATT_CHR_PROP_READ,
-							gap_read_cb, NULL,
-							NULL);
+							NULL, NULL, NULL);
+	if (gap_srvc_data.appear) {
+		uint16_t value;
+		/* Store appearance into db */
+		value = cpu_to_le16(APPEARANCE_GENERIC_PHONE);
+		gatt_db_attribute_write(gap_srvc_data.appear, 0,
+						(void *) &value, sizeof(value),
+						ATT_OP_WRITE_REQ, NULL,
+						write_confirm, NULL);
+	}
 
 	/* Pripheral privacy flag */
 	bt_uuid16_create(&uuid, GATT_CHARAC_PERIPHERAL_PRIV_FLAG);
@@ -6506,6 +6506,15 @@ static void register_gap_service(void)
 							GATT_CHR_PROP_READ,
 							gap_read_cb, NULL,
 							NULL);
+	if (gap_srvc_data.priv) {
+		uint8_t value;
+		/* Store privacy into db */
+		value = PERIPHERAL_PRIVACY_DISABLE;
+		gatt_db_attribute_write(gap_srvc_data.priv, 0,
+						&value, sizeof(value),
+						ATT_OP_WRITE_REQ, NULL,
+						write_confirm, NULL);
+	}
 
 	gatt_db_service_set_active(gap_srvc_data.srvc , true);
 
-- 
1.9.3

