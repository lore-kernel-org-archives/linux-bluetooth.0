Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] gatt: Fix not replying to Write request
Date: Mon,  2 Oct 2017 14:47:40 +0300
Message-Id: <20171002114740.9474-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When using AcquireWrite the first write would not call
gatt_db_attribute_write_result so no reply would be generated.
---
 src/gatt-database.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 4932568dd..e84c19198 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1892,6 +1892,8 @@ static void acquire_write_reply(DBusMessage *message, void *user_data)
 				op->data.iov_len) < 0)
 		goto retry;
 
+	gatt_db_attribute_write_result(op->attrib, op->id, 0);
+
 	return;
 
 retry:
-- 
2.13.5

