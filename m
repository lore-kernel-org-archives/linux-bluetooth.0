Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCHv2 26/27] android/hog: Remove redundant code
Date: Fri,  3 Apr 2015 15:43:55 +0200
Message-Id: <1428068636-13073-27-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1428068636-13073-1-git-send-email-mariusz.skamra@tieto.com>
References: <1428068636-13073-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hog.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/android/hog.c b/android/hog.c
index 22aac76..ad047f0 100644
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
@@ -70,9 +65,6 @@
 #define HOG_PROTO_MODE_BOOT    0
 #define HOG_PROTO_MODE_REPORT  1
 
-#define HOG_REPORT_MAP_MAX_SIZE        512
-#define HID_INFO_SIZE			4
-
 static bdaddr_t	adapter_addr;
 
 struct bt_hog {
-- 
1.9.1

