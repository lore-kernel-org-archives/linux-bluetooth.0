Return-Path: <cyrus@holtmann.org>
From: Peter Krystad <pkrystad@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, Peter Krystad <pkrystad@codeaurora.org>
Subject: [PATCH v5 4/5] Add parsing of A2MP signals
Date: Mon,  5 Mar 2012 16:35:50 -0800
Message-Id: <1330994151-488-5-git-send-email-pkrystad@codeaurora.org>
In-Reply-To: <1330994151-488-1-git-send-email-pkrystad@codeaurora.org>
References: <1330994151-488-1-git-send-email-pkrystad@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 parser/l2cap.c  |  354 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 parser/parser.h |    1 +
 src/hcidump.c   |    1 +
 3 files changed, 356 insertions(+), 0 deletions(-)

diff --git a/parser/l2cap.c b/parser/l2cap.c
index 39e29a0..69383e6 100644
--- a/parser/l2cap.c
+++ b/parser/l2cap.c
@@ -37,6 +37,7 @@
 #include "parser/sdp.h"
 #include "lib/hci.h"
 #include "lib/l2cap.h"
+#include "lib/a2mp.h"
 
 typedef struct {
 	uint16_t handle;
@@ -269,6 +270,16 @@ static char *reason2str(uint16_t reason)
 	}
 }
 
+static char *a2mpreason2str(uint16_t reason)
+{
+	switch (reason) {
+	case A2MP_COMMAND_NOT_RECOGNIZED:
+		return "Command not recognized";
+	default:
+		return "Reserved";
+	}
+}
+
 static char *connresult2str(uint16_t result)
 {
 	switch (result) {
@@ -409,6 +420,89 @@ static char *supervisory2str(uint8_t supervisory)
 	}
 }
 
