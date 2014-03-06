Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/7] unit/avrcp: Add /TP/MDI/BV-03-C test
Date: Thu,  6 Mar 2014 16:43:01 +0200
Message-Id: <1394116985-28247-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394116985-28247-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1394116985-28247-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that Get element attributes issued correctly.
---
 unit/test-avrcp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 46ddde9..d50b1ad 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -553,6 +553,9 @@ static void test_client(gconstpointer data)
 	if (g_str_equal(context->data->test_name, "/TP/MDI/BV-01-C"))
 		avrcp_get_play_status(context->session, NULL, NULL);
 
+	if (g_str_equal(context->data->test_name, "/TP/MDI/BV-03-C"))
+		avrcp_get_element_attributes(context->session, NULL, NULL);
+
 	execute_context(context);
 }
 
@@ -812,6 +815,12 @@ int main(int argc, char *argv[])
 				0x00, 0x00, 0x09, 0xaa, 0xaa, 0xaa,
 				0xaa, 0xbb, 0xbb, 0xbb, 0xbb, 0x00));
 
+	/* Get element attributes - CT */
+	define_test("/TP/MDI/BV-03-C", test_client,
+			raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_GET_ELEMENT_ATTRIBUTES,
+				0x00, 0x00, 0x09, 0x00, 0x00, 0x00,
+				0x00, 0x00, 0x00, 0x00, 0x00, 0x00));
 
 	return g_test_run();
 }
-- 
1.8.3.2

