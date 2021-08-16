Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3026CC4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Aug 2021 14:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04DC460F39
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Aug 2021 14:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhHPOai (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Aug 2021 10:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhHPOai (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Aug 2021 10:30:38 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0A7C061764
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Aug 2021 07:30:05 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id k5so7007494lfu.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Aug 2021 07:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1FTyxWhF82ipYTsVFvJpZeL/btz8Utu8BJqwqEetVps=;
        b=mmI+UFoV9f7c90wdinSV6fXqEoOiWPXVBSN9S5rMejHsUnifKhAfAgao33FwfN8DUn
         /l2UFb+tzb9lFoQfC+NNsP8wc5lktwHdKgH3aClFsz3nPk8nxCmzi4Z59+mjUt52TobT
         NKq8bw/HT7Dw4a96cnTbvsHwhQkSZdI5AxQRu5tg26PpeyKqqRj23iGOT57Qo6i4y7+z
         Mvby0ZKD6FcYM7QEHRYB6PfMeYyZbNXKxKX3YYJugkr4f9qwz5vnFFD6Xf7qHlJLxY1f
         cvKgxY/26hBmCITwIzLzftDgER+Idxa1+EznClxvFIRu4lfg8wjoWK6sVKp0oVUbFSKR
         yAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1FTyxWhF82ipYTsVFvJpZeL/btz8Utu8BJqwqEetVps=;
        b=X3+jfVtD7F6bTTaiiEBmH+vAyd8yzv1ZuZbBmBlEKGoq2jgxZ9HcVanglgBjN/3Xc4
         TjpI/YJ4s5IwVOAtsa00q018MAlP4mpH87oIn8It9FTlpVd38QaCvdoY+AALPYFulEBn
         LC5v6hYRmhj6j5mLJjSKZlpoj4E1omJ2KRhrSCFF8L8BGpiari4O/UbEYAi8+QzgN4k0
         HgThnfPnvk7klmeu9fcHNpyrSRardk6zp8QxV3GFpar8WO/eY/ILK1a69xjm5qhpLE9J
         5tBn2fhsGNesu117ttTsv7p3pEPrSp8LgqMUw9FBCN5lqk74KHeHgwjFHPz2lf+XPodp
         ybhA==
X-Gm-Message-State: AOAM530eUYuU0jD/bbW/f7ocdxhos6Tic4vtvRFipfmCh2wljbFOUz5K
        7dKEsGSEbnlIm+yBLLlLwPdhjBpa1x0ErQ==
X-Google-Smtp-Source: ABdhPJy+5sCc8zpQtRnFKV9rA3LAj3xNDqL75u2fvlF31sE++3QtP94O1GJ9EFWkvLQhQ7/tLZcEOg==
X-Received: by 2002:a05:6512:2210:: with SMTP id h16mr2910996lfu.621.1629124203985;
        Mon, 16 Aug 2021 07:30:03 -0700 (PDT)
Received: from localhost.localdomain ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id t142sm959619lff.269.2021.08.16.07.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 07:30:03 -0700 (PDT)
From:   mariusz.skamra@codecoup.pl
To:     linux-bluetooth@vger.kernel.org
Cc:     Mariusz Skamra <mariusz.skamra@codecoup.pl>
Subject: [PATCH 1/2] monitor: Fix Maximum PDU type in CIS Test Param
Date:   Mon, 16 Aug 2021 16:29:55 +0200
Message-Id: <20210816142956.1690272-1-mariusz.skamra@codecoup.pl>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Mariusz Skamra <mariusz.skamra@codecoup.pl>

The Maximum PDU in CIS Test parameters is 2 byte value.
---
 monitor/bt.h     | 4 ++--
 monitor/packet.c | 8 +++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 738bc294b..0bc5718a0 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2681,8 +2681,8 @@ struct bt_hci_cis_params_test {
 	uint8_t  nse;
 	uint16_t m_sdu;
 	uint16_t s_sdu;
-	uint8_t  m_pdu;
-	uint8_t  s_pdu;
+	uint16_t m_pdu;
+	uint16_t s_pdu;
 	uint8_t  m_phy;
 	uint8_t  s_phy;
 	uint8_t  m_bn;
diff --git a/monitor/packet.c b/monitor/packet.c
index 025b7e9b0..210c03259 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -8063,12 +8063,14 @@ static void print_cis_params_test(const void *data, int i)
 
 	print_field("CIS ID: 0x%2.2x", cis->cis_id);
 	print_field("NSE: 0x%2.2x", cis->nse);
-	print_field("Master to Slave Maximum SDU: 0x%4.4x", cis->m_sdu);
+	print_field("Master to Slave Maximum SDU: 0x%4.4x",
+						le16_to_cpu(cis->m_sdu));
 	print_field("Slave to Master Maximum SDU: 0x%4.4x",
 						le16_to_cpu(cis->s_sdu));
-	print_field("Master to Slave Maximum PDU: 0x%2.2x",
+	print_field("Master to Slave Maximum PDU: 0x%4.4x",
 						le16_to_cpu(cis->m_pdu));
-	print_field("Slave to Master Maximum PDU: 0x%2.2x", cis->s_pdu);
+	print_field("Slave to Master Maximum PDU: 0x%4.4x",
+						le16_to_cpu(cis->s_pdu));
 	print_le_phy("Master to Slave PHY", cis->m_phy);
 	print_le_phy("Slave to Master PHY", cis->s_phy);
 	print_field("Master to Slave Burst Number: 0x%2.2x", cis->m_bn);
-- 
2.31.1

