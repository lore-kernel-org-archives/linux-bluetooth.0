Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <andrei.emeltchenko@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 5/6] unit/avrcp: Add /TP/ICC/BV-01-I/CT test
Date: Fri, 21 Feb 2014 17:23:49 +0200
Message-Id: <1392996230-11789-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1392996230-11789-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1392996230-11789-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that the Controller can collect information of Target
by UNIT INFO command.
---
 unit/test-avrcp.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index f1c0f46..2cb28b1 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -242,6 +242,37 @@ static void test_dummy(gconstpointer data)
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
+static void test_client(gconstpointer data)
+{
+	struct context *context = create_context(0x0100, data);
+	struct avctp *session = avrcp_get_avctp(context->session);
+	int ret = 0;
+
+	if (g_str_equal(context->data->test_name, "/TP/ICC/BV-01-I/CT"))
+		ret = avctp_send_unit_info_req(session, NULL, NULL);
+
+	DBG("ret = %d", ret);
+
+	g_assert(!ret);
+
+	execute_context(context);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -261,5 +292,11 @@ int main(int argc, char *argv[])
 	define_test("/TP/CRC/BV-01-I", test_dummy, raw_pdu(0x00));
 	define_test("/TP/CRC/BV-02-I", test_dummy, raw_pdu(0x00));
 
+	/* Information collection for control tests */
+
+	define_test("/TP/ICC/BV-01-I/CT", test_client,
+			raw_pdu(0x00, 0x11, 0x0e, 0x01, 0xf8, 0x30,
+				0xff, 0xff, 0xff, 0xff, 0xff));
+
 	return g_test_run();
 }
-- 
1.8.3.2

