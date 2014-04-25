Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 17/35] unit/test-avrcp: Add /TP/MCN/CB/BV-06-C test
Date: Fri, 25 Apr 2014 11:38:54 +0300
Message-Id: <1398415152-22950-18-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
References: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

To verify the ChangePath response issued by the TG when the Direction is
FolderUp.
---
 unit/test-avrcp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index ecaaeda..2d51779 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -791,6 +791,17 @@ int main(int argc, char *argv[])
 			brs_pdu(0x02, 0x11, 0x0e, AVRCP_CHANGE_PATH,
 				0x00, 0x05, 0x04, 0x00, 0x00, 0x00, 0x00));
 
+	/* ChangePath - TG */
+	define_test("/TP/MCN/CB/BV-06-C", test_server,
+			brs_pdu(0x00, 0x11, 0x0e, AVRCP_CHANGE_PATH,
+				0x00, 0x0b,
+				0xaa, 0xbb,		/* counter */
+				0x00,			/* direction */
+				0x00, 0x00, 0x00, 0x00,
+				0x00, 0x00, 0x00, 0x01	/* Folder UID */),
+			brs_pdu(0x02, 0x11, 0x0e, AVRCP_CHANGE_PATH,
+				0x00, 0x05, 0x04, 0x00, 0x00, 0x00, 0x00));
+
 	/* GetItemAttributes - CT */
 	define_test("/TP/MCN/CB/BV-07-C", test_client,
 			raw_pdu(0x00, 0x11, 0x0e, AVRCP_GET_ITEM_ATTRIBUTES,
-- 
1.9.0

