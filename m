Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 10/35] unit/test-avrcp: Add /TP/MCN/CB/BI-02-C test
Date: Fri, 25 Apr 2014 11:38:47 +0300
Message-Id: <1398415152-22950-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
References: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

To verify the GetFolderItems response issued by the TG for an empty
folder when the command contains invalid parameters.
---
 unit/test-avrcp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 44d833a..85547d2 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -539,6 +539,7 @@ static int set_addressed(struct avrcp *session, uint8_t transaction,
 {
 	DBG("");
 
+
 	avrcp_set_addressed_player_rsp(session, transaction,
 							AVRCP_STATUS_SUCCESS);
 
@@ -550,8 +551,13 @@ static int get_folder_items(struct avrcp *session, uint8_t transaction,
 				uint16_t number, uint32_t *attrs,
 				void *user_data)
 {
+	struct context *context = user_data;
+
 	DBG("");
 
+	if (g_str_equal(context->data->test_name, "/TP/MCN/CB/BI-02-C"))
+		return -ERANGE;
+
 	avrcp_get_folder_items_rsp(session, transaction, 0xabcd, 0, NULL, NULL,
 									NULL);
 
@@ -774,6 +780,16 @@ int main(int argc, char *argv[])
 			brs_pdu(0x02, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
 				0x00, 0x01, 0x0b));
 
+	/* GetFolderItems - Virtual FS - TG */
+	define_test("/TP/MCN/CB/BI-02-C", test_server,
+			brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
+				0x00, 0x0a, AVRCP_MEDIA_PLAYER_VFS,
+				0x00, 0x00, 0x00, 0x00, /* start */
+				0x00, 0x00, 0x00, 0x01, /* end */
+				0x00),
+			brs_pdu(0x02, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
+				0x00, 0x01, 0x0b));
+
 	/* Media Content Navigation Commands and Notifications for Search */
 
 	/* Search - CT */
-- 
1.9.0

