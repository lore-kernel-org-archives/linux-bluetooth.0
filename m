Return-Path: <cyrus@holtmann.org>
From: Atul Rai <a.rai@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: sachin.dev@samsung.com
Subject: [PATCH] android/hal-bluetooth: Fix NULL ptr dereference
Date: Mon, 29 Jun 2015 12:14:13 +0530
Message-id: <1435560253-5511-1-git-send-email-a.rai@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add NULL check on malloc return to fix NULL pointer dereference
in case malloc fails.
---
 android/hal-bluetooth.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index e24f7d2..66f4a37 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -19,6 +19,7 @@
 #include <stdlib.h>
 #include <stdbool.h>
 #include <string.h>
+#include <errno.h>
 
 #include <cutils/properties.h>
 
@@ -1103,6 +1104,11 @@ static int open_bluetooth(const struct hw_module_t *module, char const *name,
 
 	DBG("");
 
+	if (!dev) {
+		error("Failed to allocate memory for device");
+		return -ENOMEM;
+	}
+
 	memset(dev, 0, sizeof(bluetooth_device_t));
 	dev->common.tag = HARDWARE_DEVICE_TAG;
 	dev->common.version = 0;
-- 
2.1.4

