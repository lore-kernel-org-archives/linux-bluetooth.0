Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 07/16] unit/avrcp: Add /TP/MPS/BV-08-C test
Date: Fri, 14 Mar 2014 17:17:49 +0200
Message-Id: <1394810278-11013-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394810278-11013-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1394810278-11013-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that GetFolderItems cmd for the Media Player List
issued by the Controller.
---
 unit/test-avrcp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 22b3e4a..b173e8d 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -713,6 +713,11 @@ static void test_client(gconstpointer data)
 	if (g_str_equal(context->data->test_name, "/TP/MPS/BV-03-C"))
 		avrcp_set_browsed_player(context->session, 0xabcd, NULL, NULL);
 
+	if (g_str_equal(context->data->test_name, "/TP/MPS/BV-08-C"))
+		avrcp_get_folder_items(context->session,
+					AVRCP_MEDIA_PLAYER_LIST, 0, 2, NULL, 0,
+					NULL, NULL);
+
 	if (g_str_equal(context->data->test_name, "/TP/CFG/BV-01-C"))
 		avrcp_get_capabilities(context->session, CAP_EVENTS_SUPPORTED,
 								NULL, NULL);
@@ -794,6 +799,14 @@ int main(int argc, char *argv[])
 			raw_pdu(0x00, 0x11, 0x0e, 0x70, 0x00, 0x02,
 				0xab, 0xcd));
 
+	/* GetFolderItems - CT */
+	define_test("/TP/MPS/BV-08-C", test_client,
+			raw_pdu(0x00, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
+				0x00, 0x0a, AVRCP_MEDIA_PLAYER_LIST,
+				0x00, 0x00, 0x00, 0x00, /* start */
+				0x00, 0x00, 0x00, 0x02, /* end */
+				0x00));
+
 	/* Connection Establishment for Control tests */
 
 	/*
-- 
1.8.3.2

