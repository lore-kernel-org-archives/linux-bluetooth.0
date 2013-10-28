Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/4] android: Add helper functions for converting bdaddr transmitted over IPC
Date: Mon, 28 Oct 2013 13:46:13 +0100
Message-ID: <1382964375-7589-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382964375-7589-1-git-send-email-szymon.janc@tieto.com>
References: <1382964375-7589-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Android holds Bluetooth address in reverse order comparing to
bluetoothd. Add convenient functions for converting to and from that
format.

Convertion is done on daemon side to keep HAL library simple.
---
 Makefile.android  |  1 +
 android/adapter.c |  3 ++-
 android/utils.h   | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 android/utils.h

diff --git a/Makefile.android b/Makefile.android
index 01b3cea..6cd26e1 100644
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
diff --git a/android/utils.h b/android/utils.h
new file mode 100644
index 0000000..5b009bc
--- /dev/null
+++ b/android/utils.h
@@ -0,0 +1,33 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2013  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+
+static inline void android2bdaddr(const void *buf, bdaddr_t *dst)
+{
+	baswap(dst, buf);
+}
+
+static inline void bdaddr2android(const bdaddr_t *src, void *buf)
+{
+	baswap(buf, src);
+}
-- 
1.8.4.1

