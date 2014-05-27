Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [RFC 3/3] android/gatt: Make CCC descriptor readable
Date: Tue, 27 May 2014 16:33:43 +0200
Message-Id: <1401201223-17852-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1401201223-17852-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1401201223-17852-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Descriptor unlike characteristic should be readable.
---
 android/gatt.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index f0cf013..c53ebd5 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -5499,7 +5499,7 @@ static void register_device_info_service(void)
 	gatt_db_service_set_active(gatt_db, srvc_handle, true);
 }
 
-static void gatt_srvc_change_register_cb(uint16_t handle, uint16_t offset,
+static void gatt_srvc_change_write_cb(uint16_t handle, uint16_t offset,
 						const uint8_t *val, size_t len,
 						uint8_t att_opcode,
 						bdaddr_t *bdaddr,
@@ -5530,6 +5530,39 @@ static void gatt_srvc_change_register_cb(uint16_t handle, uint16_t offset,
 	bt_store_gatt_ccc(bdaddr, *val);
 }
 
+static void gatt_srvc_change_read_cb(uint16_t handle, uint16_t offset,
+					uint8_t att_opcode, bdaddr_t *bdaddr,
+					void *user_data)
+{
+	struct pending_request *entry;
+	struct gatt_device *dev;
+	uint16_t ccc = 0;
+
+	dev = find_device_by_addr(bdaddr);
+	if (!dev) {
+		error("gatt: Could not find device ?!");
+		return;
+	}
+
+	entry = queue_find(dev->pending_requests, match_dev_request_by_handle,
+							UINT_TO_PTR(handle));
+	if (!entry)
+		return;
+
+	ccc = bt_get_gatt_ccc(&dev->bdaddr);
+	entry->state = REQUEST_DONE;
+
+	entry->value = (uint8_t *) new0(uint16_t, 1);
+	if (!entry->value) {
+		entry->error = ATT_ECODE_INSUFF_RESOURCES;
+
+		return;
+	}
+
+	entry->length = sizeof(uint16_t);
+	memcpy(entry->value, &ccc, sizeof(ccc));
+}
+
 static void register_gatt_service(void)
 {
 	bt_uuid_t uuid;
@@ -5548,9 +5581,9 @@ static void register_gatt_service(void)
 
 	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
 	gatt_db_add_char_descriptor(gatt_db, srvc_handle, &uuid,
-					GATT_PERM_WRITE,
-					NULL, gatt_srvc_change_register_cb,
-					NULL);
+					GATT_PERM_READ | GATT_PERM_WRITE,
+					gatt_srvc_change_read_cb,
+					gatt_srvc_change_write_cb, NULL);
 
 	gatt_db_service_set_active(gatt_db, srvc_handle, true);
 }
-- 
1.9.3

