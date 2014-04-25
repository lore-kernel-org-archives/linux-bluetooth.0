Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 13/35] unit/test-avrcp: Add /TP/MCN/NP/BV-05-C test
Date: Fri, 25 Apr 2014 11:38:50 +0300
Message-Id: <1398415152-22950-14-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
References: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

To verify the GetFolderItems command issued by the CT on the NowPlaying
folder.
---
 unit/test-avrcp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 93262a8..beaaa4a 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -637,6 +637,10 @@ static void test_client(gconstpointer data)
 					AVRCP_MEDIA_SEARCH, 0x01, 0xaabb,
 					0, NULL);
 
+	if (g_str_equal(context->data->test_name, "/TP/MCN/NP/BV-05-C"))
+		avrcp_get_folder_items(context->session,
+					AVRCP_MEDIA_NOW_PLAYING, 0, 2, 0, NULL);
+
 	if (g_str_equal(context->data->test_name, "/TP/CFG/BV-01-C"))
 		avrcp_get_capabilities(context->session, CAP_EVENTS_SUPPORTED);
 
@@ -839,6 +843,16 @@ int main(int argc, char *argv[])
 				0xaa, 0xbb,		/* counter */
 				0x00));			/* num attr */
 
+	/* Media Content Navigation Commands and Notifications for NowPlaying */
+
+	/* GetFolderItems - NowPlaying - CT */
+	define_test("/TP/MCN/NP/BV-05-C", test_client,
+			brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
+				0x00, 0x0a, AVRCP_MEDIA_NOW_PLAYING,
+				0x00, 0x00, 0x00, 0x00, /* start */
+				0x00, 0x00, 0x00, 0x02, /* end */
+				0x00));
+
 	/* Media Player Selection IOP tests */
 
 	/* Listing of available media players */
-- 
1.9.0

