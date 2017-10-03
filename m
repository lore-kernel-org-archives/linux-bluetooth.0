Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Yunhan Wang <yunhanw@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Yunhan Wang <yunhanw@google.com>
Subject: [PATCH BlueZ] gatt: Fix sending indications with proxy
Date: Tue,  3 Oct 2017 11:35:07 -0700
Message-Id: <20171003183507.37885-1-yunhanw@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When using AcquireNotify with indication, the proxy needs to be filled in
send_notification_to_devices so as to get indication confirmation in
applciation.
---
 src/gatt-database.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 0c84b2569..47304704a 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1831,7 +1831,7 @@ static bool pipe_io_read(struct io *io, void *user_data)
 				buf, bytes_read,
 				gatt_db_attribute_get_handle(chrc->ccc),
 				chrc->props & BT_GATT_CHRC_PROP_INDICATE,
-				NULL);
+				chrc->proxy);
 
 	return true;
 }
-- 
2.14.2.822.g60be5d43e6-goog

