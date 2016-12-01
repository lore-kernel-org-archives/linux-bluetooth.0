Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] shared/gatt-client: Fix not checking ATT error properly
Date: Thu,  1 Dec 2016 22:40:28 +0200
Message-Id: <20161201204030.27626-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/shared/gatt-client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 4386692..c4102dd 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1052,7 +1052,7 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
 					"Primary service discovery failed."
 					" ATT ECODE: 0x%02x", att_ecode);
 		/* Reset error in case of not found */
-		if (BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND) {
+		if (att_ecode == BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND) {
 			success = true;
 			att_ecode = 0;
 		}
-- 
2.9.3

