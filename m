Return-Path: <cyrus@holtmann.org>
From: Peter Krystad <pkrystad@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: andrei.emeltchenko@intel.com,
	Peter Krystad <pkrystad@codeaurora.org>
Subject: [PATCH 2/4] Add parsing of A2MP signals
Date: Fri, 21 Oct 2011 16:30:00 -0700
Message-Id: <1319239802-22457-3-git-send-email-pkrystad@codeaurora.org>
In-Reply-To: <1319239802-22457-1-git-send-email-pkrystad@codeaurora.org>
References: <1319239802-22457-1-git-send-email-pkrystad@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add parsing of A2MP signalling.
Example output:

2011-10-18 16:09:44.493202 > ACL data: handle 39 flags 0x02 dlen 16
    A2MP: Discover req: mtu/mps 670 mask: 0x0000
2011-10-18 16:09:44.493404 < ACL data: handle 39 flags 0x00 dlen 22
    A2MP: Discover rsp: mtu/mps 670 mask: 0x0000
      Controller list:
        id 0, type 0, status 0x01 (Bluetooth only)
        id 17, type 254, status 0x06 (Full capacity)
2011-10-18 16:09:44.697203 > ACL data: handle 39 flags 0x02 dlen 13
    A2MP: Get Info req: id 17
2011-10-18 16:09:44.697312 < ACL data: handle 39 flags 0x00 dlen 30
    A2MP: Get Info rsp: id 17 status (0) Success
      total bandwidth 500000
      max guaranteed bandwidth 0
      min latency 100000
      pal capabilities 0x0000
      assoc size 8
2011-10-18 16:09:44.893203 > ACL data: handle 39 flags 0x02 dlen 13
    A2MP: Get AMP Assoc req: id 17
2011-10-18 16:09:44.893618 < ACL data: handle 39 flags 0x00 dlen 22
    A2MP: Get AMP Assoc rsp: id 17 status (0) Success
      assoc data:
        08 01 b1 01 0a 04 6c 42
2011-10-18 16:09:45.598201 > ACL data: handle 39 flags 0x02 dlen 22
    A2MP: Create Physical Link req: local id 1 remote id 17
      assoc data:
        08 01 b1 01 0a 04 6d 38
2011-10-18 16:09:45.598643 < ACL data: handle 39 flags 0x00 dlen 15
    A2MP: Create Physical Link rsp: local id 17 remote id 1 status 0
      Success
---
 lib/amp.h       |  133 +++++++++++++++++++
 parser/l2cap.c  |  385 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 parser/parser.h |    1 +
 src/hcidump.c   |    1 +
 4 files changed, 520 insertions(+), 0 deletions(-)
 create mode 100644 lib/amp.h

