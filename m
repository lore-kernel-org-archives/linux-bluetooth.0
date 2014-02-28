Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 9/9] unit/avrcp: Add /TP/PAS/BV-11-C test
Date: Fri, 28 Feb 2014 16:18:45 +0200
Message-Id: <1393597125-18176-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1393597125-18176-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1393597125-18176-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that the set player application setting value command
issued from the Controller.
---
 unit/test-avrcp.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 0206e19..76fcdaf 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -461,6 +461,16 @@ static void test_client(gconstpointer data)
 						sizeof(attributes), NULL, NULL);
 	}
 
+	if (g_str_equal(context->data->test_name, "/TP/PAS/BV-11-C")) {
+		uint8_t attributes[2] = { AVRCP_ATTRIBUTE_EQUALIZER,
+						AVRCP_ATTRIBUTE_REPEAT_MODE };
+		uint8_t values[] = { 0xaa, 0xff };
+
+		avrcp_set_player_value(context->session, attributes,
+						sizeof(attributes), values,
+						NULL, NULL);
+	}
+
 	execute_context(context);
 }
 
@@ -628,5 +638,13 @@ int main(int argc, char *argv[])
 				AVRCP_ATTRIBUTE_EQUALIZER, 0x00,
 				AVRCP_ATTRIBUTE_REPEAT_MODE, 0x00));
 
+	define_test("/TP/PAS/BV-11-C", test_client,
+			raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48, 0x00,
+				0x00, 0x19, 0x58,
+				AVRCP_SET_PLAYER_VALUE,
+				0x00, 0x00, 0x05, 0x02,
+				AVRCP_ATTRIBUTE_EQUALIZER, 0xaa,
+				AVRCP_ATTRIBUTE_REPEAT_MODE, 0xff));
+
 	return g_test_run();
 }
-- 
1.8.3.2

