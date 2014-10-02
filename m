Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 4/5] shared/gatt-client: Fix gatt_client_init
Date: Thu,  2 Oct 2014 12:51:40 +0300
Message-Id: <1412243501-1755-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412243501-1755-1-git-send-email-luiz.dentz@gmail.com>
References: <1412243501-1755-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This function is only called within bt_gatt_client_new therefore it is
not possible to have a ready callback and should return false if
bt_gatt_exchange_mtu fails.
---
 src/shared/gatt-client.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index ddedaf0..5833e7a 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1005,10 +1005,8 @@ static bool gatt_client_init(struct bt_gatt_client *client, uint16_t mtu)
 							exchange_mtu_cb,
 							discovery_op_ref(op),
 							discovery_op_unref)) {
-		if (client->ready_callback)
-			client->ready_callback(false, 0, client->ready_data);
-
 		free(op);
+		return false;
 	}
 
 	client->in_init = true;
@@ -1269,7 +1267,8 @@ struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att, uint16_t mtu)
 
 	client->att = bt_att_ref(att);
 
-	gatt_client_init(client, mtu);
+	if (!gatt_client_init(client, mtu))
+		goto fail;
 
 	return bt_gatt_client_ref(client);
 
-- 
1.9.3

