Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] core/gatt: Report if char. value exists properly
Date: Thu, 14 May 2015 13:09:21 +0200
Message-Id: <1431601761-5816-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Return correct value in characteristic_value_exists().
---
 src/gatt-client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 3614553..162bcac 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -707,7 +707,7 @@ static gboolean characteristic_value_exists(const GDBusPropertyTable *property,
 
 	gatt_db_attribute_read(chrc->attr, 0, 0, NULL, read_check_cb, &ret);
 
-	return TRUE;
+	return ret;
 }
 
 static gboolean characteristic_get_notifying(const GDBusPropertyTable *property,
-- 
1.9.3

