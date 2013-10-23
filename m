Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 1/2] android: Add calls to socket methods in haltest
Date: Wed, 23 Oct 2013 10:34:57 +0200
Message-ID: <1382517298-28093-2-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1382517298-28093-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1382517298-28093-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds calls to socket methods.
---
 Makefile.android         |    2 +
 android/Android.mk       |    1 +
 android/client/haltest.c |    1 +
 android/client/if-bt.c   |    2 +-
 android/client/if-main.h |    2 +
 android/client/if-sock.c |  334 ++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 341 insertions(+), 1 deletion(-)
 create mode 100644 android/client/if-sock.c

diff --git a/Makefile.android b/Makefile.android
index 90d5973..30e9110 100644
--- a/Makefile.android
+++ b/Makefile.android
@@ -50,6 +50,7 @@ android_haltest_SOURCES = android/client/haltest.c \
 				android/client/tabcompletion.c \
 				android/client/if-bt.c \
 				android/client/if-hh.c \
+				android/client/if-sock.c \
 				android/client/hwmodule.c
 
 android_haltest_LDADD = android/libhal-internal.la
@@ -78,6 +79,7 @@ EXTRA_DIST += android/client/terminal.c \
 		android/client/history.c \
 		android/client/if-bt.c \
 		android/client/if-hh.c \
+		android/client/if-sock.c \
 		android/client/textconv.c \
 		android/client/tabcompletion.c \
 		android/client/textconv.h \
diff --git a/android/Android.mk b/android/Android.mk
index 7132279..7fdd70c 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -97,6 +97,7 @@ LOCAL_SRC_FILES := \
 	client/tabcompletion.c \
 	client/if-bt.c \
 	client/if-hh.c \
+	client/if-sock.c \
 
 LOCAL_CFLAGS := -DPLATFORM_SDK_VERSION=$(PLATFORM_SDK_VERSION)
 
diff --git a/android/client/haltest.c b/android/client/haltest.c
index 2894565..49c05e9 100644
--- a/android/client/haltest.c
+++ b/android/client/haltest.c
@@ -32,6 +32,7 @@
 const struct interface *interfaces[] = {
 	&bluetooth_if,
 	&hh_if,
+	&sock_if,
 	NULL
 };
 
diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index 01bf1d1..d90786a 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -807,7 +807,7 @@ static void get_profile_interface_p(int argc, const char **argv)
 	else if (strcmp(BT_PROFILE_HEALTH_ID, id) == 0)
 		pif = &dummy; /* TODO: change when if_hl is there */
 	else if (strcmp(BT_PROFILE_SOCKETS_ID, id) == 0)
-		pif = &dummy; /* TODO: change when if_sock is there */
+		pif = (const void **)&if_sock;
 	else if (strcmp(BT_PROFILE_HIDHOST_ID, id) == 0)
 		pif = (const void **)&if_hh;
 	else if (strcmp(BT_PROFILE_PAN_ID, id) == 0)
diff --git a/android/client/if-main.h b/android/client/if-main.h
index 21fdcfe..9c732c1 100644
--- a/android/client/if-main.h
+++ b/android/client/if-main.h
@@ -45,6 +45,7 @@
 /* Interfaces from hal that can be populated during application lifetime */
 extern const bt_interface_t *if_bluetooth;
 extern const bthh_interface_t *if_hh;
+extern const btsock_interface_t *if_sock;
 
 /*
  * Structure defines top level interfaces that can be used in test tool
@@ -56,6 +57,7 @@ struct interface {
 };
 
 extern const struct interface bluetooth_if;
+extern const struct interface sock_if;
 extern const struct interface hh_if;
 
 /* Interfaces that will show up in tool (first part of command line) */
