Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 5/6] android: Add initial code for socket service
Date: Wed, 23 Oct 2013 13:04:40 +0200
Message-ID: <1382526281-19711-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382526281-19711-1-git-send-email-szymon.janc@tieto.com>
References: <1382526281-19711-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Only handle register/unregister for now.
---
 Makefile.android   |  3 ++-
 android/Android.mk |  1 +
 android/main.c     | 10 ++++++++++
 android/socket.c   | 41 +++++++++++++++++++++++++++++++++++++++++
 android/socket.h   | 25 +++++++++++++++++++++++++
 5 files changed, 79 insertions(+), 1 deletion(-)
 create mode 100644 android/socket.c
 create mode 100644 android/socket.h

diff --git a/Makefile.android b/Makefile.android
index 0a05e9e..a398537 100644
--- a/Makefile.android
+++ b/Makefile.android
@@ -10,7 +10,8 @@ android_bluetoothd_SOURCES =	android/main.c \
 				src/shared/mgmt.h src/shared/mgmt.c \
 				android/adapter.h android/adapter.c \
 				android/hid.h android/hid.c \
-				android/ipc.h android/ipc.c
+				android/ipc.h android/ipc.c \
+				android/socket.h android/socket.c
 
 android_bluetoothd_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
diff --git a/android/Android.mk b/android/Android.mk
index 9f91576..dd5d6f7 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -17,6 +17,7 @@ LOCAL_SRC_FILES := \
 	log.c \
 	adapter.c \
 	hid.c \
+	socket.c \
 	ipc.c ipc.h \
 	../src/shared/mgmt.c \
 	../src/shared/util.c \
diff --git a/android/main.c b/android/main.c
index b18b8d4..e8b584d 100644
--- a/android/main.c
+++ b/android/main.c
@@ -49,6 +49,7 @@
 #include "src/shared/mgmt.h"
 
 #include "adapter.h"
+#include "socket.h"
 #include "hid.h"
 #include "hal-msg.h"
 #include "ipc.h"
@@ -81,6 +82,12 @@ static void service_register(void *buf, uint16_t len)
 			goto error;
 
 		break;
+	case HAL_SERVICE_ID_SOCK:
+		if (!bt_socket_register(hal_notif_io,
+						bt_adapter_get_address()))
+			goto error;
+
+		break;
 	default:
 		DBG("service %u not supported", m->service_id);
 		goto error;
@@ -108,6 +115,9 @@ static void service_unregister(void *buf, uint16_t len)
 	case HAL_SERVICE_ID_BLUETOOTH:
 		bt_adapter_unregister();
 		break;
+	case HAL_SERVICE_ID_SOCK:
+		bt_socket_unregister();
+		break;
 	default:
 		/* This would indicate bug in HAL, as unregister should not be
 		 * called in init failed */
diff --git a/android/socket.c b/android/socket.c
new file mode 100644
index 0000000..22d2acb
--- /dev/null
+++ b/android/socket.c
@@ -0,0 +1,41 @@
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
+#include <glib.h>
+#include <stdbool.h>
+
+#include "lib/bluetooth.h"
+#include "log.h"
+#include "socket.h"
+
+bool bt_socket_register(GIOChannel *io, const bdaddr_t *addr)
+{
+	DBG("");
+
+	return true;
+}
+
+void bt_socket_unregister(void)
+{
+	DBG("");
+}
diff --git a/android/socket.h b/android/socket.h
new file mode 100644
index 0000000..b13e84c
--- /dev/null
+++ b/android/socket.h
@@ -0,0 +1,25 @@
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
+bool bt_socket_register(GIOChannel *io, const bdaddr_t *addr);
+void bt_socket_unregister(void);
-- 
1.8.4

