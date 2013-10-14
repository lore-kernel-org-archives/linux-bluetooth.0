Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 16/22] unit: Add basic unit test for the blueatchat module
Date: Mon, 14 Oct 2013 10:34:32 +0200
Message-Id: <1381739678-16260-17-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds first few basic unit test for blueatchat's AT parsing
functionality.
---
 Makefile.am            |    9 ++
 unit/test-blueatchat.c |  334 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 343 insertions(+)
 create mode 100644 unit/test-blueatchat.c

diff --git a/Makefile.am b/Makefile.am
index 079405f..76bcc75 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -289,6 +289,15 @@ unit_test_cbuffer_SOURCES = unit/test-cbuffer.c \
 				src/shared/cbuffer.h src/shared/cbuffer.c
 unit_test_cbuffer_LDADD = @GLIB_LIBS@
 
+unit_tests += unit/test-blueatchat
+
+unit_test_blueatchat_SOURCES = unit/test-blueatchat.c \
+				src/shared/util.h src/shared/util.c \
+				src/shared/cbuffer.h src/shared/cbuffer.c \
+				src/shared/blueatchat.h src/shared/blueatchat.c \
+				src/shared/dparser.h src/shared/dparser.c
+unit_test_blueatchat_LDADD = @GLIB_LIBS@
+
 noinst_PROGRAMS += $(unit_tests)
 
 TESTS = $(unit_tests)