diff --git a/lib/amp.h b/lib/amp.h
new file mode 100644
index 0000000..0c6300a
--- /dev/null
+++ b/lib/amp.h
@@ -0,0 +1,133 @@
+/*
+ *
+ *	BlueZ - Bluetooth protocol stack for Linux
+ *
+ *	Copyright (C) 2010-2011 Code Aurora Forum.  All rights reserved.
+ *
+ *	This program is free software; you can redistribute it and/or modify
+ *	it under the terms of the GNU General Public License version 2 and
+ *	only version 2 as published by the Free Software Foundation.
+ *
+ *	This program is distributed in the hope that it will be useful,
+ *	but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *	GNU General Public License for more details.
+ *
+ */
+
+#ifndef __AMP_H
+#define __AMP_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#define AMP_MGR_CID 0x03
+
+/* AMP manager codes */
+#define AMP_COMMAND_REJ		0x01
+#define AMP_DISCOVER_REQ	0x02
+#define AMP_DISCOVER_RSP	0x03
+#define AMP_CHANGE_NOTIFY	0x04
+#define AMP_CHANGE_RSP		0x05
+#define AMP_INFO_REQ		0x06
+#define AMP_INFO_RSP		0x07
+#define AMP_ASSOC_REQ		0x08
+#define AMP_ASSOC_RSP		0x09
+#define AMP_LINK_REQ		0x0a
+#define AMP_LINK_RSP		0x0b
+#define AMP_DISCONN_REQ		0x0c
+#define AMP_DISCONN_RSP		0x0d
+
+typedef struct {
+	uint8_t		code;
+	uint8_t		ident;
+	uint16_t	len;
+} __attribute__ ((packed)) amp_mgr_hdr;
+#define AMP_MGR_HDR_SIZE 4
+
+/* AMP ASSOC structure */
+typedef struct {
+	uint8_t		type_id;
+	uint16_t	len;
+	uint8_t		data[0];
+} __attribute__ ((packed)) amp_assoc_tlv;
+
+typedef struct {
+	uint16_t	reason;
+} __attribute__ ((packed)) amp_cmd_rej_parms;
+
+typedef struct {
+	uint16_t	mtu;
+	uint16_t	mask;
+} __attribute__ ((packed)) amp_discover_req_parms;
+
+typedef struct {
+	uint16_t	mtu;
+	uint16_t	mask;
+	uint8_t		controller_list[0];
+} __attribute__ ((packed)) amp_discover_rsp_parms;
+
+typedef struct {
+	uint8_t		id;
+} __attribute__ ((packed)) amp_info_req_parms;
+
+typedef struct {
+	uint8_t		id;
+	uint8_t		status;
+	uint32_t	total_bandwidth;
+	uint32_t	max_bandwidth;
+	uint32_t	min_latency;
+	uint16_t	pal_caps;
+	uint16_t	assoc_size;
+} __attribute__ ((packed)) amp_info_rsp_parms;
+
+typedef struct {
+	uint8_t		id;
+	uint8_t		status;
+	amp_assoc_tlv	assoc;
+} __attribute__ ((packed)) amp_assoc_rsp_parms;
+
+typedef struct {
+	uint8_t		local_id;
+	uint8_t		remote_id;
+	amp_assoc_tlv	assoc;
+} __attribute__ ((packed)) amp_link_req_parms;
+
+typedef struct {
+	uint8_t		local_id;
+	uint8_t		remote_id;
+	uint8_t		status;
+} __attribute__ ((packed)) amp_link_rsp_parms;
+
+typedef struct {
+	uint8_t		local_id;
+	uint8_t		remote_id;
+} __attribute__ ((packed)) amp_disconn_req_parms;
+
+#define AMP_COMMAND_NOT_RECOGNIZED 0x0000
+
+/* AMP controller status */
+#define AMP_CT_POWERED_DOWN		0x00
+#define AMP_CT_BLUETOOTH_ONLY		0x01
+#define AMP_CT_NO_CAPACITY		0x02
+#define AMP_CT_LOW_CAPACITY		0x03
+#define AMP_CT_MEDIUM_CAPACITY		0x04
+#define AMP_CT_HIGH_CAPACITY		0x05
+#define AMP_CT_FULL_CAPACITY		0x06
+
+/* AMP response status */
+#define AMP_STATUS_SUCCESS				0x00
+#define AMP_STATUS_INVALID_CTRL_ID			0x01
+#define AMP_STATUS_UNABLE_START_LINK_CREATION		0x02
+#define AMP_STATUS_NO_PHYSICAL_LINK_EXISTS		0x02
+#define AMP_STATUS_COLLISION_OCCURED			0x03
+#define AMP_STATUS_DISCONN_REQ_RECVD			0x04
+#define AMP_STATUS_PHYS_LINK_EXISTS			0x05
+#define AMP_STATUS_SECURITY_VIOLATION			0x06
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __AMP_H */
diff --git a/parser/l2cap.c b/parser/l2cap.c
index 7547e8b..7915788 100644
--- a/parser/l2cap.c
+++ b/parser/l2cap.c
@@ -36,6 +36,7 @@
 #include "parser/sdp.h"
 #include "lib/hci.h"
 #include "lib/l2cap.h"
+#include "lib/amp.h"
 
 typedef struct {
 	uint16_t handle;
@@ -259,6 +260,16 @@ static char *reason2str(uint16_t reason)
 	}
 }
 
