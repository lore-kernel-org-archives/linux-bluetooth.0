Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 21/35] unit/test-avrcp: Add /TP/MCN/SRC/BV-06-C test
Date: Fri, 25 Apr 2014 11:38:58 +0300
Message-Id: <1398415152-22950-22-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
References: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

To verify the GetItemAttributes response issued by the TG on a Media Item
in the Search folder other than the currently playing one (UID 0x0).
---
 unit/test-avrcp.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 2394557..39b1091 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -915,6 +915,17 @@ int main(int argc, char *argv[])
 				0xaa, 0xbb,		/* counter */
 				0x00));			/* num attr */
 
+	/* GetItemAttributes - TG */
+	define_test("/TP/MCN/SRC/BV-06-C", test_server,
+			brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_ITEM_ATTRIBUTES,
+				0x00, 0x0c, AVRCP_MEDIA_SEARCH,
+				0x00, 0x00, 0x00, 0x00,
+				0x00, 0x00, 0x00, 0x01,	/* uid */
+				0xaa, 0xbb,		/* counter */
+				0x00),			/* num attr */
+			brs_pdu(0x02, 0x11, 0x0e, AVRCP_GET_ITEM_ATTRIBUTES,
+				0x00, 0x02, 0x04, 0x00));
+
 	/* Media Content Navigation Commands and Notifications for NowPlaying */
 
 	/* GetFolderItems - NowPlaying - CT */
@@ -935,7 +946,6 @@ int main(int argc, char *argv[])
 			brs_pdu(0x02, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
 				0x00, 0x05, 0x04, 0xab, 0xcd, 0x00, 0x00));
 
-
 	/* Media Player Selection IOP tests */
 
 	/* Listing of available media players */
-- 
1.9.0

