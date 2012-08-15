Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC hcidump 1/8] AVRCP: Add initial support for browsing channel
Date: Wed, 15 Aug 2012 16:32:02 +0300
Message-Id: <1345037529-1828-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 parser/avctp.c  |  4 ++--
 parser/avrcp.c  | 43 ++++++++++++++++++++++++++++++++++++++++---
 parser/l2cap.c  |  3 ++-
 parser/parser.h |  4 ++--
 4 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/parser/avctp.c b/parser/avctp.c
index cf015d4..5d913cf 100644
--- a/parser/avctp.c
+++ b/parser/avctp.c
@@ -50,7 +50,7 @@ static char *pt2str(uint8_t hdr)
 	}
 }
 
-void avctp_dump(int level, struct frame *frm)
+void avctp_dump(int level, struct frame *frm, uint16_t psm)
 {
 	uint8_t hdr;
 	uint16_t pid;
@@ -65,7 +65,7 @@ void avctp_dump(int level, struct frame *frm)
 				pt2str(hdr), hdr & 0x0c, hdr >> 4, pid);
 
 	if (pid == SDP_UUID_AV_REMOTE || pid == SDP_UUID_AV_REMOTE_TARGET)
-		avrcp_dump(level + 1, frm);
+		avrcp_dump(level + 1, frm, psm);
 	else
 		raw_dump(level + 1, frm);
 }
diff --git a/parser/avrcp.c b/parser/avrcp.c
index f25dc34..46efec9 100644
--- a/parser/avrcp.c
+++ b/parser/avrcp.c
@@ -1502,13 +1502,34 @@ static const char *subunit2str(uint8_t subunit)
 	}
 }
 
-void avrcp_dump(int level, struct frame *frm)
+static void avrcp_browsing_dump(int level, struct frame *frm)
+{
+	uint8_t pduid;
+	uint16_t len;
+
+	pduid = get_u8(frm);
+	len = get_u16(frm);
+
+	printf("AVRCP: %s: len 0x%04x\n", pdu2str(pduid), len);
+
+	if (len != frm->len) {
+		p_indent(level, frm);
+		printf("PDU Malformed\n");
+		raw_dump(level, frm);
+		return;
+	}
+
+	switch (pduid) {
+	default:
+		raw_dump(level, frm);
+	}
+}
+
+static void avrcp_control_dump(int level, struct frame *frm)
 {
 	uint8_t ctype, address, subunit, opcode, company[3];
 	int i;
 
-	p_indent(level, frm);
-
 	ctype = get_u8(frm);
 	address = get_u8(frm);
 	opcode = get_u8(frm);
@@ -1557,3 +1578,19 @@ void avrcp_dump(int level, struct frame *frm)
 		raw_dump(level, frm);
 	}
 }
+
+void avrcp_dump(int level, struct frame *frm, uint16_t psm)
+{
+	p_indent(level, frm);
+
+	switch (psm) {
+		case 0x17:
+			avrcp_control_dump(level, frm);
+			break;
+		case 0x1B:
+			avrcp_browsing_dump(level, frm);
+			break;
+		default:
+			raw_dump(level, frm);
+	}
+}
diff --git a/parser/l2cap.c b/parser/l2cap.c
index 8dc825b..a6162d7 100644
--- a/parser/l2cap.c
+++ b/parser/l2cap.c
@@ -1487,8 +1487,9 @@ static void l2cap_parse(int level, struct frame *frm)
 			break;
 
 		case 0x17:
+		case 0x1B:
 			if (!p_filter(FILT_AVCTP))
-				avctp_dump(level, frm);
+				avctp_dump(level, frm, psm);
 			else
 				raw_dump(level + 1, frm);
 			break;
diff --git a/parser/parser.h b/parser/parser.h
index 1130a5f..c712d42 100644
--- a/parser/parser.h
+++ b/parser/parser.h
@@ -233,8 +233,8 @@ void cmtp_dump(int level, struct frame *frm);
 void hidp_dump(int level, struct frame *frm);
 void hcrp_dump(int level, struct frame *frm);
 void avdtp_dump(int level, struct frame *frm);
-void avctp_dump(int level, struct frame *frm);
-void avrcp_dump(int level, struct frame *frm);
+void avctp_dump(int level, struct frame *frm, uint16_t psm);
+void avrcp_dump(int level, struct frame *frm, uint16_t psm);
 void att_dump(int level, struct frame *frm);
 void smp_dump(int level, struct frame *frm);
 void sap_dump(int level, struct frame *frm);
-- 
1.7.11.2

