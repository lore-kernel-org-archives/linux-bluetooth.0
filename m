Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] android/gatt: Fix device name characteristic
Date: Wed, 12 Nov 2014 17:03:13 +0200
Message-Id: <1415804594-1761-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1415804594-1761-1-git-send-email-luiz.dentz@gmail.com>
References: <1415804594-1761-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

gap_read_cb was never calling gatt_db_attribute_read_result which now
cause a timeout after 1 second.
---
 android/gatt.c | 58 ++++++++++------------------------------------------------
 1 file changed, 10 insertions(+), 48 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 7105daf..ddc4545 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4611,13 +4611,6 @@ struct request_processing_data {
 	struct gatt_device *device;
 };
 
-static bool match_dev_request_by_attrib(const void *data, const void *user_data)
-{
-	const struct pending_request *handle_data = data;
-
-	return handle_data->attrib == user_data;
-}
-
 static uint8_t check_device_permissions(struct gatt_device *device,
 					uint8_t opcode, uint32_t permissions)
 {
@@ -6412,45 +6405,15 @@ static struct gap_srvc_handles gap_srvc_data;
 #define APPEARANCE_GENERIC_PHONE 0x0040
 #define PERIPHERAL_PRIVACY_DISABLE 0x00
 
-static void gap_read_cb(struct gatt_db_attribute *attrib, unsigned int id,
-			uint16_t offset, uint8_t opcode, bdaddr_t *bdaddr,
-			void *user_data)
+static void device_name_read_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					uint8_t opcode, bdaddr_t *bdaddr,
+					void *user_data)
 {
-	struct pending_request *entry;
-	struct gatt_device *dev;
-
-	DBG("");
+	const char *name = bt_get_adapter_name();
 
-	dev = find_device_by_addr(bdaddr);
-	if (!dev) {
-		error("gatt: Could not find device ?!");
-		return;
-	}
-
-	entry = queue_find(dev->pending_requests, match_dev_request_by_attrib,
-									attrib);
-	if (!entry)
-		return;
-
-	if (attrib == gap_srvc_data.dev_name) {
-		const char *name = bt_get_adapter_name();
-
-		entry->value = malloc0(strlen(name));
-		if (!entry->value) {
-			entry->error = ATT_ECODE_INSUFF_RESOURCES;
-			goto done;
-		}
-
-		entry->length = strlen(name);
-		memcpy(entry->value, bt_get_adapter_name(), entry->length);
-	} else {
-		entry->error = ATT_ECODE_ATTR_NOT_FOUND;
-	}
-
-	entry->offset = offset;
-
-done:
-	entry->state  = REQUEST_DONE;
+	gatt_db_attribute_read_result(attrib, id, 0, (void *) name,
+								strlen(name));
 }
 
 static void write_confirm(struct gatt_db_attribute *attrib,
@@ -6477,8 +6440,8 @@ static void register_gap_service(void)
 			gatt_db_service_add_characteristic(gap_srvc_data.srvc,
 							&uuid, GATT_PERM_READ,
 							GATT_CHR_PROP_READ,
-							gap_read_cb, NULL,
-							NULL);
+							device_name_read_cb,
+							NULL, NULL);
 
 	/* Appearance */
 	bt_uuid16_create(&uuid, GATT_CHARAC_APPEARANCE);
@@ -6504,8 +6467,7 @@ static void register_gap_service(void)
 			gatt_db_service_add_characteristic(gap_srvc_data.srvc,
 							&uuid, GATT_PERM_READ,
 							GATT_CHR_PROP_READ,
-							gap_read_cb, NULL,
-							NULL);
+							NULL, NULL, NULL);
 	if (gap_srvc_data.priv) {
 		uint8_t value;
 		/* Store privacy into db */
-- 
1.9.3

