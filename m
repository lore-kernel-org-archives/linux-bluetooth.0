Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6208BC4320A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 10:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E80860560
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 10:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240144AbhHEKDZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Aug 2021 06:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240087AbhHEKDX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Aug 2021 06:03:23 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FE0C0613C1
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Aug 2021 03:03:09 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id j1so7449629pjv.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Aug 2021 03:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8XRuBGVk2TTwf9hGVxYImjah4Tr644Zkbwg4wofK/FY=;
        b=cx7QG8BfkGZGWzDxJty+84rmZqIXWHoanpTdk8ibesKW1mSmOx8J/JE9xciyO7sqAa
         ae641fMfbrOKA74Nlm+mCetqEhdXfyuxOSpVo1kpLvwoEbRCugaAyBLD6nGYXFC/U9Bh
         3+W6yPuxG58z0hRd3ehdh0Ri9KMYAHS4a7bKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8XRuBGVk2TTwf9hGVxYImjah4Tr644Zkbwg4wofK/FY=;
        b=MrC3iKo0csJfN8dBhCdNzC0EzXNnSEQOgARxeF+MfPuboYJxH9JkwCHYyd8dJGrH9j
         Wcz++tm+h3Bi6A7Xa8R3KFnsyYjU0cZNHVqQe+q7Wz8oesMorMgtY4Y0XhHQIL3IOdj/
         EjOTabVABttd7kIiP7sMHCnGkGapySnFM+CnbcCejM4p49W/tTA2e8Z0R660KimJ72gJ
         26907cuRsKHLEG3cDRH1htij1U+q2HCTPcbroKlJ6w1trEycn2ZM15o4uetrQYYtPjSV
         ZguyQSnRx+5e/MP+D9LqyGOIah/P3+YaQGacx3b47hNKoW7bBI6ar7r+qiqC5nmYZb6g
         oxMg==
X-Gm-Message-State: AOAM532qObRcKigXwoK2XzalXp2j9XDoxifeWmfsyP1niOn/zhQOPpnn
        fDDCqRhY6rxjeqeamPhmWEb6AYBljZpSCg==
X-Google-Smtp-Source: ABdhPJwY8zMelHeMSEHYuzv7SX1IK/yoIrC+1fHDKJyykogs5DKAeC6uKxJn/YFkGH2bF+DjXWJnGA==
X-Received: by 2002:a17:902:c205:b029:12c:daac:c8a0 with SMTP id 5-20020a170902c205b029012cdaacc8a0mr3260744pll.13.1628157789141;
        Thu, 05 Aug 2021 03:03:09 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:2c18:41ac:c6a8:ddfe])
        by smtp.gmail.com with ESMTPSA id jz24sm5436194pjb.9.2021.08.05.03.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 03:03:08 -0700 (PDT)
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
Subject: [PATCH v6 2/4] Bluetooth: btintel: support link statistics telemetry events
Date:   Thu,  5 Aug 2021 18:02:58 +0800
Message-Id: <20210805180227.v6.2.Ifb35feb49ec588106b256c508259500583582125@changeid>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
In-Reply-To: <20210805180227.v6.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
References: <20210805180227.v6.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
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

