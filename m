Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] shared/gatt-client: Fix secondary service discovery
Date: Wed, 14 Mar 2018 15:17:25 +0200
Message-Id: <20180314131726.24945-2-luiz.dentz@gmail.com>
In-Reply-To: <20180314131726.24945-1-luiz.dentz@gmail.com>
References: <20180314131726.24945-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the error returned is either BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND or
BT_ATT_ERROR_UNSUPPORTED_GROUP_TYPE the discovery shall be marked as
successful and no error shall be printed.
---
 src/shared/gatt-client.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index d61668df7..c369ccb40 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -933,14 +933,16 @@ static void discover_secondary_cb(bool success, uint8_t att_ecode,
 	discovery_req_clear(client);
 
 	if (!success) {
-		util_debug(client->debug_callback, client->debug_data,
-					"Secondary service discovery failed."
-					" ATT ECODE: 0x%02x", att_ecode);
 		switch (att_ecode) {
 		case BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND:
 		case BT_ATT_ERROR_UNSUPPORTED_GROUP_TYPE:
+			success = true;
+			att_ecode = 0;
 			goto next;
 		default:
+			util_debug(client->debug_callback, client->debug_data,
+					"Secondary service discovery failed."
+					" ATT ECODE: 0x%02x", att_ecode);
 			goto done;
 		}
 	}
-- 
2.14.3

