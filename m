Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] android: Use helper function to convert bdaddr to android format
Date: Mon, 28 Oct 2013 14:45:14 +0100
Message-ID: <1382967914-11102-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382967914-11102-1-git-send-email-szymon.janc@tieto.com>
References: <1382967914-11102-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will make easier to understand why swap is needed.
---
 Makefile.android  | 1 +
 android/adapter.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile.android b/Makefile.android
index fd8043c..2b57daa 100644
--- a/Makefile.android
+++ b/Makefile.android
@@ -4,6 +4,7 @@ noinst_PROGRAMS += android/bluetoothd
 android_bluetoothd_SOURCES =	android/main.c \
 				src/log.c \
 				android/hal-msg.h \
+				android/utils.h \
 				src/sdpd-database.c src/sdpd-server.c \
 				src/sdpd-service.c src/sdpd-request.c \
 				src/shared/util.h src/shared/util.c \
diff --git a/android/adapter.c b/android/adapter.c
index f393c49..15b65e5 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -31,6 +31,7 @@
 #include "log.h"
 #include "hal-msg.h"
 #include "ipc.h"
+#include "utils.h"
 #include "adapter.h"
 
 static GIOChannel *notification_io = NULL;
@@ -384,7 +385,7 @@ static void send_adapter_address(void)
 
 	ev->props[0].type = HAL_PROP_ADAPTER_ADDR;
 	ev->props[0].len = sizeof(bdaddr_t);
-	baswap((bdaddr_t *) ev->props[0].val, &adapter->bdaddr);
+	bdaddr2android(&adapter->bdaddr, ev->props[0].val);
 
 	ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH,
 				HAL_EV_ADAPTER_PROPS_CHANGED, len, ev, -1);
-- 
1.8.4.1

