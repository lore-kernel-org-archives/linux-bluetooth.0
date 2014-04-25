Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 09/35] unit/test-avrcp: Add /TP/MCN/CB/BI-01-C test
Date: Fri, 25 Apr 2014 11:38:46 +0300
Message-Id: <1398415152-22950-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
References: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

To verify the GetFolderItems response issued by the TG when the command
contains invalid parameters.
---
 unit/test-avrcp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index d82ccd9..44d833a 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -764,6 +764,16 @@ int main(int argc, char *argv[])
 				0xaa, 0xbb,		/* counter */
 				0x00));			/* num attr */
 
+	/* GetFolderItems - Virtual FS - TG */
+	define_test("/TP/MCN/CB/BI-01-C", test_server,
+			brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
+				0x00, 0x0a, AVRCP_MEDIA_PLAYER_VFS,
+				0x00, 0x00, 0x00, 0x01, /* start */
+				0x00, 0x00, 0x00, 0x00, /* end */
+				0x00),
+			brs_pdu(0x02, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
+				0x00, 0x01, 0x0b));
+
 	/* Media Content Navigation Commands and Notifications for Search */
 
 	/* Search - CT */
-- 
1.9.0

