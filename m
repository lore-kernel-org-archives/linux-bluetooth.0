Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] unit/avrcp: Add /TP/ICC/BV-01-I test
Date: Mon, 24 Feb 2014 11:45:24 +0200
Message-Id: <1393235125-28822-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that the Target responds to UNIT INFO command initiated by
Controller.
---
 unit/test-avrcp.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index f1c0f46..edbcad1 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -242,6 +242,30 @@ static void test_dummy(gconstpointer data)
 	destroy_context(context);
 }
 
+static void execute_context(struct context *context)
+{
+	g_main_loop_run(context->main_loop);
+
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
+static void test_server(gconstpointer data)
+{
+	struct context *context = create_context(0x0100, data);
+
+	g_idle_add(send_pdu, context);
+
+	execute_context(context);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -261,5 +285,13 @@ int main(int argc, char *argv[])
 	define_test("/TP/CRC/BV-01-I", test_dummy, raw_pdu(0x00));
 	define_test("/TP/CRC/BV-02-I", test_dummy, raw_pdu(0x00));
 
+	/* Information collection for control tests */
+
+	define_test("/TP/ICC/BV-01-I", test_server,
+			raw_pdu(0x00, 0x11, 0x0e, 0x01, 0xf8, 0x30,
+				0xff, 0xff, 0xff, 0xff, 0xff),
+			raw_pdu(0x02, 0x11, 0x0e, 0x0c, 0xf8, 0x30,
+				0x07, 0x48, 0xff, 0xff, 0xff));
+
 	return g_test_run();
 }
-- 
1.8.3.2

