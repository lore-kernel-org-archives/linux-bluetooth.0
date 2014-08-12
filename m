Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH v2 2/6] monitor: Add AV/C commands related macros and helper
 functions
Date: Tue, 12 Aug 2014 17:24:16 +0530
Message-id: <1407844460-11497-2-git-send-email-vikram.pal@samsung.com>
In-reply-to: <1407844460-11497-1-git-send-email-vikram.pal@samsung.com>
References: <1407844460-11497-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added AV/C commands related stuffs such as macros and helper
functions in Bluetooth monitor.
---
 monitor/avctp.c | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 108 insertions(+), 3 deletions(-)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index 36befab..fb780a4 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -43,19 +43,124 @@
 #include "sdp.h"
 #include "avctp.h"
 
+/* ctype entries */
+#define AVC_CTYPE_CONTROL		0x0
+#define AVC_CTYPE_STATUS		0x1
+#define AVC_CTYPE_SPECIFIC_INQUIRY	0x2
+#define AVC_CTYPE_NOTIFY		0x3
+#define AVC_CTYPE_GENERAL_INQUIRY	0x4
+#define AVC_CTYPE_NOT_IMPLEMENTED	0x8
+#define AVC_CTYPE_ACCEPTED		0x9
+#define AVC_CTYPE_REJECTED		0xA
+#define AVC_CTYPE_IN_TRANSITION		0xB
+#define AVC_CTYPE_STABLE		0xC
+#define AVC_CTYPE_CHANGED		0xD
+#define AVC_CTYPE_INTERIM		0xF
+
+/* subunit type */
+#define AVC_SUBUNIT_MONITOR		0x00
+#define AVC_SUBUNIT_AUDIO		0x01
+#define AVC_SUBUNIT_PRINTER		0x02
+#define AVC_SUBUNIT_DISC		0x03
+#define AVC_SUBUNIT_TAPE		0x04
+#define AVC_SUBUNIT_TURNER		0x05
+#define AVC_SUBUNIT_CA			0x06
+#define AVC_SUBUNIT_CAMERA		0x07
+#define AVC_SUBUNIT_PANEL		0x09
+#define AVC_SUBUNIT_BULLETIN_BOARD	0x0a
+#define AVC_SUBUNIT_CAMERA_STORAGE	0x0b
+#define AVC_SUBUNIT_VENDOR_UNIQUE	0x0c
+#define AVC_SUBUNIT_EXTENDED		0x1e
+#define AVC_SUBUNIT_UNIT		0x1f
+
+/* opcodes */
+#define AVC_OP_VENDORDEP		0x00
+#define AVC_OP_UNITINFO			0x30
+#define AVC_OP_SUBUNITINFO		0x31
+#define AVC_OP_PASSTHROUGH		0x7c
+
 static const char *ctype2str(uint8_t ctype)
 {
-	return "Unknown";
+	switch (ctype & 0x0f) {
+	case AVC_CTYPE_CONTROL:
+		return "Control";
+	case AVC_CTYPE_STATUS:
+		return "Status";
+	case AVC_CTYPE_SPECIFIC_INQUIRY:
+		return "Specific Inquiry";
+	case AVC_CTYPE_NOTIFY:
+		return "Notify";
+	case AVC_CTYPE_GENERAL_INQUIRY:
+		return "General Inquiry";
+	case AVC_CTYPE_NOT_IMPLEMENTED:
+		return "Not Implemented";
+	case AVC_CTYPE_ACCEPTED:
+		return "Accepted";
+	case AVC_CTYPE_REJECTED:
+		return "Rejected";
+	case AVC_CTYPE_IN_TRANSITION:
+		return "In Transition";
+	case AVC_CTYPE_STABLE:
+		return "Stable";
+	case AVC_CTYPE_CHANGED:
+		return "Changed";
+	case AVC_CTYPE_INTERIM:
+		return "Interim";
+	default:
+		return "Unknown";
+	}
 }
 
 static const char *subunit2str(uint8_t subunit)
 {
-	return "Reserved";
+	switch (subunit) {
+	case AVC_SUBUNIT_MONITOR:
+		return "Monitor";
+	case AVC_SUBUNIT_AUDIO:
+		return "Audio";
+	case AVC_SUBUNIT_PRINTER:
+		return "Printer";
+	case AVC_SUBUNIT_DISC:
+		return "Disc";
+	case AVC_SUBUNIT_TAPE:
+		return "Tape";
+	case AVC_SUBUNIT_TURNER:
+		return "Turner";
+	case AVC_SUBUNIT_CA:
+		return "CA";
+	case AVC_SUBUNIT_CAMERA:
+		return "Camera";
+	case AVC_SUBUNIT_PANEL:
+		return "Panel";
+	case AVC_SUBUNIT_BULLETIN_BOARD:
+		return "Bulleting Board";
+	case AVC_SUBUNIT_CAMERA_STORAGE:
+		return "Camera Storage";
+	case AVC_SUBUNIT_VENDOR_UNIQUE:
+		return "Vendor Unique";
+	case AVC_SUBUNIT_EXTENDED:
+		return "Extended to next byte";
+	case AVC_SUBUNIT_UNIT:
+		return "Unit";
+	default:
+		return "Reserved";
+	}
 }
 
 static const char *opcode2str(uint8_t opcode)
 {
-	return "Unknown";
+	switch (opcode) {
+	case AVC_OP_VENDORDEP:
+		return "Vendor Dependent";
+	case AVC_OP_UNITINFO:
+		return "Unit Info";
+	case AVC_OP_SUBUNITINFO:
+		return "Subunit Info";
+	case AVC_OP_PASSTHROUGH:
+		return "Passthrough";
+	default:
+		return "Unknown";
+	}
 }
 
 static void avrcp_passthrough_packet(const struct l2cap_frame *frame)
-- 
1.9.1

