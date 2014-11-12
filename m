Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] android/gatt: Cleanup unused variables
Date: Wed, 12 Nov 2014 17:03:14 +0200
Message-Id: <1415804594-1761-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1415804594-1761-1-git-send-email-luiz.dentz@gmail.com>
References: <1415804594-1761-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/gatt.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index ddc4545..41409ad 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -6494,15 +6494,8 @@ static void device_info_read_cb(struct gatt_db_attribute *attrib,
 					uint8_t opcode, bdaddr_t *bdaddr,
 					void *user_data)
 {
-	struct gatt_device *dev;
 	char *buf = user_data;
 
-	dev = find_device_by_addr(bdaddr);
-	if (!dev) {
-		error("gatt: Could not find device ?!");
-		return;
-	}
-
 	gatt_db_attribute_read_result(attrib, id, 0, user_data, strlen(buf));
 }
 
@@ -6511,15 +6504,8 @@ static void device_info_read_system_id_cb(struct gatt_db_attribute *attrib,
 					uint8_t opcode, bdaddr_t *bdaddr,
 					void *user_data)
 {
-	struct gatt_device *dev;
 	uint8_t pdu[8];
 
-	dev = find_device_by_addr(bdaddr);
-	if (!dev) {
-		error("gatt: Could not find device ?!");
-		return;
-	}
-
 	put_le64(bt_config_get_system_id(), pdu);
 
 	gatt_db_attribute_read_result(attrib, id, 0, pdu, sizeof(pdu));
@@ -6530,15 +6516,8 @@ static void device_info_read_pnp_id_cb(struct gatt_db_attribute *attrib,
 					uint8_t opcode, bdaddr_t *bdaddr,
 					void *user_data)
 {
-	struct gatt_device *dev;
 	uint8_t pdu[7];
 
-	dev = find_device_by_addr(bdaddr);
-	if (!dev) {
-		error("gatt: Could not find device ?!");
-		return;
-	}
-
 	pdu[0] = bt_config_get_pnp_source();
 	put_le16(bt_config_get_pnp_vendor(), &pdu[1]);
 	put_le16(bt_config_get_pnp_product(), &pdu[3]);
-- 
1.9.3

