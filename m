Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 3/5] unit/avrcp: Add /TP/BGN/BV-02-I test
Date: Wed, 12 Mar 2014 12:54:31 +0200
Message-Id: <1394621673-13718-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394621673-13718-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <CABBYNZK6yEDvVwda3GBubgh2+J=SwE_Vmr5oEJ_hhqhOLd2CsA@mail.gmail.com>
 <1394621673-13718-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that the Controller can send Prev Group command to the
Target.
---
 unit/test-avrcp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index a5a7a38..fd95a7d 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -640,6 +640,12 @@ static void test_client(gconstpointer data)
 		avrcp_send_passthrough_vendor(context->session,
 						AVC_VENDOR_NEXT_GROUP,
 						IEEEID_BTSIG);
+
+	if (g_str_equal(context->data->test_name, "/TP/BGN/BV-02-I"))
+		avrcp_send_passthrough_vendor(context->session,
+						AVC_VENDOR_PREV_GROUP,
+						IEEEID_BTSIG);
+
 	execute_context(context);
 }
 
@@ -1041,5 +1047,12 @@ int main(int argc, char *argv[])
 				AVC_VENDOR_UNIQUE, 0x05, 0x00, 0x19,
 				0x58, 0x00, AVC_VENDOR_NEXT_GROUP));
 
+	/* Previous Group command transfer - CT */
+	define_test("/TP/BGN/BV-02-I", test_client,
+			raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48,
+				AVC_OP_PASSTHROUGH,
+				AVC_VENDOR_UNIQUE, 0x05, 0x00, 0x19,
+				0x58, 0x00, AVC_VENDOR_PREV_GROUP));
+
 	return g_test_run();
 }
-- 
1.8.3.2

