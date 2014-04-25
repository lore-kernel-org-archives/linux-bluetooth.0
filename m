Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 32/35] unit/test-avrcp: Add /TP/MCN/NP/BV-03-C test
Date: Fri, 25 Apr 2014 11:39:09 +0300
Message-Id: <1398415152-22950-33-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
References: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

To verify the AddToNowPlaying command issued by the CT.
---
 unit/test-avrcp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 0450d37..cd07d01 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -694,6 +694,10 @@ static void test_client(gconstpointer data)
 		avrcp_play_item(context->session, AVRCP_MEDIA_NOW_PLAYING, 1,
 									1);
 
+	if (g_str_equal(context->data->test_name, "/TP/MCN/NP/BV-03-C"))
+		avrcp_add_to_now_playing(context->session,
+					AVRCP_MEDIA_NOW_PLAYING, 0x01, 0xaabb);
+
 	if (g_str_equal(context->data->test_name, "/TP/MCN/NP/BV-05-C"))
 		avrcp_get_folder_items(context->session,
 					AVRCP_MEDIA_NOW_PLAYING, 0, 2, 0, NULL);
@@ -988,6 +992,14 @@ int main(int argc, char *argv[])
 			brs_pdu(0x02, 0x11, 0x0e, AVRCP_PLAY_ITEM,
 				0x00, 0x01, 0x04));
 
+	/* AddToNowPlaying - NowPlaying - CT */
+	define_test("/TP/MCN/NP/BV-03-C", test_client,
+			brs_pdu(0x00, 0x11, 0x0e, AVRCP_ADD_TO_NOW_PLAYING,
+				0x00, 0x0b, AVRCP_MEDIA_NOW_PLAYING,
+				0x00, 0x00, 0x00, 0x00,
+				0x00, 0x00, 0x00, 0x01, /* uid */
+				0xaa, 0xbb));
+
 	/* GetFolderItems - NowPlaying - CT */
 	define_test("/TP/MCN/NP/BV-05-C", test_client,
 			brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
-- 
1.9.0

