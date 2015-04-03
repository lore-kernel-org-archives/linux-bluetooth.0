Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@gmail.com>
Subject: [PATCHv2 11/27] lib/uuid: Add define for HoG UUID
Date: Fri,  3 Apr 2015 15:43:40 +0200
Message-Id: <1428068636-13073-12-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1428068636-13073-1-git-send-email-mariusz.skamra@tieto.com>
References: <1428068636-13073-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mariusz Skamra <mariusz.skamra@gmail.com>

This patch moves the HOG_UUID define to lib/uuid.
---
 android/hidhost.c | 2 --
 android/hog.c     | 2 --
 lib/uuid.h        | 1 +
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index 0f28120..e1392f6 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -90,8 +90,6 @@
 /* HID Virtual Cable Unplug */
 #define HID_VIRTUAL_CABLE_UNPLUG	0x05
 
-#define HOG_UUID		"00001812-0000-1000-8000-00805f9b34fb"
-
 static bdaddr_t adapter_addr;
 
 static GIOChannel *ctrl_io = NULL;
diff --git a/android/hog.c b/android/hog.c
index 4dcba4d..fda7a88 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -61,8 +61,6 @@
 #include "android/bas.h"
 #include "android/hog.h"
 
-#define HOG_UUID		"00001812-0000-1000-8000-00805f9b34fb"
-
 #define HOG_INFO_UUID		0x2A4A
 #define HOG_REPORT_MAP_UUID	0x2A4B
 #define HOG_REPORT_UUID		0x2A4D
diff --git a/lib/uuid.h b/lib/uuid.h
index 2dcfe9e..fd67ebb 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -88,6 +88,7 @@ extern "C" {
 #define HDP_SINK_UUID		"00001402-0000-1000-8000-00805f9b34fb"
 
 #define HID_UUID		"00001124-0000-1000-8000-00805f9b34fb"
+#define HOG_UUID		"00001812-0000-1000-8000-00805f9b34fb"
 
 #define DUN_GW_UUID		"00001103-0000-1000-8000-00805f9b34fb"
 
-- 
1.9.1

