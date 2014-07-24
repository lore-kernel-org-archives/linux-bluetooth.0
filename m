Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/client: Set default handsfree mode for host
Date: Thu, 24 Jul 2014 14:32:54 +0300
Message-Id: <1406201574-11891-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

For testing set default handsfree mode to HF
---
 android/cutils/properties.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/android/cutils/properties.h b/android/cutils/properties.h
index ef40f01..8b3d84d 100644
--- a/android/cutils/properties.h
+++ b/android/cutils/properties.h
@@ -31,6 +31,7 @@
 #define PROPERTY_VALUE_MAX 32
 
 #define BLUETOOTH_MODE_PROPERTY_NAME "persist.sys.bluetooth.mode"
+#define BLUETOOTH_MODE_PROPERTY_HANDSFREE "persist.sys.bluetooth.handsfree"
 
 static inline int property_get(const char *key, char *value,
 						const char *default_value)
@@ -40,6 +41,9 @@ static inline int property_get(const char *key, char *value,
 	if (!strcmp(key, BLUETOOTH_MODE_PROPERTY_NAME))
 		prop = getenv("BLUETOOTH_MODE");
 
+	if (!strcmp(key, BLUETOOTH_MODE_PROPERTY_HANDSFREE))
+		prop = "hfp";
+
 	if (!prop)
 		prop = default_value;
 
-- 
1.9.1

