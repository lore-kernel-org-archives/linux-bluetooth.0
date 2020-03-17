Return-Path: <SRS0=BuFd=5C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD00C2BB1D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Mar 2020 02:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1BF620674
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Mar 2020 02:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j71QDGsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgCQCLt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Mar 2020 22:11:49 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38990 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgCQCLs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Mar 2020 22:11:48 -0400
Received: by mail-pl1-f196.google.com with SMTP id m1so695512pll.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Mar 2020 19:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=redNRYVw53Y2nCzF8YK8qJRWg+E/jmn8Yib4eOsg8Yw=;
        b=j71QDGsxOk8PPbwL2LjXMMNgIdP/17xyFCirvyYwdUmg2t0jbGh0VyxXRgpWhocUjx
         HQ9TK3w2naT6AawVsAHJV2aJLVNBeXBnIgw7AYdQ1HNQ6cm6H7h1HLnyFczo5q6/DTRy
         AgSd4B6JzNvOqPS/a0du/cW3kUBDxJyG6X4/aT9YknAkSrWorL57fAoxXvYO2rcLrJIv
         StA2Mw7xdgaOjW6d0uoS1nbNAvCMewiP2zafQjBosqbg5x8cOZDQl9bW1KGStPFEkqI5
         w3w3y7PrYQNXKlhOyB4VELLUgWCkma8Ival77L39BZZvSLpXz+e7oTD93b+C5Bcx4k+a
         9LrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=redNRYVw53Y2nCzF8YK8qJRWg+E/jmn8Yib4eOsg8Yw=;
        b=pn2dn8vTBy6U/rUQ9GwRmzsLtMPNxgcRCMM4s5qgLe+l1pmLSLIfs5db+hHoUtdJlN
         q89RZExCpMR8BJ7762j6oDJRBYoifUWAc8oaEIq+vV1svpZEpCEC0lEDa6QvPHMvIB5S
         t+rxQ9tdIJujqac2onidsc/m5i/eeH9WJQkVyDnb/2/D9b8NSiiGd2D94ciQzEQbaSCQ
         c02Z59BDxyr9+JQEGXQ4MVrnXkMJGLE1n6JUlf2LTiwsDZDuRMEx1hAfXB871PEUjVhe
         9Z8ug76RUI5C8TUIe0RqDtk73dOUNpN3JT9RP9S6DXwu/mYm16iwjQzkol5qoqcyyMhc
         KXsw==
X-Gm-Message-State: ANhLgQ3pwZVLp1Mp/Id8cN437ufmxfo4iJfh4/CMfp2URr+o3evEcF/w
        qO8a5SS9zLclOrtXGMHNXQWhs8/hAk4=
X-Google-Smtp-Source: ADFU+vtfs/mSVwrgtKVSz1aBTp3k9L/SM3OenmZD3A7c2UEIFMKinl8Yg5/MIa0uxSVS0lg8XfV5RQ==
X-Received: by 2002:a17:902:b286:: with SMTP id u6mr2097444plr.280.1584411106868;
        Mon, 16 Mar 2020 19:11:46 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f19sm700769pgf.33.2020.03.16.19.11.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 19:11:46 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/6] emulator/bthost: Add support for ECRED Connection request/response
Date:   Mon, 16 Mar 2020 19:11:39 -0700
Message-Id: <20200317021141.16398-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200317021141.16398-1-luiz.dentz@gmail.com>
References: <20200317021141.16398-1-luiz.dentz@gmail.com>
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

