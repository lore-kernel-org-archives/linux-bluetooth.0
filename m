Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH 1/1] shared/gatt-server: Remove unwanted pointer validation
Date: Thu, 06 Jul 2017 20:36:36 +0530
Message-id: <1499353596-20988-1-git-send-email-s.syam@samsung.com>
References: <CGME20170706145900epcas5p3f02ab7299138d767b68c236bbb50c0ec@epcas5p3.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Here the memory address pointed by the variable op is always valid.
---
 src/shared/gatt-server.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 79e01c8..dc3bb8e 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -803,8 +803,7 @@ static void write_cb(uint8_t opcode, const void *pdu,
 							write_complete_cb, op))
 		return;
 
-	if (op)
-		async_write_op_destroy(op);
+	async_write_op_destroy(op);
 
 	ecode = BT_ATT_ERROR_UNLIKELY;
 
-- 
1.7.9.5