+static char *ampctrltype2str(uint8_t type)
+{
+	switch (type) {
+	case HCI_BREDR:
+		return "BR-EDR";
+	case HCI_AMP:
+		return "802.11 AMP";
+	default:
+		return "Reserved";
+	}
+}
+
+static char *ampctrlstatus2str(uint8_t status)
+{
+	switch (status) {
+	case AMP_CTRL_POWERED_DOWN:
+		return "Powered down";
+	case AMP_CTRL_BLUETOOTH_ONLY:
+		return "Bluetooth only";
+	case AMP_CTRL_NO_CAPACITY:
+		return "No capacity";
+	case AMP_CTRL_LOW_CAPACITY:
+		return "Low capacity";
+	case AMP_CTRL_MEDIUM_CAPACITY:
+		return "Medium capacity";
+	case AMP_CTRL_HIGH_CAPACITY:
+		return "High capacity";
+	case AMP_CTRL_FULL_CAPACITY:
+		return "Full capacity";
+	default:
+		return "Reserved";
+
+	}
+}
+
+static char *a2mpstatus2str(uint8_t status)
+{
+	switch (status) {
+	case A2MP_STATUS_SUCCESS:
+		return "Success";
+	case A2MP_STATUS_INVALID_CTRL_ID:
+		return "Invalid Controller ID";
+	default:
+		return "Reserved";
+	}
+}
+
+static char *a2mpcplstatus2str(uint8_t status)
+{
+	switch (status) {
+	case A2MP_STATUS_SUCCESS:
+		return "Success";
+	case A2MP_STATUS_INVALID_CTRL_ID:
+		return "Invalid Controller ID";
+	case A2MP_STATUS_UNABLE_START_LINK_CREATION:
+		return "Failed - Unable to start link creation";
+	case A2MP_STATUS_COLLISION_OCCURED:
+		return "Failed - Collision occured";
+	case A2MP_STATUS_DISCONN_REQ_RECVD:
+		return "Failed - Disconnect physical link received";
+	case A2MP_STATUS_PHYS_LINK_EXISTS:
+		return "Failed - Physical link already exists";
+	case A2MP_STATUS_SECURITY_VIOLATION:
+		return "Failed - Security violation";
+	default:
+		return "Reserved";
+	}
+}
+
+static char *a2mpdplstatus2str(uint8_t status)
+{
+	switch (status) {
+	case A2MP_STATUS_SUCCESS:
+		return "Success";
+	case A2MP_STATUS_INVALID_CTRL_ID:
+		return "Invalid Controller ID";
+	case A2MP_STATUS_NO_PHYSICAL_LINK_EXISTS:
+		return "Failed - No Physical Link exists";
+	default:
+		return "Reserved";
+	}
+}
+
 static inline void command_rej(int level, struct frame *frm)
 {
 	l2cap_cmd_rej *h = frm->ptr;
@@ -940,6 +1034,196 @@ static inline void move_cfm_rsp(int level, l2cap_cmd_hdr *cmd, struct frame *frm
 	printf("Move cfm rsp: icid 0x%4.4x\n", icid);
 }
 
+static inline void a2mp_command_rej(int level, struct frame *frm)
+{
+	struct a2mp_command_rej *h = frm->ptr;
+	uint16_t reason = btohs(h->reason);
+
+	printf("Command Reject: reason %d\n", reason);
+	p_indent(level + 1, 0);
+	printf("%s\n", a2mpreason2str(reason));
+}
+
+static inline void a2mp_discover_req(int level, struct frame *frm, uint16_t len)
+{
+	struct a2mp_discover_req *h = frm->ptr;
+	uint16_t mtu = btohs(h->mtu);
+	uint8_t	 *octet = (uint8_t *)&(h->mask);
+	uint16_t mask;
+	uint8_t  extension;
+
+	printf("Discover req: mtu/mps %d ", mtu);
+	len -= 2;
+
+	printf("mask:");
+
+	do {
+		len -= 2;
+		mask = btohs(*(uint16_t *)(&octet[0]));
+		printf(" 0x%4.4x", mask);
+
+		extension = octet[1] & 0x80;
+		octet += 2;
+	} while ((extension != 0) && (len >= 2));
+
+	printf("\n");
+}
+
+static inline void a2mp_ctrl_list_dump(int level, struct a2mp_ctrl *list, uint16_t len)
+{
+	p_indent(level, 0);
+	printf("Controller list:\n");
+
+	while (len >= 3) {
+		p_indent(level + 1, 0);
+		printf("id %d type %d (%s) status 0x%2.2x (%s)\n",
+			   list->id, list->type, ampctrltype2str(list->type), list->status, ampctrlstatus2str(list->status));
+		list++;
+		len -= 3;
+	}
+
+}
+
+static inline void a2mp_discover_rsp(int level, struct frame *frm, uint16_t len)
+{
+	struct a2mp_discover_rsp *h = frm->ptr;
+	uint16_t mtu = btohs(h->mtu);
+	uint8_t	 *octet = (uint8_t *)&(h->mask);
+	uint16_t mask;
+	uint8_t  extension;
+
+	printf("Discover rsp: mtu/mps %d ", mtu);
+	len -= 2;
+
+	printf("mask:");
+
+	do {
+		len -= 2;
+		mask = btohs(*(uint16_t *)(&octet[0]));
+		printf(" 0x%4.4x", mask);
+
+		extension = octet[1] & 0x80;
+		octet += 2;
+	} while ((extension != 0) && (len >= 2));
+
+	printf("\n");
+
+	if (len >= 3) {
+		a2mp_ctrl_list_dump(level + 1, (struct a2mp_ctrl *) octet, len);
+	}
+}
+
+static inline void a2mp_change_notify(int level, struct frame *frm, uint16_t len)
+{
+	struct a2mp_ctrl *list = frm->ptr;
+
+	printf("Change Notify\n");
+
+	if (len >= 3) {
+		a2mp_ctrl_list_dump(level + 1, list, len);
+	}
+}
+
+static inline void a2mp_change_rsp(int level, struct frame *frm)
+{
+	printf("Change Response\n");
+}
+
+static inline void a2mp_info_req(int level, struct frame *frm)
+{
+	struct a2mp_info_req *h = frm->ptr;
+
+	printf("Get Info req: id %d\n", h->id);
+}
+
+static inline void a2mp_info_rsp(int level, struct frame *frm)
+{
+	struct a2mp_info_rsp *h = frm->ptr;
+
+	printf("Get Info rsp: id %d status %d (%s)\n",
+		   h->id, h->status, a2mpstatus2str(h->status));
+
+	p_indent(level + 1, 0);
+	printf("Total bandwidth %d\n", btohl(h->total_bw));
+	p_indent(level + 1, 0);
+	printf("Max guaranteed bandwidth %d\n", btohl(h->max_bw));
+	p_indent(level + 1, 0);
+	printf("Min latency %d\n", btohl(h->min_latency));
+	p_indent(level + 1, 0);
+	printf("Pal capabilities 0x%4.4x\n", btohs(h->pal_caps));
+	p_indent(level + 1, 0);
+	printf("Assoc size %d\n", btohs(h->assoc_size));
+}
+
+static inline void a2mp_assoc_req(int level, struct frame *frm)
+{
+	struct a2mp_assoc_req *h = frm->ptr;
+
+	printf("Get AMP Assoc req: id %d\n", h->id);
+}
+
+static inline void a2mp_assoc_dump(int level, uint8_t *assoc, uint16_t len)
+{
+	int i;
+
+	p_indent(level, 0);
+	printf("Assoc data:");
+	for (i = 0; i < len; i++) {
+		if (!(i%16)) {
+			printf("\n");
+			p_indent(level+1, 0);
+		}
+		printf("%2.2x ",*assoc++);
+	}
+	printf("\n");
+}
+
+static inline void a2mp_assoc_rsp(int level, struct frame *frm, uint16_t len)
+{
+	struct a2mp_assoc_rsp *h = frm->ptr;
+
+	printf("Get AMP Assoc rsp: id %d status (%d) %s \n",
+		   h->id, h->status, a2mpstatus2str(h->status));
+	a2mp_assoc_dump(level + 1, (uint8_t *) &h->assoc_data, len - 2);
+}
+
+static inline void a2mp_create_req(int level, struct frame *frm, uint16_t len)
+{
+	struct a2mp_create_req *h = frm->ptr;
+
+	printf("Create Physical Link req: local id %d remote id %d\n",
+		   h->local_id, h->remote_id);
+	a2mp_assoc_dump(level + 1, (uint8_t *) &h->assoc_data, len - 2);
+}
+
+static inline void a2mp_create_rsp(int level, struct frame *frm)
+{
+	struct a2mp_create_rsp *h = frm->ptr;
+
+	printf("Create Physical Link rsp: local id %d remote id %d status %d\n",
+		   h->local_id, h->remote_id, h->status);
+	p_indent(level+1, 0);
+	printf("%s\n", a2mpcplstatus2str(h->status));
+}
+
+static inline void a2mp_disconn_req(int level, struct frame *frm)
+{
+	struct a2mp_disconn_req *h = frm->ptr;
+
+	printf("Disconnect Physical Link req: local id %d remote id %d\n",
+		   h->local_id, h->remote_id);
+}
+
+static inline void a2mp_disconn_rsp(int level, struct frame *frm)
+{
+	struct a2mp_disconn_rsp *h = frm->ptr;
+
+	printf("Disconnect Physical Link rsp: local id %d remote id %d status %d\n",
+		   h->local_id, h->remote_id, h->status);
+	p_indent(level+1, 0);
+	printf("%s\n", a2mpdplstatus2str(h->status));
+}
+
 static void l2cap_parse(int level, struct frame *frm)
 {
 	l2cap_hdr *hdr = (void *)frm->ptr;
@@ -1060,6 +1344,76 @@ static void l2cap_parse(int level, struct frame *frm)
 		p_indent(level, frm);
 		printf("L2CAP(c): len %d psm %d\n", dlen, psm);
 		raw_dump(level, frm);
+	} else if (cid == 0x3) {
+		/* AMP Manager channel */
+
+		if (p_filter(FILT_A2MP))
+			return;
+
+		/* Adjust for ERTM control bytes */
+		frm->ptr += 2;
+		frm->len -= 2;
+
+		while (frm->len >= A2MP_HDR_SIZE) {
+			struct a2mp_hdr *hdr = frm->ptr;
+
+			frm->ptr += A2MP_HDR_SIZE;
+			frm->len -= A2MP_HDR_SIZE;
+
+			p_indent(level, frm);
+			printf("A2MP: ");
+
+			switch (hdr->code) {
+			case A2MP_COMMAND_REJ:
+				a2mp_command_rej(level, frm);
+				break;
+			case A2MP_DISCOVER_REQ:
+				a2mp_discover_req(level, frm, btohs(hdr->len));
+				break;
+			case A2MP_DISCOVER_RSP:
+				a2mp_discover_rsp(level, frm, btohs(hdr->len));
+				break;
+			case A2MP_CHANGE_NOTIFY:
+				a2mp_change_notify(level, frm, btohs(hdr->len));
+				break;
+			case A2MP_CHANGE_RSP:
+				a2mp_change_rsp(level, frm);
+				break;
+			case A2MP_INFO_REQ:
+				a2mp_info_req(level, frm);
+				break;
+			case A2MP_INFO_RSP:
+				a2mp_info_rsp(level, frm);
+				break;
+			case A2MP_ASSOC_REQ:
+				a2mp_assoc_req(level, frm);
+				break;
+			case A2MP_ASSOC_RSP:
+				a2mp_assoc_rsp(level, frm, btohs(hdr->len));
+				break;
+			case A2MP_CREATE_REQ:
+				a2mp_create_req(level, frm, btohs(hdr->len));
+				break;
+			case A2MP_CREATE_RSP:
+				a2mp_create_rsp(level, frm);
+				break;
+			case A2MP_DISCONN_REQ:
+				a2mp_disconn_req(level, frm);
+				break;
+			case A2MP_DISCONN_RSP:
+				a2mp_disconn_rsp(level, frm);
+				break;
+			default:
+				printf("code 0x%2.2x ident %d len %d\n",
+					   hdr->code, hdr->ident, btohs(hdr->len));
+				raw_dump(level, frm);
+			}
+			if (frm->len > btohs(hdr->len)) {
+				frm->len -= btohs(hdr->len);
+				frm->ptr += btohs(hdr->len);
+			} else
+				frm->len = 0;
+		}
 	} else if (cid == 0x04) {
 		if (!p_filter(FILT_ATT))
 			att_dump(level, frm);
diff --git a/parser/parser.h b/parser/parser.h
index e975808..22d18c3 100644
--- a/parser/parser.h
+++ b/parser/parser.h
@@ -80,6 +80,7 @@ struct frame {
 #define FILT_AVCTP	0x0800
 #define FILT_ATT 	0x1000
 #define FILT_SMP	0x2000
+#define FILT_A2MP	0x4000
 
 #define FILT_OBEX	0x00010000
 #define FILT_CAPI	0x00020000
diff --git a/src/hcidump.c b/src/hcidump.c
index 36eedc5..eedc885 100644
--- a/src/hcidump.c
+++ b/src/hcidump.c
@@ -802,6 +802,7 @@ static struct {
 	{ "hci",	FILT_HCI	},
 	{ "sco",	FILT_SCO	},
 	{ "l2cap",	FILT_L2CAP	},
+	{ "a2mp",	FILT_A2MP	},
 	{ "rfcomm",	FILT_RFCOMM	},
 	{ "sdp",	FILT_SDP	},
 	{ "bnep",	FILT_BNEP	},
-- 
1.7.4.1

--
Peter Krystad
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
