Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 14/35] unit/test-avrcp: Add /TP/MCN/NP/BV-06-C test
Date: Fri, 25 Apr 2014 11:38:51 +0300
Message-Id: <1398415152-22950-15-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
References: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

To verify the GetFolderItems response for the NowPlaying Folder issued by
the TG.
---
 unit/test-avrcp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index beaaa4a..723d90d 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -853,6 +853,17 @@ int main(int argc, char *argv[])
 				0x00, 0x00, 0x00, 0x02, /* end */
 				0x00));
 
+	/* GetFolderItems - NowPlaying - TG */
+	define_test("/TP/MCN/NP/BV-06-C", test_server,
+			brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
+				0x00, 0x0a, AVRCP_MEDIA_NOW_PLAYING,
+				0x00, 0x00, 0x00, 0x00, /* start */
+				0x00, 0x00, 0x00, 0x02, /* end */
+				0x00),
+			brs_pdu(0x02, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
+				0x00, 0x05, 0x04, 0xab, 0xcd, 0x00, 0x00));
+
+
 	/* Media Player Selection IOP tests */
 
 	/* Listing of available media players */
-- 
1.9.0

