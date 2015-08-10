Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH] gatt-database: Return meaningful ecodes for ccc write
Date: Mon, 10 Aug 2015 18:07:25 +0530
Message-id: <1439210245-20442-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Removed generic ATT protocol error codes and added
Common Profile and Service Error Codes.
---
 src/gatt-database.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 69a814d..defe329 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1783,22 +1783,16 @@ static uint8_t ccc_write_cb(uint16_t value, void *user_data)
 		return 0;
 	}
 
-	/*
-	 * TODO: All of the errors below should fall into the so called
-	 * "Application Error" range. Since there is no well defined error for
-	 * these, we return a generic ATT protocol error for now.
-	 */
-
 	if (chrc->ntfy_cnt == UINT_MAX) {
 		/* Maximum number of per-device CCC descriptors configured */
-		return BT_ATT_ERROR_REQUEST_NOT_SUPPORTED;
+		return BT_ERROR_OUT_OF_RANGE;
 	}
 
 	/* Don't support undefined CCC values yet */
 	if (value > 2 ||
 		(value == 1 && !(chrc->props & BT_GATT_CHRC_PROP_NOTIFY)) ||
 		(value == 2 && !(chrc->props & BT_GATT_CHRC_PROP_INDICATE)))
-		return BT_ATT_ERROR_REQUEST_NOT_SUPPORTED;
+		return BT_ERROR_CCC_IMPROPERLY_CONFIGURED;
 
 	/*
 	 * Always call StartNotify for an incoming enable and ignore the return
@@ -1807,7 +1801,7 @@ static uint8_t ccc_write_cb(uint16_t value, void *user_data)
 	if (g_dbus_proxy_method_call(chrc->proxy,
 						"StartNotify", NULL, NULL,
 						NULL, NULL) == FALSE)
-		return BT_ATT_ERROR_REQUEST_NOT_SUPPORTED;
+		return BT_ERROR_ALREADY_IN_PROGRESS;
 
 	__sync_fetch_and_add(&chrc->ntfy_cnt, 1);
 
-- 
1.9.1

