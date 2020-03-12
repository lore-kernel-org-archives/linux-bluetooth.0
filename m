Return-Path: <SRS0=41cZ=45=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DF8C10DCE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 22:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E7B206CD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 22:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBbVpnMb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgCLWZY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Mar 2020 18:25:24 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42217 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgCLWZX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Mar 2020 18:25:23 -0400
Received: by mail-pl1-f194.google.com with SMTP id t3so3227886plz.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2020 15:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=redNRYVw53Y2nCzF8YK8qJRWg+E/jmn8Yib4eOsg8Yw=;
        b=OBbVpnMb2HPvPHhQABwQu6xDslhdR6jAtJmMcrZxWGkeZwHJ0lZWzZOIDMCUQ0gCZf
         OnS99jIU35PLROsHOa6rHWzWswk5gIkgqY5IAndXOfy29FcVnZ/ACSnYJ4GigQqKtYMy
         cmYSapfpjcXlcO/DLmdBdTAnrxYqvb9RoJZurvRea9LYv3OlJEmv5QFvdNf5WZA/wK6+
         qxyYR45d2yVrzebnc92kO/nrlvkTOsbNdmB/nno4pvy7dzGvzg557E2uvd1GE/IvKKdT
         gNcQgIUoMQwuksg8MKnMGZHvgR6dJljYgwPrrbJIMnAQ3IRmWJ5J6DriB/Yas9jpkIHr
         MMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=redNRYVw53Y2nCzF8YK8qJRWg+E/jmn8Yib4eOsg8Yw=;
        b=lcKJmMT8eBY+FY6KZU4c5srUQvCyRKohryE7cD2weCCxpqs4f2cv5a9CX3Pbb4Royn
         7MLtuQ20lL47Jnt0Dsue7YHlVhm8JzPqPuwAJjQJJzMK5D2m9qTqLqiKI2ekz8+82xDB
         K3hEtDIa8mXYs+spPsva5U9dsfqwuQl/+BK50fLIMkTJ+OyVeFS8VyMQLE5H7a91WiHD
         Wk7kZ1xtbbImDwozpZdHN7Z72O/eyEmwkNHf7sdtFGhXDSq+r/EogKs0OlpSUv+NhVDw
         Y6ELtv4euqK3bxerP+IdZs4TFw/+g4+5BrlsFj2LGRCy37aG0qp7qK4IFmE29Jv8OSDk
         G3og==
X-Gm-Message-State: ANhLgQ1NF7ltjH00R905vGSo55WO7u3zWQYmVr8vbuqNLpehNEwpUf2B
        hjlZupyb3IEnokiysbDu8jinRygK30I=
X-Google-Smtp-Source: ADFU+vsGutQTr6vJAyYgoNBawM6k+5LMVrl+yes98SkkEWkcoMze9vEkyXKeIK4MpV68fD5azjJRIQ==
X-Received: by 2002:a17:902:b711:: with SMTP id d17mr9817680pls.316.1584051921699;
        Thu, 12 Mar 2020 15:25:21 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id i13sm4296468pfd.180.2020.03.12.15.25.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 15:25:20 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] emulator/bthost: Add support for ECRED Connection request/response
Date:   Thu, 12 Mar 2020 15:25:15 -0700
Message-Id: <20200312222516.5179-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200312222516.5179-1-luiz.dentz@gmail.com>
References: <20200312222516.5179-1-luiz.dentz@gmail.com>
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

