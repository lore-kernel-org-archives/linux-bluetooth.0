Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump 1/2] AVRCP: Add parsing for SetAbsoluteVolume PDU
Date: Mon, 19 Mar 2012 14:41:31 -0300
Message-Id: <1332178892-8987-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 parser/avrcp.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/parser/avrcp.c b/parser/avrcp.c
index 643e494..d746937 100644
--- a/parser/avrcp.c
+++ b/parser/avrcp.c
@@ -1201,6 +1201,23 @@ response:
 	}
 }
 
+static void avrcp_set_absolut_volume_dump(int level, struct frame *frm,
+						uint8_t ctype, uint16_t len)
+{
+	uint8_t value;
+
+	p_indent(level, frm);
+
+	if (len < 1) {
+		printf("PDU Malformed\n");
+		raw_dump(level, frm);
+		return;
+	}
+
+	value = get_u8(frm);
+	printf("Value: 0x%02x\n", value);
+}
+
 static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
 {
 	uint8_t pduid, pt;
@@ -1267,6 +1284,9 @@ static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
 	case AVRCP_REGISTER_NOTIFICATION:
 		avrcp_register_notification_dump(level + 1, frm, ctype, len);
 		break;
+	case AVRCP_SET_ABSOLUTE_VOLUME:
+		avrcp_set_absolut_volume_dump(level + 1, frm, ctype, len);
+		break;
 	default:
 		raw_dump(level, frm);
 	}
-- 
1.7.7.6

