Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 10/16] unit/avrcp: Add /TP/MCN/CB/BV-01-C test
Date: Tue, 18 Mar 2014 11:20:41 +0200
Message-Id: <1395134447-8957-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1395134447-8957-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1395134447-8957-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that the GetFolderItems command issued by the Controller
with VFS parameter.
---
 unit/test-avrcp.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 602e4bb..b69674b 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -576,6 +576,11 @@ static void test_client(gconstpointer data)
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
@@ -665,6 +670,19 @@ int main(int argc, char *argv[])
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

