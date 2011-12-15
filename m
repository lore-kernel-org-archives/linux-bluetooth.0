Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH] mcap_sync: fix import statements
Date: Thu, 15 Dec 2011 14:19:19 +0100
Message-Id: <1323955159-19799-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/mcap_sync.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/health/mcap_sync.c b/health/mcap_sync.c
index 5545cea..0e21877 100644
--- a/health/mcap_sync.c
+++ b/health/mcap_sync.c
@@ -21,21 +21,19 @@
  *
  */
 
-#include "btio.h"
 #include <stdint.h>
 #include <netinet/in.h>
 #include <time.h>
 #include <stdlib.h>
-#include <bluetooth/bluetooth.h>
-#include <bluetooth/l2cap.h>
-#include "../src/adapter.h"
-#include "../src/manager.h"
 #include <sys/ioctl.h>
 
-#include "config.h"
-#include "log.h"
-
 #include <bluetooth/bluetooth.h>
+#include <bluetooth/l2cap.h>
+#include <adapter.h>
+#include <manager.h>
+#include <btio.h>
+#include <log.h>
+
 #include "mcap.h"
 #include "mcap_lib.h"
 #include "mcap_internal.h"
-- 
1.7.8

