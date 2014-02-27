Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5] unit/avrcp: Add /TP/PAS/BV-01-C test
Date: Thu, 27 Feb 2014 11:11:31 +0200
Message-Id: <1393492291-15099-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1393492291-15099-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1393492291-15099-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that the List Player Application Setting Attributes command
issued from the Controller.
---
 unit/test-avrcp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 0924a7e..c65f743 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -358,6 +358,9 @@ static void test_client(gconstpointer data)
 		avrcp_get_capabilities(context->session, CAP_EVENTS_SUPPORTED,
 								NULL, NULL);
 
+	if (g_str_equal(context->data->test_name, "/TP/PAS/BV-01-C"))
+		avrcp_list_player_attributes(context->session, NULL, NULL);
+
 	execute_context(context);
 }
 
@@ -452,5 +455,12 @@ int main(int argc, char *argv[])
 				0x00, 0x00, 0x01,
 				AVRCP_STATUS_INVALID_PARAM));
 
+	/* Player Application Settings tests */
+
+	define_test("/TP/PAS/BV-01-C", test_client,
+			raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
+				0x00, 0x19, 0x58, 0x11, 0x00, 0x00,
+				0x00));
+
 	return g_test_run();
 }
-- 
1.8.3.2

