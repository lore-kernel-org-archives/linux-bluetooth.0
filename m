Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B02EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 May 2022 10:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiEYKuh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 May 2022 06:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiEYKuf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 May 2022 06:50:35 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC73A1C6
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 May 2022 03:50:34 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so4677712pjf.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 May 2022 03:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/+P/7k1LChvI26DD9TDcF/h4mBlWn8AMjL3OetW7svw=;
        b=U0BkY3nCf0ZKzy/JlzQaWxci40PBuP+83Fi6cZlkI/E0mRuMx5ves07vSOyFmtBFpZ
         8MPfGjw0QxU6GG+RbQcEU1PP2v8v7earmVvspYRWMkxUWYDFnsgLxNI79gVcQpWxK36f
         zqoR7lDXzGGBrtR/DdVgkPyRHciuoStnB4c+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/+P/7k1LChvI26DD9TDcF/h4mBlWn8AMjL3OetW7svw=;
        b=ixjtXhePsRio0TFidSIGDhXt3ly8zv4b2HN4T9hMbxwPctuT+0OhpUACO0T1DkBvnm
         JFDj5v6h+0BNlNe85uzJcrHjgLdfFPIOMOS/e4dkSuht2zfaO6Z7iB2hfjsGufE/0XIQ
         VWQRNro5r1+BIHhEwvv+h9TyxK0X31v/8K1L9yBVrEeV7wIFGGLj1eTv5rUKmp/IQySO
         T+Trx/MMPKP+eDKa28XapG2CbHHwf1pXPDaSaAAabWXYBdHm83wVHdGATdEsEL+/LrC3
         ekpNMvKtUAd/h2HtBWIOxyGkNBGLIcw+aItuTwHIVoTnGets5OK9UHZEi8XqFhPn5Zuc
         zxFw==
X-Gm-Message-State: AOAM531l+IurZJgFgDOdJQqtIxCoWd+A0zWLxsI7D39g0PVxCygM/Wot
        ovS6NFAESy1o1DqnJGDSkTBE4xbFhjNL3Q==
X-Google-Smtp-Source: ABdhPJzxi1p/BIeQg+gEd16KVGKSgEMmTz4wwokyMY0bWnH71F/Loeocg4W23B/WCiXi6KI55w3c5g==
X-Received: by 2002:a17:902:c752:b0:161:7cb4:78b1 with SMTP id q18-20020a170902c75200b001617cb478b1mr31801632plq.166.1653475834023;
        Wed, 25 May 2022 03:50:34 -0700 (PDT)
Received: from localhost (174.71.80.34.bc.googleusercontent.com. [34.80.71.174])
        by smtp.gmail.com with UTF8SMTPSA id v4-20020a17090a458400b001d9780b7779sm1282983pjg.15.2022.05.25.03.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 03:50:33 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>
Subject: [BlueZ PATCH v5 3/8] adapter: remove quality report from experimental features
Date:   Wed, 25 May 2022 18:50:10 +0800
Message-Id: <20220525105015.2315987-3-josephsih@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220525105015.2315987-1-josephsih@chromium.org>
References: <20220525105015.2315987-1-josephsih@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The quality report feature is now enabled through
MGMT_OP_SET_QUALITY_REPORT instead of through the experimental
features.

---

Changes in v5:
- Move is_quality_report_supported() implementation to next patch.
  The function does not belong to this patch.

Changes in v4:
- Move forward this patch in the patch series so that this
  command patch is prior to the quality report event patches.

Changes in v3:
- This is a new patch that enables the quality report feature via
  MGMT_OP_SET_QUALITY_REPORT.

 src/adapter.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index db2624c60..d0abb2a3c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -120,13 +120,6 @@ static const struct mgmt_exp_uuid le_simult_central_peripheral_uuid = {
 	.str = "671b10b5-42c0-4696-9227-eb28d1b049d6"
 };
 
-/* 330859bc-7506-492d-9370-9a6f0614037f */
-static const struct mgmt_exp_uuid quality_report_uuid = {
-	.val = { 0x7f, 0x03, 0x14, 0x06, 0x6f, 0x9a, 0x70, 0x93,
-		0x2d, 0x49, 0x06, 0x75, 0xbc, 0x59, 0x08, 0x33 },
-	.str = "330859bc-7506-492d-9370-9a6f0614037f"
-};
-
 /* 15c0a148-c273-11ea-b3de-0242ac130004 */
 static const struct mgmt_exp_uuid rpa_resolution_uuid = {
 	.val = { 0x04, 0x00, 0x13, 0xac, 0x42, 0x02, 0xde, 0xb3,
@@ -9617,12 +9610,6 @@ static void le_simult_central_peripheral_func(struct btd_adapter *adapter,
 				(void *)le_simult_central_peripheral_uuid.val);
 }
 
-static void quality_report_func(struct btd_adapter *adapter, uint8_t action)
-{
-	if (action)
-		queue_push_tail(adapter->exps, (void *)quality_report_uuid.val);
-}
-
 static void set_rpa_resolution_complete(uint8_t status, uint16_t len,
 					const void *param, void *user_data)
 {
@@ -9698,7 +9685,6 @@ static const struct exp_feat {
 	EXP_FEAT(&debug_uuid, exp_debug_func),
 	EXP_FEAT(&le_simult_central_peripheral_uuid,
 		 le_simult_central_peripheral_func),
-	EXP_FEAT(&quality_report_uuid, quality_report_func),
 	EXP_FEAT(&rpa_resolution_uuid, rpa_resolution_func),
 	EXP_FEAT(&codec_offload_uuid, codec_offload_func),
 };
-- 
2.36.1.124.g0e6072fb45-goog

