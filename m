Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] unit/avrcp: Add /TP/PAS/BV-03-C test
Date: Thu, 27 Feb 2014 15:35:12 +0200
Message-Id: <1393508113-18628-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1393508113-18628-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1393508113-18628-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that the get player application settings attribute text
command issued from the Controller.
---
 unit/test-avrcp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index c4faca3..a75165b 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -375,6 +375,10 @@ static void test_client(gconstpointer data)
 	if (g_str_equal(context->data->test_name, "/TP/PAS/BV-01-C"))
 		avrcp_list_player_attributes(context->session, NULL, NULL);
 
+	if (g_str_equal(context->data->test_name, "/TP/PAS/BV-03-C"))
+		avrcp_get_player_attribute_text(context->session, NULL, 0,
+								NULL, NULL);
+
 	execute_context(context);
 }
 
@@ -484,5 +488,11 @@ int main(int argc, char *argv[])
 				0x00, 0x19, 0x58, 0x11, 0x00, 0x00,
 				0x01, 0x00));
 
+	define_test("/TP/PAS/BV-03-C", test_client,
+			raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
+				0x00, 0x19, 0x58,
+				AVRCP_GET_PLAYER_ATTRIBUTE_TEXT,
+				0x00, 0x00, 0x00));
+
 	return g_test_run();
 }
-- 
1.8.3.2

