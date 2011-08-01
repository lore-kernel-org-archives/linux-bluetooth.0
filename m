Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump 10/13] Add parsing for AVRCP InformBatteryStatusOfCT pdu
Date: Mon,  1 Aug 2011 11:42:15 +0300
Message-Id: <1312188138-32265-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1312188138-32265-1-git-send-email-luiz.dentz@gmail.com>
References: <1312188138-32265-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 parser/avrcp.c |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/parser/avrcp.c b/parser/avrcp.c
index ababe03..bb7bcbb 100644
--- a/parser/avrcp.c
+++ b/parser/avrcp.c
@@ -847,6 +847,38 @@ static void avrcp_displayable_charset(int level, struct frame *frm,
 	}
 }
 
+static const char *status2str(uint8_t status)
+{
+	switch (status) {
+	case 0x0:
+		return "NORMAL";
+	case 0x1:
+		return "WARNING";
+	case 0x2:
+		return "CRITICAL";
+	case 0x3:
+		return "EXTERNAL";
+	case 0x4:
+		return "FULL_CHARGE";
+	default:
+		return "Reserved";
+	}
+}
+
+static void avrcp_ct_battery_status_dump(int level, struct frame *frm,
+						uint8_t ctype, uint16_t len)
+{
+	uint8_t status;
+
+	if (ctype > AVC_CTYPE_GENERAL_INQUIRY)
+		return;
+
+	p_indent(level, frm);
+
+	status = get_u8(frm);
+	printf("BatteryStatus: 0x%02x (%s)\n", status, status2str(status));
+}
+
 static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
 {
 	uint8_t pduid, pt;
@@ -902,6 +934,9 @@ static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
 	case AVRCP_DISPLAYABLE_CHARSET:
 		avrcp_displayable_charset(level + 1, frm, ctype, len);
 		break;
+	case AVRCP_CT_BATTERY_STATUS:
+		avrcp_ct_battery_status_dump(level + 1, frm, ctype, len);
+		break;
 	default:
 		raw_dump(level, frm);
 	}
-- 
1.7.6

