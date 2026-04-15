Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E5B38B14E
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 20:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776286711; cv=none; b=h3qvXpkWOySxFcFTpb1hQr0uf4BWrDwrCosGL3EOn1Y/6kPk7A7nZy6MQqDdak7q0GXGqPPdHEj/UqNCk5VZy7eG95/pO6q+x6DNDxUlGNtiMR2kqq2a1C7CFM0HC230D2VcfryVeobrIObPw5U7mJuHtqW3goPvcZEPAmdnt9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776286711; c=relaxed/simple;
	bh=tK8T0nPt0fr0zrxbVVuhDSzbpXJlmOWqPaP4U5fsYLY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XZbvJ8CXAKf4eqNP30/CGNuKtOCQX/sv3/noi1oRqWA6xppyXcXyphrNittnBNBBCQkIk7Yl2i4eVvFmNZvJm8O0dQYTW56gE3tzzu3t8WR6sJBHyl/ZskthdjEoZeu2HTG8XpDc7eVcqanmNK2Ns83JaKmm29TRHKfybnQpg1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVFoCaa/; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVFoCaa/"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56a8e0ea02aso7195978e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 13:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776286708; x=1776891508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KZhyBlSyM0CnSTG7TFhovSfhAGT0ujk272wKbjOg+OE=;
        b=MVFoCaa/YRwyl1EefwUodLVwS01JiTiq7HFeaEEqVdxEIQNp4fJ7Guo1BI5NTfwim+
         nz6q4xOtxAEEdKX/7ktqubnUl96AN6BmQApdCti684W2XS6DUSAsBKXF34jZpcvgQcUg
         Svx95sqLs61EfLZVu8NbvVwbTY7bXMz3OcqceRcX26OEwRkWXZIPKLxB/rt1/hyVsE3L
         eaYhwA4ntGomDnXKjZw2ARUuL+Z7nNhRTXWpOLRzFTLOn5XY8fFqn0g+oYfkzmxClgmM
         hRyIKhKY4L0CHzGZV5aj2cuUfW7bmoAqsjaZxoJvJ5LE/UBMY+MiXfQ9+BE56fYecJvJ
         KKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776286708; x=1776891508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KZhyBlSyM0CnSTG7TFhovSfhAGT0ujk272wKbjOg+OE=;
        b=kTejfHvsHPVo3dD7h2yhzBFV5SFf2IE4iv0PMG9CFxnVvhBBCOJNu7eNAoshMgze6g
         WvZk0kh34bJf3KlX6Vs+n9/RD+0XAqFL2Rg8vHZuAW4iZzUEVqyvsZ5o8K13iXxldodo
         uxtooDp5UalVm/sCMZN86Cw9UQeWc53eZk9035tlhC+5npQ2WQ5CReO6mLmyD1RlvSLp
         aQGM0SScy0Yw0+/WkBf9pQKcZKfFtTfTgg2zAGDkVWoCYhso4eSWYwCnpAfk6zAAVysI
         tQzdrqlIHZfsNdWfCm3M7SXzXvaRZ5M3Rtb4t5Ke/N+zefH58QDFBEh4ROy7BMHI+mpX
         fyqQ==
X-Gm-Message-State: AOJu0YwtVc9yhVG0K2SbeB0MXTG436ApoTPq4q+1RkaA6Fu6pe/R5149
	Cz5pCCJiAj4aDycclQTMQQO1k50FmeNKtajznStbkzrZY+iKhWNm6NAt4ZcxZ0OR/IY=
X-Gm-Gg: AeBDiesA09gLeKRTNqMp3FzHY77vgRb8zDJJqmYCKaOt2vGfK0jDqPJY+8xoPROJiis
	2vpd8PrU90Rf7YkBCo4XH+LHI60Ny/R2EGifuxxnBHs6sa2dbWJzg7mRNjEoLAAiUeM++RQk6IF
	0PrYUgh+UELunuNCfDY/oNL0EevrBisT2Zb2E/F41q58dY2wITmLji21lITQ9Bhvd53JxPzg9P3
	kSR4S5MxPCAklB3wggw9QKJsCMsslyUK2wk9m+OaeYDusHwTXJSulsSvkB61ycQVKp7qhZ6Yhm6
	XhiBctPhonv1QzSaSAAZ5g8x4C24qT/Dxl8SMfdtzXYItNCcYSBahLTIweEZYayUZ0OwM2b1hXo
	TvVy6d1CqnnLsIhWMNvr26qVEV4y2gB/7xrztQzHOXSA/Bu1qhmAQFtDuxwMkOAEgthDRBJtnzU
	u4oxGq/jEq4xuOaCjpzDgz8OY70LZifwLsm4htjNUsnKaPgHVcQOBFTg/48yiGyq8KxWf0XojL6
	tE0zhMWlVc/sxOvWt61b65h4uKp+qfHI04TlhQ=
