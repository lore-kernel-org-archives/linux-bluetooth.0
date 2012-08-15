Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC hcidump 2/8] AVRCP: Fix parsing SetBrowsedPlayer as AV/C pdu
Date: Wed, 15 Aug 2012 16:32:03 +0300
Message-Id: <1345037529-1828-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1345037529-1828-1-git-send-email-luiz.dentz@gmail.com>
References: <1345037529-1828-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

As per AVRCP specification 1.4 page 32 the command type of
SetBrowsedPlayer is Browsing, so move it to browsing channel.

In addition to that pass the avctp header to avrcp_dump as it is
required to identify if the frame is a command or response.
---
 parser/avctp.c  |  2 +-
 parser/avrcp.c  | 18 +++++++++---------
 parser/parser.h |  2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/parser/avctp.c b/parser/avctp.c
index 5d913cf..aca1b75 100644
--- a/parser/avctp.c
+++ b/parser/avctp.c
@@ -65,7 +65,7 @@ void avctp_dump(int level, struct frame *frm, uint16_t psm)
 				pt2str(hdr), hdr & 0x0c, hdr >> 4, pid);
 
 	if (pid == SDP_UUID_AV_REMOTE || pid == SDP_UUID_AV_REMOTE_TARGET)
-		avrcp_dump(level + 1, frm, psm);
+		avrcp_dump(level + 1, frm, hdr, psm);
 	else
 		raw_dump(level + 1, frm);
 }
diff --git a/parser/avrcp.c b/parser/avrcp.c
index 46efec9..5179501 100644
--- a/parser/avrcp.c
+++ b/parser/avrcp.c
@@ -1264,8 +1264,8 @@ response:
 	printf("Status: 0x%02x (%s)\n", status, error2str(status));
 }
 
-static void avrcp_set_browsed_player(int level, struct frame *frm,
-						uint8_t ctype, uint16_t len)
+static void avrcp_set_browsed_player_dump(int level, struct frame *frm,
+						uint8_t hdr, uint16_t len)
 {
 	uint32_t items;
 	uint16_t id, uids, charset;
@@ -1273,7 +1273,7 @@ static void avrcp_set_browsed_player(int level, struct frame *frm,
 
 	p_indent(level, frm);
 
-	if (ctype > AVC_CTYPE_GENERAL_INQUIRY)
+	if (hdr & 0x02)
 		goto response;
 
 	if (len < 2) {
@@ -1406,9 +1406,6 @@ static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
 	case AVRCP_SET_ADDRESSED_PLAYER:
 		avrcp_set_addressed_player(level + 1, frm, ctype, len);
 		break;
-	case AVRCP_SET_BROWSED_PLAYER:
-		avrcp_set_browsed_player(level + 1, frm, ctype, len);
-		break;
 	default:
 		raw_dump(level, frm);
 	}
@@ -1502,7 +1499,7 @@ static const char *subunit2str(uint8_t subunit)
 	}
 }
 
-static void avrcp_browsing_dump(int level, struct frame *frm)
+static void avrcp_browsing_dump(int level, struct frame *frm, uint8_t hdr)
 {
 	uint8_t pduid;
 	uint16_t len;
@@ -1520,6 +1517,9 @@ static void avrcp_browsing_dump(int level, struct frame *frm)
 	}
 
 	switch (pduid) {
+	case AVRCP_SET_BROWSED_PLAYER:
+		avrcp_set_browsed_player_dump(level + 1, frm, hdr, len);
+		break;
 	default:
 		raw_dump(level, frm);
 	}
@@ -1579,7 +1579,7 @@ static void avrcp_control_dump(int level, struct frame *frm)
 	}
 }
 
-void avrcp_dump(int level, struct frame *frm, uint16_t psm)
+void avrcp_dump(int level, struct frame *frm, uint8_t hdr, uint16_t psm)
 {
 	p_indent(level, frm);
 
@@ -1588,7 +1588,7 @@ void avrcp_dump(int level, struct frame *frm, uint16_t psm)
 			avrcp_control_dump(level, frm);
 			break;
 		case 0x1B:
-			avrcp_browsing_dump(level, frm);
+			avrcp_browsing_dump(level, frm, hdr);
 			break;
 		default:
 			raw_dump(level, frm);
diff --git a/parser/parser.h b/parser/parser.h
index c712d42..f8f7009 100644
--- a/parser/parser.h
+++ b/parser/parser.h
@@ -234,7 +234,7 @@ void hidp_dump(int level, struct frame *frm);
 void hcrp_dump(int level, struct frame *frm);
 void avdtp_dump(int level, struct frame *frm);
 void avctp_dump(int level, struct frame *frm, uint16_t psm);
-void avrcp_dump(int level, struct frame *frm, uint16_t psm);
+void avrcp_dump(int level, struct frame *frm, uint8_t hdr, uint16_t psm);
 void att_dump(int level, struct frame *frm);
 void smp_dump(int level, struct frame *frm);
 void sap_dump(int level, struct frame *frm);
-- 
1.7.11.2

