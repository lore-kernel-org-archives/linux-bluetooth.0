Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 03/11] android/tester-ng: Improve callback defining makro
Date: Fri, 18 Jul 2014 13:51:12 +0200
Message-Id: <1405684280-1017-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1405684280-1017-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1405684280-1017-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes CALLBACK_DEVICE_PROPS and CALLBACK_DEVICE_FOUND use more
generic CALLBACK_PROPS makro.
---
 android/tester-main.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/android/tester-main.h b/android/tester-main.h
index a5ed5b1..883ec4d 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -87,17 +87,17 @@
 		.callback_result.num_properties = prop_cnt, \
 	}
 
-#define CALLBACK_DEVICE_PROPS(props, prop_cnt) { \
-		.callback = CB_BT_REMOTE_DEVICE_PROPERTIES, \
+#define CALLBACK_PROPS(cb, props, prop_cnt) { \
+		.callback = cb, \
 		.callback_result.properties = props, \
 		.callback_result.num_properties = prop_cnt, \
 	}
 
-#define CALLBACK_DEVICE_FOUND(props, prop_cnt) { \
-		.callback = CB_BT_DEVICE_FOUND, \
-		.callback_result.properties = props, \
-		.callback_result.num_properties = prop_cnt, \
-	}
+#define CALLBACK_DEVICE_PROPS(props, prop_cnt) \
+	CALLBACK_PROPS(CB_BT_REMOTE_DEVICE_PROPERTIES, props, prop_cnt)
+
+#define CALLBACK_DEVICE_FOUND(props, prop_cnt) \
+	CALLBACK_PROPS(CB_BT_DEVICE_FOUND, props, prop_cnt)
 
 /*
  * NOTICE:
-- 
1.9.1

