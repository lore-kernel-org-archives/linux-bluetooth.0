Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] monitor: Remove uuid128_to_str
Date: Thu, 14 Jul 2016 13:08:31 +0300
Message-Id: <1468490911-23032-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1468490911-23032-1-git-send-email-luiz.dentz@gmail.com>
References: <1468490911-23032-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

uuid128_to_str is no longer necessary since all the user have been
converted to use uuidstr_to_str.
---
 monitor/uuid.c | 5 -----
 monitor/uuid.h | 2 --
 2 files changed, 7 deletions(-)

diff --git a/monitor/uuid.c b/monitor/uuid.c
index 1ceaa6f..6660bc7 100644
--- a/monitor/uuid.c
+++ b/monitor/uuid.c
@@ -585,11 +585,6 @@ const char *uuid32_to_str(uint32_t uuid)
 	return "Unknown";
 }
 
-const char *uuid128_to_str(const unsigned char *uuid)
-{
-	return "Unknown";
-}
-
 const char *uuidstr_to_str(const char *uuid)
 {
 	uint32_t val;
diff --git a/monitor/uuid.h b/monitor/uuid.h
index f467f51..6ffc0ee 100644
--- a/monitor/uuid.h
+++ b/monitor/uuid.h
@@ -26,6 +26,4 @@
 
 const char *uuid16_to_str(uint16_t uuid);
 const char *uuid32_to_str(uint32_t uuid);
-const char *uuid128_to_str(const unsigned char *uuid);
-
 const char *uuidstr_to_str(const char *uuid);
-- 
2.7.4

