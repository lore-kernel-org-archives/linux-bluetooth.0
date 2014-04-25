Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 25/35] unit/test-avrcp: Add /TP/MCN/NP/BV-01-C test
Date: Fri, 25 Apr 2014 11:39:02 +0300
Message-Id: <1398415152-22950-26-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
References: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

To verify the PlayItem command issued by the CT.
---
 unit/test-avrcp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 5295e38..88348aa 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -665,6 +665,10 @@ static void test_client(gconstpointer data)
 					AVRCP_MEDIA_SEARCH, 0x01, 0xaabb,
 					0, NULL);
 
+	if (g_str_equal(context->data->test_name, "/TP/MCN/NP/BV-01-C"))
+		avrcp_play_item(context->session, AVRCP_MEDIA_NOW_PLAYING, 1,
+									1);
+
 	if (g_str_equal(context->data->test_name, "/TP/MCN/NP/BV-05-C"))
 		avrcp_get_folder_items(context->session,
 					AVRCP_MEDIA_NOW_PLAYING, 0, 2, 0, NULL);
@@ -933,6 +937,13 @@ int main(int argc, char *argv[])
 
 	/* Media Content Navigation Commands and Notifications for NowPlaying */
 
+	/* PlayItem - NowPlaying - CT */
+	define_test("/TP/MCN/NP/BV-01-C", test_client,
+			brs_pdu(0x00, 0x11, 0x0e, AVRCP_PLAY_ITEM,
+				0x00, 0x0b, AVRCP_MEDIA_NOW_PLAYING,
+				0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01,
+				0x00, 0x01));
+
 	/* GetFolderItems - NowPlaying - CT */
 	define_test("/TP/MCN/NP/BV-05-C", test_client,
 			brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
-- 
1.9.0

