Return-Path: <SRS0=ITs3=3R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EC8C35240
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jan 2020 20:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808A620708
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jan 2020 20:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llT86hx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgA1UNm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jan 2020 15:13:42 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:38416 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgA1UNl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jan 2020 15:13:41 -0500
Received: by mail-pf1-f174.google.com with SMTP id x185so7233809pfc.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2020 12:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0gQt3GtwJe66EQRGNjJ06N/zsaxGo0nIdnz5kJuLxd0=;
        b=llT86hx++9JlcslKDIjW0P+D9JaNQU0lrAihFS5DhXxcWlQixdv4yUt7luOQyyGUBs
         aPJjP0Xg3JTlr18oLQg++BARxGfFCe99BfIZPMY6JTmrF5xISPlCatAErcGsS/QJ/w4/
         IicX0VXCyXGEzQ8EsDrNea7RLnnmGKl1f3Ac5P+C4GpM2FXc33pzZBWeI3Q0zXzDf/OO
         fWWmTCIKn0O30FYO6ZSRi8SUxn2Qudq2K+qUjOcTu7JRfSBjb3Gjh3AAW+OPxwVTJ0mf
         qOMMmFQMcCeiZjFKEiEatB0QjGOO/orjkM6f9yzHl3uqR8w2foe+neqWZz99F1Z7wE/5
         pySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0gQt3GtwJe66EQRGNjJ06N/zsaxGo0nIdnz5kJuLxd0=;
        b=bGc6BGfbx8ZKRdK3VjEmkiRPdQd0+jm5T5pNrChH9NPlQIsxz8O6WWbtCNiLbTuXcY
         ssmanY3g17TIGChjUWbO51fiKwpp4i/1/yB5cqVbLQaEN9zdmmV3c7J6mf1kknxQXJVh
         M7mZqXGid2dtFL8Bg+OiCWJrCZcB29xyPEyKKILHY7u19KBefJyXrMzONO/FzGGZRd8M
         fkgWFCP/XvPtyErsw6fL5WtmxKVqjxqS5w2Kv0NO3Z9LC1Idn7iTOpF3Sl4EbKdB9mSM
         pMsYFTXqqxr36PHS0NNiwlLY9sBxvkVKZsi6/cKi9PGsg+JwIoZyzYn9LNxdUNLex7it
         mCnA==
X-Gm-Message-State: APjAAAWvBUDdGX61HoF5dTIB1I5hEUoJ/+Ul0J9OrUfLbeLx/cpnz3w7
        lep9iB9UZGndXZSfj5t7oXadoWREyy8=
X-Google-Smtp-Source: APXvYqy9T/m478dM5T6HIGdrb7kHrtweXl4LIpj67f6O/QHdQl8N13bZAHEWWRMkKUH5U/z/srUjeA==
X-Received: by 2002:a65:5608:: with SMTP id l8mr27389695pgs.210.1580242420718;
        Tue, 28 Jan 2020 12:13:40 -0800 (PST)
Received: from localhost.localdomain ([192.102.209.38])
        by smtp.gmail.com with ESMTPSA id x8sm3367504pfr.104.2020.01.28.12.13.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 12:13:39 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/6] monitor: Add decoding for L2CAP Enhanced Credit Based PDUs
Date:   Tue, 28 Jan 2020 12:13:33 -0800
Message-Id: <20200128201335.6165-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128201335.6165-1-luiz.dentz@gmail.com>
References: <20200128201335.6165-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Enhanced Credit Based Flow Control Mode is used for L2CAP
connection-oriented channels on LE and BR/EDR with flow control using
a credit-based scheme for L2CAP data.
---
 monitor/bt.h    |  30 ++++++++++
 monitor/l2cap.c | 153 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 183 insertions(+)

diff --git a/monitor/bt.h b/monitor/bt.h
index c2e6964ff..d989f5b94 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -3712,6 +3712,36 @@ struct bt_l2cap_pdu_le_flowctl_creds {
 	uint16_t credits;
 } __attribute__ ((packed));
 
