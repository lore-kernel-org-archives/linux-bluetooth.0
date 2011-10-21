Return-Path: <cyrus@holtmann.org>
From: Peter Krystad <pkrystad@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: andrei.emeltchenko@intel.com,
	Peter Krystad <pkrystad@codeaurora.org>
Subject: [PATCH 1/4] Add parsing of L2CAP Create/Move Channel signals
Date: Fri, 21 Oct 2011 16:29:59 -0700
Message-Id: <1319239802-22457-2-git-send-email-pkrystad@codeaurora.org>
In-Reply-To: <1319239802-22457-1-git-send-email-pkrystad@codeaurora.org>
References: <1319239802-22457-1-git-send-email-pkrystad@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add parsing of L2CAP Create/Move Channel signalling.
Example output:

2011-10-18 16:09:47.810208 > ACL data: handle 39 flags 0x02 dlen 13
    L2CAP(s): Create req: psm 4097 scid 0x4201 id 17
2011-10-18 16:09:47.810269 < ACL data: handle 39 flags 0x00 dlen 16
    L2CAP(s): Create rsp: dcid 0x0040 scid 0x4201 result 1 status 0
2011-10-18 16:09:47.898308 < ACL data: handle 39 flags 0x00 dlen 16
    L2CAP(s): Create rsp: dcid 0x0040 scid 0x4201 result 0 status 0

....

2011-10-18 14:25:24.646869 > ACL data: handle 39 flags 0x02 dlen 11
    L2CAP(s): Move req: icid 0x4000 id 17
2011-10-18 14:25:24.646987 < ACL data: handle 39 flags 0x00 dlen 12
    L2CAP(s): Move rsp: icid 0x4000 result 1
2011-10-18 14:25:24.846873 < ACL data: handle 39 flags 0x00 dlen 12
    L2CAP(s): Move rsp: icid 0x4000 result 0
2011-10-18 14:25:25.041844 > ACL data: handle 39 flags 0x02 dlen 12
    L2CAP(s): Move cfm: icid 0x4000 result 0
2011-10-18 14:25:25.041945 < ACL data: handle 39 flags 0x00 dlen 10
    L2CAP(s): Move cfm rsp: icid 0x4000
---
 lib/l2cap.h    |   50 +++++++++++++++++++++++++++++
 parser/l2cap.c |   97 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 147 insertions(+), 0 deletions(-)

diff --git a/lib/l2cap.h b/lib/l2cap.h
index 3880551..b970a6e 100644
--- a/lib/l2cap.h
+++ b/lib/l2cap.h
@@ -82,6 +82,12 @@ struct l2cap_conninfo {
 #define L2CAP_ECHO_RSP		0x09
 #define L2CAP_INFO_REQ		0x0a
 #define L2CAP_INFO_RSP		0x0b
+#define L2CAP_CREATE_REQ	0x0c
+#define L2CAP_CREATE_RSP	0x0d
+#define L2CAP_MOVE_REQ		0x0e
+#define L2CAP_MOVE_RSP		0x0f
+#define L2CAP_MOVE_CFM		0x10
+#define L2CAP_MOVE_CFM_RSP	0x11
 
 /* L2CAP extended feature mask */
 #define L2CAP_FEAT_FLOWCTL	0x00000001
@@ -270,6 +276,50 @@ typedef struct {
 #define L2CAP_IR_SUCCESS	0x0000
 #define L2CAP_IR_NOTSUPP	0x0001
 
+typedef struct {
+	uint16_t	psm;
+	uint16_t	scid;
+	uint8_t		id;
+} __attribute__ ((packed)) l2cap_create_req;
+#define L2CAP_CREATE_REQ_SIZE 5
+
+typedef struct {
+	uint16_t	dcid;
+	uint16_t	scid;
+	uint16_t	result;
+	uint16_t	status;
+} __attribute__ ((packed)) l2cap_create_rsp;
+#define L2CAP_CREATE_RSP_SIZE 8
+
+typedef struct {
+	uint16_t	icid;
+	uint8_t		id;
+} __attribute__ ((packed)) l2cap_move_req;
+#define L2CAP_MOVE_REQ_SIZE 3
+
+typedef struct {
+	uint16_t	icid;
+	uint16_t	result;
+} __attribute__ ((packed)) l2cap_move_rsp;
+#define L2CAP_MOVE_RSP_SIZE 4
+
+typedef struct {
+	uint16_t	icid;
+	uint16_t	result;
+} __attribute__ ((packed)) l2cap_move_cfm;
+#define L2CAP_MOVE_CFM_SIZE 4
+
+typedef struct {
+	uint16_t	icid;
+} __attribute__ ((packed)) l2cap_move_cfm_rsp;
+#define L2CAP_MOVE_CFM_RSP_SIZE 2
+
+/* info type */
+#define L2CAP_IT_CL_MTU		0x0001
+#define L2CAP_IT_FEAT_MASK	0x0002
+
+/* info result */
+#define L2CAP_IR_SUCCESS	0x0000
 #ifdef __cplusplus
 }
 #endif
diff --git a/parser/l2cap.c b/parser/l2cap.c
index 6a5a4b2..7547e8b 100644
--- a/parser/l2cap.c
+++ b/parser/l2cap.c
@@ -399,6 +399,7 @@ static char *supervisory2str(uint8_t supervisory)
 	}
 }
 
+
 static inline void command_rej(int level, struct frame *frm)
 {
 	l2cap_cmd_rej *h = frm->ptr;
@@ -850,6 +851,78 @@ static void l2cap_ctrl_parse(int level, struct frame *frm, uint32_t ctrl)
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
@@ -919,6 +992,30 @@ static void l2cap_parse(int level, struct frame *frm)
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
