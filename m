Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 10/16] unit/avrcp: Add /TP/MCN/CB/BV-01-C test
Date: Fri, 14 Mar 2014 17:17:52 +0200
Message-Id: <1394810278-11013-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394810278-11013-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1394810278-11013-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that the GetFolderItems command issued by the Controller
with VFS parameter.
---
 unit/test-avrcp.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index c5aa32c..f948a8c 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -723,6 +723,11 @@ static void test_client(gconstpointer data)
 					AVRCP_MEDIA_PLAYER_LIST, 0, 2, NULL, 0,
 					NULL, NULL);
 
+	if (g_str_equal(context->data->test_name, "/TP/MCN/CB/BV-01-C"))
+		avrcp_get_folder_items(context->session,
+					AVRCP_MEDIA_PLAYER_VFS, 0, 2, NULL, 0,
+					NULL, NULL);
+
 	if (g_str_equal(context->data->test_name, "/TP/CFG/BV-01-C"))
 		avrcp_get_capabilities(context->session, CAP_EVENTS_SUPPORTED,
 								NULL, NULL);
@@ -812,6 +817,19 @@ int main(int argc, char *argv[])
 				0x00, 0x00, 0x00, 0x02, /* end */
 				0x00));
 
+	/*
+	 * Media Content Navigation Commands and Notifications for Content
+	 * Browsing.
+	 */
+
+	/* GetFolderItems - Virtual FS - CT */
+	define_test("/TP/MCN/CB/BV-01-C", test_client,
+			raw_pdu(0x00, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
+				0x00, 0x0a, AVRCP_MEDIA_PLAYER_VFS,
+				0x00, 0x00, 0x00, 0x00, /* start */
+				0x00, 0x00, 0x00, 0x02, /* end */
+				0x00));
+
 	/* Media Player Selection IOP tests */
 
 	/* Listing of available media players */
-- 
1.8.3.2