+#define BT_L2CAP_PDU_ECRED_CONN_REQ	0x17
+struct bt_l2cap_pdu_ecred_conn_req {
+	uint16_t psm;
+	uint16_t mtu;
+	uint16_t mps;
+	uint16_t credits;
+	uint16_t scid[0];
+} __attribute__ ((packed));
+
+#define BT_L2CAP_PDU_ECRED_CONN_RSP	0x18
+struct bt_l2cap_pdu_ecred_conn_rsp {
+	uint16_t mtu;
+	uint16_t mps;
+	uint16_t credits;
+	uint16_t result;
+	uint16_t dcid[0];
+} __attribute__ ((packed));
+
+#define BT_L2CAP_PDU_ECRED_RECONF_REQ	0x19
+struct bt_l2cap_pdu_ecred_reconf_req {
+	uint16_t mtu;
+	uint16_t mps;
+	uint16_t scid[0];
+} __attribute__ ((packed));
+
+#define BT_L2CAP_PDU_ECRED_RECONF_RSP	0x1a
+struct bt_l2cap_pdu_ecred_reconf_rsp {
+	uint16_t result;
+} __attribute__ ((packed));
+
 struct bt_l2cap_hdr_connless {
 	uint16_t psm;
 } __attribute__ ((packed));
diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index d4feca451..3b2b25f24 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -54,6 +54,7 @@
 #define L2CAP_MODE_ERTM			0x03
 #define L2CAP_MODE_STREAMING		0x04
 #define L2CAP_MODE_LE_FLOWCTL		0x80
+#define L2CAP_MODE_ECRED		0x81
 
 /* L2CAP Control Field bit masks */
 #define L2CAP_CTRL_SAR_MASK		0xC000
