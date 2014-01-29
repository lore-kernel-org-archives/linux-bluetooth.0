Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 2/3] unit/avctp: Add TP/NFR/BV-02-C test
Date: Wed, 29 Jan 2014 14:41:13 +0200
Message-Id: <1390999274-15631-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1390999274-15631-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1390999274-15631-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

To verify that the IUT (TG) formats correctly the following fields of
the AVCTP response message: “transaction label”, "message type(R)", PID,
“packet type”, IPID and “message information”. Check that AVCTP send
response packet along with other information. Payload is out of scope of
this test (AVC_CTYPE_REJECTED is OK).
---
 unit/test-avctp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/unit/test-avctp.c b/unit/test-avctp.c
index 49bd640..8c97a82 100644
--- a/unit/test-avctp.c
+++ b/unit/test-avctp.c
@@ -244,6 +244,15 @@ static void test_client(gconstpointer data)
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
@@ -254,5 +263,9 @@ int main(int argc, char *argv[])
 	define_test("/TP/NFR/BV-01-C", test_client,
 				raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x00, 0x00));
 
+	define_test("/TP/NFR/BV-02-C", test_server,
+				raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x00, 0x00),
+				raw_pdu(0x02, 0x11, 0x0e, 0x0a, 0x00, 0x00));
+
 	return g_test_run();
 }
-- 
1.8.3.2

