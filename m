Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] shared/gatt-client: Fix error when no service could be found
Date: Wed, 29 Jul 2015 10:58:52 +0300
Message-Id: <1438156733-3258-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In case the remote device has no services available ready callback would
be called with success set to false but in fact it has succeeded it just
did not find anything.
---
 src/shared/gatt-client.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 24aef18..903afa7 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -971,6 +971,11 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
 		util_debug(client->debug_callback, client->debug_data,
 					"Primary service discovery failed."
 					" ATT ECODE: 0x%02x", att_ecode);
+		/* Reset error in case of not found */
+		if (BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND) {
+			success = true;
+			att_ecode = 0;
+		}
 		goto secondary;
 	}
 
-- 
2.1.0

