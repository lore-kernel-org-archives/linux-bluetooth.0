Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] shared/gatt-client: Fix not freeing notify data
Date: Tue,  8 Sep 2015 15:23:40 +0300
Message-Id: <1441715022-20327-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

notify_data_write_ccc takes another reference in case it succeed so
the original reference should be dropped to cause the data to be freed
once notify_data_write_ccc completes.
---
 src/shared/gatt-client.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 903afa7..0983852 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1596,8 +1596,7 @@ static void complete_unregister_notify(void *data)
 						!notify_data->chrc->ccc_handle)
 		goto done;
 
-	if (notify_data_write_ccc(notify_data, false, disable_ccc_callback))
-		return;
+	notify_data_write_ccc(notify_data, false, disable_ccc_callback);
 
 done:
 	notify_data_unref(notify_data);
-- 
2.4.3

