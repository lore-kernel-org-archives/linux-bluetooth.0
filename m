Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] unit/avrcp: First unit test for AVRCP profile
Date: Thu, 30 Jan 2014 17:38:04 +0200
Message-Id: <1391096284-26285-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test TP/MPS/BV-01-C [SetAddressedPlayer – CT] verifies
SetAddressedPlayer command.
---
 Makefile.am       |   9 ++
 unit/test-avrcp.c | 325 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 334 insertions(+)
 create mode 100644 unit/test-avrcp.c

diff --git a/Makefile.am b/Makefile.am
index 1a44a9f..67b7167 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -281,6 +281,15 @@ unit_test_avctp_SOURCES = unit/test-avctp.c \
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
index 0000000..2030b22
--- /dev/null
+++ b/unit/test-avrcp.c
@@ -0,0 +1,325 @@
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
+#define IEEEID_BTSIG		0x001958
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
+	struct avrcp_device *dev;
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
+		util_hexdump('<', pdu->data, len, test_debug, "AVCTP: ");
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
+		util_hexdump('>', buf, len, test_debug, "AVCTP: ");
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
+	bdaddr_t dst;
+
+	context->main_loop = g_main_loop_new(NULL, FALSE);
+	g_assert(context->main_loop);
+
+	err = socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0, sv);
+	g_assert(err == 0);
+
+	context->dev = avrcp_device_new(&dst);
+	context->dev->session = avctp_new(sv[0], 672, 672, version);
+	g_assert(context->dev->session != NULL);
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
+static void execute_context(struct context *context)
+{
+	g_main_loop_run(context->main_loop);
+
+	if (context->source > 0)
+		g_source_remove(context->source);
+
+	avrcp_device_free(context->dev);
+
+	g_main_loop_unref(context->main_loop);
+
+	test_free(context->data);
+	g_free(context);
+}
+
+#define AVRCP_SET_ADDRESSED_PLAYER	0x60
+
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+
+struct avrcp_header {
+	uint8_t company_id[3];
+	uint8_t pdu_id;
+	uint8_t packet_type:2;
+	uint8_t rsvd:6;
+	uint16_t params_len;
+	uint8_t params[0];
+} __attribute__ ((packed));
+#define AVRCP_HEADER_LENGTH 7
+
+#elif __BYTE_ORDER == __BIG_ENDIAN
+
+struct avrcp_header {
+	uint8_t company_id[3];
+	uint8_t pdu_id;
+	uint8_t rsvd:6;
+	uint8_t packet_type:2;
+	uint16_t params_len;
+	uint8_t params[0];
+} __attribute__ ((packed));
+#define AVRCP_HEADER_LENGTH 7
+
+#else
+#error "Unknown byte order"
+#endif
+
+static void set_company_id(uint8_t cid[3], const uint32_t cid_in)
+{
+	cid[0] = cid_in >> 16;
+	cid[1] = cid_in >> 8;
+	cid[2] = cid_in;
+}
+
+static int avrcp_sent_set_addr_player(struct context *context)
+{
+	uint8_t buf[AVRCP_HEADER_LENGTH + 2];
+	struct avrcp_header *pdu = (void *) buf;
+
+	memset(buf, 0, sizeof(buf));
+
+	set_company_id(pdu->company_id, IEEEID_BTSIG);
+
+	pdu->pdu_id = AVRCP_SET_ADDRESSED_PLAYER;
+	pdu->params[0] = 0xab;
+	pdu->params[1] = 0xcd;
+	pdu->params_len = htons(2);
+
+	return avctp_send_vendordep_req(context->dev->session,
+					AVC_CTYPE_CONTROL, AVC_SUBUNIT_PANEL,
+					buf, sizeof(buf),
+					NULL, NULL);
+}
+
+static void test_client(gconstpointer data)
+{
+	struct context *context = create_context(0x0100, data);
+
+	avrcp_sent_set_addr_player(context);
+
+	execute_context(context);
+}
+
+int main(int argc, char *argv[])
+{
+	g_test_init(&argc, &argv, NULL);
+
+	if (g_test_verbose())
+		__btd_log_init("*", 0);
+
+	/* Media Player Selection Commands and Notifications tests */
+
+	define_test("/TP/MPS/BV-01-C", test_client,
+			raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48, 0x00,
+				0x00, 0x19, 0x58, 0x60, 0x00, 0x00,
+				0x02, 0xab, 0xcd));
+
+	return g_test_run();
+}
-- 
1.8.3.2

