Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] shared/gatt-client: Simplify service changed handling
Date: Wed, 16 Mar 2016 15:17:25 +0200
Message-Id: <1458134245-23277-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1458134245-23277-1-git-send-email-luiz.dentz@gmail.com>
References: <1458134245-23277-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Don't reset the range since the discovery should be able to detect
modifications and in case the service was removed the code calls
gatt_db_clear_range to reset it at the end.
---
 src/shared/gatt-client.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 37c219b..1dd6b22 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1377,16 +1377,6 @@ static void process_service_changed(struct bt_gatt_client *client,
 {
 	struct discovery_op *op;
 
-	/* On full database reset just re-run attribute discovery */
-	if (start_handle == 0x0001 && end_handle == 0xffff)
-		goto discover;
-
-	/* Remove all services that overlap the modified range since we'll
-	 * rediscover them
-	 */
-	gatt_db_clear_range(client->db, start_handle, end_handle);
-
-discover:
 	op = discovery_op_create(client, start_handle, end_handle,
 						service_changed_complete,
 						service_changed_failure);
-- 
2.5.0

