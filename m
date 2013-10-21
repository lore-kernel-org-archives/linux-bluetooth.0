Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 08/11] android: Add IPC helper for sending command responses and notification
Date: Mon, 21 Oct 2013 20:56:48 +0200
Message-Id: <1382381811-28123-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382381811-28123-1-git-send-email-szymon.janc@tieto.com>
References: <1382381811-28123-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If send failed mainloop is stopped.
---
 Makefile.android   |  3 +-
 android/Android.mk |  1 +
 android/ipc.c      | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 android/ipc.h      | 25 +++++++++++++++++
 4 files changed, 108 insertions(+), 1 deletion(-)
 create mode 100644 android/ipc.c
 create mode 100644 android/ipc.h

diff --git a/Makefile.android b/Makefile.android
index c2010b3..aebc715 100644
--- a/Makefile.android
+++ b/Makefile.android
@@ -8,7 +8,8 @@ android_bluetoothd_SOURCES =	android/main.c \
 				src/sdpd-service.c src/sdpd-request.c \
 				src/shared/util.h src/shared/util.c \
 				src/shared/mgmt.h src/shared/mgmt.c \
-				android/adapter.h android/adapter.c
+				android/adapter.h android/adapter.c \
+				android/ipc.h android/ipc.c
 
 android_bluetoothd_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
diff --git a/android/Android.mk b/android/Android.mk
index bd3d48a..679c12b 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -16,6 +16,7 @@ LOCAL_SRC_FILES := \
 	main.c \
 	log.c \
 	adapter.c \
+	ipc.c ipc.h \
 	../src/shared/mgmt.c \
 	../src/shared/util.c \
 	../src/sdpd-database.c \
diff --git a/android/ipc.c b/android/ipc.c
new file mode 100644
index 0000000..449ba23
--- /dev/null
+++ b/android/ipc.c
@@ -0,0 +1,80 @@
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
+#include <stddef.h>
+#include <errno.h>
+#include <stdint.h>
+#include <string.h>
+#include <sys/socket.h>
+
+#include <glib.h>
+
+#include "hal-msg.h"
+#include "ipc.h"
+#include "log.h"
+#include "main.h"
+
+void ipc_send(GIOChannel *io, uint8_t service_id, uint8_t opcode, uint16_t len,
+							void *param, int fd)
+{
+	struct msghdr msg;
+	struct iovec iv[2];
+	struct hal_msg_hdr hal_msg;
+	char cmsgbuf[CMSG_SPACE(sizeof(int))];
+	struct cmsghdr *cmsg;
+
+
+	memset(&msg, 0, sizeof(msg));
+	memset(&hal_msg, 0, sizeof(hal_msg));
+
+	hal_msg.service_id = service_id;
+	hal_msg.opcode = opcode;
+	hal_msg.len = len;
+
+	iv[0].iov_base = &hal_msg;
+	iv[0].iov_len = sizeof(hal_msg);
+
+	iv[1].iov_base = param;
+	iv[1].iov_len = len;
+
+	msg.msg_iov = iv;
+	msg.msg_iovlen = 2;
+
+	if (fd >= 0) {
+		cmsg = CMSG_FIRSTHDR(&msg);
+		cmsg->cmsg_level = SOL_SOCKET;
+		cmsg->cmsg_type = SCM_RIGHTS;
+		cmsg->cmsg_len = CMSG_LEN(sizeof(int));
+
+		/* Initialize the payload */
+		memcpy(CMSG_DATA(cmsg), &fd, sizeof(int));
+
+		msg.msg_control = cmsgbuf;
+		msg.msg_controllen = sizeof(cmsgbuf);
+	}
+
+	if (sendmsg(g_io_channel_unix_get_fd(io), &msg, 0) < 0) {
+		error("IPC send failed, terminating :%s", strerror(errno));
+		main_quit();
+	}
+}
diff --git a/android/ipc.h b/android/ipc.h
new file mode 100644
index 0000000..db92c97
--- /dev/null
+++ b/android/ipc.h
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
+void ipc_send(GIOChannel *io, uint8_t service_id, uint8_t opcode, uint16_t len,
+							void *param, int fd);
-- 
1.8.4

