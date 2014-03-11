Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 07/10] unit/avrcp: Add /TP/BGN/BV-01-I test
Date: Tue, 11 Mar 2014 15:05:51 +0200
Message-Id: <1394543154-25355-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394543154-25355-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1394458798-13822-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1394543154-25355-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that the Controller can send Next Group command to the
Target.
---
 unit/test-avrcp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 5d78a9a..d33c69d 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -636,6 +636,9 @@ static void test_client(gconstpointer data)
 						AVRCP_EVENT_STATUS_CHANGED, 0,
 						NULL, NULL);
 
+	if (g_str_equal(context->data->test_name, "/TP/BGN/BV-01-I"))
+		avrcp_passthrough_vendor_req(context->session,
+						AVC_VENDOR_NEXT_GROUP, true);
 	execute_context(context);
 }
 
@@ -1030,5 +1033,12 @@ int main(int argc, char *argv[])
 				0xff, 0x00, 0x00, 0x01,
 				AVRCP_STATUS_INVALID_COMMAND));
 
+	/* Next Group command transfer - CT */
+	define_test("/TP/BGN/BV-01-I", test_client,
+			raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48,
+				AVC_OP_PASSTHROUGH,
+				AVC_VENDOR_UNIQUE, 0x05, 0x00, 0x19,
+				0x58, 0x00, AVC_VENDOR_NEXT_GROUP));
+
 	return g_test_run();
 }
-- 
1.8.3.2

