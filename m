Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <andrei.emeltchenko@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 6/6] unit/avrcp: Add /TP/ICC/BV-01-I/TG test
Date: Fri, 21 Feb 2014 17:23:50 +0200
Message-Id: <1392996230-11789-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1392996230-11789-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1392996230-11789-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that the Target responds to UNIT INFO command initiated by
Controller.
---
 unit/test-avrcp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 2cb28b1..0e7de96 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -273,6 +273,15 @@ static void test_client(gconstpointer data)
 	execute_context(context);
 }
 
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
@@ -298,5 +307,11 @@ int main(int argc, char *argv[])
 			raw_pdu(0x00, 0x11, 0x0e, 0x01, 0xf8, 0x30,
 				0xff, 0xff, 0xff, 0xff, 0xff));
 
+	define_test("/TP/ICC/BV-01-I/TG", test_server,
+			raw_pdu(0x00, 0x11, 0x0e, 0x01, 0xf8, 0x30,
+				0xff, 0xff, 0xff, 0xff, 0xff),
+			raw_pdu(0x02, 0x11, 0x0e, 0x0c, 0xf8, 0x30,
+				0x07, 0x48, 0xff, 0xff, 0xff));
+
 	return g_test_run();
 }
-- 
1.8.3.2

