Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 03/10] shared/gatt-client: Insert included attribute with handle
Date: Tue,  9 May 2017 23:48:33 +0300
Message-Id: <20170509204840.3270-4-luiz.dentz@gmail.com>
In-Reply-To: <20170509204840.3270-1-luiz.dentz@gmail.com>
References: <20170509204840.3270-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This ensures the local representation matches exactly the handle used
by the remote in its database.
---
 src/shared/gatt-client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 0134721..3caed5f 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -457,7 +457,7 @@ static void discover_incl_cb(bool success, uint8_t att_ecode,
 		if (!tmp)
 			goto failed;
 
-		tmp = gatt_db_service_add_included(attr, tmp);
+		tmp = gatt_db_service_insert_included(attr, handle, tmp);
 		if (!tmp)
 			goto failed;
 
-- 
2.9.3

