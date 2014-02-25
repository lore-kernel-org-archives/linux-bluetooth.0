Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/avrcp: trivial header include cleanup
Date: Tue, 25 Feb 2014 15:51:53 +0200
Message-Id: <1393336313-1154-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/avrcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/avrcp.c b/android/avrcp.c
index acffd56..48444a4 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -34,10 +34,10 @@
 #include "lib/sdp_lib.h"
 #include "src/log.h"
 #include "bluetooth.h"
-#include "avrcp.h"
-#include "avrcp-lib.h"
 #include "hal-msg.h"
 #include "ipc.h"
+#include "avrcp-lib.h"
+#include "avrcp.h"
 
 #define L2CAP_PSM_AVCTP 0x17
 
-- 
1.8.3.2

