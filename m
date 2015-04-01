Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH 28/28] android/hog: Remove redundant code
Date: Wed,  1 Apr 2015 18:40:44 +0200
Message-Id: <1427906444-11769-29-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com>
References: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hog.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/android/hog.c b/android/hog.c
index a18275e..9f64e41 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -31,13 +31,8 @@
 #include <stdlib.h>
 #include <stdbool.h>
 #include <errno.h>
-#include <unistd.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
 
 #include "lib/bluetooth.h"
-#include "lib/sdp.h"
 #include "lib/uuid.h"
 
 #include "src/shared/util.h"
@@ -64,9 +59,6 @@
 #define HOG_PROTO_MODE_BOOT    0
 #define HOG_PROTO_MODE_REPORT  1
 
-#define HOG_REPORT_MAP_MAX_SIZE        512
-#define HID_INFO_SIZE			4
-
 static const bt_uuid_t info_uuid = { .type = BT_UUID16,
 					.value.u16 = 0x2A4A };
 static const bt_uuid_t report_map_uuid = { .type = BT_UUID16,
-- 
1.9.1

