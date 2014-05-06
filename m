Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 02/10] unit/test-att: Add unit tests for src/shared/att.
Date: Mon,  5 May 2014 21:45:55 -0700
Message-Id: <1399351563-25991-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1399351563-25991-1-git-send-email-armansito@chromium.org>
References: <1399351563-25991-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces unit tests for src/shared/att. The code currently
only tests locally initiated requests and responses.
---
 Makefile.am     |   9 ++
 unit/test-att.c | 307 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 316 insertions(+)
 create mode 100644 unit/test-att.c

diff --git a/Makefile.am b/Makefile.am
index 0c3424f..04be6c4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -262,6 +262,15 @@ unit_test_mgmt_SOURCES = unit/test-mgmt.c \
 				src/shared/mgmt.h src/shared/mgmt.c
 unit_test_mgmt_LDADD = @GLIB_LIBS@
 
+unit_tests += unit/test-att
+
+unit_test_att_SOURCES = unit/test-att.c \
+				src/shared/io.h src/shared/io-glib.c \
+				src/shared/queue.h src/shared/queue.c \
+				src/shared/util.h src/shared/util.c \
+				src/shared/att.h src/shared/att.c
+unit_test_att_LDADD = @GLIB_LIBS@
+
 unit_tests += unit/test-sdp
 
 unit_test_sdp_SOURCES = unit/test-sdp.c \
