Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/8] unit/test-avrcp: Add /TP/MPS/BV-04-C test
Date: Wed,  8 Oct 2014 15:31:44 +0300
Message-Id: <1412771509-7996-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412771509-7996-1-git-send-email-luiz.dentz@gmail.com>
References: <1412771509-7996-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Verify the SetBrowsedPlayer response issued by the TG.
---
 unit/test-avrcp.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 92c3420..146858b 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -586,6 +586,20 @@ static int set_addressed(struct avrcp *session, uint8_t transaction,
 	return -EAGAIN;
 }
 
+static int set_browsed(struct avrcp *session, uint8_t transaction,
+						uint16_t id, void *user_data)
+{
+	const char *folders[1] = { "Filesystem" };
+
+	DBG("");
+
+	avrcp_set_browsed_player_rsp(session, transaction,
+					AVRCP_STATUS_SUCCESS, 0xabcd, 0, 1,
+					folders);
+
+	return -EAGAIN;
+}
+
 static int get_folder_items(struct avrcp *session, uint8_t transaction,
 				uint8_t scope, uint32_t start, uint32_t end,
 				uint16_t number, uint32_t *attrs,
@@ -683,6 +697,7 @@ static const struct avrcp_control_ind control_ind = {
 	.register_notification = register_notification,
 	.set_volume = set_volume,
 	.set_addressed = set_addressed,
+	.set_browsed = set_browsed,
 	.get_folder_items = get_folder_items,
 	.change_path = change_path,
 	.get_item_attributes = get_item_attributes,
@@ -860,6 +875,16 @@ int main(int argc, char *argv[])
 			brs_pdu(0x00, 0x11, 0x0e, 0x70, 0x00, 0x02,
 				0xab, 0xcd));
 
+	/* SetBrowsedPlayer - TG */
+	define_test("/TP/MPS/BV-04-C", test_server,
+			brs_pdu(0x00, 0x11, 0x0e, 0x70, 0x00, 0x02,
+				0xab, 0xcd),
+			brs_pdu(0x02, 0x11, 0x0e, 0x70, 0x00, 0x16,
+				0x04, 0xab, 0xcd, 0x00, 0x00, 0x00,
+				0x00, 0x00, 0x6a, 0x01, 0x00, 0x0a,
+				0x46, 0x69, 0x6c, 0x65, 0x73, 0x79,
+				0x73, 0x74, 0x65, 0x6d));
+
 	/* GetFolderItems - CT */
 	define_test("/TP/MPS/BV-08-C", test_client,
 			brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
-- 
1.9.3

