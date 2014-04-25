Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 27/35] unit/test-avrcp: Add /TP/MCN/NP/BV-02-C test
Date: Fri, 25 Apr 2014 11:39:04 +0300
Message-Id: <1398415152-22950-28-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
References: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

To verify the PlayItem response issued by the TG.
---
 unit/test-avrcp.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 88348aa..5af4f4b 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -593,6 +593,16 @@ static int get_item_attributes(struct avrcp *session, uint8_t transaction,
 	return -EAGAIN;
 }
 
+static int play_item(struct avrcp *session, uint8_t transaction, uint8_t scope,
+			uint64_t uid, uint16_t counter, void *user_data)
+{
+	DBG("");
+
+	avrcp_play_item_rsp(session, transaction);
+
+	return -EAGAIN;
+}
+
 static const struct avrcp_control_ind control_ind = {
 	.get_capabilities = get_capabilities,
 	.list_attributes = list_attributes,
@@ -608,6 +618,7 @@ static const struct avrcp_control_ind control_ind = {
 	.get_folder_items = get_folder_items,
 	.change_path = change_path,
 	.get_item_attributes = get_item_attributes,
+	.play_item = play_item,
 };
 
 static void test_server(gconstpointer data)
@@ -944,6 +955,15 @@ int main(int argc, char *argv[])
 				0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01,
 				0x00, 0x01));
 
+	/* PlayItem - NowPlaying - TG */
+	define_test("/TP/MCN/NP/BV-02-C", test_server,
+			brs_pdu(0x00, 0x11, 0x0e, AVRCP_PLAY_ITEM,
+				0x00, 0x0b, AVRCP_MEDIA_NOW_PLAYING,
+				0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01,
+				0x00, 0x01),
+			brs_pdu(0x02, 0x11, 0x0e, AVRCP_PLAY_ITEM,
+				0x00, 0x01, 0x04));
+
 	/* GetFolderItems - NowPlaying - CT */
 	define_test("/TP/MCN/NP/BV-05-C", test_client,
 			brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
-- 
1.9.0

