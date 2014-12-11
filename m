Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] shared/gatt: Fix NULL pointer dereference
Date: Thu, 11 Dec 2014 14:15:37 +0200
Message-Id: <1418300137-27756-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

We go to fail if (!op) making NULL dereference in discovery_op_free().
---
 src/shared/gatt-client.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 463de3b..96b5f1f 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1101,11 +1101,12 @@ static void process_service_changed(struct bt_gatt_client *client,
 		return;
 	}
 
+	discovery_op_free(op);
+
 fail:
 	util_debug(client->debug_callback, client->debug_data,
 					"Failed to initiate service discovery"
 					" after Service Changed");
-	discovery_op_free(op);
 }
 
 static void service_changed_cb(uint16_t value_handle, const uint8_t *value,
-- 
2.1.0

