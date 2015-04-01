Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/gatt-client: Fix possible crash
Date: Wed,  1 Apr 2015 15:18:44 +0300
Message-Id: <1427890724-22149-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Similar to issue found with unit test it is necessary to protect
bt_gatt_client instance before calling the callback otherwise it may
destroy it causing a crash.
---
 src/shared/gatt-client.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index df994d7..b92d7b1 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -2456,14 +2456,17 @@ static void complete_write_long_op(struct request *req, bool success,
 	if (req->att_id)
 		return;
 
-
 	request_unref(req);
 	success = false;
 
+	bt_gatt_client_ref(op->client);
+
 	if (op->callback)
 		op->callback(success, reliable_error, att_ecode, op->user_data);
 
 	start_next_long_write(op->client);
+
+	bt_gatt_client_unref(op->client);
 }
 
 static void prepare_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
-- 
2.1.0

