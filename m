Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 6/9] unit/avrcp: Add /TP/PAS/BV-09-C test
Date: Fri, 28 Feb 2014 16:18:42 +0200
Message-Id: <1393597125-18176-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1393597125-18176-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1393597125-18176-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that get current player application setting value command
issued from the Controller.
---
 unit/test-avrcp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index b469dfd..f297efd 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -429,6 +429,14 @@ static void test_client(gconstpointer data)
 		avrcp_get_player_attribute_text(context->session, NULL, 0,
 								NULL, NULL);
 
+	if (g_str_equal(context->data->test_name, "/TP/PAS/BV-09-C")) {
+		uint8_t attributes[2] = { AVRCP_ATTRIBUTE_EQUALIZER,
+						AVRCP_ATTRIBUTE_REPEAT_MODE };
+
+		avrcp_get_current_player_value(context->session, attributes,
+						sizeof(attributes), NULL, NULL);
+	}
+
 	execute_context(context);
 }
 
@@ -574,5 +582,13 @@ int main(int argc, char *argv[])
 				AVRCP_GET_PLAYER_VALUE_TEXT,
 				0x00, 0x00, 0x01, 0x00));
 
+	define_test("/TP/PAS/BV-09-C", test_client,
+			raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
+				0x00, 0x19, 0x58,
+				AVRCP_GET_CURRENT_PLAYER_VALUE,
+				0x00, 0x00, 0x03, 0x02,
+				AVRCP_ATTRIBUTE_EQUALIZER,
+				AVRCP_ATTRIBUTE_REPEAT_MODE));
+
 	return g_test_run();
 }
-- 
1.8.3.2