+static char *ampreason2str(uint16_t reason)
+{
+	switch (reason) {
+	case AMP_COMMAND_NOT_RECOGNIZED:
+		return "Command not recognized";
+	default:
+		return "Reserved";
+	}
+}
+
 static char *connresult2str(uint16_t result)
 {
 	switch (result) {
@@ -399,6 +410,76 @@ static char *supervisory2str(uint8_t supervisory)
 	}
 }
 
+static char *ampctstatus2str(uint8_t status)
+{
+	switch (status) {
+	case AMP_CT_POWERED_DOWN:
+		return "Powered down";
+	case AMP_CT_BLUETOOTH_ONLY:
+		return "Bluetooth only";
+	case AMP_CT_NO_CAPACITY:
+		return "No capacity";
+	case AMP_CT_LOW_CAPACITY:
+		return "Low capacity";
+	case AMP_CT_MEDIUM_CAPACITY:
+		return "Medium capacity";
+	case AMP_CT_HIGH_CAPACITY:
+		return "High capacity";
+	case AMP_CT_FULL_CAPACITY:
+		return "Full capacity";
+	default:
+		return "Reserved";
+
+	}
+}
+
+static char *ampstatus2str(uint8_t status)
+{
+	switch (status) {
+	case AMP_STATUS_SUCCESS:
+		return "Success";
+	case AMP_STATUS_INVALID_CTRL_ID:
+		return "Invalid Controller ID";
+	default:
+		return "Reserved";
+	}
+}
+
+static char *ampcplstatus2str(uint8_t status)
+{
+	switch (status) {
+	case AMP_STATUS_SUCCESS:
+		return "Success";
+	case AMP_STATUS_INVALID_CTRL_ID:
+		return "Invalid Controller ID";
+	case AMP_STATUS_UNABLE_START_LINK_CREATION:
+		return "Failed - Unable to start link creation";
+	case AMP_STATUS_COLLISION_OCCURED:
+		return "Failed - Collision occured";
+	case AMP_STATUS_DISCONN_REQ_RECVD:
+		return "Failed - Disconnect physical link received";
+	case AMP_STATUS_PHYS_LINK_EXISTS:
+		return "Failed - Physical link already exists";
+	case AMP_STATUS_SECURITY_VIOLATION:
+		return "Failed - Security violation";
+	default:
+		return "Reserved";
+	}
+}
+
+static char *ampdplstatus2str(uint8_t status)
+{
+	switch (status) {
+	case AMP_STATUS_SUCCESS:
+		return "Success";
+	case AMP_STATUS_INVALID_CTRL_ID:
+		return "Invalid Controller ID";
+	case AMP_STATUS_NO_PHYSICAL_LINK_EXISTS:
+		return "Failed - No Physical Link exists";
+	default:
+		return "Reserved";
+	}
+}
 
 static inline void command_rej(int level, struct frame *frm)
 {
@@ -923,6 +1004,240 @@ static inline void move_cfm_rsp(int level, l2cap_cmd_hdr *cmd, struct frame *frm
 	printf("Move cfm rsp: icid 0x%4.4x\n", icid);
 }
 
+static inline void amp_command_rej(int level, struct frame *frm)
+{
+	amp_cmd_rej_parms *h = frm->ptr;
+	uint16_t reason = btohs(h->reason);
+
+	if (p_filter(FILT_A2MP))
+		return;
+
+	printf("Command Reject: reason (%d)- ", reason);
+	p_indent(level + 1, frm);
+	printf("%s\n", ampreason2str(reason));
+}
+
+static inline void amp_discover_req(int level, struct frame *frm, uint16_t len)
+{
+	amp_discover_req_parms *h = frm->ptr;
+	uint16_t mtu = btohs(h->mtu);
+	uint8_t	 *octet = (uint8_t *)&(h->mask);
+	uint16_t mask;
+	uint8_t  extension;
+
+	if (p_filter(FILT_A2MP))
+		return;
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
+static inline void controller_list_dump (int level, uint8_t *octet, uint16_t len)
+{
+	if (p_filter(FILT_A2MP))
+		return;
+
+	p_indent(level, 0);
+	printf("Controller list:\n");
+
+	while (len >= 3) {
+		p_indent(level + 1, 0);
+		printf("id %d, type %d, status 0x%2.2x (%s)\n",
+			   octet[0], octet[1], octet[2], ampctstatus2str(octet[2]));
+		octet += 3;
+		len -= 3;
+	}
+
+}
+
+static inline void amp_discover_rsp(int level, struct frame *frm, uint16_t len)
+{
+	amp_discover_rsp_parms *h = frm->ptr;
+	uint16_t mtu = btohs(h->mtu);
+	uint8_t	 *octet = (uint8_t *)&(h->mask);
+	uint16_t mask;
+	uint8_t  extension;
+
+	if (p_filter(FILT_A2MP))
+		return;
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
+		controller_list_dump (level + 1, octet, len);
+	}
+}
+
+static inline void amp_change_notify(int level, struct frame *frm, uint16_t len)
+{
+	uint8_t *octet = frm->ptr;
+
+	if (p_filter(FILT_A2MP))
+		return;
+
+	printf("Change Notify\n");
+
+	if (len >= 3) {
+		controller_list_dump (level + 1, octet, len);
+	}
+}
+
+static inline void amp_change_rsp(int level, struct frame *frm)
+{
+	if (p_filter(FILT_A2MP))
+		return;
+
+	printf("Change Response\n");
+}
+
+static inline void amp_info_req(int level, struct frame *frm)
+{
+	amp_info_req_parms *h = frm->ptr;
+
+	if (p_filter(FILT_A2MP))
+		return;
+
+	printf("Get Info req: id %d\n", h->id);
+}
+
+static inline void amp_info_rsp(int level, struct frame *frm)
+{
+	amp_info_rsp_parms *h = frm->ptr;
+
+	if (p_filter(FILT_A2MP))
+		return;
+
+	printf("Get Info rsp: id %d status (%d) %s\n",
+		   h->id, h->status, ampstatus2str(h->status));
+
+	p_indent(level + 1, frm);
+	printf("total bandwidth %d\n", btohl(h->total_bandwidth));
+	p_indent(level + 1, frm);
+	printf("max guaranteed bandwidth %d\n", btohl(h->max_bandwidth));
+	p_indent(level + 1, frm);
+	printf("min latency %d\n", btohl(h->min_latency));
+	p_indent(level + 1, frm);
+	printf("pal capabilities 0x%4.4x\n", btohs(h->pal_caps));
+	p_indent(level + 1, frm);
+	printf("assoc size %d\n", btohs(h->assoc_size));
+}
+
+static inline void amp_assoc_req(int level, struct frame *frm)
+{
+	amp_info_req_parms *h = frm->ptr;
+
+	if (p_filter(FILT_A2MP))
+		return;
+
+	printf("Get AMP Assoc req: id %d\n", h->id);
+}
+
+static inline void amp_assoc_dump(int level, uint8_t *assoc, uint16_t len)
+{
+	int i;
+
+	if (p_filter(FILT_A2MP))
+		return;
+
+	p_indent(level, 0);
+	printf("assoc data:");
+	for (i = 0; i < len; i++) {
+		if (!(i%16)) printf("\n");
+		if (!(i%16)) p_indent(level+1, 0);
+		printf("%2.2x ",*assoc++);
+	}
+	printf("\n");
+
+}
+
+static inline void amp_assoc_rsp(int level, struct frame *frm, uint16_t len)
+{
+	amp_assoc_rsp_parms *h = frm->ptr;
+
+	if (p_filter(FILT_A2MP))
+		return;
+
+	printf("Get AMP Assoc rsp: id %d status (%d) %s \n",
+		   h->id, h->status, ampstatus2str(h->status));
+	amp_assoc_dump(level + 1, (uint8_t *) &h->assoc, len - 2);
+}
+
+static inline void amp_link_req(int level, struct frame *frm, uint16_t len)
+{
+	amp_link_req_parms *h = frm->ptr;
+
+	if (p_filter(FILT_A2MP))
+		return;
+
+	printf("Create Physical Link req: local id %d remote id %d\n",
+		   h->local_id, h->remote_id);
+	amp_assoc_dump(level + 1, (uint8_t *) &h->assoc, len - 2);
+}
+
+static inline void amp_link_rsp(int level, struct frame *frm)
+{
+	amp_link_rsp_parms *h = frm->ptr;
+
+	if (p_filter(FILT_A2MP))
+		return;
+
+	printf("Create Physical Link rsp: local id %d remote id %d status %d\n",
+		   h->local_id, h->remote_id, h->status);
+	p_indent(level+1, 0);
+	printf("%s\n", ampcplstatus2str(h->status));
+}
+
+static inline void amp_disconn_req(int level, struct frame *frm)
+{
+	amp_disconn_req_parms *h = frm->ptr;
+
+	if (p_filter(FILT_A2MP))
+		return;
+
+	printf("Disconnect Physical Link req: local id %d remote id %d\n",
+		   h->local_id, h->remote_id);
+}
+
+static inline void amp_disconn_rsp(int level, struct frame *frm)
+{
+	amp_link_rsp_parms *h = frm->ptr;
+
+	if (p_filter(FILT_A2MP))
+		return;
+
+	printf("Disconnect Physical Link rsp: local id %d remote id %d status %d\n",
+		   h->local_id, h->remote_id, h->status);
+	p_indent(level+1, 0);
+	printf("%s\n", ampdplstatus2str(h->status));
+}
+
 static void l2cap_parse(int level, struct frame *frm)
 {
 	l2cap_hdr *hdr = (void *)frm->ptr;
@@ -1043,6 +1358,76 @@ static void l2cap_parse(int level, struct frame *frm)
 		p_indent(level, frm);
 		printf("L2CAP(c): len %d psm %d\n", dlen, psm);
 		raw_dump(level, frm);
+	} else if ((cid == 0x3) && (frm->len > 4)) {
+
+		/* Adjust for extra ERTM control bytes */
+		frm->ptr += 2;
+		frm->len -= 2;
+
+		while (frm->len >= AMP_MGR_HDR_SIZE) {
+			amp_mgr_hdr *hdr = frm->ptr;
+
+			frm->ptr += AMP_MGR_HDR_SIZE;
+			frm->len -= AMP_MGR_HDR_SIZE;
+
+			if (!p_filter(FILT_A2MP)) {
+				p_indent(level, frm);
+				printf("A2MP: ");
+			}
+			switch (hdr->code) {
+			case AMP_COMMAND_REJ:
+				amp_command_rej(level, frm);
+				break;
+			case AMP_DISCOVER_REQ:
+				amp_discover_req(level, frm, hdr->len);
+				break;
+			case AMP_DISCOVER_RSP:
+				amp_discover_rsp(level, frm, hdr->len);
+				break;
+			case AMP_CHANGE_NOTIFY:
+				amp_change_notify(level, frm, hdr->len);
+				break;
+			case AMP_CHANGE_RSP:
+				amp_change_rsp(level, frm);
+				break;
+			case AMP_INFO_REQ:
+				amp_info_req(level, frm);
+				break;
+			case AMP_INFO_RSP:
+				amp_info_rsp(level, frm);
+				break;
+			case AMP_ASSOC_REQ:
+				amp_assoc_req(level, frm);
+				break;
+			case AMP_ASSOC_RSP:
+				amp_assoc_rsp(level, frm, hdr->len);
+				break;
+			case AMP_LINK_REQ:
+				amp_link_req(level, frm, hdr->len);
+				break;
+			case AMP_LINK_RSP:
+				amp_link_rsp(level, frm);
+				break;
+			case AMP_DISCONN_REQ:
+				amp_disconn_req(level, frm);
+				break;
+			case AMP_DISCONN_RSP:
+				amp_disconn_rsp(level, frm);
+				break;
+			default:
+				if (p_filter(FILT_A2MP))
+					break;
+				printf("code 0x%2.2x ident %d len %d\n",
+					   hdr->code, hdr->ident, btohs(hdr->len));
+				raw_dump(level, frm);
+			}
+
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
index 0c13360..2513c7c 100644
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
1.7.7

--
Peter Krystad
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
