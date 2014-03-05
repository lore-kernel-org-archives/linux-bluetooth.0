Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 02/11] unit: Initial version of test-hfp
Date: Wed,  5 Mar 2014 20:22:47 +0100
Message-Id: <1394047376-11495-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1394047376-11495-1-git-send-email-marcin.kraglak@tieto.com>
References: <1394047376-11495-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is skeleton of hfp unit tests with basic init test
for hfp_gw_new().
Basic test with hfp_gw_new() and hfp_gw_unref.
---
 .gitignore      |   1 +
 Makefile.am     |  12 ++++
 unit/test-hfp.c | 173 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 186 insertions(+)
 create mode 100644 unit/test-hfp.c

diff --git a/.gitignore b/.gitignore
index 94c0c78..6719be8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -84,6 +84,7 @@ unit/test-gdbus-client
 unit/test-sdp
 unit/test-lib
 unit/test-mgmt
+unit/test-hfp
 tools/mgmt-tester
 tools/smp-tester
 tools/gap-tester
diff --git a/Makefile.am b/Makefile.am
index 0c79e58..0107cef 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -293,6 +293,18 @@ unit_test_avrcp_SOURCES = unit/test-avrcp.c \
 				android/avrcp-lib.c android/avrcp-lib.h
 unit_test_avrcp_LDADD = @GLIB_LIBS@ lib/libbluetooth-internal.la
 
+unit_tests += unit/test-hfp
+
+unit_test_hfp_SOURCES = unit/test-hfp.c \
+				src/shared/io.h src/shared/io-glib.c \
+				src/shared/queue.h src/shared/queue.c \
+				src/shared/util.h src/shared/util.c \
+				src/shared/mgmt.h src/shared/mgmt.c \
+				src/shared/ringbuf.h src/shared/ringbuf.c \
+				src/shared/hfp.h src/shared/hfp.c
+
+unit_test_hfp_LDADD = @GLIB_LIBS@
+
 unit_tests += unit/test-gdbus-client
 
 unit_test_gdbus_client_SOURCES = unit/test-gdbus-client.c
diff --git a/unit/test-hfp.c b/unit/test-hfp.c
new file mode 100644
index 0000000..f220569
--- /dev/null
+++ b/unit/test-hfp.c
@@ -0,0 +1,173 @@
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
+#include <sys/socket.h>
+#include <unistd.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+
+#include <glib.h>
+#include "src/shared/hfp.h"
+
+struct context {
+	GMainLoop *main_loop;
+	guint watch_id;
+	int fd_server;
+	int fd_client;
+	struct hfp_gw *hfp;
+	const struct test_data *data;
+	unsigned int pdu_offset;
+};
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
+#define data(args...) ((const unsigned char[]) { args })
+
+#define raw_pdu(args...)					\
+	{							\
+		.valid = true,					\
+		.data = data(args),				\
+		.size = sizeof(data(args)),			\
+	}
+
+#define data_end()						\
+	{							\
+		.valid = false,					\
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
+static void context_quit(struct context *context)
+{
+	g_main_loop_quit(context->main_loop);
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
+static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
+							gpointer user_data)
+{
+	struct context *context = user_data;
+	const struct test_pdu *pdu;
+
+	pdu = &context->data->pdu_list[context->pdu_offset++];
+
+	g_assert(!pdu->valid);
+	context_quit(context);
+
+	return FALSE;
+}
+
+static struct context *create_context(gconstpointer data)
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
+	channel = g_io_channel_unix_new(sv[1]);
+
+	g_io_channel_set_close_on_unref(channel, TRUE);
+	g_io_channel_set_encoding(channel, NULL, NULL);
+	g_io_channel_set_buffered(channel, FALSE);
+
+	context->watch_id = g_io_add_watch(channel,
+				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				test_handler, context);
+	g_assert(context->watch_id > 0);
+
+	g_io_channel_unref(channel);
+
+	context->fd_server = sv[1];
+	context->fd_client = sv[0];
+	context->data = data;
+
+	return context;
+}
+
+static void execute_context(struct context *context)
+{
+	g_main_loop_run(context->main_loop);
+
+	g_source_remove(context->watch_id);
+
+	g_main_loop_unref(context->main_loop);
+
+	test_free(context->data);
+
+	g_free(context);
+}
+
+static void test_init(gconstpointer data)
+{
+	struct context *context = create_context(data);
+
+	context->hfp = hfp_gw_new(context->fd_client);
+
+	g_assert(context->hfp);
+	g_assert(hfp_gw_set_close_on_unref(context->hfp, true));
+
+	hfp_gw_unref(context->hfp);
+
+	execute_context(context);
+}
+
+int main(int argc, char *argv[])
+{
+	g_test_init(&argc, &argv, NULL);
+
+	define_test("/hfp/test_init", test_init, data_end());
+
+	return g_test_run();
+}
-- 
1.8.3.1

