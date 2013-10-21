Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 3/6] android: Implement basic HAL server
Date: Mon, 21 Oct 2013 14:28:34 +0300
Message-Id: <1382354917-8632-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1382354917-8632-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1382354917-8632-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add basic HAL server on BlueZ daemon side. It will listen for messages
from Android HAL threads.
---
 Makefile.android   |    2 +-
 android/Android.mk |    1 +
 android/hal-msg.c  |  267 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 android/hal-msg.h  |    5 +
 android/main.c     |   11 +++
 5 files changed, 285 insertions(+), 1 deletion(-)
 create mode 100644 android/hal-msg.c

diff --git a/Makefile.android b/Makefile.android
index 8196583..96f3f22 100644
--- a/Makefile.android
+++ b/Makefile.android
@@ -3,7 +3,7 @@ noinst_PROGRAMS += android/bluetoothd
 
 android_bluetoothd_SOURCES =	android/main.c \
 				src/log.c \
-				android/hal-msg.h \
+				android/hal-msg.h android/hal-msg.c \
 				src/sdpd-database.c src/sdpd-server.c \
 				src/sdpd-service.c src/sdpd-request.c \
 				src/shared/util.h src/shared/util.c \
diff --git a/android/Android.mk b/android/Android.mk
index 30b2169..d5dfde7 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -16,6 +16,7 @@ LOCAL_SRC_FILES := \
 	main.c \
 	log.c \
 	adapter.c \
+	hal-msg.c \
 	../src/shared/mgmt.c \
 	../src/shared/util.c \
 	../src/sdpd-database.c \
