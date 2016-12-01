Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Petri Gynther <pgynther@google.com>
Subject: [PATCH 1/2] shared/gatt-client: Fix discover_primary_cb()
Date: Thu,  1 Dec 2016 12:16:01 -0800
Message-Id: <1480623362-49499-1-git-send-email-pgynther@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix the handling of primary services discovery failure.
---
 src/shared/gatt-client.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 4386692..84145e7 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1052,11 +1052,14 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
 					"Primary service discovery failed."
 					" ATT ECODE: 0x%02x", att_ecode);
 		/* Reset error in case of not found */
-		if (BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND) {
+		switch (att_ecode) {
+		case BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND:
 			success = true;
 			att_ecode = 0;
+			goto secondary;
+		default:
+			goto done;
 		}
-		goto secondary;
 	}
 
 	if (!result || !bt_gatt_iter_init(&iter, result)) {
-- 
2.8.0.rc3.226.g39d4020

