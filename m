Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] unit/avrcp: Add /TP/CFG/BV-01-C test
Date: Wed, 26 Feb 2014 17:14:27 +0200
Message-Id: <1393427669-15337-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that the get capabilities command issued from the
Controller.
---
 unit/test-avrcp.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 53e9237..4a92860 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -297,6 +297,16 @@ static void test_server(gconstpointer data)
 	execute_context(context);
 }
 
+static void test_client(gconstpointer data)
+{
+	struct context *context = create_context(0x0100, data);
+
+	if (g_str_equal(context->data->test_name, "/TP/CFG/BV-01-C"))
+		avrcp_get_capabilities(context->session, NULL);
+
+	execute_context(context);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -364,5 +374,12 @@ int main(int argc, char *argv[])
 			raw_pdu(0x02, 0x11, 0x0e, 0x09, 0x48, 0x7c,
 				AVC_PLAY | 0x80, 0x00));
 
+	/* Metadata transfer tests */
+
+	define_test("/TP/CFG/BV-01-C", test_client,
+			raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
+				0x00, 0x19, 0x58, 0x10, 0x00, 0x00,
+				0x01, 0x03));
+
 	return g_test_run();
 }
-- 
1.8.3.2

