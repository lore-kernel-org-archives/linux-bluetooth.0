Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 08/16] unit/avrcp: Add /TP/MPS/BV-01-I test
Date: Tue, 18 Mar 2014 11:20:39 +0200
Message-Id: <1395134447-8957-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1395134447-8957-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1395134447-8957-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that Controller is able to request the list of available
Media Players.
---
 unit/test-avrcp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 4336668..46c10a3 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -571,6 +571,11 @@ static void test_client(gconstpointer data)
 					AVRCP_MEDIA_PLAYER_LIST, 0, 2, NULL, 0,
 					NULL, NULL);
 
+	if (g_str_equal(context->data->test_name, "/TP/MPS/BV-01-I"))
+		avrcp_get_folder_items(context->session,
+					AVRCP_MEDIA_PLAYER_LIST, 0, 2, NULL, 0,
+					NULL, NULL);
+
 	if (g_str_equal(context->data->test_name, "/TP/CFG/BV-01-C"))
 		avrcp_get_capabilities(context->session, CAP_EVENTS_SUPPORTED,
 								NULL, NULL);
@@ -660,6 +665,16 @@ int main(int argc, char *argv[])
 				0x00, 0x00, 0x00, 0x02, /* end */
 				0x00));
 
+	/* Media Player Selection IOP tests */
+
+	/* Listing of available media players */
+	define_test("/TP/MPS/BV-01-I", test_client,
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

