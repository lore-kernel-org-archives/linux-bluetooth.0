Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 2/2] shared/gatt-client: Call ready_handler only in init.
Date: Fri, 21 Nov 2014 15:45:00 -0800
Message-Id: <1416613500-13315-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1416613500-13315-1-git-send-email-armansito@chromium.org>
References: <1416613500-13315-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently disconnect_cb calls ready_handler to notify the upper layer
if a disconnect occurred during initialization. This patch fixes it so
that the handler is only called if in_init is set.
---
 src/shared/gatt-client.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 4a645eb..033cba1 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1455,6 +1455,7 @@ static void bt_gatt_client_free(struct bt_gatt_client *client)
 static void att_disconnect_cb(void *user_data)
 {
 	struct bt_gatt_client *client = user_data;
+	bool in_init = client->in_init;
 
 	client->disc_id = 0;
 
@@ -1464,7 +1465,7 @@ static void att_disconnect_cb(void *user_data)
 	client->in_init = false;
 	client->ready = false;
 
-	if (client->ready_callback)
+	if (in_init && client->ready_callback)
 		client->ready_callback(false, 0, client->ready_data);
 }
 
-- 
2.1.0.rc2.206.gedb03e5

