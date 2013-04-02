Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ 02/18] unit: Add test for gatt_exchange_mtu()
Date: Tue,  2 Apr 2013 12:50:49 -0400
Message-Id: <1364921465-31182-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1364921465-31182-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1364921465-31182-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The new unit/test-gatt.c file will contain tests for GATT API
implemented in attrib/gatt.{c,h}.
---
 Makefile.am      |    9 +++
 unit/test-gatt.c |  238 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 247 insertions(+)
 create mode 100644 unit/test-gatt.c

diff --git a/Makefile.am b/Makefile.am
index f75b8d6..6c3f1fe 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -275,6 +275,15 @@ unit_tests += unit/test-lib
 unit_test_lib_SOURCES = unit/test-lib.c
 unit_test_lib_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@
 
+unit_tests += unit/test-gatt
+
+unit_test_gatt_SOURCES = unit/test-gatt.c \
+				attrib/gatt.h attrib/gatt.c \
+				attrib/gattrib.h attrib/gattrib.c \
+				attrib/att.h attrib/att.c \
+				src/shared/util.c
+unit_test_gatt_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@
+
 noinst_PROGRAMS += $(unit_tests)
 
 TESTS = $(unit_tests)
diff --git a/unit/test-gatt.c b/unit/test-gatt.c
new file mode 100644
index 0000000..babc30a
--- /dev/null
+++ b/unit/test-gatt.c
@@ -0,0 +1,238 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2013  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2013  Instituto Nokia de Tecnologia - INdT
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
+#include "config.h"
+#endif
+
+#include <glib.h>
+#include <unistd.h>
+#include <stdbool.h>
+
+#include "lib/uuid.h"
+#include "attrib/att.h"
+#include "attrib/gattrib.h"
+#include "attrib/gatt.h"
+#include "btio/btio.h"
+#include "log.h"
+#include "src/shared/util.h"
+
+struct context {
+	GMainLoop *main_loop;
+	guint server_source;
+	GAttrib *attrib;
+};
+
+void btd_debug(const char *format, ...)
+{
+}
+
+gboolean bt_io_get(GIOChannel *io, GError **err, BtIOOption opt1, ...)
+{
+	va_list args;
+	BtIOOption opt = opt1;
+
+	va_start(args, opt1);
+	while (opt != BT_IO_OPT_INVALID) {
+		switch (opt) {
+		case BT_IO_OPT_SEC_LEVEL:
+			*(va_arg(args, int *)) = BT_SECURITY_HIGH;
+			break;
+		case BT_IO_OPT_IMTU:
+			*(va_arg(args, uint16_t *)) = 512;
+			break;
+		case BT_IO_OPT_CID:
+			*(va_arg(args, uint16_t *)) = ATT_CID;
+			break;
+		default:
+			if (g_test_verbose() == TRUE)
+				printf("Unknown option %d\n", opt);
+
+			return FALSE;
+		}
+
+		opt = va_arg(args, int);
+	}
+	va_end(args);
+
+	return TRUE;
+}
+
+static gboolean handle_mtu_exchange(int fd)
+{
+	uint8_t pdu[3];
+	uint16_t mtu, pdu_len;
+	ssize_t len;
+
+	len = recv(fd, pdu, sizeof(pdu), 0);
+	g_assert(len == sizeof(pdu));
+
+	pdu_len = dec_mtu_req(pdu, len, &mtu);
+	g_assert(pdu_len == sizeof(pdu));
+
+	if (g_test_verbose() == TRUE)
+		printf("Received Exchange MTU Request: Client Rx MTU 0x%04x\n",
+									mtu);
+
+	/* Just reply with same MTU as client */
+	pdu_len = enc_mtu_resp(mtu, pdu, len);
+	g_assert(pdu_len == sizeof(pdu));
+
+	len = write(fd, pdu, pdu_len);
+	g_assert(len == pdu_len);
+
+	return TRUE;
+}
+
+static void att_debug(const char *str, void *user_data)
+{
+	g_print("ATT: %s\n", str);
+}
+
+static gboolean handle_not_supported(int fd)
+{
+	uint8_t pdu[5], ipdu[ATT_DEFAULT_LE_MTU];
+	ssize_t len;
+	uint16_t pdu_len;
+
+	len = recv(fd, ipdu, sizeof(ipdu), 0);
+	g_assert(len > 0);
+
+	if (g_test_verbose() == TRUE) {
+		printf("Unsupported/invalid ATT request (opcode 0x%02x)\n",
+								ipdu[0]);
+		util_hexdump('>', ipdu, len, att_debug, NULL);
+	}
+
+	pdu_len = enc_error_resp(ipdu[0], 0x0000, ATT_ECODE_REQ_NOT_SUPP, pdu,
+								sizeof(pdu));
+	g_assert(pdu_len == sizeof(pdu));
+
+	len = write(fd, pdu, pdu_len);
+	g_assert(len == pdu_len);
+
+	return TRUE;
+}
+
+static gboolean server_handler(GIOChannel *channel, GIOCondition cond,
+							gpointer user_data)
+{
+	uint8_t opcode;
+	ssize_t len;
+	int fd;
+
+	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP))
+		return FALSE;
+
+	fd = g_io_channel_unix_get_fd(channel);
+	len = recv(fd, &opcode, sizeof(opcode), MSG_PEEK);
+	g_assert(len == sizeof(opcode));
+
+	if (g_test_verbose() == TRUE)
+		printf("ATT request received (opcode 0x%02x)\n", opcode);
+
+	switch (opcode) {
+	case ATT_OP_MTU_REQ:
+		return handle_mtu_exchange(fd);
+	}
+
+	return handle_not_supported(fd);
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
+	channel = g_io_channel_unix_new(sv[1]);
+	context->attrib = g_attrib_new(channel);
+	g_io_channel_unref(channel);
+
+	return context;
+}
+
+static void execute_context(struct context *context)
+{
+	g_main_loop_run(context->main_loop);
+
+	g_source_remove(context->server_source);
+	g_main_loop_unref(context->main_loop);
+	g_attrib_unref(context->attrib);
+
+	g_free(context);
+}
+
+static void exchange_mtu_cb(uint8_t status, uint16_t mtu, void *user_data)
+{
+	struct context *context = user_data;
+
+	g_assert(status == 0);
+
+	if (g_test_verbose() == TRUE)
+		printf("Received Exchange MTU Response: Server Rx MTU 0x%04x\n",
+									mtu);
+
+	g_assert(mtu == ATT_DEFAULT_LE_MTU);
+
+	g_main_loop_quit(context->main_loop);
+}
+
+static void test_gatt_exchange_mtu(void)
+{
+	struct context *context = create_context();
+
+	gatt_exchange_mtu(context->attrib, ATT_DEFAULT_LE_MTU, exchange_mtu_cb,
+								context);
+
+	execute_context(context);
+}
+
+int main(int argc, char *argv[])
+{
+	g_test_init(&argc, &argv, NULL);
+
+	g_test_add_func("/gatt/gatt_exchange_mtu", test_gatt_exchange_mtu);
+
+	return g_test_run();
+}
-- 
1.7.9.5