diff --git a/unit/test-att.c b/unit/test-att.c
new file mode 100644
index 0000000..3a3a77d
--- /dev/null
+++ b/unit/test-att.c
@@ -0,0 +1,307 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Intel Corporation. All rights reserved.
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdlib.h>
+#include <stdbool.h>
+#include <unistd.h>
+#include <sys/socket.h>
+
+#include <glib.h>
+
+#include "src/shared/att.h"
+
+struct context {
+	GMainLoop *main_loop;
+	struct bt_att *att_client;
+	guint server_source;
+	GList *handler_list;
+};
+
+enum action {
+	ACTION_PASSED,
+	ACTION_IGNORE,
+};
+
+struct handler {
+	const void *req_data;
+	uint16_t req_size;
+	const void *resp_data;
+	uint16_t resp_size;
+	enum action action;
+};
+
+static void att_debug(const char *str, void *user_data)
+{
+	const char *prefix = user_data;
+
+	g_printf("%s%s\n", prefix, str);
+}
+
+static void context_quit(struct context *context)
+{
+	g_main_loop_quit(context->main_loop);
+}
+
+static void check_actions(struct context *context, int server_socket,
+					const void *data, uint16_t size)
+{
+	GList *list;
+	ssize_t written;
+
+	for (list = g_list_first(context->handler_list); list;
+						list = g_list_next(list)) {
+		struct handler *handler = list->data;
+
+		if (size != handler->req_size)
+			continue;
+
+		if (memcmp(data, handler->req_data, handler->req_size))
+			continue;
+
+		switch (handler->action) {
+		case ACTION_PASSED:
+			if (!handler->resp_data || !handler->resp_size) {
+				context_quit(context);
+				return;
+			}
+
+			/* Test case involves a response. */
+			written = write(server_socket, handler->resp_data,
+							handler->resp_size);
+			g_assert(written == handler->resp_size);
+			return;
+		case ACTION_IGNORE:
+			return;
+		}
+	}
+
+	g_test_message("Request not handled\n");
+	g_assert_not_reached();
+}
+
+static gboolean server_handler(GIOChannel *channel, GIOCondition cond,
+							gpointer user_data)
+{
+	struct context *context = user_data;
+	unsigned char buf[512];
+	ssize_t result;
+	int fd;
+
+	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP))
+		return FALSE;
+
+	fd = g_io_channel_unix_get_fd(channel);
+
+	result = read(fd, buf, sizeof(buf));
+	if (result < 0)
+		return FALSE;
+
+	check_actions(context, fd, buf, result);
+
+	return TRUE;
+}
+
+static struct context *create_context(void)
+{
+	struct context *context = g_new0(struct context, 1);
+	GIOChannel *channel;
+	int err, sv[2];
+
+	context->main_loop = g_main_loop_new(NULL, FALSE);
+	g_assert(context->main_loop);
+
+	err = socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0, sv);
+	g_assert(err == 0);
+
+	channel = g_io_channel_unix_new(sv[0]);
+
+	g_io_channel_set_close_on_unref(channel, TRUE);
+	g_io_channel_set_encoding(channel, NULL, NULL);
+	g_io_channel_set_buffered(channel, FALSE);
+
+	context->server_source = g_io_add_watch(channel,
+				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				server_handler, context);
+	g_assert(context->server_source > 0);
+
+	g_io_channel_unref(channel);
+
+	context->att_client = bt_att_new(sv[1]);
+	g_assert(context->att_client);
+
+	if (g_test_verbose() == TRUE)
+		bt_att_set_debug(context->att_client, att_debug, "att: ", NULL);
+
+	bt_att_set_close_on_unref(context->att_client, true);
+
+	return context;
+}
+
+static void execute_context(struct context *context)
+{
+	g_main_loop_run(context->main_loop);
+
+	g_list_free_full(context->handler_list, g_free);
+
+	g_source_remove(context->server_source);
+
+	bt_att_unref(context->att_client);
+
+	g_main_loop_unref(context->main_loop);
+
+	g_free(context);
+}
+
+static void add_action(struct context *context,
+				const void *req_data, uint16_t req_size,
+				const void *resp_data, uint16_t resp_size,
+				enum action action)
+{
+	struct handler *handler = g_new0(struct handler, 1);
+
+	handler->req_data = req_data;
+	handler->req_size = req_size;
+	handler->resp_data = resp_data;
+	handler->resp_size = resp_size;
+	handler->action = action;
+
+	context->handler_list = g_list_append(context->handler_list, handler);
+}
+
+struct request_test_data {
+	uint8_t req_opcode;
+	const void *req_param;
+	uint16_t req_param_length;
+	uint8_t resp_opcode;
+	const void *resp_param;
+	uint16_t resp_param_length;
+	const void *req_data;
+	uint16_t req_size;
+	const  void *resp_data;
+	uint16_t resp_size;
+};
+
+struct request_test {
+	const struct request_test_data *test_data;
+	struct context *context;
+};
+
+/* Exchange MTU request <-> response test */
+static const unsigned char exchange_mtu_req_bytes_1[] = { 0x02, 0x32, 0x00 };
+static const struct bt_att_exchange_mtu_req_param exchange_mtu_req_param_1 = {
+	.client_rx_mtu = 50,
+};
+static const unsigned char exchange_mtu_resp_bytes_1[] = { 0x03, 0x30, 0x00 };
+static const struct bt_att_exchange_mtu_rsp_param exchange_mtu_rsp_param_1 = {
+	.server_rx_mtu = 48,
+};
+static const struct request_test_data request_test_1 = {
+	.req_opcode = ATT_OP_EXCHANGE_MTU_REQ,
+	.req_param = &exchange_mtu_req_param_1,
+	.req_param_length = sizeof(exchange_mtu_req_param_1),
+	.resp_opcode = ATT_OP_EXCHANGE_MTU_RESP,
+	.resp_param = &exchange_mtu_rsp_param_1,
+	.resp_param_length = sizeof(exchange_mtu_rsp_param_1),
+	.req_data = exchange_mtu_req_bytes_1,
+	.req_size = sizeof(exchange_mtu_req_bytes_1),
+	.resp_data = exchange_mtu_resp_bytes_1,
+	.resp_size = sizeof(exchange_mtu_resp_bytes_1),
+};
+
+/* Exchange MTU request <-> error response test */
+static const unsigned char exchange_mtu_req_bytes_2[] = { 0x02, 0x32, 0x00 };
+static const struct bt_att_exchange_mtu_req_param exchange_mtu_req_param_2 = {
+	.client_rx_mtu = 50,
+};
+static const unsigned char exchange_mtu_resp_bytes_2[] = {
+	0x01, 0x02, 0x00, 0x00, 0x06
+};
+static const struct bt_att_error_rsp_param exchange_mtu_rsp_param_2 = {
+	.request_opcode = ATT_OP_EXCHANGE_MTU_REQ,
+	.handle = 0,
+	.error_code = ATT_ERROR_REQUEST_NOT_SUPPORTED,
+};
+static const struct request_test_data request_test_2 = {
+	.req_opcode = ATT_OP_EXCHANGE_MTU_REQ,
+	.req_param = &exchange_mtu_req_param_2,
+	.req_param_length = sizeof(exchange_mtu_req_param_2),
+	.resp_opcode = ATT_OP_ERROR_RESP,
+	.resp_param = &exchange_mtu_rsp_param_2,
+	.resp_param_length = sizeof(exchange_mtu_rsp_param_2),
+	.req_data = exchange_mtu_req_bytes_2,
+	.req_size = sizeof(exchange_mtu_req_bytes_2),
+	.resp_data = exchange_mtu_resp_bytes_2,
+	.resp_size = sizeof(exchange_mtu_resp_bytes_2),
+};
+
+static void test_request_callback(uint8_t opcode, const void *param,
+					uint16_t length, void *user_data)
+{
+	struct request_test *test = user_data;
+	const struct request_test_data *test_data = test->test_data;
+
+	g_assert(opcode == test_data->resp_opcode);
+	g_assert(length == test_data->resp_param_length);
+
+	g_assert(0 == memcmp(param, test_data->resp_param, length));
+
+	context_quit(test->context);
+}
+
+static void test_request(gconstpointer data)
+{
+	struct request_test *test;
+	const struct request_test_data *test_data = data;
+	struct context *context = create_context();
+	unsigned int req_id = 0;
+
+	add_action(context, test_data->req_data, test_data->req_size,
+			test_data->resp_data, test_data->resp_size,
+			ACTION_PASSED);
+
+	test = malloc(sizeof(struct request_test));
+	test->test_data = test_data; 
+	test->context = context;
+
+	req_id = bt_att_send(context->att_client,
+				test_data->req_opcode, test_data->req_param,
+				test_data->req_param_length,
+				test_request_callback, test, free);
+	g_assert(req_id);
+
+	execute_context(context);
+}
+
+int main(int argc, char *argv[])
+{
+	g_test_init(&argc, &argv, NULL);
+
+	g_test_add_data_func("/att/request/1", &request_test_1, test_request);
+	g_test_add_data_func("/att/request/2", &request_test_2, test_request);
+
+	return g_test_run();
+}
-- 
1.9.1.423.g4596e3a

