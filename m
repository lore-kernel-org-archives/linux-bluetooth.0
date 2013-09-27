Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 16/16] android: Add HAL message helpers
Date: Fri, 27 Sep 2013 17:12:41 +0300
Message-Id: <1380291161-10232-17-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1380291161-10232-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1380291161-10232-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add helper to ease opening channel and sending commands.
---
 android/Android.mk       |    1 +
 android/hal_msg_client.c |  112 ++++++++++++++++++++++++++++++++++++++++++++++
 android/hal_msg_client.h |   25 +++++++++++
 3 files changed, 138 insertions(+)
 create mode 100644 android/hal_msg_client.c
 create mode 100644 android/hal_msg_client.h

diff --git a/android/Android.mk b/android/Android.mk
index d16c3f5..4446b2f 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -46,6 +46,7 @@ LOCAL_SRC_FILES := \
 	hal_bluetooth.c \
 	hal_cb_thread.c \
 	hal_bt_sock.c \
+	hal_msg_client.c \
 
 LOCAL_SHARED_LIBRARIES := \
 	libcutils \
diff --git a/android/hal_msg_client.c b/android/hal_msg_client.c
new file mode 100644
index 0000000..87880fe
--- /dev/null
+++ b/android/hal_msg_client.c
@@ -0,0 +1,112 @@
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
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <stdbool.h>
+
+#include <hardware/bluetooth.h>
+#include <cutils/sockets.h>
+#include <cutils/properties.h>
+
+#define LOG_TAG "BlueZ"
+#include <cutils/log.h>
+
+#include "hal_msg.h"
+#include "hal_msg_client.h"
+
+#define BLUEZ_SOCKET "bluez_hal"
+
+int open_hal_chan(void)
+{
+	int tries = 10;
+	int sock;
+
+	while (tries-- > 0) {
+		sock = socket_local_client(BLUEZ_SOCKET,
+					ANDROID_SOCKET_NAMESPACE_RESERVED,
+					SOCK_STREAM);
+		if (sock < 0)
+			ALOGE("%s: Cannot open chan: %s", __func__,
+							strerror(errno));
+		else
+			return sock;
+
+		usleep(100000);
+	}
+
+	return sock;
+}
+
+static int hal_send(int sock, struct hal_msg_hdr *msg)
+{
+	struct hal_msg_rsp rsp;
+	int len, size;
+
+	if (sock < 0) {
+		ALOGE("%s: socket not ready", __func__);
+		return BT_STATUS_NOT_READY;
+	}
+
+	size = sizeof(*msg) + msg->len;
+	len = send(sock, msg, size, 0);
+	if (len != size) {
+		ALOGE("%s: send(): %s", __func__, strerror(errno));
+		close(sock);
+		return BT_STATUS_FAIL;
+	}
+
+	ALOGD("%s: Sent %d bytes", __func__, len);
+
+	len = recv(sock, &rsp, sizeof(rsp), 0);
+	if (len != sizeof(rsp)) {
+		ALOGE("%s: recv(): read %d bytes", __func__, len);
+		return BT_STATUS_FAIL;
+	}
+
+	return rsp.status;
+}
+
+int hal_register_module(int sock, uint8_t service_id)
+{
+	struct hal_msg_hdr *hdr;
+	struct hal_msg_cp_register_module *msg;
+	int err;
+
+	hdr = malloc(sizeof(*hdr) + sizeof(*msg));
+	if (hdr == NULL)
+		return BT_STATUS_NOMEM;
+
+	hdr->service_id = 0;
+	hdr->opcode = HAL_MSG_OP_REGISTER_MODULE;
+	hdr->len = sizeof(*msg);
+
+	msg = (struct  hal_msg_cp_register_module *) hdr->payload;
+	msg->service_id = service_id;
+
+	err = hal_send(sock, hdr);
+
+	free(hdr);
+	return err;
+}
diff --git a/android/hal_msg_client.h b/android/hal_msg_client.h
new file mode 100644
index 0000000..c620dea
--- /dev/null
+++ b/android/hal_msg_client.h
@@ -0,0 +1,25 @@
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
+int hal_register_module(int sock, uint8_t service_id);
+int open_hal_chan(void);
-- 
1.7.10.4

