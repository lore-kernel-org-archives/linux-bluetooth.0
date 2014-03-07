Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/9] unit/avrcp: Add /TP/NFY/BV-01-C test
Date: Fri,  7 Mar 2014 13:51:51 +0200
Message-Id: <1394193113-32347-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394193113-32347-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1394193113-32347-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that Register notification command is issued by
Controller.
---
 unit/test-avrcp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 496dd1b..fa4870d 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -578,6 +578,11 @@ static void test_client(gconstpointer data)
 	if (g_str_equal(context->data->test_name, "/TP/MDI/BV-03-C"))
 		avrcp_get_element_attributes(context->session, NULL, NULL);
 
+	if (g_str_equal(context->data->test_name, "/TP/NFY/BV-01-C"))
+		avrcp_register_notification(context->session,
+						AVRCP_EVENT_STATUS_CHANGED, 0,
+						NULL, NULL);
+
 	execute_context(context);
 }
 
@@ -865,5 +870,14 @@ int main(int argc, char *argv[])
 				0x00, 0x19, 0x58, AVRCP_GET_ELEMENT_ATTRIBUTES,
 				0x00, 0x00, 0x00));
 
+	/* Notification Commands */
+
+	/* Register notification - CT */
+	define_test("/TP/NFY/BV-01-C", test_client,
+			raw_pdu(0x00, 0x11, 0x0e, 0x03, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICATION,
+				0x00, 0x00, 0x05, AVRCP_EVENT_STATUS_CHANGED,
+				0x00, 0x00, 0x00, 0x00));
+
 	return g_test_run();
 }
-- 
1.8.3.2

