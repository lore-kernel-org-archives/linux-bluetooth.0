Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6A5C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Oct 2021 21:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33BCC61212
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Oct 2021 21:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhJTVvD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Oct 2021 17:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbhJTVvC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Oct 2021 17:51:02 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FA8C061749
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Oct 2021 14:48:47 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id t5-20020a17090a4e4500b001a0a284fcc2so1570312pjl.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Oct 2021 14:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IuGa2QPJpftocW8isLuMSQ2KWeu77Go79pc3YM6U+TM=;
        b=NB4G/xeRiePWcSSIFGwIsHUoYr9bYMbR2qO2agrttP0IJV2S9y8u07owTRIcJ0SXaG
         j+u/IYLNDFZk0EqNezBYJLNZCoMVoN94PeTyxB9+StmTHw2jEMETAOCxMSclvB9fnuM1
         1g8aSx9QX/W+1awpRuvYOKW8lC4cU2RN4ZS0m/UpegX78qSOz65dkJC3Pirm1zaMP5qJ
         9VI2BECfR5T4Be08ItMdtUR5a437btPB4hpdbJaTOYl4LuBOf5zo9gkC2L66RZDjilYP
         Aeb6WOeLb2GszrRRmq6Qjx8TwhLh/+VtSKuRs1ZAWizWrD7fz0BUEN7+m1TxTdl2cznB
         NMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IuGa2QPJpftocW8isLuMSQ2KWeu77Go79pc3YM6U+TM=;
        b=E6sioM1JKZuYbXtbIoGyAmIdNJPyzb9qi4wC1IbZdbdL9mVdyop3HDCR7jEggnU/ay
         P/I1FmOO+DX8cakJE4EDjIhtnbEulkbG6vN/Su5Zsct7UIQ2POwqbcEMpug5Q2HkJkKz
         gGs1t/Ytabw41d9TwNVW58UnkeVmy387Z4ZDPb0nJtY5UERE5psLuKbw/G7WG2AAbT1f
         ELMBGbl7DDcudKmYXXopFHgCFVfQjf7CweJNWdeGmzT5foEiBEJa0uxAhwILJItaKn97
         p6savfcmXT1OVJz+XVpMlV08e45IbYI/J2cxkqzkyot7TGfRoZub3xXtvUXKNRT03GLv
         /GlQ==
X-Gm-Message-State: AOAM530oFRzt6V8cpll6HbIaoHVRT/lst+gPEZdufeKn99VGLTxVB1gB
        Ao3Eu7FIzQAQhrsfVYVX4v4ryG9cvZQ=
X-Google-Smtp-Source: ABdhPJwqSyeN6XLFWYsATD3QUuh6WQ4zxqAcgODb0YccQUJp2hZGQbs9EXU8j90jtY+mvXCMMMWsHA==
X-Received: by 2002:a17:903:1207:b0:138:e2f9:6c98 with SMTP id l7-20020a170903120700b00138e2f96c98mr1620350plh.11.1634766526772;
        Wed, 20 Oct 2021 14:48:46 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b13sm7257664pjl.15.2021.10.20.14.48.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 14:48:46 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/6] monitor/msft: Add feature bits definition
Date:   Wed, 20 Oct 2021 14:48:39 -0700
Message-Id: <20211020214843.431327-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211020214843.431327-1-luiz.dentz@gmail.com>
References: <20211020214843.431327-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the feature bits definition used in
HCI_VS_MSFT_Read_Supported_Features.
---
 monitor/msft.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/monitor/msft.h b/monitor/msft.h
index d2921f4c8..e6e3019be 100644
--- a/monitor/msft.h
+++ b/monitor/msft.h
@@ -30,6 +30,13 @@ struct msft_cmd_read_supported_features {
 	uint8_t subcmd;
 } __attribute__((packed));
 
+#define MSFT_MONITOR_BREDR_RSSI			BIT(0)
+#define MSFT_MONITOR_LE_RSSI			BIT(1)
+#define MSFT_MONITOR_LE_LEGACY_RSSI		BIT(2)
+#define MSFT_MONITOR_LE_ADV			BIT(3)
+#define MSFT_MONITOR_SSP_VALIDATION		BIT(4)
+#define MSFT_MONITOR_LE_ADV_CONTINUOS		BIT(5)
+
 struct msft_rsp_read_supported_features {
 	uint8_t  status;
 	uint8_t  subcmd;
-- 
2.31.1

