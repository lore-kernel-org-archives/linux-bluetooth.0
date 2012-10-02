Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] attrib: Get address type using gatt_get_address()
Date: Tue,  2 Oct 2012 08:50:20 -0400
Message-Id: <1349182220-525-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This avoids a separate call to device_get_addr_type().
---
 attrib/client.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index ece16bf..d49804c 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -705,7 +705,6 @@ static GSList *load_characteristics(struct gatt_service *gatt, uint16_t start)
 static void store_attribute(struct gatt_service *gatt, uint16_t handle,
 				uint16_t type, uint8_t *value, gsize len)
 {
-	struct btd_device *device = gatt->dev;
 	bdaddr_t sba, dba;
 	uint8_t bdaddr_type;
 	bt_uuid_t uuid;
@@ -722,9 +721,7 @@ static void store_attribute(struct gatt_service *gatt, uint16_t handle,
 	for (i = 0, tmp = str + MAX_LEN_UUID_STR; i < len; i++, tmp += 2)
 		sprintf(tmp, "%02X", value[i]);
 
-	gatt_get_address(gatt, &sba, &dba, NULL);
-
-	bdaddr_type = device_get_addr_type(device);
+	gatt_get_address(gatt, &sba, &dba, &bdaddr_type);
 
 	write_device_attribute(&sba, &dba, bdaddr_type, handle, str);
 
-- 
1.7.9.5

