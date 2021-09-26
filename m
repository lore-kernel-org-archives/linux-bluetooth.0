Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AEFC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 26 Sep 2021 07:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCE6461090
	for <linux-bluetooth@archiver.kernel.org>; Sun, 26 Sep 2021 07:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhIZHJh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 26 Sep 2021 03:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbhIZHJf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 26 Sep 2021 03:09:35 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E342C061575
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Sep 2021 00:08:00 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id bb10so9527646plb.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Sep 2021 00:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BpdS2aFlZ1zRpA2zLjv6Hye68VZ4PQccnLWfxs3dzj0=;
        b=Qm2GEOaABbYbteFqTxtWZKpUKZtGwnqtMBlQvHFmsUZkmQD/W3xV0nYQQt50A7tQnY
         iPZGoXICtVi+F2gFDcis4h/KAzHfGZczNWmswg11JuMNDYbnEtHuE65argCUpJN58edo
         pJFP0t+mZyBJ8m8/P1hFoSYB9XLxBs6a7fbEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BpdS2aFlZ1zRpA2zLjv6Hye68VZ4PQccnLWfxs3dzj0=;
        b=25i1g1TrEpsvAtz9ZOeT/8/ApHws67OqSFpe//35PIcGxmNbbFvZ8hG3RsEGJv4uL6
         VBuNQc9L5uhBuCXAH5ZGxuxWUIr8NbCoC1QAnlIGFqc26QSd40RgM35BeR2BDTcjMuCY
         dOX5OXPw2HzbFfxegKcTojuPDBKnMAlp7N3FzNOtefKPhMFZVkw4Xtfx5MdqxGG5kHSl
         rRbAdkQWxSBDaJNx1HCpF36D37SNeCedsu7h4cgml6/77ylSJR+gnpzDVUYY7NlZw05y
         lCFMOmR5f43K8bZjH3L3YjRmOmYo7lt9kXF6D31DI4o4BpQhZaOFVn1GWNv80qzVKPsa
         5cOQ==
X-Gm-Message-State: AOAM531P+sRZC7bJZ5lAlRk+wpjDuJL/huNvn2Fd2JdtDQnpaX3f4PiL
        owbam8EpzDNgLRI4OKPu91f6HMFkKu9B3w==
X-Google-Smtp-Source: ABdhPJyPMGD42kP6K9XFuoYHdaQ0hgJvV4v6nloABIy+D4XMtfeXdrE9m+o67F5nf9a78rrn3Xc3KQ==
X-Received: by 2002:a17:90a:1b2a:: with SMTP id q39mr12316659pjq.219.1632640079446;
        Sun, 26 Sep 2021 00:07:59 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:8152:3867:7050:3260])
        by smtp.gmail.com with ESMTPSA id o17sm13796174pfp.126.2021.09.26.00.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 00:07:59 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] Bluetooth: hci_qca: enable Qualcomm WCN399x for AOSP extension
Date:   Sun, 26 Sep 2021 15:07:47 +0800
Message-Id: <20210926150657.v4.2.I287dfe4fd9801db8ea35dc095ea05c23e8b9129d@changeid>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210926150657.v4.1.Iaa4a0269e51d8e8d8784a6ac8e05899b49a1377d@changeid>
References: <20210926150657.v4.1.Iaa4a0269e51d8e8d8784a6ac8e05899b49a1377d@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch enables Qualcomm WCN399x to support the AOSP extension.

Reported-by: kernel test robot <lkp@intel.com>

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Joseph Hwang <josephsih@chromium.org>

---

Changes in v4:
- Call hci_set_aosp_capable in the driver.

Changes in v3:
- Fix the auto build test ERROR
  "undefined symbol: btandroid_set_quality_report" that occurred
  with some kernel configs.

Changes in v2:
- Fix the title

 drivers/bluetooth/hci_qca.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 53deea2eb7b4..e2566d606c93 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1730,6 +1730,7 @@ static int qca_setup(struct hci_uart *hu)
 	if (qca_is_wcn399x(soc_type) ||
 	    qca_is_wcn6750(soc_type)) {
 		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
+		hci_set_aosp_capable(hdev);
 
 		ret = qca_read_soc_version(hdev, &ver, soc_type);
 		if (ret)
-- 
2.33.0.685.g46640cef36-goog

