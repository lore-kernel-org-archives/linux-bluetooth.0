Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/5] shared/gatt-client: Add debug log if characteristic cannot be added
Date: Mon, 15 Feb 2016 14:30:38 +0200
Message-Id: <1455539442-31843-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If gatt_db_service_insert_characteristic fails print an error for the
handle.
---
 src/shared/gatt-client.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 20c195a..8486b09 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -588,8 +588,12 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
 							chrc_data->properties,
 							NULL, NULL, NULL);
 
-		if (!attr)
+		if (!attr) {
+			util_debug(client->debug_callback, client->debug_data,
+				"Failed to insert characteristic at 0x%04x",
+				chrc_data->value_handle);
 			goto failed;
+		}
 
 		if (gatt_db_attribute_get_handle(attr) !=
 							chrc_data->value_handle)
-- 
2.5.0

