Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/8] unit/test-avrcp: Add /TP/MPS/BV-05-C test
Date: Wed,  8 Oct 2014 15:31:45 +0300
Message-Id: <1412771509-7996-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412771509-7996-1-git-send-email-luiz.dentz@gmail.com>
References: <1412771509-7996-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Verify the AddressedPlayerChanged Notification issued by the TG and the
procedure associated to this.
---
 unit/test-avrcp.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 146858b..7998976 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -526,6 +526,7 @@ static int register_notification(struct avrcp *session, uint8_t transaction,
 	struct context *context = user_data;
 	uint64_t track;
 	uint8_t settings[3];
+	uint16_t player[2];
 	void *data;
 	size_t len;
 
@@ -551,6 +552,13 @@ static int register_notification(struct avrcp *session, uint8_t transaction,
 		data = settings;
 		len = sizeof(settings);
 		break;
+	case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
+		player[0] = 0x0001;
+		player[1] = 0xabcd;
+
+		data = player;
+		len = sizeof(player);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -885,6 +893,21 @@ int main(int argc, char *argv[])
 				0x46, 0x69, 0x6c, 0x65, 0x73, 0x79,
 				0x73, 0x74, 0x65, 0x6d));
 
+	/* AddressedPlayerChanged notification – TG */
+	define_test("/TP/MPS/BV-05-C", test_server,
+			raw_pdu(0x00, 0x11, 0x0e, 0x03, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICATION,
+				0x00, 0x00, 0x05, 0x0b,
+				0x00, 0x00, 0x00, 0x00),
+			frg_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_INTERIM, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICATION,
+				0x00, 0x00, 0x05, 0x0b,
+				0x00, 0x01, 0xab, 0xcd),
+			raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_CHANGED, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICATION,
+				0x00, 0x00, 0x05, 0x0b,
+				0x01, 0x00, 0xcd, 0xab));
+
 	/* GetFolderItems - CT */
 	define_test("/TP/MPS/BV-08-C", test_client,
 			brs_pdu(0x00, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
-- 
1.9.3

