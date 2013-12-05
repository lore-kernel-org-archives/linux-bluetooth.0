Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/8] android: Fix sending status on bluetooth init if already initialized
Date: Thu,  5 Dec 2013 11:37:12 +0100
Message-Id: <1386239837-4102-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1386239837-4102-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1386239837-4102-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We should be sending BT_STATUS_DONE when calling init on already
initialized interface like Bluedroid does. This indicates that previosly
registered callbacks are still registered, not those passed with second
init call.

---
 android/hal-bluetooth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 87d6fc7..7cac15c 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -373,7 +373,7 @@ static int init(bt_callbacks_t *callbacks)
 	DBG("");
 
 	if (interface_ready())
-		return BT_STATUS_SUCCESS;
+		return BT_STATUS_DONE;
 
 	bt_hal_cbacks = callbacks;
 
-- 
1.8.5

