Return-Path: <cyrus@holtmann.org>
From: Peter Krystad <pkrystad@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: Peter Krystad <pkrystad@codeaurora.org>
Subject: [PATCH v2 hcidump 3/5] Add parsing of L2CAP Create/Move Channel signals
Date: Wed,  2 Nov 2011 17:56:55 -0700
Message-Id: <1320281817-359-4-git-send-email-pkrystad@codeaurora.org>
In-Reply-To: <1320281817-359-1-git-send-email-pkrystad@codeaurora.org>
References: <1320281817-359-1-git-send-email-pkrystad@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 parser/l2cap.c |   97 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 97 insertions(+), 0 deletions(-)

diff --git a/parser/l2cap.c b/parser/l2cap.c
index 696456a..1a4c288 100644
--- a/parser/l2cap.c
+++ b/parser/l2cap.c
@@ -409,6 +409,7 @@ static char *supervisory2str(uint8_t supervisory)
 	}
 }
 
+
 static inline void command_rej(int level, struct frame *frm)
 {
 	l2cap_cmd_rej *h = frm->ptr;
@@ -868,6 +869,78 @@ static void l2cap_ctrl_parse(int level, struct frame *frm, uint32_t ctrl)
 		printf(" F-bit");
 }
 
+static inline void create_req(int level, l2cap_cmd_hdr *cmd, struct frame *frm)
+{
+	l2cap_create_req *h = frm->ptr;
+	uint16_t psm = btohs(h->psm);
+	uint16_t scid = btohs(h->scid);
+
+	if (p_filter(FILT_L2CAP))
+		return;
+
+	printf("Create req: psm %d scid 0x%4.4x id %d\n", psm, scid, h->id);
+}
+
+static inline void create_rsp(int level, l2cap_cmd_hdr *cmd, struct frame *frm)
+{
+	l2cap_create_rsp *h = frm->ptr;
+	uint16_t scid = btohs(h->scid);
+	uint16_t dcid = btohs(h->dcid);
+	uint16_t result = btohs(h->result);
+	uint16_t status = btohs(h->status);
+
+	if (p_filter(FILT_L2CAP))
+		return;
+
+	printf("Create rsp: dcid 0x%4.4x scid 0x%4.4x result %d status %d\n", dcid, scid, result, status);
+}
+
+static inline void move_req(int level, l2cap_cmd_hdr *cmd, struct frame *frm)
+{
+	l2cap_move_req *h = frm->ptr;
+	uint16_t icid = btohs(h->icid);
+
+	if (p_filter(FILT_L2CAP))
+		return;
+
+	printf("Move req: icid 0x%4.4x id %d\n", icid, h->id);
+}
+
+static inline void move_rsp(int level, l2cap_cmd_hdr *cmd, struct frame *frm)
+{
+	l2cap_move_rsp *h = frm->ptr;
+	uint16_t icid = btohs(h->icid);
+	uint16_t result = btohs(h->result);
+
+	if (p_filter(FILT_L2CAP))
+		return;
+
+	printf("Move rsp: icid 0x%4.4x result %d\n", icid, result);
+}
+
+static inline void move_cfm(int level, l2cap_cmd_hdr *cmd, struct frame *frm)
+{
+	l2cap_move_cfm *h = frm->ptr;
+	uint16_t icid = btohs(h->icid);
+	uint16_t result = btohs(h->result);
+
+	if (p_filter(FILT_L2CAP))
+		return;
+
+	printf("Move cfm: icid 0x%4.4x result %d\n", icid, result);
+}
+
+static inline void move_cfm_rsp(int level, l2cap_cmd_hdr *cmd, struct frame *frm)
+{
+	l2cap_move_cfm_rsp *h = frm->ptr;
+	uint16_t icid = btohs(h->icid);
+
+	if (p_filter(FILT_L2CAP))
+		return;
+
+	printf("Move cfm rsp: icid 0x%4.4x\n", icid);
+}
+
 static void l2cap_parse(int level, struct frame *frm)
 {
 	l2cap_hdr *hdr = (void *)frm->ptr;
@@ -937,6 +1010,30 @@ static void l2cap_parse(int level, struct frame *frm)
 				info_rsp(level, hdr, frm);
 				break;
 
+			case L2CAP_CREATE_REQ:
+				create_req(level, hdr, frm);
+				break;
+
+			case L2CAP_CREATE_RSP:
+				create_rsp(level, hdr, frm);
+				break;
+
+			case L2CAP_MOVE_REQ:
+				move_req(level, hdr, frm);
+				break;
+
+			case L2CAP_MOVE_RSP:
+				move_rsp(level, hdr, frm);
+				break;
+
+			case L2CAP_MOVE_CFM:
+				move_cfm(level, hdr, frm);
+				break;
+
+			case L2CAP_MOVE_CFM_RSP:
+				move_cfm_rsp(level, hdr, frm);
+				break;
+
 			default:
 				if (p_filter(FILT_L2CAP))
 					break;
-- 
1.7.7

--
Peter Krystad
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
