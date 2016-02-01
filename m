Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] shared/gatt-client: Fix not resetting request id
Date: Mon,  1 Feb 2016 16:13:19 +0200
Message-Id: <1454336002-4954-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The request id shall be reset to 0 after bt_att_cancel has been called.
---
 src/shared/gatt-client.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 06ac763..5fd0208 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1581,6 +1581,7 @@ static void complete_unregister_notify(void *data)
 	 */
 	if (notify_data->att_id) {
 		bt_att_cancel(notify_data->client->att, notify_data->att_id);
+		notify_data->att_id = 0;
 		goto done;
 	}
 
-- 
2.5.0

