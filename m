Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump 2/2] AVRCP: Add support for Addressed Player Changed event
Date: Mon, 18 Jun 2012 17:09:23 +0300
Message-Id: <1340028563-8089-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1340028563-8089-1-git-send-email-luiz.dentz@gmail.com>
References: <1340028563-8089-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 parser/avrcp.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/parser/avrcp.c b/parser/avrcp.c
index 0f2f1e6..6fa3742 100644
--- a/parser/avrcp.c
+++ b/parser/avrcp.c
@@ -1107,6 +1107,7 @@ static void avrcp_register_notification_dump(int level, struct frame *frm,
 						uint8_t ctype, uint16_t len)
 {
 	uint8_t event, status;
+	uint16_t uid;
 	uint32_t interval;
 	uint64_t id;
 
@@ -1202,6 +1203,15 @@ response:
 		status = get_u8(frm) & 0x7F;
 		printf("Volume: %.2f%% (%d/127)\n", status/1.27, status);
 		break;
+	case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
+		uid = get_u16(frm);
+		printf("PlayerID: 0x%04x", uid);
+
+		p_indent(level, frm);
+
+		uid = get_u16(frm);
+		printf("UID: 0x%04x", uid);
+		break;
 	}
 }
 
-- 
1.7.10.2

