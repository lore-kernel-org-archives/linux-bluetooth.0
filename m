Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/8] unit/test-avrcp: Add /TP/MPS/BV-07-C test
Date: Wed,  8 Oct 2014 15:31:47 +0300
Message-Id: <1412771509-7996-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412771509-7996-1-git-send-email-luiz.dentz@gmail.com>
References: <1412771509-7996-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Verify the AvailablePlayersChanged Notification issued by the TG.
---
 unit/test-avrcp.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 72e75c3..a0cb685 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -552,6 +552,10 @@ static int register_notification(struct avrcp *session, uint8_t transaction,
 		data = settings;
 		len = sizeof(settings);
 		break;
+	case AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED:
+		data = NULL;
+		len = 0;
+		break;
 	case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
 		player[0] = 0x0001;
 		player[1] = 0xabcd;
@@ -940,6 +944,19 @@ int main(int argc, char *argv[])
 			brs_pdu(0x02, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
 				0x00, 0x05, 0x04, 0xab, 0xcd, 0x00, 0x00));
 
+	/* AvailablePlayersChanged Notification – TG */
+	define_test("/TP/MPS/BV-07-C", test_server,
+			raw_pdu(0x00, 0x11, 0x0e, 0x03, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICATION,
+				0x00, 0x00, 0x05, 0x0a,
+				0x00, 0x00, 0x00, 0x00),
+			frg_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_INTERIM, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICATION,
+				0x00, 0x00, 0x01, 0x0a),
+			raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_CHANGED, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICATION,
+				0x00, 0x00, 0x01, 0x0a));
+
 	/* GetFolderItems - CT */
 	define_test("/TP/MPS/BV-08-C", test_client,
 			brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
-- 
1.9.3

