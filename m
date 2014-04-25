Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 35/35] unit/test-avrcp: Add /TP/MCN/NP/BI-02-C test
Date: Fri, 25 Apr 2014 11:39:12 +0300
Message-Id: <1398415152-22950-36-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
References: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

To verify the AddToNowPlaying response issued by the TG when an invalid
UID is requested.
---
 unit/test-avrcp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 2d112c6..3fa4739 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -622,6 +622,9 @@ static int add_to_now_playing(struct avrcp *session, uint8_t transaction,
 {
 	DBG("");
 
+	if (!uid)
+		return -ENOENT;
+
 	avrcp_add_to_now_playing_rsp(session, transaction);
 
 	return -EAGAIN;
@@ -1070,6 +1073,16 @@ int main(int argc, char *argv[])
 			brs_pdu(0x02, 0x11, 0x0e, AVRCP_PLAY_ITEM,
 				0x00, 0x01, 0x09));
 
+	/* AddToNowPlaying - NowPlaying - TG */
+	define_test("/TP/MCN/NP/BI-02-C", test_server,
+			brs_pdu(0x00, 0x11, 0x0e, AVRCP_ADD_TO_NOW_PLAYING,
+				0x00, 0x0b, AVRCP_MEDIA_NOW_PLAYING,
+				0x00, 0x00, 0x00, 0x00,
+				0x00, 0x00, 0x00, 0x00, /* uid */
+				0xaa, 0xbb),		/* counter */
+			brs_pdu(0x02, 0x11, 0x0e, AVRCP_ADD_TO_NOW_PLAYING,
+				0x00, 0x01, 0x09));
+
 	/* Media Player Selection IOP tests */
 
 	/* Listing of available media players */
-- 
1.9.0

