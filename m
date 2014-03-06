Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/3] android: Change property name for valgrind
Date: Thu, 6 Mar 2014 10:37:59 +0100
Message-ID: <1394098681-18983-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetoothd-wrapper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/bluetoothd-wrapper.c b/android/bluetoothd-wrapper.c
index 122e6b0..3a9f32e 100644
--- a/android/bluetoothd-wrapper.c
+++ b/android/bluetoothd-wrapper.c
@@ -22,7 +22,7 @@
 
 #include <cutils/properties.h>
 
-#define PROPERTY_NAME "persist.sys.bluetooth.valgrind"
+#define PROPERTY_VALGRIND_NAME "persist.sys.bluetooth.valgrind"
 
 #define VALGRIND_BIN "/system/bin/valgrind"
 
@@ -62,7 +62,7 @@ int main(int argc, char *argv[])
 {
 	char value[PROPERTY_VALUE_MAX];
 
-	if (property_get(PROPERTY_NAME, value, "") > 0 &&
+	if (property_get(PROPERTY_VALGRIND_NAME, value, "") > 0 &&
 			(!strcasecmp(value, "true") || atoi(value) > 0))
 		run_valgrind();
 
-- 
1.8.4

