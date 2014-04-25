Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 34/35] unit/test-avrcp: Add /TP/MCN/NP/BV-04-C test
Date: Fri, 25 Apr 2014 11:39:11 +0300
Message-Id: <1398415152-22950-35-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
References: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

To verify the AddToNowPlaying response issued by the TG.
---
 unit/test-avrcp.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index cd07d01..2d112c6 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -616,6 +616,17 @@ static int search(struct avrcp *session, uint8_t transaction,
 	return -EAGAIN;
 }
 
+static int add_to_now_playing(struct avrcp *session, uint8_t transaction,
+				uint8_t scope, uint64_t uid, uint16_t counter,
+				void *user_data)
+{
+	DBG("");
+
+	avrcp_add_to_now_playing_rsp(session, transaction);
+
+	return -EAGAIN;
+}
+
 static const struct avrcp_control_ind control_ind = {
 	.get_capabilities = get_capabilities,
 	.list_attributes = list_attributes,
@@ -633,6 +644,7 @@ static const struct avrcp_control_ind control_ind = {
 	.get_item_attributes = get_item_attributes,
 	.play_item = play_item,
 	.search = search,
+	.add_to_now_playing = add_to_now_playing,
 };
 
 static void test_server(gconstpointer data)
@@ -1000,6 +1012,16 @@ int main(int argc, char *argv[])
 				0x00, 0x00, 0x00, 0x01, /* uid */
 				0xaa, 0xbb));
 
+	/* AddToNowPlaying - NowPlaying - TG */
+	define_test("/TP/MCN/NP/BV-04-C", test_server,
+			brs_pdu(0x00, 0x11, 0x0e, AVRCP_ADD_TO_NOW_PLAYING,
+				0x00, 0x0b, AVRCP_MEDIA_NOW_PLAYING,
+				0x00, 0x00, 0x00, 0x00,
+				0x00, 0x00, 0x00, 0x01, /* uid */
+				0xaa, 0xbb),
+			brs_pdu(0x02, 0x11, 0x0e, AVRCP_ADD_TO_NOW_PLAYING,
+				0x00, 0x01, 0x04));
+
 	/* GetFolderItems - NowPlaying - CT */
 	define_test("/TP/MCN/NP/BV-05-C", test_client,
 			brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
-- 
1.9.0

