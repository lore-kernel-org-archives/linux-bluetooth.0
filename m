Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] shared/gatt-client: Make it possible to clone non-ready clients
Date: Mon, 21 Mar 2016 17:45:40 +0200
Message-Id: <1458575141-3808-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is necessary in order to be possible to send commands while the
discovery is in progress.
---
 src/shared/gatt-client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 1dd6b22..8fa66ae 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1722,7 +1722,7 @@ struct bt_gatt_client *bt_gatt_client_clone(struct bt_gatt_client *client)
 {
 	struct bt_gatt_client *clone;
 
-	if (!client || !client->ready)
+	if (!client)
 		return NULL;
 
 	clone = gatt_client_new(client->db, client->att);
-- 
2.5.0

