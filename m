Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android: Make shutdown timeout shorter
Date: Thu,  8 Jan 2015 11:16:10 +0100
Message-Id: <1420712170-14973-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Android L is using 8 seconds for both enable and disable timeouts.
Set daemon shutdown timeout to 5 seconds to make sure we fit into
framework timeout in case things goes wrong.
---
 android/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/main.c b/android/main.c
index 58dd9ab..ec28742 100644
--- a/android/main.c
+++ b/android/main.c
@@ -70,7 +70,7 @@
 #define DEFAULT_NAME "BlueZ for Android"
 
 #define STARTUP_GRACE_SECONDS 5
-#define SHUTDOWN_GRACE_SECONDS 10
+#define SHUTDOWN_GRACE_SECONDS 5
 
 static char *config_vendor = NULL;
 static char *config_model = NULL;
-- 
1.9.1

