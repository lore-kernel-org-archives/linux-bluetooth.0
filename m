Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] shared/gatt: Fix NULL dereference
Date: Fri,  5 Dec 2014 09:30:35 +0200
Message-Id: <1417764636-28857-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

The which is executed after checking (!op) is dereferencing op in
function discovery_op_free().
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
1.9.1

