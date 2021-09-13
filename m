Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDBBC433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Sep 2021 07:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9492F60FDA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Sep 2021 07:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237657AbhIMHaD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Sep 2021 03:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237646AbhIMHaC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Sep 2021 03:30:02 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DAEC061767
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Sep 2021 00:28:47 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id h3so8627732pgb.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Sep 2021 00:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wzr/tDY+SZhvYSJPQ+K7kJlNJzjJfxAyxq+7vt2n+E8=;
        b=PapxB+4evxTDIxxsBZs5sP8wB4RESQHtmXbaiuABpZbRCivOVxFr/xnYn3ArvE2x45
         OkkT3PnMsDFTkOaZVqSgJa5Y27vFcvLL83iIUQfY6XO4XW2zayPuyH5wKFrHvZUva2DT
         5r154psCD4xPSSTD9vZmEwoY3Qikmhp9FVIQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wzr/tDY+SZhvYSJPQ+K7kJlNJzjJfxAyxq+7vt2n+E8=;
        b=udd7OXVWk7EI8qbWrZziIcRJmSze0U/iBG59CS9YfJuZAvPsBerK+b5/ZheW5KRQle
         V74aGECJtFN4sm1xj5pU+qFLTo6qV4h6ig/UsyvOvA3gU0Wp1FR3ff2ZMo44jESbHgx0
         d1J1iVy5wMPBT9LQyXcmJn8UQ6eNcDG3Z1+P62Bwrij18MGKVRy0wa6WN53qZNAIzcL+
         CK3aYu6IE4TRWws4oI5fWQ/SSfDO6stk8CZkywyIWG9X2OxWN9u5ZRb6sGJAsbTEFxXy
         uz5kELT1qgXk9rjZtzXmRbp22Qr8+gEfee/Hk6pOQwKCsecF8WX1nd80Q2XVMN6YysrL
         bdYg==
X-Gm-Message-State: AOAM530gqWZDZzu3Jbi45YNDiMeEzNhbqVj1o4zWVc/p/qKpG5X8p1Sr
        hkx2eSg/nWrLFv1cNsaAS0JZ5/qimeaSYQ==
X-Google-Smtp-Source: ABdhPJzkKp9xe290AFmj3veLxm1mWg9pNLjagG+3eu2OWr86D1yuTxbIo9Td28dQqtVn/Ng8v60jVw==
X-Received: by 2002:a62:16c8:0:b0:43d:d6b8:f38 with SMTP id 191-20020a6216c8000000b0043dd6b80f38mr2948110pfw.9.1631518126387;
        Mon, 13 Sep 2021 00:28:46 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:b418:a601:c444:4951])
        by smtp.gmail.com with ESMTPSA id g8sm5688019pfv.51.2021.09.13.00.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 00:28:46 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] Bluetooth: hci_qca: Set up Qualcomm WCN399x for Android BQR commands
Date:   Mon, 13 Sep 2021 15:28:37 +0800
Message-Id: <20210913152801.v3.2.Ie2014b5e6ed62dee26015805cf9c9b00d8dc64e5@changeid>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
In-Reply-To: <20210913152801.v3.1.I17f57656757b83a1c0fb4b78525d8aca581725db@changeid>
References: <20210913152801.v3.1.I17f57656757b83a1c0fb4b78525d8aca581725db@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch sets up Qualcomm WCN399x to support the Android BQR commands.

Reported-by: kernel test robot <lkp@intel.com>

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

Changes in v3:
- Fix the auto build test ERROR
  "undefined symbol: btandroid_set_quality_report" that occurred
  with some kernel configs.

Changes in v2:
- Fix the title

 drivers/bluetooth/hci_qca.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 53deea2eb7b4..bf576046681d 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -38,6 +38,7 @@
 
 #include "hci_uart.h"
 #include "btqca.h"
+#include "btandroid.h"
 
 /* HCI_IBS protocol messages */
 #define HCI_IBS_SLEEP_IND	0xFE
@@ -1730,6 +1731,7 @@ static int qca_setup(struct hci_uart *hu)
 	if (qca_is_wcn399x(soc_type) ||
 	    qca_is_wcn6750(soc_type)) {
 		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
+		hdev->set_quality_report = btandroid_set_quality_report;
 
 		ret = qca_read_soc_version(hdev, &ver, soc_type);
 		if (ret)
-- 
2.33.0.309.g3052b89438-goog

