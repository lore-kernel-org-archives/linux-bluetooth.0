Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH V2 01/10] shared/btp: Add initial code for library
Date: Fri,  8 Dec 2017 15:03:40 +0100
Message-Id: <20171208140348.30342-2-szymon.janc@codecoup.pl>
In-Reply-To: <20171208140348.30342-1-szymon.janc@codecoup.pl>
References: <20171208140348.30342-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to connect to BTP socket, process message one-by-one (next
message is processed only after reply to previous was sent), reply and
send notifications.

Currently it is very simple and push most of error checking to user.
Could be extended in future if needed.
---
 src/shared/btp.c | 383 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/btp.h |  95 ++++++++++++++
 2 files changed, 478 insertions(+)
 create mode 100644 src/shared/btp.c
 create mode 100644 src/shared/btp.h

diff --git a/src/shared/btp.c b/src/shared/btp.c
new file mode 100644
index 000000000..d981621a8
--- /dev/null
+++ b/src/shared/btp.c
@@ -0,0 +1,383 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012-2017  Intel Corporation. All rights reserved.
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
+#include <stdbool.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <unistd.h>
+
+#include <ell/ell.h>
+
+#include "src/shared/btp.h"
+
+#define BTP_MTU 512
+
+struct btp_handler {
+	unsigned int id;
+	uint8_t service;
+	uint8_t opcode;
+
+	btp_cmd_func_t callback;
+	void *user_data;
+	btp_destroy_func_t destroy;
+};
+
+struct btp {
+	struct l_io *io;
+
+	struct l_queue *pending;
+	bool writer_active;
+	bool reader_active;
+
+	struct l_queue *handlers;
+	unsigned int next_handler;
+
+	uint8_t buf[BTP_MTU];
+
+	btp_disconnect_func_t disconnect_cb;
+	void *disconnect_cb_data;
+	btp_destroy_func_t disconnect_cb_data_destroy;
+};
+
+
+static struct l_io *btp_connect(const char *path)
+{
+	struct sockaddr_un addr;
+	struct l_io *io;
+	int sk;
+
+	sk = socket(AF_UNIX, SOCK_STREAM | SOCK_NONBLOCK, 0);
+	if (sk < 0)
+		return NULL;
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sun_family = AF_UNIX;
+	strncpy(addr.sun_path, path, sizeof(addr.sun_path) - 1);
+
+	if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		close(sk);
+		return NULL;
+	}
+
+	io = l_io_new(sk);
+	if (!io) {
+		close(sk);
+		return NULL;
+	}
+
+	l_io_set_close_on_destroy(io, true);
+	return io;
+}
+
+static void disconnect_handler(struct l_io *io, void *user_data)
+{
+	struct btp *btp = user_data;
+
+	btp->disconnect_cb(btp, btp->disconnect_cb_data);
+}
+
+static void disconnect_handler_destroy(void *user_data)
+{
+	struct btp *btp = user_data;
+
+	if (btp->disconnect_cb_data_destroy)
+		btp->disconnect_cb_data_destroy(btp->disconnect_cb_data);
+}
+
+struct handler_match_data {
+	uint8_t service;
+	uint8_t opcode;
+};
+
+static bool handler_match(const void *a, const void *b)
+{
+	const struct btp_handler *handler = a;
+	const struct handler_match_data *match = b;
+
+	return (handler->service == match->service) &&
+					(handler->opcode == match->opcode);
+}
+
+static bool can_read_data(struct l_io *io, void *user_data)
+{
+	struct handler_match_data match;
+	struct btp *btp = user_data;
+	struct btp_handler *handler;
+	struct btp_hdr *hdr;
+	ssize_t bytes_read;
+	uint16_t data_len;
+
+	bytes_read = read(l_io_get_fd(btp->io), btp->buf, sizeof(btp->buf));
+	if (bytes_read < 0)
+		return false;
+
+	if ((size_t) bytes_read < sizeof(*hdr))
+		return false;
+
+	hdr = (void *)btp->buf;
+
+	data_len = L_LE16_TO_CPU(hdr->data_len);
+
+	if ((size_t) bytes_read < sizeof(*hdr) + data_len)
+		return false;
+
+	match.service = hdr->service;
+	match.opcode = hdr->opcode;
+
+	handler = l_queue_find(btp->handlers, handler_match, &match);
+	if (handler) {
+		handler->callback(hdr->index, hdr->data, data_len,
+							handler->user_data);
+		return false;
+	}
+
+	/* keep reader active if we sent error reply */
+	btp_send_error(btp, match.service, hdr->index, BTP_ERROR_UNKNOWN_CMD);
+	return true;
+}
+
+static void read_watch_destroy(void *user_data)
+{
+	struct btp *btp = user_data;
+
+	btp->reader_active = false;
+}
+
+static void wakeup_reader(struct btp *btp)
+{
+	if (btp->reader_active)
+		return;
+
+	btp->reader_active = l_io_set_read_handler(btp->io, can_read_data, btp,
+							read_watch_destroy);
+}
+
+struct btp *btp_new(const char *path)
+{
+	struct btp *btp;
+	struct l_io *io;
+
+	io = btp_connect(path);
+	if (!io)
+		return NULL;
+
+	btp = l_new(struct btp, 1);
+	btp->pending = l_queue_new();
+	btp->handlers = l_queue_new();
+	btp->io = io;
+	btp->next_handler = 1;
+
+	wakeup_reader(btp);
+
+	return btp;
+}
+
+struct pending_message {
+	size_t len;
+	void *data;
+	bool wakeup_read;
+};
+
+static void destroy_message(struct pending_message *msg)
+{
+	l_free(msg->data);
+	l_free(msg);
+}
+
+void btp_cleanup(struct btp *btp)
+{
+	if (!btp)
+		return;
+
+	l_io_destroy(btp->io);
+	l_queue_destroy(btp->pending, (l_queue_destroy_func_t)destroy_message);
+	l_queue_destroy(btp->handlers, (l_queue_destroy_func_t)l_free);
+	l_free(btp);
+}
+
+bool btp_set_disconnect_handler(struct btp *btp, btp_disconnect_func_t callback,
+				void *user_data, btp_destroy_func_t destroy)
+{
+	if (callback) {
+		if (!l_io_set_disconnect_handler(btp->io, disconnect_handler,
+					btp, disconnect_handler_destroy))
+			return false;
+	} else {
+		if (!l_io_set_disconnect_handler(btp->io, NULL, NULL, NULL))
+			return false;
+	}
+
+	btp->disconnect_cb = callback;
+	btp->disconnect_cb_data = user_data;
+	btp->disconnect_cb_data_destroy = destroy;
+
+	return true;
+}
+
+static bool can_write_data(struct l_io *io, void *user_data)
+{
+	struct btp *btp = user_data;
+	struct pending_message *msg;
+
+	msg = l_queue_pop_head(btp->pending);
+	if (!msg)
+		return false;
+
+	if (msg->wakeup_read)
+		wakeup_reader(btp);
+
+	if (write(l_io_get_fd(btp->io), msg->data, msg->len) < 0) {
+		l_error("Failed to send BTP message");
+		destroy_message(msg);
+		return false;
+	}
+
+	destroy_message(msg);
+
+	return !l_queue_isempty(btp->pending);
+}
+
+static void write_watch_destroy(void *user_data)
+{
+	struct btp *btp = user_data;
+
+	btp->writer_active = false;
+}
+
+static void wakeup_writer(struct btp *btp)
+{
+	if (l_queue_isempty(btp->pending))
+		return;
+
+	if (btp->writer_active)
+		return;
+
+	btp->writer_active = l_io_set_write_handler(btp->io, can_write_data,
+						btp, write_watch_destroy);
+}
+
+bool btp_send_error(struct btp *btp, uint8_t service, uint8_t index,
+								uint8_t status)
+{
+	struct btp_error rsp;
+
+	rsp.status = status;
+
+	return btp_send(btp, service, BTP_OP_ERROR, index, sizeof(rsp), &rsp);
+}
+
+bool btp_send(struct btp *btp, uint8_t service, uint8_t opcode, uint8_t index,
+					uint16_t length, const void *param)
+{
+	struct btp_hdr *hdr;
+	struct pending_message *msg;
+	size_t len;
+
+	len = sizeof(*hdr) + length;
+	hdr = l_malloc(len);
+	if (!hdr)
+		return NULL;
+
+	hdr->service = service;
+	hdr->opcode = opcode;
+	hdr->index = index;
+	hdr->data_len = L_CPU_TO_LE16(length);
+	if (length)
+		memcpy(hdr->data, param, length);
+
+	msg = l_new(struct pending_message, 1);
+	msg->len = len;
+	msg->data = hdr;
+	msg->wakeup_read = opcode < 0x80;
+
+	l_queue_push_tail(btp->pending, msg);
+	wakeup_writer(btp);
+
+	return true;
+}
+
+unsigned int btp_register(struct btp *btp, uint8_t service, uint8_t opcode,
+				btp_cmd_func_t callback, void *user_data,
+				btp_destroy_func_t destroy)
+{
+	struct btp_handler *handler;
+
+	handler = l_new(struct btp_handler, 1);
+
+	handler->id = btp->next_handler++;
+	handler->service = service;
+	handler->opcode = opcode;
+	handler->callback = callback;
+	handler->user_data = user_data;
+	handler->destroy = destroy;
+
+	l_queue_push_tail(btp->handlers, handler);
+
+	return handler->id;
+}
+
+static bool handler_match_by_id(const void *a, const void *b)
+{
+	const struct btp_handler *handler = a;
+	unsigned int id = L_PTR_TO_UINT(b);
+
+	return handler->id == id;
+}
+
+bool btp_unregister(struct btp *btp, unsigned int id)
+{
+	struct btp_handler *handler;
+
+	handler = l_queue_remove_if(btp->handlers, handler_match_by_id,
+							L_UINT_TO_PTR(id));
+	if (!handler)
+		return false;
+
+	if (handler->destroy)
+		handler->destroy(handler->user_data);
+
+	l_free(handler);
+
+	return true;
+}
+
+static bool handler_remove_by_service(void *a, void *b)
+{
+	struct btp_handler *handler = a;
+	uint8_t service = L_PTR_TO_UINT(b);
+
+	if (handler->service != service)
+		return false;
+
+	if (handler->destroy)
+		handler->destroy(handler->user_data);
+
+	l_free(handler);
+	return true;
+}
+
+void btp_unregister_service(struct btp *btp, uint8_t service)
+{
+	l_queue_foreach_remove(btp->handlers, handler_remove_by_service,
+							L_UINT_TO_PTR(service));
+}
diff --git a/src/shared/btp.h b/src/shared/btp.h
new file mode 100644
index 000000000..66f29ba73
--- /dev/null
+++ b/src/shared/btp.h
@@ -0,0 +1,95 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012-2017  Intel Corporation. All rights reserved.
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
+#include <stdbool.h>
+
+#ifndef __packed
+#define __packed __attribute__((packed))
+#endif
+
+#define BTP_INDEX_NON_CONTROLLER 0xff
+
+#define BTP_ERROR_FAIL		0x01
+#define BTP_ERROR_UNKNOWN_CMD	0x02
+#define BTP_ERROR_NOT_READY	0x03
+#define BTP_ERROR_INVALID_INDEX	0x04
+
+#define BTP_CORE_SERVICE	0
+#define BTP_GAP_SERVICE		1
+#define BTP_GATT_SERVICE	2
+#define BTP_L2CAP_SERVICE	3
+#define BTP_MESH_NODE_SERVICE	4
+
+struct btp_hdr {
+	uint8_t service;
+	uint8_t opcode;
+	uint8_t index;
+	uint16_t data_len;
+	uint8_t data[0];
+} __packed;
+
+struct btp_error {
+	uint8_t status;
+} __packed;
+
+#define BTP_OP_ERROR				0x00
+
+#define BTP_OP_CORE_READ_SUPPORTED_COMMANDS	0x01
+
+#define BTP_OP_CORE_READ_SUPPORTED_SERVICES	0x02
+
+#define BTP_OP_CORE_REGISTER			0x03
+struct btp_core_register_cp {
+	uint8_t service_id;
+} __packed;
+
+#define BTP_OP_CORE_UNREGISTER			0x04
+struct btp_core_unregister_cp {
+	uint8_t service_id;
+} __packed;
+
+#define BTP_EV_CORE_READY			0x80
+
+struct btp;
+
+typedef void (*btp_destroy_func_t)(void *user_data);
+typedef void (*btp_disconnect_func_t)(struct btp *btp, void *user_data);
+typedef void (*btp_cmd_func_t)(uint8_t index, const void *param,
+					uint16_t length, void *user_data);
+
+struct btp *btp_new(const char *path);
+void btp_cleanup(struct btp *btp);
+
+bool btp_set_disconnect_handler(struct btp *btp, btp_disconnect_func_t callback,
+				void *user_data, btp_destroy_func_t destroy);
+
+bool btp_send_error(struct btp *btp, uint8_t service, uint8_t index,
+								uint8_t status);
+bool btp_send(struct btp *btp, uint8_t service, uint8_t opcode, uint8_t index,
+					uint16_t length, const void *param);
+
+unsigned int btp_register(struct btp *btp, uint8_t service, uint8_t opcode,
+				btp_cmd_func_t callback, void *user_data,
+				btp_destroy_func_t destroy);
+bool btp_unregister(struct btp *btp, unsigned int id);
+void btp_unregister_service(struct btp *btp, uint8_t service);
-- 
2.14.3

