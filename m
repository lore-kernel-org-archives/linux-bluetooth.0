Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 2/5] unit/avrcp: Add /TP/BGN/BV-01-I test
Date: Wed, 12 Mar 2014 12:54:30 +0200
Message-Id: <1394621673-13718-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394621673-13718-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <CABBYNZK6yEDvVwda3GBubgh2+J=SwE_Vmr5oEJ_hhqhOLd2CsA@mail.gmail.com>
 <1394621673-13718-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that the Controller can send Next Group command to the
Target.
---
 unit/test-avrcp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 3702d39..a5a7a38 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -636,6 +636,10 @@ static void test_client(gconstpointer data)
 						AVRCP_EVENT_STATUS_CHANGED, 0,
 						NULL, NULL);
 
+	if (g_str_equal(context->data->test_name, "/TP/BGN/BV-01-I"))
+		avrcp_send_passthrough_vendor(context->session,
+						AVC_VENDOR_NEXT_GROUP,
+						IEEEID_BTSIG);
 	execute_context(context);
 }
 
@@ -1030,5 +1034,12 @@ int main(int argc, char *argv[])
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