diff --git a/unit/test-blueatchat.c b/unit/test-blueatchat.c
new file mode 100644
index 0000000..ae10ff7
--- /dev/null
+++ b/unit/test-blueatchat.c
@@ -0,0 +1,334 @@
+#include <stdio.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <string.h>
+
+#include <glib.h>
+#include "src/shared/cbuffer.h"
+#include "src/shared/blueatchat.h"
+
+/* use power of 2 for the buffer size */
+#define BUFFER_SIZE (1<<8)
+
+/* #define BLUEATCHAT_DEBUG */
+
+/* storage used by unit testing framework */
+struct blueat_fixture {
+	GMainLoop *loop;
+	char *msg;
+	struct blueatchat_session *session;
+	GIOChannel *gio_read, *gio_write;
+	bool issent;
+};
+
+/* stores callback calls count for each test case if data was parsed */
+volatile int called;
+/* stores callback calls for unknown commands or with wring data */
+volatile int unknown;
+
+/******************************************************************************
+ * Add test cases below:
+ *	- create test case for sending commands data
+ *	- if sending new commands - remember to register this command
+ *		and its callback which verifies parsed data
+ *	- add prepared test case in the main function at the very bottom
+ ******************************************************************************/
+/* Unknown command test case and callback that verifies (non)parsed data */
+static bool tc_blueat_unknown_cb(GSList *data)
+{
+	unknown += 1;
+
+	/* In this test case there should be no parsed data */
+	g_assert(data);
+	g_assert(data->data);
+	g_message("Unknown command callback: %s",
+			g_strescape((char *)data->data, NULL));
+
+	return true;
+}
+static void tc_blueat_unknown(struct blueat_fixture *fix,
+					gconstpointer test_data)
+{
+	/* Defined test case */
+	fix->msg = "\r\nunknown command and garbage\r\n";
+
+	/* start the loop for IO ops execution */
+	g_main_loop_run(fix->loop);
+
+	/* one unknown command should be found */
+	g_assert_cmpint(called, ==, 0);
+	g_assert_cmpint(unknown, ==, 1);
+}
+
+/* OK test case and callback that verifies parsed data */
+static bool tc_blueat_ok_cb(GSList *data)
+{
+	called += 1;
+	g_message("OK callback");
+	g_assert(!data);
+	return true;
+}
+static void tc_blueat_ok(struct blueat_fixture *fix, gconstpointer test_data)
+{
+	fix->msg = "\r\nOK\r\n";
+
+	g_main_loop_run(fix->loop);
+
+	/* one ok command should be found */
+	g_assert_cmpint(called, ==, 1);
+}
+static void tc_blueat_garbagemix(struct blueat_fixture *fix,
+					gconstpointer test_data)
+{
+	/* Define test case */
+	fix->msg = "garbage\n\r"		/* garbage */
+			"\r\nunknown\r\n"	/* unknown */
+			"\r\nOK\r\n"		/* ok */
+			"\r\n\n\rgarbage\r\n"	/* unknown */
+			"\r\rgarbageggegg\n\n"	/* garbage */
+			"\r\nOK\r\n";		/* ok */
+
+	g_main_loop_run(fix->loop);
+
+	/* 2 OK and 2 unknown commands should be found */
+	g_assert_cmpint(called, ==, 2);
+	g_assert_cmpint(unknown, ==, 2);
+}
+
+/* AT+BRSF test case and callback that verifies parsed data */
+static bool tc_blueat_atbrsf_cb(GSList *data)
+{
+	called += 1;
+	g_message("AT+BRSF= callback");
+
+	g_assert(data);
+	g_assert(data->data);
+	g_assert_cmpint(*(int *)data->data, ==, 128);
+
+	return true;
+}
+static void tc_blueat_atbrsf(struct blueat_fixture *fix,
+					gconstpointer test_data)
+{
+	/* Define test case */
+	fix->msg = "\r\nAT+BRSF=128\r\n";
+
+	g_main_loop_run(fix->loop);
+
+	/* 1 callback should be called */
+	g_assert_cmpint(called, ==, 1);
+}
+
+static void tc_blueat_garbage(struct blueat_fixture *fix,
+					gconstpointer test_data)
+{
+	/* Define test case */
+	fix->msg = "dfg5745j46\74845r4\68r\48un468n4wn\4r4hgnn\r\nOKjf\rkfhn"
+			"\r\n\nlsfg\aargarbage\r;\nsrdgfhdnOK\r\n";
+
+	/* start the loop for IO ops execution */
+	g_main_loop_run(fix->loop);
+
+	/* no commands should be found in this garbage */
+	g_assert_cmpint(called, ==, 0);
+}
+
+static bool tc_blueat_cnum_cb(GSList *data)
+{
+	GSList *item = NULL;
+
+	called += 1;
+	g_message("+CNUM: callback");
+
+	g_assert(data);
+	item = g_slist_reverse(data);
+
+	g_assert(item);
+	/* no optional parameter */
+	g_assert((char *)item->data == NULL);
+
+	g_assert((item = g_slist_next(item)));
+	g_assert((char *)item->data != NULL);
+	g_assert_cmpint(strcmp((char *)item->data, "5551212"), ==, 0);
+
+	g_assert((item = g_slist_next(item)));
+	g_assert((int *)item->data != NULL);
+	g_assert_cmpint(*(int *)item->data, ==, 129);
+
+	/* no optional parameter */
+	g_assert((item = g_slist_next(item)));
+	g_assert((int *)item->data == NULL);
+
+	g_assert((item = g_slist_next(item)));
+	g_assert((int *)item->data != NULL);
+	g_assert_cmpint(*(int *)item->data, ==, 4);
+	return true;
+}
+static void tc_blueat_cnum(struct blueat_fixture *fix, gconstpointer test_data)
+{
+	/* Define test case */
+	/* two optional command parameters absent */
+	fix->msg = "\r\n+CNUM: ,\"5551212\",129,,4\r\n";
+
+	/* start the loop for IO ops execution */
+	g_main_loop_run(fix->loop);
+
+	/* 1 cnum command should be found */
+	g_assert_cmpint(called, ==, 1);
+}
+
+/******************************************************************************
+ * Parser configuration and command registration
+ ******************************************************************************/
+static struct blueatchat_config cfg = {
+	.buff_size = BUFFER_SIZE,
+	.cmd_prefix = "\r\n",
+	.cmd_postfix = "\r\n"
+};
+
+/* Commands that should be recognised by the parser.
+ * !IMPORTANT: unknown command callback should always be last.
+ */
+static struct blueatchat_cmd_descriptor commands[] = {
+	/* recognised command | syntax descriptor   |   callback */
+	{"OK",		NULL,				tc_blueat_ok_cb},
+	{"AT+BRSF=",	"u",				tc_blueat_atbrsf_cb},
+	{"+CNUM: ",	"oq,q,u,ou,u*",			tc_blueat_cnum_cb},
+	{NULL,		"s",				tc_blueat_unknown_cb},
+};
+
+/* Callback sending messages to the blueatchat module */
+static gboolean gio_out_cb(GIOChannel *gio, GIOCondition condition,
+					gpointer data)
+{
+	struct blueat_fixture *fix = data;
+
+	if (condition & G_IO_HUP)
+		g_error("Write end of pipe died!\n");
+
+	if (!fix->issent) {
+		gsize len;
+		GIOStatus ret;
+		GError *err = NULL;
+		const gchar *msg = fix->msg;
+
+		ret = g_io_channel_write_chars(gio, msg, -1, &len,
+						&err);
+		if (ret == G_IO_STATUS_ERROR)
+			g_error("Error writing: %s\n", err->message);
+		fix->issent = true;
+		return TRUE;
+	}
+
+	/* It will end up here at second io write,
+	 * when message has already been written.
+	 */
+	g_main_loop_quit(fix->loop);
+	return FALSE;
+}
+
+/* Make blueatchat silent */
+static void blueatchat_debug(const char *str, void *user_data)
+{
+#ifdef BLUEATCHAT_DEBUG
+	const char *prefix = user_data;
+	g_message("%s: %s", prefix, g_strescape(str, NULL));
+#endif
+}
+
+static gboolean blueat_read_cb(GIOChannel *gio, GIOCondition condition,
+				gpointer data)
+{
+	struct blueatchat_session *session = (struct blueatchat_session *)data;
+
+	if (!session)
+		g_error("Session died!\n");
+
+	g_message("Read started");
+
+	if (condition & (G_IO_NVAL | G_IO_HUP | G_IO_ERR)) {
+		g_message("Read end of pipe died!");
+		return FALSE;
+	}
+
+	if (!blueatchat_read(session, gio)) {
+		g_message("AT chat died!");
+		return FALSE;
+	}
+	return TRUE;
+}
+
+static void blueat_fix_setup(struct blueat_fixture *fix, gconstpointer tdata)
+{
+	int fd[2], ret;
+
+	called = 0;
+	unknown = 0;
+	fix->issent = false;
+	fix->loop = g_main_loop_new(NULL, FALSE);
+
+	ret = pipe(fd);
+	if (ret == -1)
+		g_error("Creating pipe failed: %s\n", strerror(errno));
+
+	fix->gio_read = g_io_channel_unix_new(fd[0]);
+	fix->gio_write = g_io_channel_unix_new(fd[1]);
+
+	g_io_channel_set_encoding(fix->gio_write, NULL, NULL);
+	g_io_channel_set_buffered(fix->gio_write, FALSE);
+
+	g_io_channel_set_encoding(fix->gio_read, NULL, NULL);
+	g_io_channel_set_buffered(fix->gio_read, FALSE);
+	g_io_channel_set_flags(fix->gio_read, G_IO_FLAG_NONBLOCK, NULL);
+
+	fix->session =
+		blueatchat_init_session(&cfg, commands, blueatchat_debug);
+
+	if (!fix->session)
+		g_error("Cannot initialize the gat_parser!\n");
+
+	if (!fix->gio_read || !fix->gio_write)
+		g_error("Cannot create new GIOChannel!\n");
+
+	g_io_add_watch_full(fix->gio_read, G_PRIORITY_DEFAULT,
+					(G_IO_IN | G_IO_ERR | G_IO_NVAL),
+					blueat_read_cb,
+					fix->session, NULL);
+	if (!g_io_add_watch(fix->gio_write, G_IO_OUT | G_IO_HUP,
+					gio_out_cb, fix))
+		g_error("Cannot add watch on GIOChannel!\n");
+}
+
+static void blueat_fix_teardown(struct blueat_fixture *fix, gconstpointer tdata)
+{
+	/* channel clean up */
+	blueatchat_cleanup_session(fix->session);
+	g_io_channel_unref(fix->gio_read);
+	g_io_channel_unref(fix->gio_write);
+	g_main_loop_unref(fix->loop);
+}
+
+int main(int argc, char **argv)
+{
+	g_test_init(&argc, &argv, NULL);
+	g_test_add("/blueatchat/unknown", struct blueat_fixture, 0,
+				blueat_fix_setup, tc_blueat_unknown,
+				blueat_fix_teardown);
+	g_test_add("/blueatchat/ok", struct blueat_fixture, 0,
+				blueat_fix_setup, tc_blueat_ok,
+				blueat_fix_teardown);
+	g_test_add("/blueatchat/garbagemix", struct blueat_fixture, 0,
+				blueat_fix_setup, tc_blueat_garbagemix,
+				blueat_fix_teardown);
+	g_test_add("/blueatchat/atbrsf", struct blueat_fixture, 0,
+				blueat_fix_setup, tc_blueat_atbrsf,
+				blueat_fix_teardown);
+	g_test_add("/blueatchat/garbage", struct blueat_fixture, 0,
+				blueat_fix_setup, tc_blueat_garbage,
+				blueat_fix_teardown);
+	g_test_add("/blueatchat/cnum", struct blueat_fixture, 0,
+				blueat_fix_setup, tc_blueat_cnum,
+				blueat_fix_teardown);
+	return g_test_run();
+}
-- 
1.7.9.5

