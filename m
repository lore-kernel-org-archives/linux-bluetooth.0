Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 11/35] unit/test-avrcp: Add /TP/MCN/CB/BI-03-C test
Date: Fri, 25 Apr 2014 11:38:48 +0300
Message-Id: <1398415152-22950-12-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
References: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

To verify the GetFolderItems response issued by the TG when the command
contains invalid parameters accessing items beyond the end of a folder.
---
 unit/test-avrcp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 85547d2..f653861 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -558,6 +558,9 @@ static int get_folder_items(struct avrcp *session, uint8_t transaction,
 	if (g_str_equal(context->data->test_name, "/TP/MCN/CB/BI-02-C"))
 		return -ERANGE;
 
+	if (start > 1)
+		return -ERANGE;
+
 	avrcp_get_folder_items_rsp(session, transaction, 0xabcd, 0, NULL, NULL,
 									NULL);
 
@@ -790,6 +793,16 @@ int main(int argc, char *argv[])
 			brs_pdu(0x02, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
 				0x00, 0x01, 0x0b));
 
+	/* GetFolderItems - Virtual FS - TG */
+	define_test("/TP/MCN/CB/BI-03-C", test_server,
+			brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
+				0x00, 0x0a, AVRCP_MEDIA_PLAYER_VFS,
+				0x00, 0x00, 0x00, 0x02, /* start */
+				0x00, 0x00, 0x00, 0x03, /* end */
+				0x00),
+			brs_pdu(0x02, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
+				0x00, 0x01, 0x0b));
+
 	/* Media Content Navigation Commands and Notifications for Search */
 
 	/* Search - CT */
-- 
1.9.0