diff --git a/android/hal-msg.c b/android/hal-msg.c
new file mode 100644
index 0000000..aa02236
--- /dev/null
+++ b/android/hal-msg.c
@@ -0,0 +1,267 @@
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <errno.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <sys/stat.h>
+
+#include <glib.h>
+
+#include "log.h"
+#include "hal-msg.h"
+
+static guint watch_id = 0;
+
+static uint8_t hal_register_module(struct hal_msg_hdr *msg)
+{
+	DBG("");
+
+	return 0;
+}
+
+static uint8_t hal_unregister_module(struct hal_msg_hdr *msg)
+{
+	DBG("");
+
+	return 0;
+}
+
+static uint8_t process_hal_service_chan(struct hal_msg_hdr *msg)
+{
+	uint8_t status = -1;
+
+	DBG("");
+
+	switch (msg->opcode) {
+	case HAL_MSG_OP_REGISTER_MODULE:
+		status = hal_register_module(msg);
+		break;
+	case HAL_MSG_OP_UNREGISTER_MODULE:
+		status = hal_unregister_module(msg);
+		break;
+	default:
+		error("%s: unrecognized command on service channel", __func__);
+		break;
+	}
+
+	return status;
+}
+
+static uint8_t sanity_check(struct hal_msg_hdr *msg)
+{
+	/* TODO: Add sanity check here */
+
+	return 0;
+}
+
+static uint8_t process_hal_msg(uint8_t *buf, int len)
+{
+	struct hal_msg_hdr *msg = (struct hal_msg_hdr *) buf;
+	uint8_t status;
+
+	DBG("");
+
+	status = sanity_check(msg);
+	if (status != 0)
+		return status;
+
+	if (msg->service_id == 0)
+		status = process_hal_service_chan(msg);
+
+	return status;
+}
+
+static gboolean io_session_event(GIOChannel *chan, GIOCondition cond,
+								gpointer data)
+{
+	struct hal_msg_hdr *hdr;
+	uint8_t buf[MAX_HAL_BUF_SIZE];
+	int sock, len;
+	uint8_t status;
+
+	if (cond & G_IO_NVAL)
+		return FALSE;
+
+	sock = g_io_channel_unix_get_fd(chan);
+
+	if (cond & (G_IO_HUP | G_IO_ERR)) {
+		error("%s: error condition %d", __func__, cond);
+		/* TODO: handle */
+		return FALSE;
+	}
+
+	len = recv(sock, buf, sizeof(buf), 0);
+	if (len <= 0) {
+		error("%s: recv(): %s", __func__, strerror(errno));
+		/* TODO: handle */
+		return FALSE;
+	}
+
+	if (len < (int) sizeof(struct hal_msg_hdr))
+		return FALSE;
+
+	status = process_hal_msg(buf, len);
+
+	hdr = (struct hal_msg_hdr *) buf;
+
+	if (status == 0) {
+		/* Success reply */
+		len =  send(sock, hdr, sizeof(*hdr), 0);
+		if (len != sizeof(hdr)) {
+			error("%s: send() rsp: %s", __func__, strerror(errno));
+			/* TODO: handle */
+			return FALSE;
+		}
+	} else {
+		struct hal_msg_rsp {
+			struct hal_msg_hdr hdr;
+			uint8_t status;
+		} rsp;
+
+		rsp.hdr.service_id = hdr->service_id;
+		rsp.hdr.opcode = HAL_MSG_OP_ERROR;
+		rsp.hdr.len = sizeof(rsp.status);
+		rsp.status = status;
+
+		len = send(sock, &rsp, sizeof(rsp), 0);
+		if (len != sizeof(rsp)) {
+			error("%s: send() rsp: %s", __func__, strerror(errno));
+			/* TODO: handle */
+			return FALSE;
+		}
+	}
+
+	return TRUE;
+}
+
+static gboolean io_accept_event(GIOChannel *chan, GIOCondition cond,
+								gpointer data)
+{
+	GIOChannel *io;
+	int sock, nsk;
+	struct sockaddr_un addr;
+	socklen_t len = sizeof(addr);
+
+	DBG("");
+
+	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL))
+		return FALSE;
+
+	sock = g_io_channel_unix_get_fd(chan);
+
+	nsk = accept(sock, (struct sockaddr *) &addr, &len);
+	if (nsk < 0) {
+		error("%s: accept(): %s", __func__, strerror(errno));
+		return TRUE;
+	}
+
+	io = g_io_channel_unix_new(nsk);
+	g_io_channel_set_close_on_unref(io, TRUE);
+
+	g_io_add_watch(io, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+						io_session_event, data);
+
+	g_io_channel_unref(io);
+
+	return TRUE;
+}
+
+static int init_hal_socket(const char *sock_path)
+{
+	struct sockaddr_un addr;
+	int sock;
+	size_t len;
+
+	DBG("");
+
+	sock = socket(AF_UNIX, SOCK_SEQPACKET, 0);
+	if (sock < 0) {
+		error("%s: socket(): %s", __func__, strerror(errno));
+		return sock;
+	}
+
+	len = strlen(sock_path);
+	if (len > sizeof(addr.sun_path) - 1) {
+		error("%s: too big socket name", __func__);
+		return -1;
+	}
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sun_family = AF_UNIX;
+	strcpy(addr.sun_path, sock_path);
+
+	/* let fail for android */
+	if (unlink(addr.sun_path) < 0)
+		warn("%s: unlink() %s failed: %s", __func__, sock_path,
+							strerror(errno));
+
+	if (bind(sock, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		error("%s: bind(): %s", __func__, strerror(errno));
+		return -1;
+	}
+
+	if (listen(sock, 5) < 0) {
+		error("%s: listen(): %s", __func__, strerror(errno));
+		return -1;
+	}
+
+	chmod(sock_path, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP);
+
+	return sock;
+}
+
+void start_hal_srv(const char *sock_path)
+{
+	GIOChannel *io;
+	int sock;
+
+	DBG("");
+
+	sock = init_hal_socket(sock_path);
+	if (sock < 0)
+		return;
+
+	io = g_io_channel_unix_new(sock);
+	g_io_channel_set_close_on_unref(io, TRUE);
+
+	watch_id = g_io_add_watch(io, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+							io_accept_event, &sock);
+}
+
+void stop_hal_srv(void)
+{
+	DBG("");
+
+	if (watch_id > 0)
+		g_source_remove(watch_id);
+
+	watch_id = 0;
+}
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 4440fc8..f27662a 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -23,6 +23,9 @@
 
 static const char BLUEZ_HAL_SK_PATH[] = "\0bluez_hal_socket";
 
+void start_hal_srv(const char *sock_path);
+void stop_hal_srv(void);
+
 struct hal_msg_hdr {
 	uint8_t service_id;
 	uint8_t opcode;
@@ -40,6 +43,8 @@ struct hal_msg_hdr {
 #define HAL_SERVICE_ID_AVRCP		8
 #define HAL_SERVICE_ID_GATT		9
 
+#define MAX_HAL_BUF_SIZE	1024
+
 /* Core Service */
 
 #define HAL_MSG_OP_ERROR		0x00
diff --git a/android/main.c b/android/main.c
index 4a716be..99db09b 100644
--- a/android/main.c
+++ b/android/main.c
@@ -56,6 +56,14 @@
 #include "adapter.h"
 #include "hal-msg.h"
 
+#if defined(ANDROID)
+#define BT_HAL_SOCKET "/tmp/bt_hal"
+#else
+#define BT_HAL_SOCKET "/var/run/bt_hal"
+#endif
+
+#define SHUTDOWN_GRACE_SECONDS 10
+
 static GMainLoop *event_loop;
 static struct mgmt *mgmt_if = NULL;
 
@@ -505,6 +513,7 @@ int main(int argc, char *argv[])
 
 	/* Use params: mtu = 0, flags = 0 */
 	start_sdp_server(0, 0);
+	start_hal_srv(BT_HAL_SOCKET);
 
 	DBG("Entering main loop");
 
@@ -513,6 +522,8 @@ int main(int argc, char *argv[])
 	g_source_remove(signal);
 
 	cleanup_hal_connection();
+
+	stop_hal_srv();
 	stop_sdp_server();
 	cleanup_mgmt_interface();
 	g_main_loop_unref(event_loop);
-- 
1.7.10.4

