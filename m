Return-Path: <SRS0=7F+K=5F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6AEC4332E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 20:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6188720775
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 20:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRVa27SI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgCTUkp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Mar 2020 16:40:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45036 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgCTUko (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Mar 2020 16:40:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id 37so3641311pgm.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2020 13:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=redNRYVw53Y2nCzF8YK8qJRWg+E/jmn8Yib4eOsg8Yw=;
        b=QRVa27SI0X+SW7TPhBf5bpAgL9vXmnw+L3f3zUTH5d0ql6PupNVFUL/Om5dI2dSAvO
         zcatTLGImEOjW0Kj//63N8dhn6UPaz0LDMQAmHOthfJQ/TFTA4OZmfNVyrGPJ22Ya8qm
         TM93P8+fEyyu9+ztnlfUL1c9zbz0R8V9Hoft3ye85s8kpuGn2IqjtY6b9g+BcvnjBjQB
         a/7EY0I0dNpo0Tr6C/gAKixUgC7bayr8VuJr1k7cmNCDcYk/TTGDUEqCFfaBrCK44Qlm
         fpI9dlXZIuOvWPr3UJ9BH5Tqp7vazAff5NwvDV9LN0xnD0EnAcHcoGfPP6xuk5Oy0hM5
         7xsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=redNRYVw53Y2nCzF8YK8qJRWg+E/jmn8Yib4eOsg8Yw=;
        b=f1nLteKU5Kw4ILLRYLHqdhPZS6oRCUqpO0dEOqndc2xAQOhpkI8HuUYsJKX/NDgoik
         r3rmbOqk2Z3sI95ttyLudslhRLqZjpl0jXlZf6iAurMAnyuX747ZXShF7b3VbrMRN8xp
         RmPc/WpA0+ygQVw668hYXjjT4eL57AR1ll/qkMhkRwdw8URMSCh566TPAF+ZWy9OD37I
         iob6UhYE+u2Gw9P+TGG5/tUZsWSeLmD2mkhpniy8vh/bQFrKpU6Fn5gIyqcp5P8epDlm
         OXAkCH3y5kBKzYIDKkDNNy27eyTJyKQuxBRo8uHxoTu9lK98OyFFOlolYE7aDD+udaib
         Cm/A==
X-Gm-Message-State: ANhLgQ0lVCJNo/zB+5sXn4cffhwpFzXRklQsicQvNcFK0T3bI5oBzCTk
        btRWpc9z/uPxZQgv97gPgTTJkbu6
X-Google-Smtp-Source: ADFU+vujeSQkRIaayKuK4ZL81AIk/et17mSMe8Di6h0XTOt5pjgnj3rAeTyprQjvcZli5Uu/gTueFA==
X-Received: by 2002:a62:1c4c:: with SMTP id c73mr11219435pfc.64.1584736842887;
        Fri, 20 Mar 2020 13:40:42 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id d5sm6219522pga.36.2020.03.20.13.40.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 13:40:42 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 4/6] emulator/bthost: Add support for ECRED Connection request/response
Date:   Fri, 20 Mar 2020 13:40:36 -0700
Message-Id: <20200320204038.11799-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200320204038.11799-1-luiz.dentz@gmail.com>
References: <20200320204038.11799-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for ECRED Connection request/response which will be
used by l2cap-runner to test L2CAP_MODE_EXT_FLOWCTL mode.
---
 emulator/bthost.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 6482bbecc..0fa283464 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -1773,6 +1773,69 @@ static bool l2cap_le_conn_rsp(struct bthost *bthost, struct btconn *conn,
 	return true;
 }
 
+static bool l2cap_ecred_conn_req(struct bthost *bthost, struct btconn *conn,
+				uint8_t ident, const void *data, uint16_t len)
+{
+	const struct bt_l2cap_pdu_ecred_conn_req *req = data;
+	struct {
+		struct bt_l2cap_pdu_ecred_conn_rsp pdu;
+		uint16_t dcid[5];
+	} __attribute__ ((packed)) rsp;
+	uint16_t psm;
+	int num_scid, i = 0;
+
+	if (len < sizeof(*req))
+		return false;
+
+	psm = le16_to_cpu(req->psm);
+
+	memset(&rsp, 0, sizeof(rsp));
+
+	rsp.pdu.mtu = 64;
+	rsp.pdu.mps = 64;
+	rsp.pdu.credits = 1;
+
+	if (!bthost_find_l2cap_cb_by_psm(bthost, psm)) {
+		rsp.pdu.result = cpu_to_le16(0x0002); /* PSM Not Supported */
+		goto respond;
+	}
+
+	len -= sizeof(rsp.pdu);
+	num_scid = len / sizeof(*req->scid);
+
+	for (; i < num_scid; i++)
+		rsp.dcid[i] = cpu_to_le16(conn->next_cid++);
+
+respond:
+	l2cap_sig_send(bthost, conn, BT_L2CAP_PDU_ECRED_CONN_RSP, ident, &rsp,
+			sizeof(rsp.pdu) + i * sizeof(*rsp.dcid));
+
+	return true;
+}
+
+static bool l2cap_ecred_conn_rsp(struct bthost *bthost, struct btconn *conn,
+				uint8_t ident, const void *data, uint16_t len)
+{
+	const struct  {
+		const struct bt_l2cap_pdu_ecred_conn_rsp *pdu;
+		uint16_t scid[5];
+	} __attribute__ ((packed)) *rsp = data;
+	int num_scid, i;
+
+	if (len < sizeof(*rsp))
+		return false;
+
+	num_scid = len / sizeof(*rsp->scid);
+
+	for (i = 0; i < num_scid; i++)
+		/* TODO add L2CAP connection before with proper PSM */
+		bthost_add_l2cap_conn(bthost, conn, 0,
+				      le16_to_cpu(rsp->scid[i]), 0);
+
+
+	return true;
+}
+
 static void l2cap_le_sig(struct bthost *bthost, struct btconn *conn,
 						const void *data, uint16_t len)
 {
@@ -1819,6 +1882,15 @@ static void l2cap_le_sig(struct bthost *bthost, struct btconn *conn,
 		ret = l2cap_le_conn_rsp(bthost, conn, hdr->ident,
 						data + sizeof(*hdr), hdr_len);
 		break;
+	case BT_L2CAP_PDU_ECRED_CONN_REQ:
+		ret = l2cap_ecred_conn_req(bthost, conn, hdr->ident,
+						data + sizeof(*hdr), hdr_len);
+		break;
+
+	case BT_L2CAP_PDU_ECRED_CONN_RSP:
+		ret = l2cap_ecred_conn_rsp(bthost, conn, hdr->ident,
+						data + sizeof(*hdr), hdr_len);
+		break;
 
 	default:
 		printf("Unknown L2CAP code 0x%02x\n", hdr->code);
-- 
2.21.1

