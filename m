Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 16/16] unit/avrcp: Add /TP/MCN/SRC/BV-01-C test
Date: Tue, 18 Mar 2014 11:20:47 +0200
Message-Id: <1395134447-8957-17-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1395134447-8957-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1395134447-8957-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that Search command issued by the Controller.
---
 unit/test-avrcp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 860deaf..a06d068 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -590,6 +590,10 @@ static void test_client(gconstpointer data)
 					AVRCP_MEDIA_PLAYER_VFS, 0x01, 0xaabb,
 					NULL, 0, NULL, NULL);
 
+	if (g_str_equal(context->data->test_name, "/TP/MCN/SRC/BV-01-C"))
+		avrcp_search(context->session, AVRCP_CHARSET_UTF8, "Country",
+								NULL, NULL);
+
 	if (g_str_equal(context->data->test_name, "/TP/CFG/BV-01-C"))
 		avrcp_get_capabilities(context->session, CAP_EVENTS_SUPPORTED,
 								NULL, NULL);
@@ -710,6 +714,16 @@ int main(int argc, char *argv[])
 				0xaa, 0xbb,		/* counter */
 				0x00));			/* num attr */
 
+	/* Media Content Navigation Commands and Notifications for Search */
+
+	/* Search - CT */
+	define_test("/TP/MCN/SRC/BV-01-C", test_client,
+			raw_pdu(0x00, 0x11, 0x0e, AVRCP_SEARCH,
+				0x00, 0x0b, 0x00, AVRCP_CHARSET_UTF8,
+				0x00, 0x07,
+				0x43, 0x6f, 0x75, 0x6e, 0x74, 0x72, 0x79));
+
+
 	/* Media Player Selection IOP tests */
 
 	/* Listing of available media players */
-- 
1.8.3.2

