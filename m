Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 1/2] android/gatt: Fix caching included services descriptors
Date: Mon, 14 Apr 2014 12:39:50 +0200
Message-Id: <1397471991-21200-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 004063c..f303aea 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1839,7 +1839,7 @@ static bool build_descr_cache(int32_t conn_id, struct gatt_device *dev,
 
 	/* Clip range to given characteristic */
 	start = ch->ch.value_handle + 1;
-	end = srvc->prim.range.end;
+	end = srvc->primary ? srvc->prim.range.end : srvc->incl.range.end;
 
 	/* Use next characteristic start as end. If there is none -
 	 * service end is valid end.
-- 
1.9.1

