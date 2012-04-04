Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] DeviceInfo: Fix compilation with old glib
Date: Wed, 4 Apr 2012 16:58:22 +0200
Message-ID: <1333551502-28159-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add missing include glib-compat.h to deviceinfo.c. deviceinfo_free
is using g_slist_free_full() which is not available in old glib
resulting in compilation error.

deviceinfo/deviceinfo.c: In function ‘deviceinfo_free’:
deviceinfo/deviceinfo.c:66: error: implicit declaration of function ‘g_slist_free_full’
---
 deviceinfo/deviceinfo.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/deviceinfo/deviceinfo.c b/deviceinfo/deviceinfo.c
index e9fcd04..95fa12d 100644
--- a/deviceinfo/deviceinfo.c
+++ b/deviceinfo/deviceinfo.c
@@ -26,6 +26,7 @@
 
 #include <glib.h>
 #include <bluetooth/uuid.h>
+#include "glib-compat.h"
 #include "adapter.h"
 #include "device.h"
 #include "gattrib.h"
-- 
on behalf of ST-Ericsson

