Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/5] unit/test-gatt: Add TP/GAC/CL/BV-01-C test
Date: Thu,  2 Oct 2014 12:51:38 +0300
Message-Id: <1412243501-1755-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412243501-1755-1-git-send-email-luiz.dentz@gmail.com>
References: <1412243501-1755-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Verify that a Generic Attribute Profile client can generate an
Exchange MTU Request command.
---
 Makefile.am      |   7 ++
 unit/test-gatt.c | 266 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 273 insertions(+)
 create mode 100644 unit/test-gatt.c

diff --git a/Makefile.am b/Makefile.am
index ebd5b44..eba594d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -363,6 +363,13 @@ unit_tests += unit/test-lib
 unit_test_lib_SOURCES = unit/test-lib.c
 unit_test_lib_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
+unit_tests += unit/test-gatt
+
+unit_test_gatt_SOURCES = unit/test-gatt.c
+unit_test_gatt_LDADD = src/libshared-glib.la lib/libbluetooth-internal.la \
+			@GLIB_LIBS@
+
+
 noinst_PROGRAMS += $(unit_tests)
 
 TESTS = $(unit_tests)
diff --git a/unit/test-gatt.c b/unit/test-gatt.c
new file mode 100644
index 0000000..bbbf9a5
--- /dev/null
+++ b/unit/test-gatt.c
@@ -0,0 +1,266 @@
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
+#include "src/shared/att.h"
+#include "src/shared/gatt-client.h"
+
+struct test_pdu {
+	bool valid;
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
+	struct bt_gatt_client *client;
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
+		util_hexdump('<', pdu->data, len, test_debug, "GATT: ");
+
+	g_assert_cmpint(len, ==, pdu->size);
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
+		util_hexdump('>', buf, len, test_debug, "GATT: ");
+
+	g_assert_cmpint(len, ==, pdu->size);
+
+	g_assert(memcmp(buf, pdu->data, pdu->size) == 0);
+
+	context_process(context);
+
+	return TRUE;
+}
+
+static void gatt_debug(const char *str, void *user_data)
+{
+	const char *prefix = user_data;
+
+	g_print("%s%s\n", prefix, str);
+}
+
+static struct context *create_context(uint16_t mtu, gconstpointer data)
+{
+	struct context *context = g_new0(struct context, 1);
+	GIOChannel *channel;
+	int err, sv[2];
+	struct bt_att *att;
+
+	context->main_loop = g_main_loop_new(NULL, FALSE);
+	g_assert(context->main_loop);
+
+	err = socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0, sv);
+	g_assert(err == 0);
+
+	att = bt_att_new(sv[0]);
+	g_assert(att);
+
+	context->client = bt_gatt_client_new(att, mtu);
+	g_assert(context->client);
+
+	if (g_test_verbose())
+		bt_gatt_client_set_debug(context->client, gatt_debug, "gatt:",
+									NULL);
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
+	bt_att_unref(att);
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
+	bt_gatt_client_unref(context->client);
+
+	g_main_loop_unref(context->main_loop);
+
+	test_free(context->data);
+	g_free(context);
+}
+
+static void execute_context(struct context *context)
+{
+	g_main_loop_run(context->main_loop);
+
+	destroy_context(context);
+}
+
+static void test_client(gconstpointer data)
+{
+	struct context *context = create_context(512, data);
+
+	execute_context(context);
+}
+
+int main(int argc, char *argv[])
+{
+	g_test_init(&argc, &argv, NULL);
+
+	/*
+	 * Server Configuration
+	 *
+	 * The test group objective is to verify Generic Attribute Profile
+	 * Server Configuration.
+	 */
+	define_test("/TP/GAC/CL/BV-01-C", test_client,
+				raw_pdu(0x02, 0x00, 0x02));
+
+	return g_test_run();
+}
-- 
1.9.3

