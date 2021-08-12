Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACF1C43214
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Aug 2021 09:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A72CF6101E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Aug 2021 09:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbhHLJQl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Aug 2021 05:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235827AbhHLJQk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Aug 2021 05:16:40 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF21BC0613D3
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Aug 2021 02:16:15 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id hv22-20020a17090ae416b0290178c579e424so9711574pjb.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Aug 2021 02:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qo2S1l3e71xDGUQfWsHR5ktR7WTQXcYye34NKBDFtAI=;
        b=deU0oWZd89aB+49trFKTOg7MKEehWm8yLg8rNgsXBEGCWV1v15OF44GlTt9DcEbp6a
         51WTBNB+buaDEiLBGv9vdNpgrCepUTvheY31H1CuK4rkNnFp4qBBEd4YRiDV4xipvyvl
         1GIrm64DUsJV2t3g7ECk4FbyrJgKHwddpTk8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qo2S1l3e71xDGUQfWsHR5ktR7WTQXcYye34NKBDFtAI=;
        b=Ac6caMEi+gwjVmXUmCzfeExzXKw7J8ubpdhplJjK/LIxyEMo/Onyhp9kxVv7WHpnR8
         jmvqzMTBhhvGJjTAF+eeMbDT/eeRZEQIoxFgX2ac6us8VeqcBjW+eFKtFfbV4xtSLd4r
         H2sqvBVWJXmeRORhl8upxTk8l0e3/SRad9q5HNM8YLXDcAQF0hoDIldEtTO2g/n1LAqq
         oTqmG2pYMD9r3R3FIaDJ9aBCbdTSS3NavQrsZIonAn9xEvj4tNT5nT5vxIwFVd4TK7+g
         2tGn7p1KcAoINM/Jh52Wbez1yrmI19NTi3PpaRW5Dq2twuUEhfLecUiEobPxUmc9bYis
         eicQ==
X-Gm-Message-State: AOAM533x2qtBunYL6fV62aI9VbTrMttDbM42/SrIP2H3zUlkbooEO4aA
        1txcWL7te3KovQ28Sn8luCRe1uX6WoDrXA==
X-Google-Smtp-Source: ABdhPJzNk2Yzm3LutyAtcCBrSoc9D+D7v05i7cWh8iXHxER79J/h5SimnxqluGa/hkGVKVgl8CYJnQ==
X-Received: by 2002:a17:90a:de8b:: with SMTP id n11mr15509950pjv.31.1628759775173;
        Thu, 12 Aug 2021 02:16:15 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:8f67:7d0e:97df:b4b4])
        by smtp.gmail.com with ESMTPSA id n32sm2563966pgl.69.2021.08.12.02.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 02:16:14 -0700 (PDT)
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
Subject: [PATCH v7 2/4] Bluetooth: btintel: support link statistics telemetry events
Date:   Thu, 12 Aug 2021 17:15:59 +0800
Message-Id: <20210812171533.v7.2.Ifb35feb49ec588106b256c508259500583582125@changeid>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
In-Reply-To: <20210812171533.v7.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
References: <20210812171533.v7.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
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

Changes in v7:
- Rebase on Tedd's patches that moved functionality from btusb to
  btintel.

 drivers/bluetooth/btintel.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 0fe093fa5158..643e2194ca01 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1285,8 +1285,10 @@ static int btintel_read_debug_features(struct hci_dev *hdev,
 static int btintel_set_debug_features(struct hci_dev *hdev,
 			       const struct intel_debug_features *features)
 {
-	u8 mask[11] = { 0x0a, 0x92, 0x02, 0x07, 0x00, 0x00, 0x00, 0x00,
+	u8 mask[11] = { 0x0a, 0x92, 0x02, 0x7f, 0x00, 0x00, 0x00, 0x00,
 			0x00, 0x00, 0x00 };
+	u8 period[5] = { 0x04, 0x91, 0x02, 0x05, 0x00 };
+	u8 trace_enable = 0x02;
 	struct sk_buff *skb;
 
 	if (!features)
@@ -1303,8 +1305,24 @@ static int btintel_set_debug_features(struct hci_dev *hdev,
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
 
-- 
2.32.0.605.g8dce9f2422-goog

