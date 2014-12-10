Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/3] android/gatt: Fix passing out of att range errors
Date: Wed, 10 Dec 2014 13:40:50 +0100
Message-Id: <1418215251-24018-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1418215251-24018-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1418215251-24018-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Those statuses or errors are of type int and and we need to crop
them to att's range. This fixes potential issues when user app sends
status that is equal or greater than GATT_FAILURE.
---
 android/gatt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 18a5092..b2ce9c1 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -5556,12 +5556,12 @@ static void handle_server_send_response(const void *buf, uint16_t len)
 	if (transaction->opcode < ATT_OP_WRITE_REQ)
 		gatt_db_attribute_read_result(transaction->attrib,
 						transaction->serial_id,
-						cmd->status,
+						err_to_att(cmd->status),
 						cmd->data, cmd->len);
 	else
 		gatt_db_attribute_write_result(transaction->attrib,
 						transaction->serial_id,
-						cmd->status);
+						err_to_att(cmd->status));
 
 	send_dev_complete_response(conn->device, transaction->opcode);
 
-- 
1.9.1

