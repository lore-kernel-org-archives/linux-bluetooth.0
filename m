Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE66BC49361
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jun 2021 08:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2A5C613B9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jun 2021 08:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbhFRID1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jun 2021 04:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbhFRIDH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jun 2021 04:03:07 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED74C061767
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Jun 2021 01:00:48 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id i4so568645plt.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Jun 2021 01:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=InZhYqpv8m1+7VVhTH77wgZ+W95Cha0AWCB0EvIdTXY=;
        b=l83ZIor3bdYFAsNOHzp84GWE6gE7BJQCkA7D5v97xxbKaYtL51nEoYZuwqMhSSCqlK
         aiSeOv4a+G+Mi1fDk+3zeb7eTOvgofYzoGznWAMxMuhgKCftUdRBBIfLexFg/cCvys9x
         YYIonzEqgaQulejtTIB8L2qrcffRlL8NRrIps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=InZhYqpv8m1+7VVhTH77wgZ+W95Cha0AWCB0EvIdTXY=;
        b=XBmywroHIXXR5wwJPahzwADu8bLWCwwRLG7KykZeidVzfw0tPyWzlr0Ppxncw4sFSy
         im0fe9S688+zYUlBnjM5VkSeJ29ml0rwMOHJSjU5th2VABt+8wZL0/w/AbpIxL3jszI3
         BancXX1Z9uFyOSAEWtWhKkENSJZxgJrsNrDeSrKFwGAuqsdvtZIBD0NIXVLjaNntJErj
         hyrJb5ql//RvveHe/81/75AejHFKtUAZwVRpAP0cViK9d45EMfd9yD2pPgqFWUYGEDbf
         HQvXz0LPs1KweLet0nDVPVUGMuR0a5yEknz3PukiF2QKfd4h/rQ6PjJzEcoS7Otei2K+
         2ycw==
X-Gm-Message-State: AOAM530v3hXp9gMhBjMaJIrtr1Bqg+JJCEhds9luXXdpmSyCDOy9PjCM
        xBecw+eBLffFS30CyCnbc3O4jNh0Qf3YJA==
X-Google-Smtp-Source: ABdhPJwEOwojVPfMDqPw6N+jQgIklXCslZ1wyeDFGuamDh2i+cfIgN6tDoZqI6KRL6tWX1uBfViXAw==
X-Received: by 2002:a17:90a:4e4a:: with SMTP id t10mr9845003pjl.173.1624003247772;
        Fri, 18 Jun 2021 01:00:47 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:6cbb:95eb:e2ae:8479])
        by smtp.gmail.com with ESMTPSA id v21sm7341671pfu.77.2021.06.18.01.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 01:00:47 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Kiran K <kiran.k@intel.com>,
        Joseph Hwang <josephsih@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] Bluetooth: btintel: support link statistics telemetry events
Date:   Fri, 18 Jun 2021 16:00:37 +0800
Message-Id: <20210618160016.v4.2.Ifb35feb49ec588106b256c508259500583582125@changeid>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
In-Reply-To: <20210618160016.v4.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
References: <20210618160016.v4.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Chethan T N <chethan.tumkur.narayan@intel.com>

This patch supports the link statistics telemetry events for
intel controllers

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

(no changes since v1)

 drivers/bluetooth/btintel.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index e44b6993cf91..fd21ddb76928 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1248,8 +1248,10 @@ EXPORT_SYMBOL_GPL(btintel_read_debug_features);
 int btintel_set_debug_features(struct hci_dev *hdev,
 			       const struct intel_debug_features *features)
 {
-	u8 mask[11] = { 0x0a, 0x92, 0x02, 0x07, 0x00, 0x00, 0x00, 0x00,
+	u8 mask[11] = { 0x0a, 0x92, 0x02, 0x7f, 0x00, 0x00, 0x00, 0x00,
 			0x00, 0x00, 0x00 };
+	u8 period[5] = { 0x04, 0x91, 0x02, 0x05, 0x00 };
+	u8 trace_enable = 0x02;
 	struct sk_buff *skb;
 
 	if (!features)
@@ -1266,8 +1268,24 @@ int btintel_set_debug_features(struct hci_dev *hdev,
 			   PTR_ERR(skb));
 		return PTR_ERR(skb);
 	}
+	kfree_skb(skb);
+
+	skb = __hci_cmd_sync(hdev, 0xfc8b, 5, period, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Setting periodicity for link statistics traces failed (%ld)",
+			   PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+	kfree_skb(skb);
 
+	skb = __hci_cmd_sync(hdev, 0xfca1, 1, &trace_enable, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Enable tracing of link statistics events failed (%ld)",
+			   PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
 	kfree_skb(skb);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(btintel_set_debug_features);
-- 
2.32.0.288.g62a8d224e6-goog

