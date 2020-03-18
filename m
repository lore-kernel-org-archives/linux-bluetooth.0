Return-Path: <SRS0=jOg2=5D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510B9C4332D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 21:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2688A2076C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 21:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKYwhlLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgCRVva (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Mar 2020 17:51:30 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37958 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgCRVva (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Mar 2020 17:51:30 -0400
Received: by mail-pj1-f68.google.com with SMTP id m15so25414pje.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2020 14:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=redNRYVw53Y2nCzF8YK8qJRWg+E/jmn8Yib4eOsg8Yw=;
        b=RKYwhlLzzuZtzK0RO3BuybZ1eloBsvTJSCicNijx1SEDkpSU7/2yxxbqfI6mWPquwJ
         D8aGPKLnlCkN39LqYIeneO/UmumqFhtNNBgAgOKyCcDwjTY13R0vJnu5iVT4p7rCX78Y
         Gp8Yd8hot2HnhtKDsTrFHNuGkbOcvl3sx8iSyJbfIqfmaQNuhI561OiNVHqihTJWNhRu
         zahWH/9S/s7bBVCbKBMi6hL+EbRm5yUSeV1kQ3fhTxuwzFuQy9RR9sQmoxo0A2lXKLHL
         d961VwLExn6TpkYaFNrRgiDeI30apIJn56+T8Mvxw8vHqLy/ipx3nrd/Q482PgW+hvuW
         OUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=redNRYVw53Y2nCzF8YK8qJRWg+E/jmn8Yib4eOsg8Yw=;
        b=c0owKnHe08MKqel/reVzqYJHy07K/c3EBpn0eL2gkT7Na2M5CuUnf++HAJlY1Pv6Uz
         NFpdzvEHZRf2Z/inj1Md+ERiVkdpqf/fAnu+iPhJ6BY4ZDA0RZv2aqgmo4w2a9g3RqLj
         /6q6q7TIsPDpeNt1EVIEQtjZm+jL1qK7bxpUutmRRAbWsoA9z4GxDcaS0GRAwZKJcCzx
         WpvBK59s8fX+UPFyXxCAg+8OIR7Hh7GoohliGlZVuxGwukEapisuiaKCM5pzCsj+oxRH
         hNuWSFquc7LmXCLBtya7XKZZPAMXMC+ovZP4cS6C2TdYuH44FkyoHhg5JX+CGUAybMjW
         aQXw==
X-Gm-Message-State: ANhLgQ1ejfuFmHdHXC62wwPVaNeueNA/dkPY3pGuIDJfUr5A0Vi+WvxR
        KZF8inQ/KbIRpCh89mLvTCOrw/pZ
X-Google-Smtp-Source: ADFU+vsFVBwjBlor2L5i3vDTWDXicXLkeC0NzXpTTfwEWVqvh0Vq3JG7zg6HWsqRRTplbLp6bTmEpA==
X-Received: by 2002:a17:90a:2710:: with SMTP id o16mr303815pje.110.1584568289101;
        Wed, 18 Mar 2020 14:51:29 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id r13sm83709pgf.1.2020.03.18.14.51.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 14:51:28 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 4/6] emulator/bthost: Add support for ECRED Connection request/response
Date:   Wed, 18 Mar 2020 14:51:22 -0700
Message-Id: <20200318215124.21880-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200318215124.21880-1-luiz.dentz@gmail.com>
References: <20200318215124.21880-1-luiz.dentz@gmail.com>
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

