Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 5/5] Add unit test for gattrib
Date: Thu, 23 Oct 2014 09:33:29 -0700
Message-Id: <1414082009-40903-6-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1414082009-40903-1-git-send-email-jamuraa@chromium.org>
References: <1414082009-40903-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will ensure that the API behavior of gattrib is preserved.
---
 .gitignore          |   1 +
 Makefile.am         |   7 +
 unit/test-gattrib.c | 584 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 592 insertions(+)
 create mode 100644 unit/test-gattrib.c

diff --git a/.gitignore b/.gitignore
index 97daa9f..164cc97 100644
--- a/.gitignore
+++ b/.gitignore
@@ -121,6 +121,7 @@ unit/test-avdtp
 unit/test-avctp
 unit/test-avrcp
 unit/test-gatt
+unit/test-gattrib
 unit/test-*.log
 unit/test-*.trs
 
diff --git a/Makefile.am b/Makefile.am
index 2dfea28..3fddb80 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -377,6 +377,13 @@ unit_test_gatt_SOURCES = unit/test-gatt.c
 unit_test_gatt_LDADD = src/libshared-glib.la \
 				lib/libbluetooth-internal.la @GLIB_LIBS@
 
+unit_tests += unit/test-gattrib
+
+unit_test_gattrib_SOURCES = unit/test-gattrib.c attrib/gattrib.c $(btio_sources) src/log.h src/log.c
+unit_test_gattrib_LDADD = lib/libbluetooth-internal.la \
+			src/libshared-glib.la \
+			@GLIB_LIBS@ @DBUS_LIBS@ -ldl -lrt
+
 if MAINTAINER_MODE
 noinst_PROGRAMS += $(unit_tests)
 endif
