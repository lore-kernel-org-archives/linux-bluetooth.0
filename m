Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 12/35] unit/test-avrcp: Add /TP/MCN/SRC/BV-04-C test
Date: Fri, 25 Apr 2014 11:38:49 +0300
Message-Id: <1398415152-22950-13-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
References: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

To verify the GetFolderItems response for the Search Folder issued by
the TG.
---
 unit/test-avrcp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index f653861..93262a8 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -820,6 +820,16 @@ int main(int argc, char *argv[])
 				0x00, 0x00, 0x00, 0x02, /* end */
 				0x00));
 
+	/* GetFolderItems - NowPlaying - TG */
+	define_test("/TP/MCN/SCR/BV-04-C", test_server,
+			brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
+				0x00, 0x0a, AVRCP_MEDIA_SEARCH,
+				0x00, 0x00, 0x00, 0x00, /* start */
+				0x00, 0x00, 0x00, 0x02, /* end */
+				0x00),
+			brs_pdu(0x02, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
+				0x00, 0x05, 0x04, 0xab, 0xcd, 0x00, 0x00));
+
 	/* GetItemAttributes - CT */
 	define_test("/TP/MCN/SRC/BV-05-C", test_client,
 			raw_pdu(0x00, 0x11, 0x0e, AVRCP_GET_ITEM_ATTRIBUTES,
-- 
1.9.0

