Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 3/4] core/gatt: Remove spammy log messages
Date: Wed,  4 Mar 2015 13:57:50 -0800
Message-Id: <1425506271-20775-4-git-send-email-armansito@chromium.org>
In-Reply-To: <1425506271-20775-1-git-send-email-armansito@chromium.org>
References: <1425506271-20775-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes some spammy debug log messages regarding CEP/CCC
descriptor processing.
---
 src/gatt-database.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 21c9e95..c7b2223 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1708,10 +1708,8 @@ static bool database_add_ccc(struct external_service *service,
 						struct external_chrc *chrc)
 {
 	if (!(chrc->props & BT_GATT_CHRC_PROP_NOTIFY) &&
-				!(chrc->props & BT_GATT_CHRC_PROP_INDICATE)) {
-		DBG("No need to create CCC entry for characteristic");
+				!(chrc->props & BT_GATT_CHRC_PROP_INDICATE))
 		return true;
-	}
 
 	chrc->ccc = service_add_ccc(service->attrib, service->database,
 						ccc_write_cb, chrc, NULL);
@@ -1726,6 +1724,8 @@ static bool database_add_ccc(struct external_service *service,
 		return false;
 	}
 
+	DBG("Created CCC entry for characteristic");
+
 	return true;
 }
 
@@ -1745,10 +1745,8 @@ static bool database_add_cep(struct external_service *service,
 	bt_uuid_t uuid;
 	uint8_t value[2];
 
-	if (!chrc->ext_props) {
-		DBG("No need to create CEP entry for characteristic");
+	if (!chrc->ext_props)
 		return true;
-	}
 
 	bt_uuid16_create(&uuid, GATT_CHARAC_EXT_PROPER_UUID);
 	cep = gatt_db_service_add_descriptor(service->attrib, &uuid,
@@ -1768,6 +1766,8 @@ static bool database_add_cep(struct external_service *service,
 		return false;
 	}
 
+	DBG("Created CEP entry for characteristic");
+
 	return true;
 }
 
-- 
2.2.0.rc0.207.ga3a616c