diff --git a/android/client/if-sock.c b/android/client/if-sock.c
new file mode 100644
index 0000000..f761a0f
--- /dev/null
+++ b/android/client/if-sock.c
@@ -0,0 +1,334 @@
+/*
+ * Copyright (C) 2013 Intel Corporation
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ *
+ */
+
+#include <stdio.h>
+#include <ctype.h>
+#include <unistd.h>
+
+#include "if-main.h"
+#include "pollhandler.h"
+
+const btsock_interface_t *if_sock = NULL;
+
+SINTMAP(btsock_type_t, -1, "(unknown)")
+	DELEMENT(BTSOCK_RFCOMM),
+	DELEMENT(BTSOCK_SCO),
+	DELEMENT(BTSOCK_L2CAP),
+ENDMAP
+
+#define MAX_LISTEN_FD 15
+static int listen_fd[MAX_LISTEN_FD];
+static int listen_fd_count;
+
+/*
+ * This function reads data from file descriptor and
+ * prints it to the user
+ */
+static void receive_from_client(struct pollfd *pollfd)
+{
+	char buf[16];
+	/* Buffer for lines:
+	 * 41 42 43 20 20 00 31 32 00 07 04 00 00 00 00 00 ABC  .12.....
+	 */
+	char outbuf[sizeof(buf) * 4 + 2];
+	int i;
+	int ret;
+
+	if (pollfd->revents & POLLHUP) {
+		haltest_error("Disconnected fd=%d\n", pollfd->fd);
+		poll_unregister_fd(pollfd->fd, receive_from_client);
+	} else if (pollfd->revents & POLLIN) {
+
+		haltest_info("receiving from client fd=%d\n", pollfd->fd);
+
+		do {
+			memset(outbuf, ' ', sizeof(outbuf));
+			outbuf[sizeof(outbuf) - 1] = 0;
+			ret = recv(pollfd->fd, buf, sizeof(buf), MSG_DONTWAIT);
+
+			for (i = 0; i < ret; ++i)
+				sprintf(outbuf + i * 3, "%02X ",
+							(unsigned) buf[i]);
+			outbuf[i * 3] = ' ';
+			for (i = 0; i < ret; ++i)
+				sprintf(outbuf + 48 + i, "%c",
+					(isprint(buf[i]) ? buf[i] : '.'));
+			if (ret > 0)
+				haltest_info("%s\n", outbuf);
+		} while (ret > 0);
+	} else {
+		/* For now disconnect on all other events */
+		haltest_error("Poll event %x\n", pollfd->revents);
+		poll_unregister_fd(pollfd->fd, receive_from_client);
+	}
+}
+
+/*
+ * This function read from fd socket information about
+ * connected socket
+ */
+static void receive_sock_connect_signal(struct pollfd *pollfd)
+{
+	sock_connect_signal_t cs;
+	char addr_str[MAX_ADDR_STR_LEN];
+
+	if (pollfd->revents & POLLIN) {
+		int ret;
+
+		poll_unregister_fd(pollfd->fd, receive_sock_connect_signal);
+		ret = read(pollfd->fd, &cs, sizeof(cs));
+		if (ret != sizeof(cs)) {
+			haltest_info("Read on connect return %d\n", ret);
+			return;
+		}
+		haltest_info("Connection to %s channel %d status=%d\n",
+				bt_bdaddr_t2str(&cs.bd_addr, addr_str),
+							cs.channel, cs.status);
+
+		if (cs.status == 0)
+			poll_register_fd(pollfd->fd, POLLIN,
+							receive_from_client);
+	}
+
+	if (pollfd->revents & POLLHUP) {
+		haltest_error("Disconnected fd=%d revents=0x%X\n", pollfd->fd,
+				pollfd->revents);
+		poll_unregister_fd(pollfd->fd, receive_sock_connect_signal);
+	}
+}
+
+/*
+ * This function read from fd socket information about
+ * incoming connection and starts monitoring new connection
+ * on file descriptor read from fd.
+ */
+static void read_accepted(int fd)
+{
+	int ret;
+	struct msghdr msg;
+	struct iovec iv;
+	char cmsgbuf[CMSG_SPACE(1)];
+	struct cmsghdr *cmsgptr;
+	sock_connect_signal_t cs;
+	int accepted_fd = -1;
+	char addr_str[MAX_ADDR_STR_LEN];
+
+	memset(&msg, 0, sizeof(msg));
+	memset(&iv, 0, sizeof(iv));
+
+	iv.iov_base = &cs;
+	iv.iov_len = sizeof(cs);
+
+	msg.msg_iov = &iv;
+	msg.msg_iovlen = 1;
+	msg.msg_control = cmsgbuf;
+	msg.msg_controllen = sizeof(cmsgbuf);
+
+	do {
+		ret = recvmsg(fd, &msg, MSG_NOSIGNAL);
+	} while (ret < 0 && errno == EINTR);
+
+	if (ret < 16 ||
+		(msg.msg_flags & (MSG_CTRUNC | MSG_OOB | MSG_ERRQUEUE)) != 0)
+		haltest_error("Failed to accept connection\n");
+
+	for (cmsgptr = CMSG_FIRSTHDR(&msg);
+		cmsgptr != NULL; cmsgptr = CMSG_NXTHDR(&msg, cmsgptr)) {
+		int *descs;
+		int count;
+
+		if (cmsgptr->cmsg_level != SOL_SOCKET ||
+			cmsgptr->cmsg_type != SCM_RIGHTS)
+			continue;
+
+		descs = (int *) CMSG_DATA(cmsgptr);
+		count = ((cmsgptr->cmsg_len - CMSG_LEN(0)) / sizeof(int));
+
+		if (count != 1)
+			haltest_error("Failed to accept descriptors count=%d\n",
+									count);
+
+		accepted_fd = descs[0];
+		break;
+	}
+	haltest_info("Incoming connection from %s channel %d status=%d fd=%d\n",
+			bt_bdaddr_t2str(&cs.bd_addr, addr_str), cs.channel,
+							cs.status, accepted_fd);
+	poll_register_fd(accepted_fd, POLLIN, receive_from_client);
+}
+
+/* handles incoming connections on socket */
+static void client_connected(struct pollfd *pollfd)
+{
+	haltest_info("client connected %x\n", pollfd->revents);
+
+	if (pollfd->revents & POLLHUP)
+		poll_unregister_fd(pollfd->fd, client_connected);
+	else if (pollfd->revents & POLLIN)
+		read_accepted(pollfd->fd);
+}
+
+/** listen */
+
+static void listen_c(int argc, const char **argv,
+					enum_func *penum_func, void **puser)
+{
+	if (argc == 3) {
+		*puser = TYPE_ENUM(btsock_type_t);
+		*penum_func = enum_defines;
+	}
+}
+
+static void listen_p(int argc, const char **argv)
+{
+	btsock_type_t type;
+	const char *service_name;
+	bt_uuid_t service_uuid;
+	int channel;
+	int sock_fd;
+	int flags;
+
+	RETURN_IF_NULL(if_sock);
+
+	/* Socket type */
+	if (argc < 3) {
+		haltest_error("No socket type specified\n");
+		return;
+	}
+	type = str2btsock_type_t(argv[2]);
+	if ((int) type == -1)
+		type = atoi(argv[2]);
+
+	/* service name */
+	if (argc < 4) {
+		haltest_error("No service name specified\n");
+		return;
+	}
+	service_name = argv[3];
+
+	/* uuid */
+	if (argc < 5) {
+		haltest_error("No uuid specified\n");
+		return;
+	}
+	str2bt_uuid_t(argv[4], &service_uuid);
+
+	/* channel */
+	channel = argc > 5 ? atoi(argv[5]) : 0;
+
+	/* flags */
+	flags = argc > 6 ? atoi(argv[6]) : 0;
+
+	if (listen_fd_count >= MAX_LISTEN_FD) {
+		haltest_error("Max (%d) listening sockets exceeded\n",
+							listen_fd_count);
+		return;
+	}
+	EXEC(if_sock->listen, type, service_name,
+				&service_uuid.uu[0], channel, &sock_fd, flags);
+	if (sock_fd > 0) {
+		int channel = 0;
+		int ret = read(sock_fd, &channel, 4);
+		if (ret != 4)
+			haltest_info("Read channel failed\n");
+		haltest_info("Channel returned from first read %d\n", channel);
+		listen_fd[listen_fd_count++] = sock_fd;
+		poll_register_fd(sock_fd, POLLIN, client_connected);
+	}
+}
+
+/** connect */
+
+static void connect_c(int argc, const char **argv,
+					enum_func *penum_func, void **puser)
+{
+	if (argc == 3) {
+		*penum_func = enum_devices;
+	} else if (argc == 4) {
+		*puser = TYPE_ENUM(btsock_type_t);
+		*penum_func = enum_defines;
+	}
+}
+
+static void connect_p(int argc, const char **argv)
+{
+	bt_bdaddr_t addr;
+	btsock_type_t type;
+	bt_uuid_t uuid;
+	int channel;
+	int sock_fd;
+	int flags;
+
+	/* Address */
+	if (argc <= 2) {
+		haltest_error("No address specified\n");
+		return;
+	}
+	str2bt_bdaddr_t(argv[2], &addr);
+
+	/* Socket type */
+	if (argc <= 3) {
+		haltest_error("No socket type specified\n");
+		return;
+	}
+	type = str2btsock_type_t(argv[3]);
+	if ((int) type == -1)
+		type = atoi(argv[3]);
+
+	/* uuid */
+	if (argc <= 4) {
+		haltest_error("No uuid specified\n");
+		return;
+	}
+	str2bt_uuid_t(argv[4], &uuid);
+
+	/* channel */
+	if (argc <= 5) {
+		haltest_error("No channel specified\n");
+		return;
+	}
+	channel = atoi(argv[5]);
+
+	/* flags */
+	flags = argc <= 6 ? 0 : atoi(argv[6]);
+
+	RETURN_IF_NULL(if_sock);
+
+	EXEC(if_sock->connect, &addr, type, &uuid.uu[0], channel, &sock_fd,
+									flags);
+	if (sock_fd > 0) {
+		int channel = 0;
+		int ret = read(sock_fd, &channel, 4);
+		if (ret != 4)
+			haltest_info("Read channel failed\n");
+		haltest_info("Channel returned from first read %d\n", channel);
+		listen_fd[listen_fd_count++] = sock_fd;
+		poll_register_fd(sock_fd, POLLIN, receive_sock_connect_signal);
+	}
+}
+
+/* Methods available in btsock_interface_t */
+static struct method methods[] = {
+	STD_METHODCH(listen, "<sock_type> <srvc_name> <uuid> [<channle>] [<flags>]"),
+	STD_METHODCH(connect, "<addr> <sock_type> <uuid> <channle> [<flags>]"),
+	END_METHOD
+};
+
+const struct interface sock_if = {
+	.name = "socket",
+	.methods = methods
+};
-- 
1.7.9.5

