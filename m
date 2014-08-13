Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] android/bluetooth: remove unused include
Date: Wed, 13 Aug 2014 15:44:35 +0200
Message-Id: <1407937477-25402-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

uuid-helper.h is no longer used in bluetooth.c
---
 android/bluetooth.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 655844d..699e880 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -40,7 +40,6 @@
 #include "lib/mgmt.h"
 #include "src/shared/util.h"
 #include "src/shared/mgmt.h"
-#include "src/uuid-helper.h"
 #include "src/eir.h"
 #include "lib/sdp.h"
 #include "lib/sdp_lib.h"
-- 
1.9.3