X-Received: by 2002:a05:6122:45a6:b0:56a:ef51:4cae with SMTP id 71dfb90a1353d-56f3bb8a321mr11782733e0c.4.1776286708160;
        Wed, 15 Apr 2026 13:58:28 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56f8a032227sm2059622e0c.18.2026.04.15.13.58.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 13:58:27 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/3] monitor: Add L2CAP channel details to analyze output
Date: Wed, 15 Apr 2026 16:58:16 -0400
Message-ID: <20260415205818.594024-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Enhance btmon analyze mode to display richer per-channel information:

- Add MTU, MPS, and mode fields to struct l2cap_chan
- Parse Configure Request/Response options for BR/EDR channels to
  extract MTU (option 0x01) and mode (option 0x04)
- Add l2cap_le_sig() to parse LE signaling (CID 5) for LE Credit
  Based Connection Request/Response and Enhanced Credit Connection
  Request, extracting PSM, MTU, MPS, and mode
- Display fixed channel names (ATT, L2CAP Signaling, SMP) for CID <= 7
- Show PSM in both decimal and hex format
- Print mode, MTU, and MPS for dynamic channels
---
 monitor/analyze.c | 221 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 219 insertions(+), 2 deletions(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index 819d621cd03d..68e4910325e5 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -94,6 +94,9 @@ struct plot {
 struct l2cap_chan {
 	uint16_t cid;
 	uint16_t psm;
+	uint16_t mtu;
+	uint16_t mps;
+	uint8_t mode;
 	bool out;
 	struct timeval last_rx;
 	struct hci_stats rx;
@@ -156,17 +159,76 @@ static void print_stats(struct hci_stats *stats, const char *label)
 	plot_draw(stats->plot, label);
 }
 
+static const char *fixed_channel_name(uint16_t cid)
+{
+	switch (cid) {
+	case 0x0001:
+		return "L2CAP Signaling (BR/EDR)";
+	case 0x0002:
+		return "Connectionless";
+	case 0x0003:
+		return "AMP Manager";
+	case 0x0004:
+		return "ATT";
+	case 0x0005:
+		return "L2CAP Signaling (LE)";
+	case 0x0006:
+		return "SMP (LE)";
+	case 0x0007:
+		return "SMP (BR/EDR)";
+	default:
+		return NULL;
+	}
+}
+
+static const char *l2cap_mode_name(uint8_t mode)
+{
+	switch (mode) {
+	case 0x00:
+		return "Basic";
+	case 0x01:
+		return "Retransmission";
+	case 0x02:
+		return "Flow Control";
+	case 0x03:
+		return "ERTM";
+	case 0x04:
+		return "Streaming";
+	case 0x80:
+		return "LE Credit";
+	case 0x81:
+		return "Enhanced Credit";
+	default:
+		return "Unknown";
+	}
+}
+
 static void chan_destroy(void *data)
 {
 	struct l2cap_chan *chan = data;
+	const char *fixed;
 
 	if (!chan->rx.num && !chan->tx.num)
 		goto done;
 
-	printf("  Found %s L2CAP channel with CID %u\n",
+	fixed = fixed_channel_name(chan->cid);
+	if (fixed)
+		printf("  Found %s L2CAP channel with CID %u (%s)\n",
+					chan->out ? "TX" : "RX", chan->cid,
+					fixed);
+	else
+		printf("  Found %s L2CAP channel with CID %u\n",
 					chan->out ? "TX" : "RX", chan->cid);
+
 	if (chan->psm)
-		print_field("PSM %u", chan->psm);
+		print_field("PSM %u (0x%04x)", chan->psm, chan->psm);
+	if (!fixed) {
+		print_field("Mode: %s", l2cap_mode_name(chan->mode));
+		if (chan->mtu)
+			print_field("MTU: %u", chan->mtu);
+		if (chan->mps)
+			print_field("MPS: %u", chan->mps);
+	}
 
 	print_stats(&chan->rx, "RX");
 	print_stats(&chan->tx, "TX");
@@ -433,6 +495,159 @@ static void l2cap_sig(struct hci_conn *conn, bool out,
 				chan->psm = psm;
 		}
 		break;
+	case BT_L2CAP_PDU_CONFIG_REQ:
+	{
+		const struct bt_l2cap_pdu_config_req *pdu = data + 4;
+		const uint8_t *opts;
+		uint16_t opts_len;
+
+		dcid = le16_to_cpu(pdu->dcid);
+		/* Options start after the 4-byte config req header */
+		opts = data + 4 + sizeof(*pdu);
+		opts_len = size - 4 - sizeof(*pdu);
+
+		chan = chan_lookup(conn, dcid, !out);
+		if (!chan)
+			break;
+
+		while (opts_len >= 2) {
+			uint8_t type = opts[0];
+			uint8_t len = opts[1];
+
+			if (opts_len < (uint16_t)(2 + len))
+				break;
+
+			switch (type) {
+			case 0x01: /* MTU */
+				if (len >= 2)
+					chan->mtu = get_le16(opts + 2);
+				break;
+			case 0x04: /* Retransmission and Flow Control */
+				if (len >= 1)
+					chan->mode = opts[2];
+				break;
+			}
+
+			opts += 2 + len;
+			opts_len -= 2 + len;
+		}
+		break;
+	}
+	case BT_L2CAP_PDU_CONFIG_RSP:
+	{
+		const struct bt_l2cap_pdu_config_rsp *pdu = data + 4;
+		const uint8_t *opts;
+		uint16_t opts_len;
+
+		scid = le16_to_cpu(pdu->scid);
+		/* Options start after the 6-byte config rsp header */
+		opts = data + 4 + sizeof(*pdu);
+		opts_len = size - 4 - sizeof(*pdu);
+
+		chan = chan_lookup(conn, scid, out);
+		if (!chan)
+			break;
+
+		while (opts_len >= 2) {
+			uint8_t type = opts[0];
+			uint8_t len = opts[1];
+
+			if (opts_len < (uint16_t)(2 + len))
+				break;
+
+			switch (type) {
+			case 0x01: /* MTU */
+				if (len >= 2)
+					chan->mtu = get_le16(opts + 2);
+				break;
+			case 0x04: /* Retransmission and Flow Control */
+				if (len >= 1)
+					chan->mode = opts[2];
+				break;
+			}
+
+			opts += 2 + len;
+			opts_len -= 2 + len;
+		}
+		break;
+	}
+	}
+}
+
+static void l2cap_le_sig(struct hci_conn *conn, bool out,
+					const void *data, uint16_t size)
+{
+	const struct bt_l2cap_hdr_sig *hdr = data;
+	struct l2cap_chan *chan;
+	uint16_t psm, scid, dcid;
+
+	switch (hdr->code) {
+	case BT_L2CAP_PDU_LE_CONN_REQ:
+	{
+		const struct bt_l2cap_pdu_le_conn_req *pdu = data + 4;
+
+		psm = le16_to_cpu(pdu->psm);
+		scid = le16_to_cpu(pdu->scid);
+		chan = chan_lookup(conn, scid, out);
+		if (chan) {
+			chan->psm = psm;
+			chan->mtu = le16_to_cpu(pdu->mtu);
+			chan->mps = le16_to_cpu(pdu->mps);
+			chan->mode = 0x80; /* LE Credit */
+		}
+		break;
+	}
+	case BT_L2CAP_PDU_LE_CONN_RSP:
+	{
+		const struct bt_l2cap_pdu_le_conn_rsp *pdu = data + 4;
+
+		dcid = le16_to_cpu(pdu->dcid);
+
+		/* The response's dcid is the responder's CID.  Its MTU/MPS
+		 * belong to the responder, so set them on the channel for
+		 * that direction (out).  Also propagate PSM from the
+		 * requester's channel (!out) if available.
+		 */
+		chan = chan_lookup(conn, dcid, out);
+		if (chan) {
+			struct l2cap_chan *req_chan;
+
+			chan->mtu = le16_to_cpu(pdu->mtu);
+			chan->mps = le16_to_cpu(pdu->mps);
+			chan->mode = 0x80; /* LE Credit */
+
+			/* Propagate PSM from the request channel */
+			req_chan = queue_find(conn->chan_list,
+					chan_match_cid,
+					UINT_TO_PTR(dcid |
+						(!out ? 0x10000 : 0)));
+			if (req_chan && req_chan->psm)
+				chan->psm = req_chan->psm;
+		}
+		break;
+	}
+	case BT_L2CAP_PDU_ECRED_CONN_REQ:
+	{
+		const struct bt_l2cap_pdu_ecred_conn_req *pdu = data + 4;
+		uint16_t req_len = le16_to_cpu(hdr->len);
+		int num_cids;
+		int i;
+
+		psm = le16_to_cpu(pdu->psm);
+		num_cids = (req_len - sizeof(*pdu)) / sizeof(uint16_t);
+
+		for (i = 0; i < num_cids; i++) {
+			scid = le16_to_cpu(pdu->scid[i]);
+			chan = chan_lookup(conn, scid, out);
+			if (chan) {
+				chan->psm = psm;
+				chan->mtu = le16_to_cpu(pdu->mtu);
+				chan->mps = le16_to_cpu(pdu->mps);
+				chan->mode = 0x81; /* Enhanced Credit */
+			}
+		}
+		break;
+	}
 	}
 }
 
@@ -938,6 +1153,8 @@ static void acl_pkt(struct timeval *tv, uint16_t index, bool out,
 		chan = chan_lookup(conn, cid, out);
 		if (cid == 1)
 			l2cap_sig(conn, out, data + 4, size - 4);
+		else if (cid == 5)
+			l2cap_le_sig(conn, out, data + 4, size - 4);
 		break;
 	}
 
-- 
2.53.0

