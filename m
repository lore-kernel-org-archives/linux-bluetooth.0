Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 20/35] unit/test-avrcp: Add /TP/MCN/CB/BV-08-C test
Date: Fri, 25 Apr 2014 11:38:57 +0300
Message-Id: <1398415152-22950-21-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
References: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

To verify the GetItemAttributes response issued by the TG on a Media Item
in the Media Player Virtual Filesystem other than the currently playing
one (UID 0x0).
---
 unit/test-avrcp.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 1cde8fb..2394557 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -581,6 +581,18 @@ static int change_path(struct avrcp *session, uint8_t transaction,
 	return -EAGAIN;
 }
 
+static int get_item_attributes(struct avrcp *session, uint8_t transaction,
+					uint8_t scope, uint64_t uid,
+					uint16_t counter, uint8_t number,
+					uint32_t *attrs, void *user_data)
+{
+	DBG("");
+
+	avrcp_get_item_attributes_rsp(session, transaction, 0, NULL, NULL);
+
+	return -EAGAIN;
+}
+
 static const struct avrcp_control_ind control_ind = {
 	.get_capabilities = get_capabilities,
 	.list_attributes = list_attributes,
@@ -595,6 +607,7 @@ static const struct avrcp_control_ind control_ind = {
 	.set_addressed = set_addressed,
 	.get_folder_items = get_folder_items,
 	.change_path = change_path,
+	.get_item_attributes = get_item_attributes,
 };
 
 static void test_server(gconstpointer data)
@@ -814,6 +827,17 @@ int main(int argc, char *argv[])
 				0xaa, 0xbb,		/* counter */
 				0x00));			/* num attr */
 
+	/* GetItemAttributes - TG */
+	define_test("/TP/MCN/CB/BV-08-C", test_server,
+			brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_ITEM_ATTRIBUTES,
+				0x00, 0x0c, AVRCP_MEDIA_PLAYER_VFS,
+				0x00, 0x00, 0x00, 0x00,
+				0x00, 0x00, 0x00, 0x01,	/* uuid */
+				0xaa, 0xbb,		/* counter */
+				0x00),			/* num attr */
+			brs_pdu(0x02, 0x11, 0x0e, AVRCP_GET_ITEM_ATTRIBUTES,
+				0x00, 0x02, 0x04, 0x00));
+
 	/* GetFolderItems - Virtual FS - TG */
 	define_test("/TP/MCN/CB/BI-01-C", test_server,
 			brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
-- 
1.9.0

