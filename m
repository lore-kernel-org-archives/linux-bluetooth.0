Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6365C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 15:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F82660F94
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 15:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236749AbhHCP1p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Aug 2021 11:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236716AbhHCP1o (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Aug 2021 11:27:44 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C257C061799
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 08:27:31 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id j3so9059161plx.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 08:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8XRuBGVk2TTwf9hGVxYImjah4Tr644Zkbwg4wofK/FY=;
        b=MQsgJNMfR+UCfzZoI3VN9d1zrZA9DLouL3DIB/inowYdG23QMuaAgMKtumqCbe60hU
         hfJrhY0YQ1N6DR4fseGUB/opus6JMgD2941bmDYk4RJv6Udt+vn6oDHGXJjmM6CYu743
         En7wyZ2crsIcka5MgxJqoapjOOphI73cAQc0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8XRuBGVk2TTwf9hGVxYImjah4Tr644Zkbwg4wofK/FY=;
        b=cAToWKGSvZcTZ2rQR7coojXWe7IwQ73UBS52BvlK/8YfQa8LVDZWUAHaglSAU1cF6M
         uN43gRT/PAyYjlQsUbpJtwRwIn/EGpVAIbT2b+7pQ9XL00u7W2BvmXRo2azi552L1qJg
         xLMMX3Y/a8nNV3ILXux6cs3mtg2hgm1VUMBF9e2vlYLw5QmI3/qHN2YKNxBxT3UZ/TJe
         9nIzG2PTLQZhK1ae33bp4o7ekEN4dpBdzWKHMzKi3UXcr2zENKOmJEr+C6WHAGxtCwxd
         ih4Yx9LK7RVfwXIKJabbSOb2y6hVboePZuCePs9mE4bq1crNKPHyJwzEUt7AtZOpF71B
         aRMA==
X-Gm-Message-State: AOAM531zFDIc7m1ANStaFqJXs3qGTf5UHMoKjChDSKgJbFcepXFrL2wS
        Zxo49KmXj9MutNFhHZp3e9V4CUrr74M+oA==
X-Google-Smtp-Source: ABdhPJy9VclF+eTNA91o9qVXsvOaHpY5kQ7ePpLs4p9ejb4RA0IUMI0a1MTIDdc48+r1k+Cerpz5SQ==
X-Received: by 2002:a17:90a:558c:: with SMTP id c12mr24183440pji.124.1628004451025;
        Tue, 03 Aug 2021 08:27:31 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:7cf5:7e9:5266:c8ba])
        by smtp.gmail.com with ESMTPSA id v30sm14922493pgk.25.2021.08.03.08.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 08:27:30 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Kiran K <kiran.k@intel.com>,
        Joseph Hwang <josephsih@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/4] Bluetooth: btintel: support link statistics telemetry events
Date:   Tue,  3 Aug 2021 23:27:17 +0800
Message-Id: <20210803232539.v5.2.Ifb35feb49ec588106b256c508259500583582125@changeid>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
In-Reply-To: <20210803232539.v5.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
References: <20210803232539.v5.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
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
2.32.0.554.ge1b32706d8-goog