diff --git a/unit/test-gattrib.c b/unit/test-gattrib.c
new file mode 100644
index 0000000..3e14ac1
--- /dev/null
+++ b/unit/test-gattrib.c
@@ -0,0 +1,584 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Google, Inc.
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
+#include "attrib/gattrib.h"
+#include "src/log.h"
+
+#define DEFAULT_MTU 23
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
+
+static void test_debug(const char *str, void *user_data)
+{
+	const char *prefix = user_data;
+
+	g_print("%s%s\n", prefix, str);
+}
+
+/* 
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
+*/
+
+static void destroy_canary_increment(gpointer data) {
+	int *canary = data;
+	(*canary)++;
+}
+
+static void test_refcounts(void)
+{
+	int err, sv[2];
+	GAttrib *att, *extra_ref;
+	GIOChannel *channel;
+	int destroy_canary;
+
+	err = socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0, sv);
+	g_assert(err == 0);
+
+	channel = g_io_channel_unix_new(sv[1]);
+
+	g_io_channel_set_close_on_unref(channel, TRUE);
+
+	att = g_attrib_new(channel, DEFAULT_MTU);
+
+	destroy_canary = 0;
+
+	g_attrib_set_destroy_function(att, destroy_canary_increment, &destroy_canary);
+
+	extra_ref = g_attrib_ref(att);
+
+	g_assert(extra_ref == att);
+
+	g_attrib_unref(extra_ref);
+
+	g_assert(destroy_canary == 0);
+
+	g_attrib_unref(att);
+
+	g_assert(destroy_canary == 1);
+
+}
+
+static void test_get_channel(void) {
+
+	int err, sv[2];
+	GAttrib *att;
+	GIOChannel *channel, *result;
+
+	err = socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0, sv);
+	g_assert(err == 0);
+
+	channel = g_io_channel_unix_new(sv[1]);
+	g_assert(channel != NULL);
+
+	g_io_channel_set_close_on_unref(channel, TRUE);
+
+	att = g_attrib_new(channel, DEFAULT_MTU);
+	g_assert(att != 0);
+
+	result = g_attrib_get_channel(att);
+
+	g_assert(result == channel);
+
+	g_attrib_unref(att);
+}
+
+struct challenge_response {
+	const uint8_t *expect;
+	const size_t expect_len;
+	const uint8_t *respond;
+	const size_t respond_len;
+	bool received;
+};
+
+static gboolean test_client(GIOChannel *channel, GIOCondition cond, gpointer data) {
+	struct challenge_response *cr = data;
+	int fd;
+	uint8_t buf[256];
+	ssize_t len;
+
+	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
+		g_print("%s: no good cond %x\n", __func__, cond);
+		return FALSE;
+	}
+
+	fd = g_io_channel_unix_get_fd(channel);
+
+	len = read(fd, buf, sizeof(buf));
+
+	g_assert(len > 0);
+	g_assert_cmpint(len, ==, cr->expect_len);
+
+	if (g_test_verbose())
+		util_hexdump('>', buf, len, test_debug, "test_client: ");
+
+	cr->received = true;
+
+	if (cr->respond != NULL) {
+		if (g_test_verbose())
+			util_hexdump('<', cr->respond, cr->respond_len, test_debug, "test_client: ");
+		len = write(fd, cr->respond, cr->respond_len);
+
+		g_assert_cmpint(len, ==, cr->respond_len);
+	}
+
+	return TRUE;
+}
+
+struct result_data {
+	guint8 status;
+	const guint8 *pdu;
+	guint16 len;
+	bool done;
+};
+
+static void result_canary(guint8 status, const guint8 *pdu, guint16 len, gpointer data) {
+	struct result_data *result = data;
+	result->status = status;
+	result->pdu = pdu;
+	result->len = len;
+
+	if (g_test_verbose())
+		util_hexdump('<', pdu, len, test_debug, "result_canary: ");
+
+	result->done = true;
+
+}
+
+static void test_send(void) {
+	int err, sv[2];
+	GIOChannel *att_io, *server_io;
+	GAttrib *att;
+	GMainLoop *main_loop;
+	GMainContext *context;
+	struct result_data results;
+
+	main_loop = g_main_loop_new(NULL, FALSE);
+
+	err = socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0, sv);
+	g_assert(err == 0);
+
+	att_io = g_io_channel_unix_new(sv[0]);
+	g_assert(att_io != 0);
+
+	g_io_channel_set_close_on_unref(att_io, TRUE);
+
+	att = g_attrib_new(att_io, DEFAULT_MTU);
+	g_assert(att != 0);
+
+	server_io = g_io_channel_unix_new(sv[1]);
+
+	g_io_channel_set_close_on_unref(server_io, TRUE);
+	g_io_channel_set_encoding(server_io, NULL, NULL);
+	g_io_channel_set_buffered(server_io, FALSE);
+
+	do {
+		struct challenge_response data = {
+			.expect = ((unsigned char[]) { 0x02, 0x00, 0x02 }),
+			.expect_len = 3,
+			.respond = ((unsigned char[]) { 0x01, 0x02, 0x03, 0x04 }),
+			.respond_len = 4,
+			.received = false,
+		};
+
+		g_io_add_watch(server_io, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+					test_client, &data);
+
+		results.done = false;
+
+		g_attrib_send(att, 0, data.expect, data.expect_len, result_canary,
+					(gpointer) &results, NULL);
+
+		// Spin the main loop until we are ready.
+		context = g_main_loop_get_context(main_loop);
+		do {
+			g_main_context_iteration(context, TRUE);
+		} while (!results.done);
+	} while (0);
+
+	g_io_channel_unref(server_io);
+
+	g_attrib_unref(att);
+}
+
+static void test_cancel(void) {
+	int err, sv[2];
+	GIOChannel *att_io, *server_io;
+	GAttrib *att;
+	guint event_id;
+	GMainLoop *main_loop;
+	GMainContext *context;
+	gboolean canceled;
+	struct result_data results;
+
+	main_loop = g_main_loop_new(NULL, FALSE);
+
+	err = socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0, sv);
+	g_assert(err == 0);
+
+	att_io = g_io_channel_unix_new(sv[0]);
+	g_assert(att_io != 0);
+
+	g_io_channel_set_close_on_unref(att_io, TRUE);
+
+	att = g_attrib_new(att_io, DEFAULT_MTU);
+	g_assert(att != 0);
+
+	server_io = g_io_channel_unix_new(sv[1]);
+
+	do {
+		struct challenge_response data = {
+			.expect = ((unsigned char[]) { 0x02, 0x00, 0x02 }),
+			.expect_len = 3,
+			.respond = ((unsigned char[]) { 0x01, 0x02, 0x03, 0x04 }),
+			.respond_len = 4,
+			.received = false,
+		};
+
+		g_io_add_watch(server_io,
+				      G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+							    test_client, &data);
+
+		results.done = false;
+		event_id = g_attrib_send(att, 0, data.expect,
+							  data.expect_len, result_canary,
+								    &results, NULL);
+
+		/* Spin the main loop until we receive the first message */
+		context = g_main_loop_get_context(main_loop);
+		do {
+			g_main_context_iteration(context, FALSE);
+		} while (!data.received);
+
+		canceled = g_attrib_cancel(att, event_id);
+		g_assert(canceled);
+
+		/*
+		 * Spin the main loop until all events are processed,
+		 * no result should be called */
+		do {
+			g_main_context_iteration(context, TRUE);
+		} while (g_main_context_pending(context));
+
+		g_assert(!results.done);
+
+
+		results.done = false;
+		data.received = false;
+		event_id = g_attrib_send(att, 0, data.expect, data.expect_len, result_canary,
+								    &results, NULL);
+
+		canceled = g_attrib_cancel(att, event_id);
+		g_assert(canceled);
+
+		/*
+		 * Spin the main loop until all events are processed,
+		 * the message should never be delivered.
+		 */
+		do {
+			g_main_context_iteration(context, TRUE);
+		} while (g_main_context_pending(context));
+
+		g_assert(!data.received);
+		g_assert(!results.done);
+
+		/* Invalid ID */
+		canceled = g_attrib_cancel(att, 42);
+		g_assert(!canceled);
+	} while (0);
+
+	g_io_channel_unref(server_io);
+
+	g_attrib_unref(att);
+}
+
+static void test_register(void) {
+	/* TODO */
+}
+
+static void test_buffers(void) {
+	int err, sv[2];
+	GIOChannel *att_io;
+	GAttrib *att;
+	size_t buflen;
+	uint8_t *buf;
+	gboolean success;
+
+	err = socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0, sv);
+	g_assert(err == 0);
+
+	att_io = g_io_channel_unix_new(sv[0]);
+	g_assert(att_io != 0);
+
+	g_io_channel_set_close_on_unref(att_io, TRUE);
+
+	att = g_attrib_new(att_io, DEFAULT_MTU);
+	g_assert(att != 0);
+
+	buf = g_attrib_get_buffer(att, &buflen);
+	g_assert(buf != 0);
+	g_assert_cmpint(buflen, ==, DEFAULT_MTU);
+
+	success = g_attrib_set_mtu(att, 5);
+	g_assert(!success);
+
+	success = g_attrib_set_mtu(att, 255);
+	g_assert(success);
+
+	buf = g_attrib_get_buffer(att, &buflen);
+	g_assert(buf != 0);
+	g_assert_cmpint(buflen, ==, 255);
+
+	g_attrib_unref(att);
+}
+
+int main(int argc, char *argv[])
+{
+	g_test_init(&argc, &argv, NULL);
+
+	__btd_log_init("*", 0);
+
+	/*
+	 * Test the GAttrib API behavior
+	 */
+	g_test_add_func("/gattrib/refcount", test_refcounts);
+	g_test_add_func("/gattrib/get_channel", test_get_channel);
+	g_test_add_func("/gattrib/send", test_send);
+	g_test_add_func("/gattrib/cancel", test_cancel);
+	g_test_add_func("/gattrib/register", test_register);
+	g_test_add_func("/gattrib/buffers", test_buffers);
+
+	return g_test_run();
+}
-- 
2.1.0.rc2.206.gedb03e5

