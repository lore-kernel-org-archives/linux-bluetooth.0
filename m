Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CE3C4743C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jun 2021 22:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBB9860FEE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jun 2021 22:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbhFUWeU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Jun 2021 18:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbhFUWeL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Jun 2021 18:34:11 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF12C0613A3
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jun 2021 15:31:50 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id u20so7662043ljl.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jun 2021 15:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pl85yJPQ8UWWXJ4GoZSz05OqJVvyRpSXlOX5oJ9CbE0=;
        b=zIZNEtQC22piu1oOY/ASJ6inohtioGWMbhHGNwKmnkg+6S/zgVXtgw3YYIm6KRmP7D
         2yQ+iV2uCIm7l2AsLFnTvfAptHFR7kZGrn47hI61YYqso7ykfC0HB6FlLPh7WTjbgJUu
         lA27VdWWiL5tFBNCvlEGIYuvH1FYQqSwllKOQtjzoRkIHRiuJkTNV9LEiJZuKLspFiv1
         +XxMW6ymZVbLE+RC+aKxtEFjpUXZwG+6uvo6kfJECwE9jgE5A8gK3fdFrkzUypwirFYW
         u0CyisCXrQiw1gQpxDWdumJ3GCAWqi9X31v2gYEgXFNfRqqGOEuutu89S3R72hsZkt+G
         W96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pl85yJPQ8UWWXJ4GoZSz05OqJVvyRpSXlOX5oJ9CbE0=;
        b=pkAz+lyS8qECd3/JZb3iduaijvkg12AZg7VMxHZjs8VVg7lZ90EXx8xAq+P0y6C9Y5
         rwWrYE6jYmzd6IGnJyafiwu9UrOSk8MBee7fu2u1U+DzCJbK4FpfmfhMEcgafeHlcTuv
         hznaLA79QqQHCSMsflEGgDSDDMLaK9kfPEp3uB0cN0JfY7P+CZAZvZqVHz6f97wJyd6Q
         iOakS7YSY38WQrgIKxyiLCs/RGA/27a4lvNkb0Kw0xlWj5GMcUcr+P9oAvPHw4wnR7dr
         DWdd5SNw7YWcLuHGGyaPVvMhlkG2bPB+TteHuzxG69rZUcRkYkKY6rLBjIkbRbjG8t3z
         OXiQ==
X-Gm-Message-State: AOAM532Zwmju36T5Kz0Md6TN5iyjmCmfBFAcnYN/+lq/kZ9v/bYOFxqm
        Gp8I0OX6NYPZykmWeqzllMt1CA==
X-Google-Smtp-Source: ABdhPJxjoVCplwPuJvjbPzknCoMLW1t50J1MCoASlafBc+Ph6ulmOtfGcOvFbeHinnh6DsqSmvnOig==
X-Received: by 2002:a2e:2a41:: with SMTP id q62mr372448ljq.371.1624314708998;
        Mon, 21 Jun 2021 15:31:48 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id b10sm2516025ljf.72.2021.06.21.15.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 15:31:48 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 6/7] Bluetooth: hci_qca: add power sequencer support to qca6390
Date:   Tue, 22 Jun 2021 01:31:40 +0300
Message-Id: <20210621223141.1638189-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210621223141.1638189-1-dmitry.baryshkov@linaro.org>
References: <20210621223141.1638189-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QCA6390 uses on-chip power sequencer (and power management unit) to
supply power to both WiFi and BT parts. Since this sequencer is
supported by a separate driver, use it as a single "vin" regulator.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/bluetooth/hci_qca.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index bb04da08468a..deea38033248 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1856,7 +1856,10 @@ static const struct qca_device_data qca_soc_data_wcn3998 = {
 
 static const struct qca_device_data qca_soc_data_qca6390 = {
 	.soc_type = QCA_QCA6390,
-	.num_vregs = 0,
+	.vregs = (struct qca_vreg []) {
+		{ "vin", 1000 },
+	},
+	.num_vregs = 1,
 	.capabilities = QCA_CAP_NEEDS_BT_ENABLE,
 	.name = "qca6390",
 };
-- 
2.30.2

