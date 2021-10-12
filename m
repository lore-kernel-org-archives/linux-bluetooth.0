Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B63C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 21:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31780610A4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 21:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbhJLVeD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Oct 2021 17:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbhJLVeC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Oct 2021 17:34:02 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B50DC061745
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Oct 2021 14:32:00 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s75so333652pgs.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Oct 2021 14:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6UoyUe+ax+jaKr28X/12cCN2wqR6maKQNLjAocK5Tr0=;
        b=ladNkcZ2FuvKmqO/pCvKG31Dq7FOZOU8NpVpDd7Qq3OIZkNoPI/rJaoTXvHwk5uUyP
         Nm2koKuVbsbzj+VoALD11unbRugm+OtA88fVqafCY7lOmMucGn4wAnKlMP0mJhJOFW1s
         vceeK5udlljSI3AFErL1/rYzPukVamBzUrykTtsQE31e5ctnZUrIqOQVmfEQu4E1IyDr
         u+8wMX8WApYkXFBtmRgo1fNm2S2mzpBu2Jr9lgCZVpvotTBXmBN8Uhh0x16c71Er3Ejb
         6H0LHRNTMW2AhmlHaf8yUm0kn1xu/hYdjn5eG21ZefqCQM7NU5dRm1Jqe7u3ZQD8+jN0
         KGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6UoyUe+ax+jaKr28X/12cCN2wqR6maKQNLjAocK5Tr0=;
        b=ut/CaXULrvXO8PbkkbKKml3GH8h3S/7ycTn1AehkmPW99qoPt5NI4IDtbQXH7emXk0
         h+wfwAyZ545Nmba2qGwAQQgNoU5bWHx6ha1crGazH6bwTYDD8Co9NPaj9WJzEI02rDLE
         b2Pthj5cJBbeERbvrBWnbUFVaGNO/Y8h7g6k8cn3eAWhYLXyMi6Wf4yq8p5NxNkzho/t
         ZkdAAlbi4XcsTpd/AOF6SD4h0zgXD4odBRLBbweBmOiOp+jrZd9jSF+pEHpS5n1l80gU
         OYs+xsJcYCdnUQ7SG5RYD0OBgyOLU2ooREAME0CvnWipXMiWdm/R33ZRqRFmiBhxBjmF
         AlgA==
X-Gm-Message-State: AOAM533N9cuuuPxT64qexjsq8JgI8EXZLMgtNbGHaYrzFxXl4d5MY3Y+
        8unPiykh7bcQjFapjqSGo6r6wbhLHUo=
X-Google-Smtp-Source: ABdhPJz67Sgj38/vXXMEjlo3d9ygwj8LE40BQhQlLT/ODpozNVQY1aHUZSKkwr2Yc0Jvd8YExDbKQQ==
X-Received: by 2002:a62:1c4e:0:b0:44d:76b:de98 with SMTP id c75-20020a621c4e000000b0044d076bde98mr18747434pfc.16.1634074319841;
        Tue, 12 Oct 2021 14:31:59 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id on17sm3940900pjb.47.2021.10.12.14.31.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 14:31:59 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: Only allow setting AOSP capable at setup stage
Date:   Tue, 12 Oct 2021 14:31:56 -0700
Message-Id: <20211012213158.2635219-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211012213158.2635219-1-luiz.dentz@gmail.com>
References: <20211012213158.2635219-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The aosp_capable flag shall only be changed while at the setup stage
otherwise it can possible take no effect.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index eb5d4ea88c3a..ac81745d2ac4 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1283,11 +1283,16 @@ static inline int hci_set_msft_opcode(struct hci_dev *hdev, __u16 opcode)
 	return 0;
 }
 
-static inline void hci_set_aosp_capable(struct hci_dev *hdev)
+static inline int hci_set_aosp_capable(struct hci_dev *hdev)
 {
+	if (!hci_dev_test_flag(hdev, HCI_SETUP))
+		return -EPERM;
+
 #if IS_ENABLED(CONFIG_BT_AOSPEXT)
 	hdev->aosp_capable = true;
 #endif
+
+	return 0;
 }
 
 int hci_dev_open(__u16 dev);
-- 
2.31.1

