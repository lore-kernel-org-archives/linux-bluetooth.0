Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC v2 1/5] android: Add initial code for generic IPC msg handling
Date: Fri, 15 Nov 2013 01:40:13 +0000
Message-Id: <1384479617-15555-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1384479617-15555-1-git-send-email-szymon.janc@tieto.com>
References: <1384479617-15555-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow to register and unregister handlers for IPC messages.
Basic sanity check will be done in common code. Commands with variable
length will be verified against minimum size only.
---
 android/Android.mk  |  2 ++
 android/Makefile.am |  5 +--
 android/hal-msg.c   | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 android/hal-msg.h   | 14 ++++++++
 android/ipc.c       |  1 +
 5 files changed, 114 insertions(+), 2 deletions(-)
 create mode 100644 android/hal-msg.c

diff --git a/android/Android.mk b/android/Android.mk
index 616a338..23a530f 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -27,6 +27,7 @@ LOCAL_SRC_FILES := \
 	ipc.c ipc.h \
 	a2dp.c \
 	pan.c \
+	hal-msg.c \
 	../src/log.c \
 	../src/shared/mgmt.c \
 	../src/shared/util.c \
@@ -88,6 +89,7 @@ LOCAL_SRC_FILES := \
 	hal-pan.c \
 	hal-a2dp.c \
 	hal-utils.c \
+	hal-msg.c \
 
 LOCAL_C_INCLUDES += \
 	$(call include-path-for, system-core) \
diff --git a/android/Makefile.am b/android/Makefile.am
index 4e0c9ed..831a3cb 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -8,7 +8,7 @@ noinst_PROGRAMS += android/bluetoothd
 
 android_bluetoothd_SOURCES = android/main.c \
 				src/log.c \
-				android/hal-msg.h \
+				android/hal-msg.h android/hal-msg.c \
 				android/utils.h \
 				src/sdpd-database.c src/sdpd-server.c \
 				src/sdpd-service.c src/sdpd-request.c \
@@ -49,7 +49,8 @@ android_libhal_internal_la_SOURCES = android/hal.h android/hal-bluetooth.c \
 					android/hardware/hardware.h \
 					android/cutils/properties.h \
 					android/hal-log.h \
-					android/hal-ipc.h android/hal-ipc.c
+					android/hal-ipc.h android/hal-ipc.c \
+					android/hal-msg.h android/hal-msg.c
 
 android_libhal_internal_la_CPPFLAGS = -I$(srcdir)/android
 
diff --git a/android/hal-msg.c b/android/hal-msg.c
new file mode 100644
index 0000000..2b5178b
--- /dev/null
+++ b/android/hal-msg.c
@@ -0,0 +1,94 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2013  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include <stddef.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <unistd.h>
+
+#include "hal-msg.h"
+
+struct service_handler {
+	const struct hal_msg_handler *handler;
+	uint8_t size;
+	uint8_t offset;
+};
+
+static struct service_handler services[HAL_SERVICE_ID_MAX + 1];
+
+void hal_msg_register(uint8_t service, const struct hal_msg_handler *handlers,
+						uint8_t size, uint8_t offset)
+{
+	services[service].handler = handlers;
+	services[service].size = size;
+	services[service].offset = offset;
+}
+
+void hal_msg_unregister(uint8_t service)
+{
+	services[service].handler = NULL;
+	services[service].size = 0;
+	services[service].offset = 0;
+}
+
+bool hal_msg_handler(void *buf, ssize_t len, int fd)
+{
+	struct hal_hdr *msg = buf;
+	const struct hal_msg_handler *handler;
+	uint8_t opcode;
+
+	if (len < (ssize_t) sizeof(*msg))
+		return false;
+
+	if (len != (ssize_t) (sizeof(*msg) + msg->len))
+		return false;
+
+	/* if service is valid */
+	if (msg->service_id > HAL_SERVICE_ID_MAX)
+		return false;
+
+	/* if service is registered */
+	if (!services[msg->service_id].handler)
+		return false;
+
+	/* if opcode fit offset (eg. events) */
+	if (msg->opcode < services[msg->service_id].offset)
+		return false;
+
+	opcode = msg->opcode - services[msg->service_id].offset;
+
+	/* if opcode is valid */
+	if (opcode >= services[msg->service_id].size)
+		return false;
+
+	handler = &services[msg->service_id].handler[opcode];
+
+	/* if payload size is valid */
+	if ((handler->var_len && handler->data_len > msg->len) ||
+			(!handler->var_len && handler->data_len != msg->len))
+		return false;
+
+	handler->handler(msg->payload, msg->len, fd);
+
+	return true;
+}
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 44fd5c8..17c0ac4 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -546,3 +546,17 @@ struct hal_ev_a2dp_audio_state {
 	uint8_t state;
 	uint8_t bdaddr[6];
 } __attribute__((packed));
+
+
+/* HAL message handler helpers */
+
+struct hal_msg_handler {
+	void (*handler) (void *buf, uint16_t len, int fd);
+	bool var_len;
+	size_t data_len;
+};
+
+void hal_msg_register(uint8_t service, const struct hal_msg_handler *handlers,
+						uint8_t size, uint8_t offset);
+void hal_msg_unregister(uint8_t service);
+bool hal_msg_handler(void *buf, ssize_t len, int fd);
diff --git a/android/ipc.c b/android/ipc.c
index 729f157..7526d25 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -28,6 +28,7 @@
 #include <stddef.h>
 #include <errno.h>
 #include <stdint.h>
+#include <stdbool.h>
 #include <string.h>
 #include <signal.h>
 #include <sys/socket.h>
-- 
1.8.4.3

