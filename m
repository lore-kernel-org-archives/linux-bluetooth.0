Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <andrei.emeltchenko@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/6] unit/avrcp: First unit test for AVRCP profile
Date: Fri, 21 Feb 2014 17:23:45 +0200
Message-Id: <1392996230-11789-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

The tests verifies connection establishment for control.
---
 Makefile.am       |   9 ++
 unit/test-avrcp.c | 265 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 274 insertions(+)
 create mode 100644 unit/test-avrcp.c

diff --git a/Makefile.am b/Makefile.am
index 11f2aa1..5fe58eb 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -282,6 +282,15 @@ unit_test_avctp_SOURCES = unit/test-avctp.c \
 				android/avctp.c android/avctp.h
 unit_test_avctp_LDADD = @GLIB_LIBS@
 
+unit_tests += unit/test-avrcp
+
+unit_test_avrcp_SOURCES = unit/test-avrcp.c \
+				src/shared/util.h src/shared/util.c \
+				src/log.h src/log.c \
+				android/avctp.c android/avctp.h \
+				android/avrcp-lib.c android/avrcp-lib.h
+unit_test_avrcp_LDADD = @GLIB_LIBS@ lib/libbluetooth-internal.la
+
 unit_tests += unit/test-gdbus-client
 
 unit_test_gdbus_client_SOURCES = unit/test-gdbus-client.c
diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
new file mode 100644
index 0000000..f1c0f46
--- /dev/null
+++ b/unit/test-avrcp.c
@@ -0,0 +1,265 @@
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
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <inttypes.h>
+#include <string.h>
+#include <fcntl.h>
+#include <sys/socket.h>
+
+#include <glib.h>
+
+#include "src/shared/util.h"
+#include "src/log.h"
+#include "lib/bluetooth.h"
+
+#include "android/avctp.h"
+#include "android/avrcp-lib.h"
+
+struct test_pdu {
+	bool valid;
+	bool fragmented;
+	const uint8_t *data;
+	size_t size;
+};
+
+struct test_data {
+	char *test_name;
+	struct test_pdu *pdu_list;
+};
+
+struct context {
+	GMainLoop *main_loop;
+	struct avrcp *session;
+	guint source;
+	guint process;
+	int fd;
+	unsigned int pdu_offset;
+	const struct test_data *data;
+};
+
+#define data(args...) ((const unsigned char[]) { args })
+
+#define raw_pdu(args...)					\
+	{							\
+		.valid = true,					\
+		.data = data(args),				\
+		.size = sizeof(data(args)),			\
+	}
+
+#define frg_pdu(args...)					\
+	{							\
+		.valid = true,					\
+		.fragmented = true,				\
+		.data = data(args),				\
+		.size = sizeof(data(args)),			\
+	}
+
+#define define_test(name, function, args...)				\
+	do {								\
+		const struct test_pdu pdus[] = {			\
+			args, { }					\
+		};							\
+		static struct test_data data;				\
+		data.test_name = g_strdup(name);			\
+		data.pdu_list = g_malloc(sizeof(pdus));			\
+		memcpy(data.pdu_list, pdus, sizeof(pdus));		\
+		g_test_add_data_func(name, &data, function);		\
+	} while (0)
+
+static void test_debug(const char *str, void *user_data)
+{
+	const char *prefix = user_data;
+
+	g_print("%s%s\n", prefix, str);
+}
+
+static void test_free(gconstpointer user_data)
+{
+	const struct test_data *data = user_data;
+
+	g_free(data->test_name);
+	g_free(data->pdu_list);
+}
+
+static gboolean context_quit(gpointer user_data)
+{
+	struct context *context = user_data;
+
+	if (context->process > 0)
+		g_source_remove(context->process);
+
+	g_main_loop_quit(context->main_loop);
+
+	return FALSE;
+}
+
+static gboolean send_pdu(gpointer user_data)
+{
+	struct context *context = user_data;
+	const struct test_pdu *pdu;
+	ssize_t len;
+
+	pdu = &context->data->pdu_list[context->pdu_offset++];
+
+	len = write(context->fd, pdu->data, pdu->size);
+
+	if (g_test_verbose())
+		util_hexdump('<', pdu->data, len, test_debug, "AVRCP: ");
+
+	g_assert_cmpint(len, ==, pdu->size);
+
+	if (pdu->fragmented)
+		return send_pdu(user_data);
+
+	context->process = 0;
+	return FALSE;
+}
+
+static void context_process(struct context *context)
+{
+	if (!context->data->pdu_list[context->pdu_offset].valid) {
+		context_quit(context);
+		return;
+	}
+
+	context->process = g_idle_add(send_pdu, context);
+}
+
+static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
+							gpointer user_data)
+{
+	struct context *context = user_data;
+	const struct test_pdu *pdu;
+	unsigned char buf[512];
+	ssize_t len;
+	int fd;
+
+	pdu = &context->data->pdu_list[context->pdu_offset++];
+
+	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
+		context->source = 0;
+		g_print("%s: cond %x\n", __func__, cond);
+		return FALSE;
+	}
+
+	fd = g_io_channel_unix_get_fd(channel);
+
+	len = read(fd, buf, sizeof(buf));
+
+	g_assert(len > 0);
+
+	if (g_test_verbose())
+		util_hexdump('>', buf, len, test_debug, "AVRCP: ");
+
+	g_assert_cmpint(len, ==, pdu->size);
+
+	g_assert(memcmp(buf, pdu->data, pdu->size) == 0);
+
+	if (!pdu->fragmented)
+		context_process(context);
+
+	return TRUE;
+}
+
+static struct context *create_context(uint16_t version, gconstpointer data)
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
+	context->session = avrcp_new(sv[0], 672, 672, version);
+	g_assert(context->session != NULL);
+
+	channel = g_io_channel_unix_new(sv[1]);
+
+	g_io_channel_set_close_on_unref(channel, TRUE);
+	g_io_channel_set_encoding(channel, NULL, NULL);
+	g_io_channel_set_buffered(channel, FALSE);
+
+	context->source = g_io_add_watch(channel,
+				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				test_handler, context);
+	g_assert(context->source > 0);
+
+	g_io_channel_unref(channel);
+
+	context->fd = sv[1];
+	context->data = data;
+
+	return context;
+}
+
+static void destroy_context(struct context *context)
+{
+	if (context->source > 0)
+		g_source_remove(context->source);
+
+	avrcp_shutdown(context->session);
+
+	g_main_loop_unref(context->main_loop);
+
+	test_free(context->data);
+	g_free(context);
+}
+
+static void test_dummy(gconstpointer data)
+{
+	struct context *context =  create_context(0x0100, data);
+
+	destroy_context(context);
+}
+
+int main(int argc, char *argv[])
+{
+	g_test_init(&argc, &argv, NULL);
+
+	if (g_test_verbose())
+		__btd_log_init("*", 0);
+
+	/* Connection Establishment for Control tests */
+
+	/*
+	 * Tests are checking connection establishement and release
+	 * for control channel. Since we are connected through socketpair
+	 * the tests are dummy
+	 */
+	define_test("/TP/CEC/BV-01-I", test_dummy, raw_pdu(0x00));
+	define_test("/TP/CEC/BV-02-I", test_dummy, raw_pdu(0x00));
+	define_test("/TP/CRC/BV-01-I", test_dummy, raw_pdu(0x00));
+	define_test("/TP/CRC/BV-02-I", test_dummy, raw_pdu(0x00));
+
+	return g_test_run();
+}
-- 
1.8.3.2

