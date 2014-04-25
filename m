Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 23/35] unit/test-avrcp: Add /TP/MCN/NP/BV-09-C test
Date: Fri, 25 Apr 2014 11:39:00 +0300
Message-Id: <1398415152-22950-24-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
References: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

To verify the GetItemAttributes response issued by the TG on a Media Item
in the NowPlaying folder.
---
 unit/test-avrcp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index ac6efde..5295e38 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -960,6 +960,17 @@ int main(int argc, char *argv[])
 				0xaa, 0xbb,		/* counter */
 				0x00));			/* num attr */
 
+	/* GetItemAttributes - TG */
+	define_test("/TP/MCN/CB/BV-09-C", test_server,
+			brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_ITEM_ATTRIBUTES,
+				0x00, 0x0c, AVRCP_MEDIA_NOW_PLAYING,
+				0x00, 0x00, 0x00, 0x00,
+				0x00, 0x00, 0x00, 0x01,	/* uid */
+				0xaa, 0xbb,		/* counter */
+				0x00),			/* num attr */
+			brs_pdu(0x02, 0x11, 0x0e, AVRCP_GET_ITEM_ATTRIBUTES,
+				0x00, 0x02, 0x04, 0x00));
+
 	/* Media Player Selection IOP tests */
 
 	/* Listing of available media players */
-- 
1.9.0

