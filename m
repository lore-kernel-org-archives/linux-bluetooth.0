Return-Path: <SRS0=vyxk=RC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8322C00319
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Feb 2019 11:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE2320863
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Feb 2019 11:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBhqIINA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbfB0Lq2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Feb 2019 06:46:28 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43339 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728751AbfB0Lq2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Feb 2019 06:46:28 -0500
Received: by mail-ed1-f66.google.com with SMTP id m35so13595291ede.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Feb 2019 03:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=QnG5cNp7u1hsEkZlyOOVHLT/vzmgbgYcWrMxMjV64Tw=;
        b=OBhqIINALKQLkxkVJrwp1sOlRfoFqvJVWVlqFzfiQ05emR/deh638T74rlWEq1D2C6
         TLghMLVn4IpaquPC80NZOWeuijQKOrGybohDDaX6Y9EtfvXwWJXP4C7AAN+j+a1ZJMVm
         vkRqrGguoznguHZJR/nL1QshgKqUD4BgFaMKoqD+vP2qzCTcNidNaZOWHY2HUoPpF8zK
         ueCaQm3CC2Qi5+d9lm/lKPQGiPxeMf6KyF9vgkFxIcsMYNHcbIiuWop75plaKu1SBwvL
         j7KKZjXtvM9xL39AXbJgqqPjkC9Jp61qOjSCrqADaDWwtv4iCZf18TawbAR3Q82DI+Pf
         aEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=QnG5cNp7u1hsEkZlyOOVHLT/vzmgbgYcWrMxMjV64Tw=;
        b=IYcVMcOiRcuwW8kIpJCkXqr7MtTK8ei0bC7e171g/xg0vf9Pns1rSl4GKIjicprVgm
         abwDWIMtO8fo0KN2p5vZ/ztANezEMjVwxT/caTaDeHKlmmZxrN1ozXPSZH1OIbH5oRdK
         NKLpyk7/185d6AvHcJmNLvJUHrQTEI4Q6LqepHUEmDnrM0wSm34QYcic0BGHh64Upl/n
         +D9lZaU4rd3cMp8zQMeb3qH+m92EM6n6irDHTVd2x6+TzvmaZSlBiRWXIFu/MzZ6C0ZC
         gNq37Zy+4v2Rh/zZjqJputmksz0wlwSQ8n+hwHBptbVa+TRIfNDKCfdmAMqHC5AwSuJW
         MmGg==
X-Gm-Message-State: AHQUAuad0FbTi4KpCO2Y+JhkWRWJQc5MsFbXxX5vZ4rQBNbbozHztZBM
        5Aa/xx68SZPxGa57L0TLdEfKqsWAFMw=
X-Google-Smtp-Source: AHgI3IYIyLcY5ijD/jD+8l6gLRIf3yMtnXAlWe/Le9I5fpoSjlet+j9muWL4L1hgsE/GPxDHLSPH/A==
X-Received: by 2002:a50:9156:: with SMTP id f22mr2053465eda.131.1551267985955;
        Wed, 27 Feb 2019 03:46:25 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id l24sm2652333eja.57.2019.02.27.03.46.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 03:46:25 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/7] monitor: Add decoding support for LL_PHY_UPDATE_IND
Date:   Wed, 27 Feb 2019 13:46:16 +0200
Message-Id: <20190227114620.21630-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190227114620.21630-1-luiz.dentz@gmail.com>
References: <20190227114620.21630-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This prints makes the fields to be printed instead of just decoding
the PDU name.
---
 monitor/bt.h |  7 +++++++
 monitor/ll.c | 24 +++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index aa4057a7b..46d9b287f 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -136,6 +136,13 @@ struct bt_ll_phy {
 
 #define BT_LL_PHY_RSP		0x17
 
+#define BT_LL_PHY_UPDATE_IND	0x18
+struct bt_ll_phy_update_ind {
+	uint8_t  m_phy;
+	uint8_t  s_phy;
+	uint16_t instant;
+} __attribute__ ((packed));
+
 #define LMP_ESC4(x) ((127 << 8) | (x))
 
 #define BT_LMP_NAME_REQ			1
diff --git a/monitor/ll.c b/monitor/ll.c
index a65c93498..02ff1f628 100644
--- a/monitor/ll.c
+++ b/monitor/ll.c
@@ -513,6 +513,28 @@ static void phy_req_rsp(const void *data, uint8_t size)
 							" (0x%2.2x)", mask);
 }
 
+static void phy_update_ind(const void *data, uint8_t size)
+{
+	const struct bt_ll_phy_update_ind *pdu = data;
+	uint8_t mask;
+
+	print_field("M_TO_S_PHY: 0x%2.2x", pdu->m_phy);
+
+	mask = print_bitfield(2, pdu->m_phy, le_phys);
+	if (mask)
+		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
+							" (0x%2.2x)", mask);
+
+	print_field("S_TO_M_PHY: 0x%2.2x", pdu->s_phy);
+
+	mask = print_bitfield(2, pdu->s_phy, le_phys);
+	if (mask)
+		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
+							" (0x%2.2x)", mask);
+
+	print_field("Instant: 0x%4.4x", pdu->instant);
+}
+
 struct llcp_data {
 	uint8_t opcode;
 	const char *str;
@@ -546,7 +568,7 @@ static const struct llcp_data llcp_table[] = {
 	{ 0x15, "LL_LENGTH_RSP",            length_req_rsp,     8, true },
 	{ 0x16, "LL_PHY_REQ",               phy_req_rsp,        2, true },
 	{ 0x17, "LL_PHY_RSP",               phy_req_rsp,        2, true },
-	{ 0x18, "LL_PHY_UPDATE_IND",        NULL,               4, true },
+	{ 0x18, "LL_PHY_UPDATE_IND",        phy_update_ind,     4, true },
 	{ 0x19, "LL_MIN_USED_CHANNELS_IND", NULL,               2, true },
 	{ }
 };
-- 
2.17.2

