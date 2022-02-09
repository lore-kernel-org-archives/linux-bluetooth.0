Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EDBC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Feb 2022 09:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbiBIJZ7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Feb 2022 04:25:59 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiBIJZ4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Feb 2022 04:25:56 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B567FE03E21E
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Feb 2022 01:25:52 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id a11-20020a17090a740b00b001b8b506c42fso4624389pjg.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Feb 2022 01:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lZ7VTq83RLOJ0uaKrHIzjaJZ39aUOWoyZ3tyZJGSuJU=;
        b=Q8F6O7dEG2GmVqhWUePA72aKjaibZFeijXFsC1Bf32F/sm6KdfoPdt7Z2JUIP4ayKJ
         +YYJFFdxBkzEQ8B/i1pQxNhh4nkLY2jlK++Gh5fNElZlt/NDGCGSMCm7yL9K46AP0472
         YrxskiyxBWJoq5e+fZv5+VQ5AUPymvivuiAOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lZ7VTq83RLOJ0uaKrHIzjaJZ39aUOWoyZ3tyZJGSuJU=;
        b=U2umLXDVgStvvTek2recXR8+u4mxP464OGHVsZs99ciV5ap4HkTesxb2/WNLKWNZmQ
         PCubGy3JCfx5nWG3jDh8V8rH0hrQ6ch3lGbQb0M/PIgx7aaK3iCDvr3ziwkzyFrrO5tn
         /CLQPA9zEwkXx/6Qrp91+R3dcIoaS4lG+6dkRNi01mNmi60Z7o5nFORq1iCcdiGTV17E
         JqnKYltGEhSvsLgotTFjxASB8MHSTivlCKqbDNzrxo/Yb784rdkjVXMtoccLp/+sPWgG
         qIXVMHwk4EHCVlqbRLX1TCVYkjhtqyhmGr0YTeyVzxe/Vem0OQamrE5dcTa6JuLZU8R3
         H55w==
X-Gm-Message-State: AOAM532x3SrmozcimEI4hyPKfQjQQM9UeYlSPwsX9WQmIs9GwVikmUo7
        GDARAay2llk0qkrxw92bTcTnDoxlZUFNiw==
X-Google-Smtp-Source: ABdhPJzcwi4WfVrKuzHeNTX5DiKKi/0SBFV1n0bFRbOxFKOQ3J5zV0PfPvhAy/lv3MkU5+mNto7PXw==
X-Received: by 2002:a17:902:ec82:: with SMTP id x2mr1301453plg.139.1644398678214;
        Wed, 09 Feb 2022 01:24:38 -0800 (PST)
Received: from localhost (174.71.80.34.bc.googleusercontent.com. [34.80.71.174])
        by smtp.gmail.com with UTF8SMTPSA id nu7sm6076006pjb.30.2022.02.09.01.24.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 01:24:37 -0800 (PST)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>
Subject: [BlueZ PATCH v3 7/9] adapter: enable quality report via MGMT_OP_SET_QUALITY_REPORT
Date:   Wed,  9 Feb 2022 17:24:12 +0800
Message-Id: <20220209092414.751642-5-josephsih@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220209092414.751642-1-josephsih@chromium.org>
References: <20220209092414.751642-1-josephsih@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The quality report feature is now enabled through
MGMT_OP_SET_QUALITY_REPORT instead of through the experimental
features.

Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

Changes in v3:
- This is a new patch that enables the quality report feature via
  MGMT_OP_SET_QUALITY_REPORT.

 src/adapter.c | 32 +++++---------------------------
 1 file changed, 5 insertions(+), 27 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 9816235ec..9cb684345 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -122,13 +122,6 @@ static const struct mgmt_exp_uuid le_simult_central_peripheral_uuid = {
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
@@ -9754,25 +9747,6 @@ static void le_simult_central_peripheral_func(struct btd_adapter *adapter,
 				(void *)le_simult_central_peripheral_uuid.val);
 }
 
-static bool is_exp_feature_uuid_the_same(const void *data,
-							const void *match_data)
-{
-	return memcmp(data, match_data,
-			sizeof(((struct mgmt_exp_uuid *)NULL)->val)) == 0;
-}
-
-bool is_quality_report_supported(struct btd_adapter *adapter)
-{
-	return queue_find(adapter->exps, is_exp_feature_uuid_the_same,
-				(void *)quality_report_uuid.val) != NULL;
-}
-
-static void quality_report_func(struct btd_adapter *adapter, uint8_t action)
-{
-	if (action)
-		queue_push_tail(adapter->exps, (void *)quality_report_uuid.val);
-}
-
 static void set_rpa_resolution_complete(uint8_t status, uint16_t len,
 					const void *param, void *user_data)
 {
@@ -9848,7 +9822,6 @@ static const struct exp_feat {
 	EXP_FEAT(&debug_uuid, exp_debug_func),
 	EXP_FEAT(&le_simult_central_peripheral_uuid,
 		 le_simult_central_peripheral_func),
-	EXP_FEAT(&quality_report_uuid, quality_report_func),
 	EXP_FEAT(&rpa_resolution_uuid, rpa_resolution_func),
 	EXP_FEAT(&codec_offload_uuid, codec_offload_func),
 };
@@ -9922,6 +9895,11 @@ static void read_exp_features(struct btd_adapter *adapter)
 	btd_error(adapter->dev_id, "Failed to read exp features info");
 }
 
+bool is_quality_report_supported(struct btd_adapter *adapter)
+{
+	return !!(adapter->supported_settings & MGMT_SETTING_QUALITY_REPORT);
+}
+
 static void quality_report_debug(const char *str, void *user_data)
 {
 	const char *prefix = user_data;
-- 
2.35.0.263.gb82422642f-goog

