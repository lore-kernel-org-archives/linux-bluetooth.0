Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH] Fix coding style issue regarding with pointer checks
Date: Thu, 17 Nov 2011 11:24:20 +0100
Message-Id: <1321525460-5754-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gatt-service.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/attrib/gatt-service.c b/attrib/gatt-service.c
index 3199830..ead3f8e 100644
--- a/attrib/gatt-service.c
+++ b/attrib/gatt-service.c
@@ -214,7 +214,7 @@ static gboolean add_characteristic(uint16_t *handle, struct gatt_info *info)
 		}
 	}
 
-	if (info->value_handle)
+	if (info->value_handle != NULL)
 		*info->value_handle = a->handle;
 
 	/* client characteristic configuration descriptor */
@@ -227,7 +227,7 @@ static gboolean add_characteristic(uint16_t *handle, struct gatt_info *info)
 		a = attrib_db_add(h++, &bt_uuid, ATT_NONE, ATT_AUTHENTICATION,
 						cfg_val, sizeof(cfg_val));
 
-		if (info->ccc_handle)
+		if (info->ccc_handle != NULL)
 			*info->ccc_handle = a->handle;
 	}
 
-- 
1.7.7.3