@@ -121,6 +122,9 @@ static void assign_scid(const struct l2cap_frame *frame, uint16_t scid,
 	int i, n = -1;
 	uint8_t seq_num = 1;
 
+	if (!scid)
+		return;
+
 	for (i = 0; i < MAX_CHAN; i++) {
 		if (n < 0 && chan_list[i].handle == 0x0000) {
 			n = i;
@@ -417,6 +421,8 @@ static char *mode2str(uint8_t mode)
 		return "Streaming";
 	case L2CAP_MODE_LE_FLOWCTL:
 		return "LE Flow Control";
+	case L2CAP_MODE_ECRED:
+		return "Enhanced Credit";
 	default:
 		return "Unknown";
 	}
@@ -1333,6 +1339,132 @@ static void sig_le_flowctl_creds(const struct l2cap_frame *frame)
 	print_field("Credits: %u", le16_to_cpu(pdu->credits));
 }
 
+static void sig_ecred_conn_req(const struct l2cap_frame *frame)
+{
+	const struct bt_l2cap_pdu_ecred_conn_req *pdu = frame->data;
+	uint16_t scid;
+
+	l2cap_frame_pull((void *)frame, frame, sizeof(pdu));
+
+	print_psm(pdu->psm);
+	print_field("MTU: %u", le16_to_cpu(pdu->mtu));
+	print_field("MPS: %u", le16_to_cpu(pdu->mps));
+	print_field("Credits: %u", le16_to_cpu(pdu->credits));
+
+	while (l2cap_frame_get_le16((void *)frame, &scid)) {
+		print_cid("Source", scid);
+		assign_scid(frame, scid, le16_to_cpu(pdu->psm),
+						L2CAP_MODE_ECRED, 0);
+	}
+}
+
+static void print_ecred_conn_result(uint16_t result)
+{
+	const char *str;
+
+	switch (le16_to_cpu(result)) {
+	case 0x0000:
+		str = "Connection successful";
+		break;
+	case 0x0002:
+		str = "Connection refused - PSM not supported";
+		break;
+	case 0x0004:
+		str = "Some connections refused – not enough resources "
+			"available";
+		break;
+	case 0x0005:
+		str = "All Connections refused - insufficient authentication";
+		break;
+	case 0x0006:
+		str = "All Connections refused - insufficient authorization";
+		break;
+	case 0x0007:
+		str = "All Connection refused - insufficient encryption key "
+			"size";
+		break;
+	case 0x0008:
+		str = "All Connections refused - insufficient encryption";
+		break;
+	case 0x0009:
+		str = "Some Connections refused - Invalid Source CID";
+		break;
+	case 0x000a:
+		str = "Some Connections refused - Source CID already allocated";
+		break;
+	case 0x000b:
+		str = "All Connections refused - unacceptable parameters";
+		break;
+	default:
+		str = "Reserved";
+		break;
+	}
+
+	print_field("Result: %s (0x%4.4x)", str, le16_to_cpu(result));
+}
+
+static void sig_ecred_conn_rsp(const struct l2cap_frame *frame)
+{
+	const struct bt_l2cap_pdu_ecred_conn_rsp *pdu = frame->data;
+	uint16_t dcid;
+
+	l2cap_frame_pull((void *)frame, frame, sizeof(pdu));
+
+	print_field("MTU: %u", le16_to_cpu(pdu->mtu));
+	print_field("MPS: %u", le16_to_cpu(pdu->mps));
+	print_field("Credits: %u", le16_to_cpu(pdu->credits));
+	print_ecred_conn_result(pdu->result);
+
+	while (l2cap_frame_get_le16((void *)frame, &dcid)) {
+		print_cid("Destination", dcid);
+		assign_dcid(frame, dcid, 0);
+	}
+}
+
+static void sig_ecred_reconf_req(const struct l2cap_frame *frame)
+{
+	const struct bt_l2cap_pdu_ecred_reconf_req *pdu = frame->data;
+	uint16_t scid;
+
+	l2cap_frame_pull((void *)frame, frame, sizeof(pdu));
+
+	print_field("MTU: %u", le16_to_cpu(pdu->mtu));
+	print_field("MPS: %u", le16_to_cpu(pdu->mps));
+
+	while (l2cap_frame_get_le16((void *)frame, &scid))
+		print_cid("Source", scid);
+}
+
+static void print_ecred_reconf_result(uint16_t result)
+{
+	const char *str;
+
+	switch (le16_to_cpu(result)) {
+	case 0x0000:
+		str = "Reconfiguration successful";
+		break;
+	case 0x0001:
+		str = "Reconfiguration failed - reduction in size of MTU not "
+			"allowed";
+		break;
+	case 0x0002:
+		str = "Reconfiguration failed - reduction in size of MPS not "
+			"allowed for more than one channel at a time";
+		break;
+	default:
+		str = "Reserved";
+	}
+
+	print_field("Result: %s (0x%4.4x)", str, le16_to_cpu(result));
+}
+
+static void sig_ecred_reconf_rsp(const struct l2cap_frame *frame)
+{
+	const struct bt_l2cap_pdu_ecred_reconf_rsp *pdu = frame->data;
+
+	print_ecred_reconf_result(pdu->result);
+}
+
 struct sig_opcode_data {
 	uint8_t opcode;
 	const char *str;
@@ -1341,6 +1473,24 @@ struct sig_opcode_data {
 	bool fixed;
 };
 
+#define SIG_ECRED \
+	{ BT_L2CAP_PDU_ECRED_CONN_REQ,					\
+	"Enhanced Credit Connection Request",				\
+	sig_ecred_conn_req, sizeof(struct bt_l2cap_pdu_ecred_conn_req), \
+	false },							\
+	{ BT_L2CAP_PDU_ECRED_CONN_RSP,					\
+	"Enhanced Credit Connection Response",				\
+	sig_ecred_conn_rsp, sizeof(struct bt_l2cap_pdu_ecred_conn_rsp), \
+	false },							\
+	{ BT_L2CAP_PDU_ECRED_RECONF_REQ,				\
+	"Enhanced Credit Reconfigure Request",				\
+	sig_ecred_reconf_req, sizeof(struct bt_l2cap_pdu_ecred_reconf_req), \
+	false },							\
+	{ BT_L2CAP_PDU_ECRED_RECONF_RSP,				\
+	"Enhanced Credit Reconfigure Respond",				\
+	sig_ecred_reconf_rsp, sizeof(struct bt_l2cap_pdu_ecred_reconf_rsp), \
+	true },
+
 static const struct sig_opcode_data bredr_sig_opcode_table[] = {
 	{ 0x01, "Command Reject",
 			sig_cmd_reject, 2, false },
@@ -1376,6 +1526,7 @@ static const struct sig_opcode_data bredr_sig_opcode_table[] = {
 			sig_move_chan_cfm, 4, true },
 	{ 0x11, "Move Channel Confirmation Response",
 			sig_move_chan_cfm_rsp, 2, true },
+	SIG_ECRED
 	{ },
 };
 
@@ -1396,6 +1547,7 @@ static const struct sig_opcode_data le_sig_opcode_table[] = {
 			sig_le_conn_rsp, 10, true },
 	{ 0x16, "LE Flow Control Credit",
 			sig_le_flowctl_creds, 4, true },
+	SIG_ECRED
 	{ },
 };
 
@@ -3066,6 +3218,7 @@ void l2cap_frame(uint16_t index, bool in, uint16_t handle, uint16_t cid,
 
 		switch (frame.mode) {
 		case L2CAP_MODE_LE_FLOWCTL:
+		case L2CAP_MODE_ECRED:
 			chan = get_chan(&frame);
 			if (!chan->sdu) {
 				if (!l2cap_frame_get_le16(&frame, &chan->sdu))
-- 
2.21.0

